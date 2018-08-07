Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED06C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F9D215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JJK6YIFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F9D215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeHHBHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:07:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44207 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeHHBHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:07:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so111105pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+cGKSWAfCBOTI6zwyjBdUsVLrQ5UA9JbG4VoiJAv538=;
        b=JJK6YIFSD2/ec0MQMPqPtS6/V/R1voFTdvSEU2rrlusX8OBR2KT/C01sXovtRp1LNV
         PR2DaNYWhTgG8qXSmzV0zmpmqtXzNue56gpCx+BQ6fNTVBXsCdONaHIMk+XRndvAP1HT
         aE6/W6B+MDvt8IDdCkOIF9DJjZFexTmY6lWYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+cGKSWAfCBOTI6zwyjBdUsVLrQ5UA9JbG4VoiJAv538=;
        b=qXkwHaELVCKK3O4j5sJSvtv3gc8PxetuEgqpSaXnUYb+TjDCsuvO/3yXcqodUJdt9Z
         dHw5OkYSpLA9YLONOJ0L0DjizG0PX2WezNJLjrQbB3yy7opP8KvFWD3MNG48fnBPgy54
         VLtFm90NDu4CWxmBtAY7JXT24n5SWeKLB7TbWVwyuOcl/FgMltGfWyxjLL2Y15x1hq7c
         PYfFmTuV+fRp8ISP6/DPYvutY3b8kBdtq5f4cacvBClWLD6XM+stvhzDJquv9VL4pElO
         Urld9Q1r5IYxvDnpbw0r1W1h5TiKhD6dSWLbHsGmh4lY+hO7WQ+ry/yHGbZZmjCnpErw
         lzLg==
X-Gm-Message-State: AOUpUlGnUyDiqs8xczNlE+bzx1J++ITDAVgwQB4Ztp4AVcjGJ9Yo4E0M
        ojJL5GokX2wlGAWnzUlz3DFoEg==
X-Google-Smtp-Source: AA+uWPy/4Luz7s++bC3Ql8r81IV6QQganoMRGBNNSzJnaSe+qiAuyPepfMUqW5brVZmHpmEqCV3j2w==
X-Received: by 2002:a63:a502:: with SMTP id n2-v6mr228345pgf.263.1533682242311;
        Tue, 07 Aug 2018 15:50:42 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id l70-v6sm3471570pge.64.2018.08.07.15.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 15:50:41 -0700 (PDT)
Date:   Tue, 7 Aug 2018 15:50:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH wireless-drivers] mt76x0: Remove VLA usage
Message-ID: <20180807225040.GA2164@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even with "const" variables, the compiler will generate warnings about
VLA usage. In the quest to remove all VLAs from the kernel[1], this uses
a #define instead of a const to do the array sizing.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Fixes: e87b5039511a ("mt76x0: eeprom files")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Please include this for the v4.19 merge window. The VLA was introduced
with the new source file (which I also note is missing a SPDX line), so
I'd like to avoid the kernel ever getting released with a VLA here.
---
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
index 1ecd018f12b8..af2fd6a1bb44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -81,15 +81,15 @@ mt76x0_efuse_read(struct mt76x0_dev *dev, u16 addr, u8 *data,
 	return 0;
 }
 
+#define MT_MAP_READS	DIV_ROUND_UP(MT_EFUSE_USAGE_MAP_SIZE, 16)
 static int
 mt76x0_efuse_physical_size_check(struct mt76x0_dev *dev)
 {
-	const int map_reads = DIV_ROUND_UP(MT_EFUSE_USAGE_MAP_SIZE, 16);
-	u8 data[map_reads * 16];
+	u8 data[MT_MAP_READS * 16];
 	int ret, i;
 	u32 start = 0, end = 0, cnt_free;
 
-	for (i = 0; i < map_reads; i++) {
+	for (i = 0; i < MT_MAP_READS; i++) {
 		ret = mt76x0_efuse_read(dev, MT_EE_USAGE_MAP_START + i * 16,
 					 data + i * 16, MT_EE_PHYSICAL_READ);
 		if (ret)
-- 
2.17.1


-- 
Kees Cook
Pixel Security
