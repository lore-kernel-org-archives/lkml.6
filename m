Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D2FC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43EC24F8E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43EC24F8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeFXP1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:27:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeFXP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:27:38 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8F5E749F;
        Sun, 24 Jun 2018 15:27:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, trevor.francis@46labs.com,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 08/52] udp: fix rx queue len reported by diag and proc interface
Date:   Sun, 24 Jun 2018 23:21:01 +0800
Message-Id: <20180624142744.830075509@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142744.234164867@linuxfoundation.org>
References: <20180624142744.234164867@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 6c206b20092a3623184cff9470dba75d21507874 ]

After commit 6b229cf77d68 ("udp: add batching to udp_rmem_release()")
the sk_rmem_alloc field does not measure exactly anymore the
receive queue length, because we batch the rmem release. The issue
is really apparent only after commit 0d4a6608f68c ("udp: do rmem bulk
free even if the rx sk queue is empty"): the user space can easily
check for an empty socket with not-0 queue length reported by the 'ss'
tool or the procfs interface.

We need to use a custom UDP helper to report the correct queue length,
taking into account the forward allocation deficit.

Reported-by: trevor.francis@46labs.com
Fixes: 6b229cf77d68 ("UDP: add batching to udp_rmem_release()")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/transp_v6.h |   11 +++++++++--
 include/net/udp.h       |    5 +++++
 net/ipv4/udp.c          |    2 +-
 net/ipv4/udp_diag.c     |    2 +-
 net/ipv6/datagram.c     |    6 +++---
 net/ipv6/udp.c          |    3 ++-
 6 files changed, 21 insertions(+), 8 deletions(-)

--- a/include/net/transp_v6.h
+++ b/include/net/transp_v6.h
@@ -45,8 +45,15 @@ int ip6_datagram_send_ctl(struct net *ne
 			  struct flowi6 *fl6, struct ipcm6_cookie *ipc6,
 			  struct sockcm_cookie *sockc);
 
-void ip6_dgram_sock_seq_show(struct seq_file *seq, struct sock *sp,
-			     __u16 srcp, __u16 destp, int bucket);
+void __ip6_dgram_sock_seq_show(struct seq_file *seq, struct sock *sp,
+			       __u16 srcp, __u16 destp, int rqueue, int bucket);
+static inline void
+ip6_dgram_sock_seq_show(struct seq_file *seq, struct sock *sp, __u16 srcp,
+			__u16 destp, int bucket)
+{
+	__ip6_dgram_sock_seq_show(seq, sp, srcp, destp, sk_rmem_alloc_get(sp),
+				  bucket);
+}
 
 #define LOOPBACK4_IPV6 cpu_to_be32(0x7f000006)
 
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -244,6 +244,11 @@ static inline __be16 udp_flow_src_port(s
 	return htons((((u64) hash * (max - min)) >> 32) + min);
 }
 
+static inline int udp_rqueue_get(struct sock *sk)
+{
+	return sk_rmem_alloc_get(sk) - READ_ONCE(udp_sk(sk)->forward_deficit);
+}
+
 /* net/ipv4/udp.c */
 void udp_destruct_sock(struct sock *sk);
 void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len);
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2720,7 +2720,7 @@ static void udp4_format_sock(struct sock
 		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK %d",
 		bucket, src, srcp, dest, destp, sp->sk_state,
 		sk_wmem_alloc_get(sp),
-		sk_rmem_alloc_get(sp),
+		udp_rqueue_get(sp),
 		0, 0L, 0,
 		from_kuid_munged(seq_user_ns(f), sock_i_uid(sp)),
 		0, sock_i_ino(sp),
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -163,7 +163,7 @@ static int udp_diag_dump_one(struct sk_b
 static void udp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 		void *info)
 {
-	r->idiag_rqueue = sk_rmem_alloc_get(sk);
+	r->idiag_rqueue = udp_rqueue_get(sk);
 	r->idiag_wqueue = sk_wmem_alloc_get(sk);
 }
 
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -1026,8 +1026,8 @@ exit_f:
 }
 EXPORT_SYMBOL_GPL(ip6_datagram_send_ctl);
 
-void ip6_dgram_sock_seq_show(struct seq_file *seq, struct sock *sp,
-			     __u16 srcp, __u16 destp, int bucket)
+void __ip6_dgram_sock_seq_show(struct seq_file *seq, struct sock *sp,
+			       __u16 srcp, __u16 destp, int rqueue, int bucket)
 {
 	const struct in6_addr *dest, *src;
 
@@ -1043,7 +1043,7 @@ void ip6_dgram_sock_seq_show(struct seq_
 		   dest->s6_addr32[2], dest->s6_addr32[3], destp,
 		   sp->sk_state,
 		   sk_wmem_alloc_get(sp),
-		   sk_rmem_alloc_get(sp),
+		   rqueue,
 		   0, 0L, 0,
 		   from_kuid_munged(seq_user_ns(seq), sock_i_uid(sp)),
 		   0,
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1503,7 +1503,8 @@ int udp6_seq_show(struct seq_file *seq,
 		struct inet_sock *inet = inet_sk(v);
 		__u16 srcp = ntohs(inet->inet_sport);
 		__u16 destp = ntohs(inet->inet_dport);
-		ip6_dgram_sock_seq_show(seq, v, srcp, destp, bucket);
+		__ip6_dgram_sock_seq_show(seq, v, srcp, destp,
+					  udp_rqueue_get(v), bucket);
 	}
 	return 0;
 }


