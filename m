Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4B1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C97221920
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="X4ZmATpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436787AbfBOLym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:54:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42701 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404469AbfBOLym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:54:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so4738747pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 03:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=axv7HdmEMuSVKhDn2b9kqc6qnXjuuB2cUs2wKWrlCq8=;
        b=X4ZmATpK5cagjSaQlT8fQuGxwjCLyIoE8ULXAmnvwltxPZjLbfARI08AFOW1HjyuFl
         WaP1YyjwUBWJsXZeq0CI8BX0tMxrmtVKAwBlpqcwMd2cbf2YR5JQcrQBB2qpo+LC+Gv4
         d760TE++N/+/pS69kKlXyUuSzDl+W3hAzBN9UisslyX+cBYp5eUvf8EYI8hESjPfP9c0
         KEFCaOdHIrygwSiDKkPnUYen7rjIanKfDUFA93kPYi5sBMKJDeDyTob9/xVdkOWl+VwU
         a8C+VdIrUF3pdx3Aho+V4Q/+a/j/j2rxj25oZcU9Ouakr+CyZmTmBnY8wPoqBTga+O+P
         Go4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=axv7HdmEMuSVKhDn2b9kqc6qnXjuuB2cUs2wKWrlCq8=;
        b=XRDdzcV58Xb4BPTeLQQ7neZO4v1GN8QOrkHvms+rEgRfSlCFcfYl2q0MqikdfNU7Kb
         GayjvL10YEWxyaFMDRF8XmmejC1UKP6IzT6jdhQF03FoK4Mryw8tshay6qy1Op+jreq2
         akXjTwK0z3Skxzc66dDG+2+4tuI3YQGwalq8rbTTMQt085PBX3bTMVhskM09Zuae1SED
         E2+GVeubm8TOXmTZh/wUFFAkX9DN4dwRHip2IP2rwWilxIBxDy6bIEvWuxQn86T2K6gv
         Ptcakts05Ip7eNOy/MGXNk3eog+7TqxtfmB463/EJv3+oT9W4NffmkohJN2oLQ7FCPFP
         5X8A==
X-Gm-Message-State: AHQUAubvBELxP4TTKQZMYvgQk6uoGuL83U67Dmy/ijYDZCweC+Yvd4Cd
        vYK/jKL44gvWxJGZFyI4xAWS9g==
X-Google-Smtp-Source: AHgI3IZtXAKQ1rR5l1DBXkwhkNNC97C3udaN5jV26Q4Aa4ilzkPDVmSm7QE4wMULECawdqnuvdtLBw==
X-Received: by 2002:a62:b15:: with SMTP id t21mr9769151pfi.136.1550231680669;
        Fri, 15 Feb 2019 03:54:40 -0800 (PST)
Received: from localhost.localdomain (36-239-208-250.dynamic-ip.hinet.net. [36.239.208.250])
        by smtp.gmail.com with ESMTPSA id y6sm8495434pfd.104.2019.02.15.03.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 03:54:39 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: ltc3676: Simplify .readable_reg and .writable_reg callbacks
Date:   Fri, 15 Feb 2019 19:54:20 +0800
Message-Id: <20190215115421.4811-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use case range for continuous range to make the code shorter.
The .readable_reg and .writable_reg implementation are exactly the same,
so use a common ltc3676_readable_writeable_reg function instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ltc3676.c | 63 +++----------------------------------
 1 file changed, 5 insertions(+), 58 deletions(-)

diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index 71fd0f2a4b76..549a1a243870 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -241,61 +241,10 @@ static struct regulator_desc ltc3676_regulators[LTC3676_NUM_REGULATORS] = {
 	LTC3676_FIXED_REG(LDO4, ldo4, LDOB, 2),
 };
 
-static bool ltc3676_writeable_reg(struct device *dev, unsigned int reg)
+static bool ltc3676_readable_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case LTC3676_IRQSTAT:
-	case LTC3676_BUCK1:
-	case LTC3676_BUCK2:
-	case LTC3676_BUCK3:
-	case LTC3676_BUCK4:
-	case LTC3676_LDOA:
-	case LTC3676_LDOB:
-	case LTC3676_SQD1:
-	case LTC3676_SQD2:
-	case LTC3676_CNTRL:
-	case LTC3676_DVB1A:
-	case LTC3676_DVB1B:
-	case LTC3676_DVB2A:
-	case LTC3676_DVB2B:
-	case LTC3676_DVB3A:
-	case LTC3676_DVB3B:
-	case LTC3676_DVB4A:
-	case LTC3676_DVB4B:
-	case LTC3676_MSKIRQ:
-	case LTC3676_MSKPG:
-	case LTC3676_USER:
-	case LTC3676_HRST:
-	case LTC3676_CLIRQ:
-		return true;
-	}
-	return false;
-}
-
-static bool ltc3676_readable_reg(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case LTC3676_IRQSTAT:
-	case LTC3676_BUCK1:
-	case LTC3676_BUCK2:
-	case LTC3676_BUCK3:
-	case LTC3676_BUCK4:
-	case LTC3676_LDOA:
-	case LTC3676_LDOB:
-	case LTC3676_SQD1:
-	case LTC3676_SQD2:
-	case LTC3676_CNTRL:
-	case LTC3676_DVB1A:
-	case LTC3676_DVB1B:
-	case LTC3676_DVB2A:
-	case LTC3676_DVB2B:
-	case LTC3676_DVB3A:
-	case LTC3676_DVB3B:
-	case LTC3676_DVB4A:
-	case LTC3676_DVB4B:
-	case LTC3676_MSKIRQ:
-	case LTC3676_MSKPG:
-	case LTC3676_USER:
+	case LTC3676_BUCK1 ... LTC3676_IRQSTAT:
 	case LTC3676_HRST:
 	case LTC3676_CLIRQ:
 		return true;
@@ -306,9 +255,7 @@ static bool ltc3676_readable_reg(struct device *dev, unsigned int reg)
 static bool ltc3676_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case LTC3676_IRQSTAT:
-	case LTC3676_PGSTATL:
-	case LTC3676_PGSTATRT:
+	case LTC3676_IRQSTAT ... LTC3676_PGSTATRT:
 		return true;
 	}
 	return false;
@@ -317,8 +264,8 @@ static bool ltc3676_volatile_reg(struct device *dev, unsigned int reg)
 static const struct regmap_config ltc3676_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.writeable_reg = ltc3676_writeable_reg,
-	.readable_reg = ltc3676_readable_reg,
+	.writeable_reg = ltc3676_readable_writeable_reg,
+	.readable_reg = ltc3676_readable_writeable_reg,
 	.volatile_reg = ltc3676_volatile_reg,
 	.max_register = LTC3676_CLIRQ,
 	.use_single_read = true,
-- 
2.17.1

