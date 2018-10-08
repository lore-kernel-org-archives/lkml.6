Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8416FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FF3214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u47kSUgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FF3214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeJICCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:02:30 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39DAC214C4;
        Mon,  8 Oct 2018 18:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024562;
        bh=B8wllEKNdFb4EvGYxsT7OLkv7ZVMoOrZ+aCjdjs3fqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u47kSUgFgQBg0/oxENi6rEtihrL/iLPfXl16N9Wf3E/2wjkenUfkeocQvw/HocRpW
         aaRFYIEOHb4sIbJUIPwt6DOhwpWZKxl1+zUmiRrux8W5UEv5u288/FtbOmiEV988KG
         yrR2eXm6IHUkFKVKaY+rXiK+7uyN9MRJXu5h7NOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Satish Patel <satish.txt@gmail.com>,
        Markos Chandras <markos.chandras@suse.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 080/168] netfilter: xt_checksum: ignore gso skbs
Date:   Mon,  8 Oct 2018 20:31:00 +0200
Message-Id: <20181008175623.100651819@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 10568f6c5761db24249c610c94d6e44d5505a0ba ]

Satish Patel reports a skb_warn_bad_offload() splat caused
by -j CHECKSUM rules:

-A POSTROUTING -p tcp -m tcp --sport 80 -j CHECKSUM

The CHECKSUM target has never worked with GSO skbs, and the above rule
makes no sense as kernel will handle checksum updates on transmit.

Unfortunately, there are 3rd party tools that install such rules, so we
cannot reject this from the config plane without potential breakage.

Amend Kconfig text to clarify that the CHECKSUM target is only useful
in virtualized environments, where old dhcp clients that use AF_PACKET
used to discard UDP packets with a 'bad' header checksum and add a
one-time warning in case such rule isn't restricted to UDP.

v2: check IP6T_F_PROTO flag before cmp (Michal Kubecek)

Reported-by: Satish Patel <satish.txt@gmail.com>
Reported-by: Markos Chandras <markos.chandras@suse.com>
Reported-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/Kconfig       |   12 ++++++------
 net/netfilter/xt_CHECKSUM.c |   22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 7 deletions(-)

--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -740,13 +740,13 @@ config NETFILTER_XT_TARGET_CHECKSUM
 	depends on NETFILTER_ADVANCED
 	---help---
 	  This option adds a `CHECKSUM' target, which can be used in the iptables mangle
-	  table.
+	  table to work around buggy DHCP clients in virtualized environments.
 
-	  You can use this target to compute and fill in the checksum in
-	  a packet that lacks a checksum.  This is particularly useful,
-	  if you need to work around old applications such as dhcp clients,
-	  that do not work well with checksum offloads, but don't want to disable
-	  checksum offload in your device.
+	  Some old DHCP clients drop packets because they are not aware
+	  that the checksum would normally be offloaded to hardware and
+	  thus should be considered valid.
+	  This target can be used to fill in the checksum using iptables
+	  when such packets are sent via a virtual network device.
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
--- a/net/netfilter/xt_CHECKSUM.c
+++ b/net/netfilter/xt_CHECKSUM.c
@@ -16,6 +16,9 @@
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter/xt_CHECKSUM.h>
 
+#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter_ipv6/ip6_tables.h>
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael S. Tsirkin <mst@redhat.com>");
 MODULE_DESCRIPTION("Xtables: checksum modification");
@@ -25,7 +28,7 @@ MODULE_ALIAS("ip6t_CHECKSUM");
 static unsigned int
 checksum_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
-	if (skb->ip_summed == CHECKSUM_PARTIAL)
+	if (skb->ip_summed == CHECKSUM_PARTIAL && !skb_is_gso(skb))
 		skb_checksum_help(skb);
 
 	return XT_CONTINUE;
@@ -34,6 +37,8 @@ checksum_tg(struct sk_buff *skb, const s
 static int checksum_tg_check(const struct xt_tgchk_param *par)
 {
 	const struct xt_CHECKSUM_info *einfo = par->targinfo;
+	const struct ip6t_ip6 *i6 = par->entryinfo;
+	const struct ipt_ip *i4 = par->entryinfo;
 
 	if (einfo->operation & ~XT_CHECKSUM_OP_FILL) {
 		pr_info_ratelimited("unsupported CHECKSUM operation %x\n",
@@ -43,6 +48,21 @@ static int checksum_tg_check(const struc
 	if (!einfo->operation)
 		return -EINVAL;
 
+	switch (par->family) {
+	case NFPROTO_IPV4:
+		if (i4->proto == IPPROTO_UDP &&
+		    (i4->invflags & XT_INV_PROTO) == 0)
+			return 0;
+		break;
+	case NFPROTO_IPV6:
+		if ((i6->flags & IP6T_F_PROTO) &&
+		    i6->proto == IPPROTO_UDP &&
+		    (i6->invflags & XT_INV_PROTO) == 0)
+			return 0;
+		break;
+	}
+
+	pr_warn_once("CHECKSUM should be avoided.  If really needed, restrict with \"-p udp\" and only use in OUTPUT\n");
 	return 0;
 }
 


