Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B52C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93592190C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfAFIj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:39:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:57178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726431AbfAFIiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:38:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD781AC38;
        Sun,  6 Jan 2019 08:38:02 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH lora-next 01/11] net: lora: sx125x: Abort on wrong version
Date:   Sun,  6 Jan 2019 09:37:44 +0100
Message-Id: <20190106083754.6004-2-afaerber@suse.de>
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

This helps detect issues such as the concentrator being in reset.

Enhance error output while at it.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx125x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/lora/sx125x.c b/drivers/net/lora/sx125x.c
index 90e7cdb9d1a8..0228d1f887a0 100644
--- a/drivers/net/lora/sx125x.c
+++ b/drivers/net/lora/sx125x.c
@@ -195,9 +195,13 @@ static int __maybe_unused sx125x_regmap_probe(struct device *dev, struct regmap
 	if (true) {
 		ret = regmap_read(priv->regmap, SX1255_VERSION, &val);
 		if (ret) {
-			dev_err(dev, "version read failed\n");
+			dev_err(dev, "version read failed (%d)\n", ret);
 			return ret;
 		}
+		if (val != 0x21) {
+			dev_err(dev, "unexpected version: %u\n", val);
+			return -EINVAL;
+		}
 		dev_info(dev, "SX125x version: %02x\n", val);
 	}
 
-- 
2.16.4

