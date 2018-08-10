Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E859C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C05922442
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l9QwF5bN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C05922442
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeHJWSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:18:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46760 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeHJWSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:18:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so4969495pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+p3taYWqtpEK/xi30mPIvDZFkfdqCDS95GiwRtUaeQ=;
        b=l9QwF5bN89OWfhhv5ff+4HbazuiEvAQ9mMZ9QCy3kCDyv+/ON79j1HJJilB3I06CHZ
         5SrlEjUCr7NuKiVI+jEfrqJHq9f8ay7zrBNrFkScH7OnCqlynjsq1p3f8JCn/oQIgJdj
         PXamoRZ0LNrXAb74zHOdvkJZGbwn9xLl3109c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+p3taYWqtpEK/xi30mPIvDZFkfdqCDS95GiwRtUaeQ=;
        b=Gs6EWdxPN/mm+Qd0YWz1GIKmWM02ecOh9oyIMaBaEm7L7JeifxAPq36e59hhdn1wxH
         eRitBt1uQm6bISOwGpgzggRE8xOFCOHCcphIvLPERm7HdV/C4cxPQhIrh1fLH7yI9ra0
         9sRs3z8fc6hxjjUJGVUzbYWwqp/FKbEH0QdK4usej1sg6RDi+VFmAyNY7JkVYLzLtx9i
         M/uQ6oH22EfXng/x2ZFZxouT4bZNq/z8n071DHzax8AX+X/NWIdg02nHk8QdSxbnBifL
         bmT77z1kekhzGXQe+qbtGzj4l52KkPwEMH2WRpX7duOBd8ho11CvgF9vbEogQRBEKYhW
         2WDw==
X-Gm-Message-State: AOUpUlFuZGv6UXwJ3DsoGeXgoFKsF8RoHOrzaSm2itCKCvLFCmdQwWp2
        p6zdsr0EcEr/zk3b5GuFZhkjAQ==
X-Google-Smtp-Source: AA+uWPyEENIHzZiv1i9SvM12UZdlH9vv4gnqzrXbP3SR60rlK7hv3Hry6+35aeJNVRK5fXF9td4BQA==
X-Received: by 2002:a63:4951:: with SMTP id y17-v6mr7856683pgk.32.1533930437510;
        Fri, 10 Aug 2018 12:47:17 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id a77-v6sm24209113pfj.38.2018.08.10.12.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 12:47:16 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] iio: adc: qcom-spmi-adc5: Add ADC5_AMUX_THM[24]_100K_PU to rev2 channel list
Date:   Fri, 10 Aug 2018 12:47:02 -0700
Message-Id: <20180810194702.144641-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADC5_AMUX_THM2_100K_PU and ADC5_AMUX_THM4_100K_PU to the list of
rev2 ADC channels.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index a4299417f3de..1f9298a5c83d 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -491,8 +491,12 @@ static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_PMIC_THERM)
 	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
+	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 1,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
 	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
+	[ADC5_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_100k_pu", 1,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
 	[ADC5_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_100k_pu", 1,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
 	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm_100k_pu", 1,
-- 
2.18.0.597.ga71716f1ad-goog

