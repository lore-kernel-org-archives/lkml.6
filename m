Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414003-2-17430166909457973402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414003; b=ch6bWaJu5U4eIB6ycT6skDzi8ooOxjsMe4Sce/b9CRcG5K2
    e7wz5aa5ms+BW2DyBOVVHR88frckAy/4AnhhkrRGDRA1ELBbf7r6XC0isdUS6VXG
    L1jcRIbeZXYZX1+dZF7Pby1BW/tvmB8UUZkmOFuafiQaKgDGaCMHytvakkoabMMN
    PjQlrgm6iQ/olkU+rIZDjMClplKESxt4X36hFgmFmmtCodynLc4fOHVjcLlU5oE9
    QSkX6WZY6PkWshukJADYcniuD1G1tNFFv+8Immsv5t9A/yqcGwfGeNOFxpRcRYIx
    xB0fWPnnPiPmaN6yj7wxsEIFND7vPU+IMrMiGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414003; bh=CgIMvv8XLp7f7pPxFmdc1QeOAB
    M6usn6hF5tfSUJEX8=; b=S8SX7DdTZuoxPiTME0CkxC5tqru+ZN3zT48R8sIUni
    P7R0Mq/oITAxzp778+0E1kfvQ8uXCzKB3UVygs3dAuhX4D+hzEpxR6L0+waPuWF3
    wrYcCwuV6gccxSFVGvYeMJuv7MQSKT9ehS8WOAvhuEhhNGX0xFMYqTRl/0fC3nes
    OPMc+OZiBMLayoN1TN40H/mAKVFjxYOOqz4WsxNW990fGHKINiO1cuEVjEIsa4Dr
    CXW/kezyPWVHwfYGMVB8TlRU7h3M9dX3u7NSoYe17IkisQbp5/2rIwTpGv7tOB7m
    5LTgnZ817UlACZpAvycCa8EfJeeBLr6I3rbIF3k1Fb0w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935132AbeBWSwh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:52:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935166AbeBWSwf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:35 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 037/159] netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_check()
Date: Fri, 23 Feb 2018 19:25:45 +0100
Message-Id: <20180223170747.930608609@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>

commit 1a38956cce5eabd7b74f94bab70265e4df83165e upstream.

Commit 136e92bbec0a switched local_nodes from an array to a bitmask
but did not add proper bounds checks. As the result
clusterip_config_init_nodelist() can both over-read
ipt_clusterip_tgt_info.local_nodes and over-write
clusterip_config.local_nodes.

Add bounds checks for both.

Fixes: 136e92bbec0a ("[NETFILTER] CLUSTERIP: use a bitmap to store node responsibility data")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/netfilter/ipt_CLUSTERIP.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -431,7 +431,7 @@ static int clusterip_tg_check(const stru
 	struct ipt_clusterip_tgt_info *cipinfo = par->targinfo;
 	const struct ipt_entry *e = par->entryinfo;
 	struct clusterip_config *config;
-	int ret;
+	int ret, i;
 
 	if (par->nft_compat) {
 		pr_err("cannot use CLUSTERIP target from nftables compat\n");
@@ -450,8 +450,18 @@ static int clusterip_tg_check(const stru
 		pr_info("Please specify destination IP\n");
 		return -EINVAL;
 	}
-
-	/* FIXME: further sanity checks */
+	if (cipinfo->num_local_nodes > ARRAY_SIZE(cipinfo->local_nodes)) {
+		pr_info("bad num_local_nodes %u\n", cipinfo->num_local_nodes);
+		return -EINVAL;
+	}
+	for (i = 0; i < cipinfo->num_local_nodes; i++) {
+		if (cipinfo->local_nodes[i] - 1 >=
+		    sizeof(config->local_nodes) * 8) {
+			pr_info("bad local_nodes[%d] %u\n",
+				i, cipinfo->local_nodes[i]);
+			return -EINVAL;
+		}
+	}
 
 	config = clusterip_config_find_get(par->net, e->ip.dst.s_addr, 1);
 	if (!config) {
