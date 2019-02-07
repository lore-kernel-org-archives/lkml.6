Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6532190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539813;
	bh=H9Xgrq9rllhXaT1X3wGNQbCyiwEi9xs7IQ52EFuXZTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vPnsx1kBNskCS//3nVRWr4rk1tTNQo9HauDLwZ3ops6kg0LjMLD+RHqkBs5dOeUkZ
	 2g0kuWhueRr5AyDUXc0RFc/2AQYpGZ4gUdJc5mDva4U0C1C7cJpgAfSJWEfs0YF45d
	 kY+PaCZQUlh9Ns9TgsqF/kMc2/h5Ermz/ID2OkG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfBGLnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:43:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbfBGLn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:43:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3A02190C;
        Thu,  7 Feb 2019 11:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539808;
        bh=H9Xgrq9rllhXaT1X3wGNQbCyiwEi9xs7IQ52EFuXZTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPTWXTukdDIEHPg4TZW3CKYG0eCulahJWiogo7k+LEmKsMLFVt43iPj6l3RJJMZjc
         aQRhKSr1j8bHp42YkdaxKAn8jhxtgE7TICEvbRt1dw0wqjb/JfQJGdLAm6wNnUsneg
         1WIZ16/OO10Wyppf8bQep837I02/DkEtld2wFF98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 15/34] inet: frags: break the 2GB limit for frags storage
Date:   Thu,  7 Feb 2019 12:41:57 +0100
Message-Id: <20190207113026.177245886@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 3e67f106f619dcfaf6f4e2039599bdb69848c714 upstream.

Some users are willing to provision huge amounts of memory to be able
to perform reassembly reasonnably well under pressure.

Current memory tracking is using one atomic_t and integers.

Switch to atomic_long_t so that 64bit arches can use more than 2GB,
without any cost for 32bit arches.

Note that this patch avoids an overflow error, if high_thresh was set
to ~2GB, since this test in inet_frag_alloc() was never true :

if (... || frag_mem_limit(nf) > nf->high_thresh)

Tested:

$ echo 16000000000 >/proc/sys/net/ipv4/ipfrag_high_thresh

<frag DDOS>

$ grep FRAG /proc/net/sockstat
FRAG: inuse 14705885 memory 16000002880

$ nstat -n ; sleep 1 ; nstat | grep Reas
IpReasmReqds                    3317150            0.0
IpReasmFails                    3317112            0.0

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/networking/ip-sysctl.txt  |    4 ++--
 include/net/inet_frag.h                 |   20 ++++++++++----------
 net/ieee802154/6lowpan/reassembly.c     |   10 +++++-----
 net/ipv4/ip_fragment.c                  |   10 +++++-----
 net/ipv4/proc.c                         |    2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c |   10 +++++-----
 net/ipv6/proc.c                         |    2 +-
 net/ipv6/reassembly.c                   |    6 +++---
 8 files changed, 32 insertions(+), 32 deletions(-)

--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -112,10 +112,10 @@ min_adv_mss - INTEGER
 
 IP Fragmentation:
 
-ipfrag_high_thresh - INTEGER
+ipfrag_high_thresh - LONG INTEGER
 	Maximum memory used to reassemble IP fragments.
 
-ipfrag_low_thresh - INTEGER
+ipfrag_low_thresh - LONG INTEGER
 	(Obsolete since linux-4.17)
 	Maximum memory used to reassemble IP fragments before the kernel
 	begins to remove incomplete fragment queues to free up resources.
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -7,11 +7,11 @@ struct netns_frags {
 	struct rhashtable       rhashtable ____cacheline_aligned_in_smp;
 
 	/* Keep atomic mem on separate cachelines in structs that include it */
-	atomic_t		mem ____cacheline_aligned_in_smp;
+	atomic_long_t		mem ____cacheline_aligned_in_smp;
 	/* sysctls */
+	long			high_thresh;
+	long			low_thresh;
 	int			timeout;
-	int			high_thresh;
-	int			low_thresh;
 	struct inet_frags	*f;
 };
 
@@ -101,7 +101,7 @@ void inet_frags_fini(struct inet_frags *
 
 static inline int inet_frags_init_net(struct netns_frags *nf)
 {
-	atomic_set(&nf->mem, 0);
+	atomic_long_set(&nf->mem, 0);
 	return rhashtable_init(&nf->rhashtable, &nf->f->rhash_params);
 }
 void inet_frags_exit_net(struct netns_frags *nf);
@@ -118,19 +118,19 @@ static inline void inet_frag_put(struct
 
 /* Memory Tracking Functions. */
 
-static inline int frag_mem_limit(struct netns_frags *nf)
+static inline long frag_mem_limit(const struct netns_frags *nf)
 {
-	return atomic_read(&nf->mem);
+	return atomic_long_read(&nf->mem);
 }
 
-static inline void sub_frag_mem_limit(struct netns_frags *nf, int i)
+static inline void sub_frag_mem_limit(struct netns_frags *nf, long val)
 {
-	atomic_sub(i, &nf->mem);
+	atomic_long_sub(val, &nf->mem);
 }
 
-static inline void add_frag_mem_limit(struct netns_frags *nf, int i)
+static inline void add_frag_mem_limit(struct netns_frags *nf, long val)
 {
-	atomic_add(i, &nf->mem);
+	atomic_long_add(val, &nf->mem);
 }
 
 /* RFC 3168 support :
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -410,23 +410,23 @@ err:
 }
 
 #ifdef CONFIG_SYSCTL
-static int zero;
+static long zero;
 
 static struct ctl_table lowpan_frags_ns_ctl_table[] = {
 	{
 		.procname	= "6lowpanfrag_high_thresh",
 		.data		= &init_net.ieee802154_lowpan.frags.high_thresh,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= &init_net.ieee802154_lowpan.frags.low_thresh
 	},
 	{
 		.procname	= "6lowpanfrag_low_thresh",
 		.data		= &init_net.ieee802154_lowpan.frags.low_thresh,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= &zero,
 		.extra2		= &init_net.ieee802154_lowpan.frags.high_thresh
 	},
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -682,23 +682,23 @@ struct sk_buff *ip_check_defrag(struct n
 EXPORT_SYMBOL(ip_check_defrag);
 
 #ifdef CONFIG_SYSCTL
-static int zero;
+static long zero;
 
 static struct ctl_table ip4_frags_ns_ctl_table[] = {
 	{
 		.procname	= "ipfrag_high_thresh",
 		.data		= &init_net.ipv4.frags.high_thresh,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= &init_net.ipv4.frags.low_thresh
 	},
 	{
 		.procname	= "ipfrag_low_thresh",
 		.data		= &init_net.ipv4.frags.low_thresh,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= &zero,
 		.extra2		= &init_net.ipv4.frags.high_thresh
 	},
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -71,7 +71,7 @@ static int sockstat_seq_show(struct seq_
 		   sock_prot_inuse_get(net, &udplite_prot));
 	seq_printf(seq, "RAW: inuse %d\n",
 		   sock_prot_inuse_get(net, &raw_prot));
-	seq_printf(seq,  "FRAG: inuse %u memory %u\n",
+	seq_printf(seq,  "FRAG: inuse %u memory %lu\n",
 		   atomic_read(&net->ipv4.frags.rhashtable.nelems),
 		   frag_mem_limit(&net->ipv4.frags));
 	return 0;
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -64,7 +64,7 @@ struct nf_ct_frag6_skb_cb
 static struct inet_frags nf_frags;
 
 #ifdef CONFIG_SYSCTL
-static int zero;
+static long zero;
 
 static struct ctl_table nf_ct_frag6_sysctl_table[] = {
 	{
@@ -77,18 +77,18 @@ static struct ctl_table nf_ct_frag6_sysc
 	{
 		.procname	= "nf_conntrack_frag6_low_thresh",
 		.data		= &init_net.nf_frag.frags.low_thresh,
-		.maxlen		= sizeof(unsigned int),
+		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= &zero,
 		.extra2		= &init_net.nf_frag.frags.high_thresh
 	},
 	{
 		.procname	= "nf_conntrack_frag6_high_thresh",
 		.data		= &init_net.nf_frag.frags.high_thresh,
-		.maxlen		= sizeof(unsigned int),
+		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= &init_net.nf_frag.frags.low_thresh
 	},
 	{ }
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -42,7 +42,7 @@ static int sockstat6_seq_show(struct seq
 			sock_prot_inuse_get(net, &udplitev6_prot));
 	seq_printf(seq, "RAW6: inuse %d\n",
 		       sock_prot_inuse_get(net, &rawv6_prot));
-	seq_printf(seq, "FRAG6: inuse %u memory %u\n",
+	seq_printf(seq, "FRAG6: inuse %u memory %lu\n",
 		   atomic_read(&net->ipv6.frags.rhashtable.nelems),
 		   frag_mem_limit(&net->ipv6.frags));
 	return 0;
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -545,15 +545,15 @@ static struct ctl_table ip6_frags_ns_ctl
 	{
 		.procname	= "ip6frag_high_thresh",
 		.data		= &init_net.ipv6.frags.high_thresh,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= &init_net.ipv6.frags.low_thresh
 	},
 	{
 		.procname	= "ip6frag_low_thresh",
 		.data		= &init_net.ipv6.frags.low_thresh,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &zero,


