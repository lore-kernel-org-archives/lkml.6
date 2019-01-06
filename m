Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F50C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC5B2184C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfAFIjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:39:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:57212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbfAFIiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:38:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7E55ACE3;
        Sun,  6 Jan 2019 08:38:03 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH lora-next 04/11] net: lora: sx130x: Fix soft reset
Date:   Sun,  6 Jan 2019 09:37:47 +0100
Message-Id: <20190106083754.6004-5-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190106083754.6004-1-afaerber@suse.de>
References: <20190106083754.6004-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soft reset bit is volatile. As it lives in the frequently accessed
page register, refrain from marking the register as volatile and
instead bypass the cache for this one write.

Mark the cache as dirty afterwards. This does not appear to clear it,
so manually drop the whole cache. If we don't have a cache configured,
this may return -EINVAL, so guard it appropriately to aid in testing.

Cc: Ben Whitten <ben.whitten@gmail.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx130x.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 7a387d9a75a0..4ba02836a35d 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -182,7 +182,19 @@ static int sx130x_field_write(struct sx130x_priv *priv,
 
 static int sx130x_soft_reset(struct sx130x_priv *priv)
 {
-	return sx130x_field_write(priv, F_SOFT_RESET, 1);
+	int ret;
+
+	regcache_cache_bypass(priv->regmap, true);
+	ret = sx130x_field_write(priv, F_SOFT_RESET, 1);
+	regcache_cache_bypass(priv->regmap, false);
+	if (ret)
+		return ret;
+
+	regcache_mark_dirty(priv->regmap);
+	if (sx130x_regmap_config.cache_type != REGCACHE_NONE)
+		return regcache_drop_region(priv->regmap,
+			0, sx130x_regmap_config.max_register);
+	return 0;
 }
 
 static int sx130x_agc_ram_read(struct sx130x_priv *priv, u8 addr, unsigned int *val)
-- 
2.16.4

