Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F5BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EDE214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865286;
	bh=a34xNFpJpIR2g2yWNWh41JkYflYK/P5McuedTuEcMfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17WNkzftcX3A+VDLSfyZjlpArFPbI9Mpnjy/JPK2ghjpPELdkEtQsM7VZde1F8ZzP
	 RRVUmFamJPAh6DVuYFUkPTifkEwaN5las9s1K15tKkVjZRk7pkhkBWBTM0TtAVVSej
	 F86o20sGqq1r0ZkSXZdLHUv+xGthzhOyEtE09Htk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbeLZXBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:01:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbeLZWg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BDCD218FC;
        Wed, 26 Dec 2018 22:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863788;
        bh=a34xNFpJpIR2g2yWNWh41JkYflYK/P5McuedTuEcMfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ua7xW9/fTS15ew8NX+XWvu/n1XZM/aSQHdHewejZAKz4TP3XN8AG9b883o3iqkxyH
         5srZqlHLF+LDIhg4Fc3S38DKRGb2gYtmLUljRREXe/kyXmXdD5dRKKpAl6u6MalftI
         N/ispR0cM4JdSTt90ODpivm+aYRNfPiDwCKb3DeE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Aring <aring@mojatatu.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 19/97] ieee802154: hwsim: fix off-by-one in parse nested
Date:   Wed, 26 Dec 2018 17:34:39 -0500
Message-Id: <20181226223557.149329-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Aring <aring@mojatatu.com>

[ Upstream commit a73d4e1490913b76b292f91553b7ba08a65caa3f ]

This patch fixes a off-by-one mistake in nla_parse_nested() functions of
mac802154_hwsim driver. I had to enabled stack protector so I was able
to reproduce it.

Reference: https://github.com/linux-wpan/wpan-tools/issues/17

Signed-off-by: Alexander Aring <aring@mojatatu.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index bf70ab892e69..624bff4d3636 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -500,7 +500,7 @@ static int hwsim_del_edge_nl(struct sk_buff *msg, struct genl_info *info)
 	    !info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE])
 		return -EINVAL;
 
-	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX + 1,
+	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX,
 			     info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE],
 			     hwsim_edge_policy, NULL))
 		return -EINVAL;
@@ -550,7 +550,7 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 	    !info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE])
 		return -EINVAL;
 
-	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX + 1,
+	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX,
 			     info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE],
 			     hwsim_edge_policy, NULL))
 		return -EINVAL;
-- 
2.19.1

