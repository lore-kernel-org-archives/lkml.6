Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C3AC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DC12089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdhTSW23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DC12089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbeJQBIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeJQBIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:08:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2037320866;
        Tue, 16 Oct 2018 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710239;
        bh=2caFDXfRleOomWHGh5tpS69fmrBAsUOecLbGRNYLL+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdhTSW23WfqMZ0xb7h5DekuEfFeOqdHh7GG8+B5Q0vFbLsOAUSZbqzXoM18Tuil4L
         GlJ2LW/e6ruBZ2ijf27aH+rmHA1V/fhj2jbwDawit0qd/Hkc4EW0oY4xW8alRQeCDX
         SsXcGjedtK5EkJfTyZS7jwkRhkNQCG1DexoH2RKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 015/109] net: sched: Add policy validation for tc attributes
Date:   Tue, 16 Oct 2018 19:04:43 +0200
Message-Id: <20181016170525.815024482@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 8b4c3cdd9dd8290343ce959a132d3b334062c5b9 ]

A number of TC attributes are processed without proper validation
(e.g., length checks). Add a tca policy for all input attributes and use
when invoking nlmsg_parse.

The 2 Fixes tags below cover the latest additions. The other attributes
are a string (KIND), nested attribute (OPTIONS which does seem to have
validation in most cases), for dumps only or a flag.

Fixes: 5bc1701881e39 ("net: sched: introduce multichain support for filters")
Fixes: d47a6b0e7c492 ("net: sched: introduce ingress/egress block index attributes for qdisc")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_api.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1216,6 +1216,16 @@ check_loop_fn(struct Qdisc *q, unsigned
  * Delete/get qdisc.
  */
 
+const struct nla_policy rtm_tca_policy[TCA_MAX + 1] = {
+	[TCA_KIND]		= { .type = NLA_STRING },
+	[TCA_OPTIONS]		= { .type = NLA_NESTED },
+	[TCA_RATE]		= { .type = NLA_BINARY,
+				    .len = sizeof(struct tc_estimator) },
+	[TCA_STAB]		= { .type = NLA_NESTED },
+	[TCA_DUMP_INVISIBLE]	= { .type = NLA_FLAG },
+	[TCA_CHAIN]		= { .type = NLA_U32 },
+};
+
 static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			struct netlink_ext_ack *extack)
 {
@@ -1232,7 +1242,8 @@ static int tc_get_qdisc(struct sk_buff *
 	    !netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 
-	err = nlmsg_parse(n, sizeof(*tcm), tca, TCA_MAX, NULL, extack);
+	err = nlmsg_parse(n, sizeof(*tcm), tca, TCA_MAX, rtm_tca_policy,
+			  extack);
 	if (err < 0)
 		return err;
 
@@ -1302,7 +1313,8 @@ static int tc_modify_qdisc(struct sk_buf
 
 replay:
 	/* Reinit, just in case something touches this. */
-	err = nlmsg_parse(n, sizeof(*tcm), tca, TCA_MAX, NULL, extack);
+	err = nlmsg_parse(n, sizeof(*tcm), tca, TCA_MAX, rtm_tca_policy,
+			  extack);
 	if (err < 0)
 		return err;
 
@@ -1512,7 +1524,8 @@ static int tc_dump_qdisc(struct sk_buff
 	idx = 0;
 	ASSERT_RTNL();
 
-	err = nlmsg_parse(nlh, sizeof(*tcm), tca, TCA_MAX, NULL, NULL);
+	err = nlmsg_parse(nlh, sizeof(*tcm), tca, TCA_MAX,
+			  rtm_tca_policy, NULL);
 	if (err < 0)
 		return err;
 
@@ -1729,7 +1742,8 @@ static int tc_ctl_tclass(struct sk_buff
 	    !netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 
-	err = nlmsg_parse(n, sizeof(*tcm), tca, TCA_MAX, NULL, extack);
+	err = nlmsg_parse(n, sizeof(*tcm), tca, TCA_MAX, rtm_tca_policy,
+			  extack);
 	if (err < 0)
 		return err;
 


