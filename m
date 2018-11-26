Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C67C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2BB20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2BB20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeK0D36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:29:58 -0500
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:53700 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0D36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:29:58 -0500
Received: from [109.168.11.45] (port=43870 helo=pc-ceresoli.dev.aim)
        by srv-hp10.netsons.net with esmtpa (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1gRJqu-00BwAq-Uw; Mon, 26 Nov 2018 17:35:17 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-media@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] media: imx274: fix stack corruption in imx274_read_reg
Date:   Mon, 26 Nov 2018 17:35:07 +0100
Message-Id: <20181126163507.31598-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx274_read_reg() takes a u8 pointer ("reg") and casts it to pass it
to regmap_read(), which takes an unsigned int pointer. This results in
a corrupted stack and random crashes.

Fixes: 0985dd306f72 ("media: imx274: V4l2 driver for Sony imx274 CMOS sensor")
Cc: stable@vger.kernel.org # 4.15.x
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Notes!

I have no evidence of this bug showing up in the mainline driver. It
appeared on a modified version where imx274_read_reg() is used,
unmodified, in a different way than it does in mainline (passing a
pointer to a single u8 instead of a pointer to an element of a u8
array).

Also the bug is only present in versions v4.15 (where the driver was
added) to v4.19. The offending function is unused since commit
ca017467c78b ("media: imx274: add helper to read multibyte
registers"), merged in v4.20-rc1, thus master is not affected. I'm
sending this bugfix patch anyway for easier integration in the stable
branches. Later I plan to send a patch against master to entirely
remove the function. Or somebody might want to use this function
again, so better having a fixed version out anyway.

I'm not 100% sure this qualifies this commit for stable trees.
---
 drivers/media/i2c/imx274.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index e1b0395a657f..40c717f13eb8 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -619,16 +619,19 @@ static int imx274_write_table(struct stimx274 *priv, const struct reg_8 table[])
 
 static inline int imx274_read_reg(struct stimx274 *priv, u16 addr, u8 *val)
 {
+	unsigned int uint_val;
 	int err;
 
-	err = regmap_read(priv->regmap, addr, (unsigned int *)val);
+	err = regmap_read(priv->regmap, addr, &uint_val);
 	if (err)
 		dev_err(&priv->client->dev,
 			"%s : i2c read failed, addr = %x\n", __func__, addr);
 	else
 		dev_dbg(&priv->client->dev,
 			"%s : addr 0x%x, val=0x%x\n", __func__,
-			addr, *val);
+			addr, uint_val);
+
+	*val = uint_val;
 	return err;
 }
 
-- 
2.17.1

