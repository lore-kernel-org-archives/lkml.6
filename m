Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878D6C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E5F20855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVOUnK34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfA1PzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42642 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbfA1PzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so18605864wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4uJKpLWM6aPmr+zhJuvVuuv2Ucq9pVDA4S2r+Yn6Xzk=;
        b=jVOUnK34SgCGU4+niCiHTbiLCK6fH4+xrDwa49Pd9qknCFh2xEyLTDDip2x6TUUVKO
         CH/13tx2t7q53C4haDiFitiVzy33h50K4LYkgrEmya/NkZxwg6HqKyIu4zeH9QMK8im7
         voxeWxUNRisqGBz66XcUeZ2VhtgiAX+FSkoQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4uJKpLWM6aPmr+zhJuvVuuv2Ucq9pVDA4S2r+Yn6Xzk=;
        b=rTMM2cDrgZ9KT3vXuJJkAZqdcozzOUIqWhDky5JWZH63vgyzSz2f/6HsNRzS/vuWal
         wv62C6pjDxBoGi/5MfWhh9xhHIZ5pREKsOhV77fyt4bIjxiKlNgh+axSvCakhNjCf9Ln
         50Vr69cdBIiUFbxVqMcQFH+YBu/M+g6kJVxVmInz1Njz4fwChIIYH228eRYAwaiS1NG1
         2XEGNn0hLEE4dIy054uKNqwvYirmdjqoXq0xqx40zc0SYog+pMX9poWyhuXYxf8nObs1
         i2Z/+0VovBjW4o/IECevH1gUE5LsprPUctQ8u3ghsAYo5WYqWWb+xgkfm2OYYsMG3aeI
         z93g==
X-Gm-Message-State: AJcUukfW8EfCVKnTU78PATRyCfGP73THuKhsSHs1/kO7K7q7h6gavFip
        TZdf5JkBmzTSiqxTyDZHn6lpxpQAadw=
X-Google-Smtp-Source: ALg8bN4UMvmxnQdJteykRze7dUhP2ygrSemOWspYivTe6ggVoEhAjSOqC1NseuEJA3YZT+W40sQPlg==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr22085966wrg.183.1548690909803;
        Mon, 28 Jan 2019 07:55:09 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:08 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] nvmem: sc27xx: Convert nvmem offset to block index
Date:   Mon, 28 Jan 2019 15:54:54 +0000
Message-Id: <20190128155506.25566-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
References: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sc27xx-efuse.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index 33185d8d82cf..c6ee21018d80 100644
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
2.20.1

