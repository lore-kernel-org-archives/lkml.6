Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3385AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60132063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217324;
	bh=ktXytxDznS5A74EnKIr1XLrgtui9bdZ+qy3QdmGGT74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MD6+mEQPEzg4gbP8pVjvTearJtoe2im+Qz1461shkhFGfb9CfHt5LoWB+X+yDwfoR
	 hvUwe7Zu3hJGkiOXUoLP1R6AwR6HWgQvy1s4S95jiIg38F9OlnbAvWF0o8RAs+Ljk9
	 SOGHad+b9juzc0LXXiZo1nKgp8oGZCICqU/hM74U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbfAKOfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389389AbfAKOfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342A4204EC;
        Fri, 11 Jan 2019 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217319;
        bh=ktXytxDznS5A74EnKIr1XLrgtui9bdZ+qy3QdmGGT74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJWbTNpFSzuIkFEjLZLnuIdiSsQY0k7pJBaD+twRjYn0CV9yBXTL2pG5NdN1v8QSM
         0Kq5bagaPzt21J6hS7jk6XIynCFCt1A/E1mswJ44eQJu52I5Dm545qC9GQMvW4Uda0
         Mfiq880cKh//a7wsC9LIvpOBRLKkBVFPYx5Kuxrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Aring <aring@mojatatu.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 019/148] ieee802154: hwsim: fix off-by-one in parse nested
Date:   Fri, 11 Jan 2019 15:13:17 +0100
Message-Id: <20190111131115.092790561@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



