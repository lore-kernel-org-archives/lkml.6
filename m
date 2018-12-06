Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736DAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B291214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAoJscDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B291214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLFT0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:26:46 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52496 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:26:43 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so3228704itg.2;
        Thu, 06 Dec 2018 11:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aLyL+5ccPVaEmYknKvT34wn/q013LqFPculhkOfivZQ=;
        b=jAoJscDsvhLQOO8H0eFnEauzPxPD/TLaTltM6aw/iS5MZihj9tvkp9WL4i6tzf7ysj
         JQZGF9oj3ARF9XSWHahZ4Qt7Piq7E9M6iPfVTmrl/HYLsw+Wyk43xc9uItME/KU+hv/+
         AM50iKwRsR/zJJSmMEgVF6U1tc2+SQ7+KtGqYH08o6xTzGx+KTTdlPwpeGJh2+/UnzPH
         Dmwx4lOy9U6oV+z87u7H06xEuohGi/40b9b8EOkhPnEhtMgNqeZKf18U5Bz2s92A6+Nh
         /Tk41LhsbYeVpvfgvG05sURItlMqKPGnYMCRzcR8Pvv4aKDHlrlBZh4Lx2aolN5WMHQ/
         fKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aLyL+5ccPVaEmYknKvT34wn/q013LqFPculhkOfivZQ=;
        b=ChZncL9TCoqBtUlBS7qytYKXp0YM5EO+PCrxzcy60uOtG9I1r6aYxgr8AnZZ4orLMQ
         Fj47I4HMDWFBx4oM3z7GMwRkKRyZxlqFYeVX52ChZ/nCw3ZpmaBgGgCeqUqVFikQ7MSZ
         Imad3HKWqXqOIRQQGoh+sQTWl48URNEbLccXJxW0JtNo7Nc9+tddvLI2Huik1HiX1j+6
         Jmjkv9rWh5j8D8IIgbgnjwkDFLbef+pN2fPMWzNqCAAQjpiu2kr67DDYWv5G4C2XCMxu
         xoMqwYhing6nfd88uNjFAXVPG0Lnvi81bBk3ZkvkEcY//lPWMFmFYrslILbGPPiCiJVb
         6REQ==
X-Gm-Message-State: AA+aEWZcQ9BUKaPP8Fy9UunCP7klUI7pR/HVOGH9xwz+hsMBzrMSVs/p
        ifZnOJYa0BvbyYks75sD3DE=
X-Google-Smtp-Source: AFSGD/WThs2FvFARw1yJNeYtscFh87kLRfRdj04KqhVGrHv1zx68Av0VX+FHjDGSqwl2oSpAY/fg5w==
X-Received: by 2002:a24:fe06:: with SMTP id w6mr20161335ith.108.1544124402281;
        Thu, 06 Dec 2018 11:26:42 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 195sm819524itm.2.2018.12.06.11.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:26:41 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] bus: imx-weim: support multiple address ranges per child node
Date:   Thu,  6 Dec 2018 14:26:31 -0500
Message-Id: <20181206192633.25319-2-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181206192633.25319-1-TheSven73@googlemail.com>
References: <20181206192633.25319-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that timing values for the child node are applied to
all chip selects in the child's address ranges.

Note that this does not support multiple timing settings per
child; this can be added in the future if required.

Example:
&weim {
	acme@0 {
		compatible = "acme,whatever";
		reg = <0 0 0x100>, <0 0x400000 0x800>,
				<1 0x400000 0x800>;
		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
				0x00000000 0xa0000240 0x00000000>;
	};
};

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 drivers/bus/imx-weim.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index d84996a4528e..5452d22d1bd8 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -46,6 +46,7 @@ static const struct imx_weim_devtype imx51_weim_devtype = {
 };
 
 #define MAX_CS_REGS_COUNT	6
+#define OF_REG_SIZE		3
 
 static const struct of_device_id weim_id_table[] = {
 	/* i.MX1/21 */
@@ -115,27 +116,40 @@ static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
 				    const struct imx_weim_devtype *devtype)
 {
 	u32 cs_idx, value[MAX_CS_REGS_COUNT];
-	int i, ret;
+	int i, ret, reg_idx, num_regs;
 
 	if (WARN_ON(devtype->cs_regs_count > MAX_CS_REGS_COUNT))
 		return -EINVAL;
 
-	/* get the CS index from this child node's "reg" property. */
-	ret = of_property_read_u32(np, "reg", &cs_idx);
+	ret = of_property_read_u32_array(np, "fsl,weim-cs-timing",
+					 value, devtype->cs_regs_count);
 	if (ret)
 		return ret;
 
-	if (cs_idx >= devtype->cs_count)
+	/*
+	 * the child node's "reg" property may contain multiple address ranges,
+	 * extract the chip select for each.
+	 */
+	num_regs = of_property_count_elems_of_size(np, "reg", OF_REG_SIZE);
+	if (num_regs < 0)
+		return num_regs;
+	if (!num_regs)
 		return -EINVAL;
+	for (reg_idx = 0; reg_idx < num_regs; reg_idx++) {
+		/* get the CS index from this child node's "reg" property. */
+		ret = of_property_read_u32_index(np, "reg",
+					reg_idx*OF_REG_SIZE, &cs_idx);
+		if (ret)
+			break;
 
-	ret = of_property_read_u32_array(np, "fsl,weim-cs-timing",
-					 value, devtype->cs_regs_count);
-	if (ret)
-		return ret;
+		if (cs_idx >= devtype->cs_count)
+			return -EINVAL;
 
-	/* set the timing for WEIM */
-	for (i = 0; i < devtype->cs_regs_count; i++)
-		writel(value[i], base + cs_idx * devtype->cs_stride + i * 4);
+		/* set the timing for WEIM */
+		for (i = 0; i < devtype->cs_regs_count; i++)
+			writel(value[i],
+				base + cs_idx * devtype->cs_stride + i * 4);
+	}
 
 	return 0;
 }
-- 
2.17.1

