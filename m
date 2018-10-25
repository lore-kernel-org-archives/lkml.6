Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C471DECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0CE20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnqZB+eW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0CE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbeJYWxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730875AbeJYWxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:12 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF64220870;
        Thu, 25 Oct 2018 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477214;
        bh=2HoZ0JijPGowB7r0pEZ4DzNssaTZNBYMFVwf00fhVoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnqZB+eWpT0RBcTfnzFleT7kEVinoEz36TS6wccveKCWK1XsKsYjorHft/AZItW8b
         vv5c4O30AzeIH9qMZpKs5VO8VXKRKth4f3IDR6tQondoKKMY5CiS706OP3RzsuFt1w
         mWCsGC/4t6wG1GzaMXZILGya4oGy+kiuYC2vIZ/c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 53/98] rtnl: don't account unused struct ifla_port_vsi in rtnl_port_size
Date:   Thu, 25 Oct 2018 10:18:08 -0400
Message-Id: <20181025141853.214051-53-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 025331df34f6722f86b467cb13a69326444ab1bc ]

When allocating rtnl dump messages, struct ifla_port_vsi is never dumped,
so we can save header plus payload in rtnl_port_size(). Infact, attribute
IFLA_PORT_VSI_TYPE and struct ifla_port_vsi are not used anywhere in
the kernel. We only need to keep the nla policy should applications in
user space be filling this out. Same NLA_BINARY issue exists as was fixed
in 364d5716a7ad ("rtnetlink: ifla_vf_policy: fix misuses of NLA_BINARY")
and others, but then again IFLA_PORT_VSI_TYPE is not used anywhere, so
just add a comment that it's unused.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 51301ad3c2d9..cd09f85ba8d6 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -817,8 +817,6 @@ static size_t rtnl_port_size(const struct net_device *dev,
 {
 	size_t port_size = nla_total_size(4)		/* PORT_VF */
 		+ nla_total_size(PORT_PROFILE_MAX)	/* PORT_PROFILE */
-		+ nla_total_size(sizeof(struct ifla_port_vsi))
-							/* PORT_VSI_TYPE */
 		+ nla_total_size(PORT_UUID_MAX)		/* PORT_INSTANCE_UUID */
 		+ nla_total_size(PORT_UUID_MAX)		/* PORT_HOST_UUID */
 		+ nla_total_size(1)			/* PROT_VDP_REQUEST */
@@ -1231,14 +1229,19 @@ static const struct nla_policy ifla_port_policy[IFLA_PORT_MAX+1] = {
 	[IFLA_PORT_VF]		= { .type = NLA_U32 },
 	[IFLA_PORT_PROFILE]	= { .type = NLA_STRING,
 				    .len = PORT_PROFILE_MAX },
-	[IFLA_PORT_VSI_TYPE]	= { .type = NLA_BINARY,
-				    .len = sizeof(struct ifla_port_vsi)},
 	[IFLA_PORT_INSTANCE_UUID] = { .type = NLA_BINARY,
 				      .len = PORT_UUID_MAX },
 	[IFLA_PORT_HOST_UUID]	= { .type = NLA_STRING,
 				    .len = PORT_UUID_MAX },
 	[IFLA_PORT_REQUEST]	= { .type = NLA_U8, },
 	[IFLA_PORT_RESPONSE]	= { .type = NLA_U16, },
+
+	/* Unused, but we need to keep it here since user space could
+	 * fill it. It's also broken with regard to NLA_BINARY use in
+	 * combination with structs.
+	 */
+	[IFLA_PORT_VSI_TYPE]	= { .type = NLA_BINARY,
+				    .len = sizeof(struct ifla_port_vsi) },
 };
 
 static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
-- 
2.17.1

