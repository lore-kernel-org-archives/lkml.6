Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BB3C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C803D2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehZpg7kq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfAOHNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:13:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40656 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfAOHNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:13:36 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so855831plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 23:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XiObOYBMEnYUhtFYQFKhimRVBQlxUjJZmTDd1jp1WKQ=;
        b=ehZpg7kqnY1pucWToaGilTvYWNigZFMlF3T3qhUOYmMnLPzxg/jfWbqvK4LGjAdAvG
         IfCj6Hp8wGFLv690oXDNjqGztujSdO/vbCBmjEX75YyyCHTcopjpgOnvY8EXftFiTK/z
         7BIef/aJq4dUVthQ/22FPqWpt0iQwPBq+Rgyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XiObOYBMEnYUhtFYQFKhimRVBQlxUjJZmTDd1jp1WKQ=;
        b=bI5RS1RCK+A/QqwMlkh2VUsWbLySTHHA4uSfErweVz+OI0qp4TyWvKDYAjlR7hrOY+
         bOugAwHEvlthCyY48eQjr/2yEaEO/mm5nqUM0YAzB39de6mEvo1rOw5+vjyTk8uA/iYl
         IX+JpUQXn/7YienJMH96aMVcbhqdv4aBC6IJ+PvxlWTaVNb5w4M0mzDIFFLyNIN0X5Zz
         s3dma0HwQUBLxkbNzo+3qCJnWHAIlaCNFrcUl4nHAgPpfhwiJ4i9LQYfH17Rxov3Ix6J
         5dwPs4/i/leVnBurxqIO0u/vx05H1VLvGkoZ8dayhzYNOwziI4WqSe36CvyDSSzvJuaR
         droQ==
X-Gm-Message-State: AJcUukcX42+H21bRnqi6BEOJW6Bly2psS6sDRCbA4ucwcNXw+0tFRnXS
        tSoHnIfaT634byFu1MhB0o7AlTxG7dpIow==
X-Google-Smtp-Source: ALg8bN5ib8kt85qXTZpR69kDQ+gUBAcHS8pj4AX2V3sMPfBqVY7EBHfJYSVzfHozBKxRYjNRGtObyw==
X-Received: by 2002:a17:902:2b8a:: with SMTP id l10mr2538561plb.70.1547536415828;
        Mon, 14 Jan 2019 23:13:35 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t29sm3055019pfa.158.2019.01.14.23.13.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 23:13:35 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     srinivas.kandagatla@linaro.org
Cc:     broonie@kernel.org, freeman.liu@unisoc.com, baolin.wang@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: sc27xx: Convert nvmem offset to block index
Date:   Tue, 15 Jan 2019 15:12:58 +0800
Message-Id: <915eacd1c2f05ec84ae50474feb94902bd790ec3.1547536224.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

The Spreadtrum SC27XX efuse data are organized by blocks and each block
contains 2 bytes data. Moreover the nvmem core always pass the offset
in byte to the controller, so we should change the offset in byte to
the correct block index and block offset to read the data.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/nvmem/sc27xx-efuse.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index 33185d8..c6ee210 100644
--- a/drivers/nvmem/sc27xx-efuse.c
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -106,10 +106,12 @@ static int sc27xx_efuse_poll_status(struct sc27xx_efuse *efuse, u32 bits)
 static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 {
 	struct sc27xx_efuse *efuse = context;
-	u32 buf;
+	u32 buf, blk_index = offset / SC27XX_EFUSE_BLOCK_WIDTH;
+	u32 blk_offset = (offset % SC27XX_EFUSE_BLOCK_WIDTH) * BITS_PER_BYTE;
 	int ret;
 
-	if (offset > SC27XX_EFUSE_BLOCK_MAX || bytes > SC27XX_EFUSE_BLOCK_WIDTH)
+	if (blk_index > SC27XX_EFUSE_BLOCK_MAX ||
+	    bytes > SC27XX_EFUSE_BLOCK_WIDTH)
 		return -EINVAL;
 
 	ret = sc27xx_efuse_lock(efuse);
@@ -133,7 +135,7 @@ static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 	/* Set the block address to be read. */
 	ret = regmap_write(efuse->regmap,
 			   efuse->base + SC27XX_EFUSE_BLOCK_INDEX,
-			   offset & SC27XX_EFUSE_BLOCK_MASK);
+			   blk_index & SC27XX_EFUSE_BLOCK_MASK);
 	if (ret)
 		goto disable_efuse;
 
@@ -171,8 +173,10 @@ static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 unlock_efuse:
 	sc27xx_efuse_unlock(efuse);
 
-	if (!ret)
+	if (!ret) {
+		buf >>= blk_offset;
 		memcpy(val, &buf, bytes);
+	}
 
 	return ret;
 }
-- 
1.7.9.5

