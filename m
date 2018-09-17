Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783AAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3773220867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3773220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbeIREfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:35:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbeIREfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:35:07 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D880AC49;
        Mon, 17 Sep 2018 23:05:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 110/126] inet: frags: fix ip6frag_low_thresh boundary
Date:   Tue, 18 Sep 2018 00:42:38 +0200
Message-Id: <20180917211711.192268276@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

Giving an integer to proc_doulongvec_minmax() is dangerous on 64bit arches,
since linker might place next to it a non zero value preventing a change
to ip6frag_low_thresh.

ip6frag_low_thresh is not used anymore in the kernel, but we do not
want to prematuraly break user scripts wanting to change it.

Since specifying a minimal value of 0 for proc_doulongvec_minmax()
is moot, let's remove these zero values in all defrag units.

Fixes: 6e00f7dd5e4e ("ipv6: frags: fix /proc/sys/net/ipv6/ip6frag_low_thresh")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 3d23401283e80ceb03f765842787e0e79ff598b7)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/6lowpan/reassembly.c     |    2 --
 net/ipv4/ip_fragment.c                  |    5 ++---
 net/ipv6/netfilter/nf_conntrack_reasm.c |    2 --
 net/ipv6/reassembly.c                   |    4 +---
 4 files changed, 3 insertions(+), 10 deletions(-)

--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -411,7 +411,6 @@ err:
 }
 
 #ifdef CONFIG_SYSCTL
-static long zero;
 
 static struct ctl_table lowpan_frags_ns_ctl_table[] = {
 	{
@@ -428,7 +427,6 @@ static struct ctl_table lowpan_frags_ns_
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero,
 		.extra2		= &init_net.ieee802154_lowpan.frags.high_thresh
 	},
 	{
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -672,7 +672,7 @@ struct sk_buff *ip_check_defrag(struct n
 EXPORT_SYMBOL(ip_check_defrag);
 
 #ifdef CONFIG_SYSCTL
-static long zero;
+static int dist_min;
 
 static struct ctl_table ip4_frags_ns_ctl_table[] = {
 	{
@@ -689,7 +689,6 @@ static struct ctl_table ip4_frags_ns_ctl
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero,
 		.extra2		= &init_net.ipv4.frags.high_thresh
 	},
 	{
@@ -705,7 +704,7 @@ static struct ctl_table ip4_frags_ns_ctl
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero
+		.extra1		= &dist_min,
 	},
 	{ }
 };
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -63,7 +63,6 @@ struct nf_ct_frag6_skb_cb
 static struct inet_frags nf_frags;
 
 #ifdef CONFIG_SYSCTL
-static long zero;
 
 static struct ctl_table nf_ct_frag6_sysctl_table[] = {
 	{
@@ -79,7 +78,6 @@ static struct ctl_table nf_ct_frag6_sysc
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero,
 		.extra2		= &init_net.nf_frag.frags.high_thresh
 	},
 	{
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -554,7 +554,6 @@ static const struct inet6_protocol frag_
 };
 
 #ifdef CONFIG_SYSCTL
-static int zero;
 
 static struct ctl_table ip6_frags_ns_ctl_table[] = {
 	{
@@ -570,8 +569,7 @@ static struct ctl_table ip6_frags_ns_ctl
 		.data		= &init_net.ipv6.frags.low_thresh,
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra2		= &init_net.ipv6.frags.high_thresh
 	},
 	{


