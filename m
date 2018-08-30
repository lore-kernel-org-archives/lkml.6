Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174C6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08D420834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq1+ke7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08D420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeH3TvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:51:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38741 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbeH3TsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so8508136wrc.5;
        Thu, 30 Aug 2018 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eOlesON9JEbI3RiqZ3yU2XvULXMLDkhbr+tAcyHX1jI=;
        b=Nq1+ke7O/3ya6/cyzzgBbnofTTSbq4B8nYtp63N3AU68AKwaR+lq1bS44T09X84raD
         ogLjL22wB1uB1eCKw8HIgJghhEU7FBsguP8qW1kJ1mOOGfS11dpuJPWvStDCuVkmTezB
         DlDGNdk0GTnDOkz+XmzpDaZKGq99jrzNBZELlDXGiYtSgib2Fon8jvJRejlIT7had5RP
         LA1EZpPD43sEqxtM6Zt1+jirAzGcTTpCXZ5LW9Dn+U95rVDwdhqpQQw4SdwrjzqVGQPk
         Sv3HjM19hXRbosqiSPdFLauT3y/FOsKHLmlkgXBnlC/vN9kzRkSyc0AI1/eq92t2ZC5W
         fMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eOlesON9JEbI3RiqZ3yU2XvULXMLDkhbr+tAcyHX1jI=;
        b=h/9/0uBF/LrUyQ3SrT09B84koft1oZMWTL4HDU+wVZxbA3DYFLKZQ+2zDEkgUmPxbD
         nx/nX1W9++SeIM5Gckt6SN18epoMUD1MLoMtZHLfCDWgbIBGbaFaowE85/H13dTpkVRJ
         cTpNxZ3jXun8sxlB8tMOvjdEFmdmYIExR/a8Rj4RxfEt0YhO9vCRy+O/cI0x3pyyBLg5
         GqP/d3P+cpOWAoFpDry4C2hZEuXS2QUjju1s7ia8DpFXCRTMXfgIf7fBa89uXLSUGP7R
         IFo0w6bpeKkyB0bPNhYX3rQdBYCqKMD9svsZn2Hj9vBb05r0uGFK3ln+ojtn4qpR4LBW
         16sg==
X-Gm-Message-State: APzg51Ac5QkCAxPWN2py/5/Nss041uHfYCjo6Vzebwc01B7gcu7xQKbM
        AS856YGWSia4eUBsMqQgJQk=
X-Google-Smtp-Source: ANB0VdZydzVwlgmNC9jd6c1kvxIV3So3eSC9twIoJ2AGHHYmBHN7Vik0oavzqD6xr/AuRK25jSD16Q==
X-Received: by 2002:adf:8504:: with SMTP id 4-v6mr7768377wrh.72.1535643922732;
        Thu, 30 Aug 2018 08:45:22 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:22 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 03/30] iio: adc: Remove ID table
Date:   Thu, 30 Aug 2018 17:44:51 +0200
Message-Id: <20180830154518.29507-4-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To disable the driver we are removing the compatibles.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 04d7147e0110..d95dd0fde2a6 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -698,21 +698,12 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id sun4i_gpadc_id[] = {
-	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_data },
-	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_data },
-	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_data },
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(platform, sun4i_gpadc_id);
-
 static struct platform_driver sun4i_gpadc_driver = {
 	.driver = {
 		.name = "sun4i-gpadc-iio",
 		.of_match_table = sun4i_gpadc_of_id,
 		.pm = &sun4i_gpadc_pm_ops,
 	},
-	.id_table = sun4i_gpadc_id,
 	.probe = sun4i_gpadc_probe,
 	.remove = sun4i_gpadc_remove,
 };
-- 
2.11.0

