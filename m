Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A066C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E4A2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AQdKyV33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E4A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeLDTOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:14:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44995 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDTOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:14:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so7786053pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C67/nsy2CoF6z2v9yZ5QbeDbvOTlhWg75hvnJgKsDQ8=;
        b=AQdKyV33pG3hEHDfKCpn0uRz6bkLY7ysUaTj8DUsZQ62ScpHHzIs/2pDjWMCp+wVCW
         EoNsjN0CANoJHNvM1aESw1OfTszrPSd1sb9vnzwlgu3y7gDz/01vyOtRN4/icLy0GEI2
         Nsq/hZCbBZ4ZrAxgYKnR6baYZj/vRXvA8q3rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C67/nsy2CoF6z2v9yZ5QbeDbvOTlhWg75hvnJgKsDQ8=;
        b=hwKwEYRHi0mlLpF25ELs+RYKBS1HHIFzBRkEvgDhMmBNqTYGndmaa0gZWExM7TSqi8
         GyU3O6rWBJ+UaL9jvsfWfyyUYqEnoxTmiU3iMUb+HLyLI/UJul1hlgKdPqUw2ADXONzS
         hoAcayWmho+iOkf33upFeBxnhCcghFsqd71LU94oG1DdgJ/voJqrtz04wCRzrwawbV8m
         zQWBB/WSKhwej/L3G95arn73PbyU5zx1of+syWl+GJLWp87UkvQDTgziB6fKO9mn7jfU
         6pj3ehvKQpOS4JT11gaE0ZGxt1N/p1gvwLs9376Hkrdfl70mZj9nh+ULg6crpQph/UcT
         vfMQ==
X-Gm-Message-State: AA+aEWazks65l+kizd8MKmjOFCqLAdMiP8HxEOAl3MncoEiQdsVA/Uxj
        yMg0180Kzm6LAjVDi1TXh5PlVg==
X-Google-Smtp-Source: AFSGD/WLbIO1MifDxvlrLkkTybUcX77D4bBsCpDQxxV5Vxa6DORX/NqodBafMYf1ZBXpXDNT8/Xtng==
X-Received: by 2002:a65:40c5:: with SMTP id u5mr17116170pgp.46.1543950881545;
        Tue, 04 Dec 2018 11:14:41 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id l69sm25056091pfb.75.2018.12.04.11.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 11:14:40 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     mka@chromium.org, Evan Green <evgreen@chromium.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: adc: qcom-spmi-adc5: Initialize prescale properly
Date:   Tue,  4 Dec 2018 11:14:19 -0800
Message-Id: <20181204191419.144726-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adc5_get_dt_data uses a local, prop, feeds it to adc5_get_dt_channel_data,
and then puts the result into adc->chan_props. The problem is
adc5_get_dt_channel_data may not initialize that structure fully, so a
garbage value is used for prescale if the optional "qcom,pre-scaling" is
not defined in DT. adc5_read_raw then uses this as an array index,
generating a crash that looks like this:

[    6.683186] Unable to handle kernel paging request at virtual address ffffff90e78c7964
Call trace:
qcom_vadc_scale_code_voltage_factor+0x74/0x104
qcom_vadc_scale_hw_calib_die_temp+0x20/0x60
qcom_adc5_hw_scale+0x78/0xa4
adc5_read_raw+0x3d0/0x65c
iio_channel_read+0x240/0x30c
iio_read_channel_processed+0x10c/0x150
qpnp_tm_get_temp+0xc0/0x40c
of_thermal_get_temp+0x7c/0x98
thermal_zone_get_temp+0xac/0xd8
thermal_zone_device_update+0xc0/0x38c
qpnp_tm_probe+0x624/0x81c
platform_drv_probe+0xe4/0x11c
really_probe+0x188/0x3fc
driver_probe_device+0xb8/0x188
__device_attach_driver+0x114/0x180
bus_for_each_drv+0xd8/0x118
__device_attach+0x180/0x27c
device_initial_probe+0x20/0x2c
bus_probe_device+0x78/0x124
deferred_probe_work_func+0xfc/0x138
process_one_work+0x3d8/0x8b0
process_scheduled_works+0x48/0x6c
worker_thread+0x488/0x7cc
kthread+0x24c/0x264
ret_from_fork+0x10/0x18

Unfortunately, when I went to add the initializer for this and tried to
boot it, my machine shut down immediately, complaining that it was
hotter than the sun. It appears that adc5_chans_pmic and adc5_chans_rev2
were initializing prescale_index as if it were directly a divisor,
rather than the index into adc5_prescale_ratios that it is.

Fix the uninitialized value, and change the static initialization to use
indices into adc5_prescale_ratios.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/iio/adc/qcom-spmi-adc5.c | 58 +++++++++++++++++---------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index f9af6b082916b..6a866cc187f7d 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -423,6 +423,7 @@ struct adc5_channels {
 	enum vadc_scale_fn_type scale_fn_type;
 };
 
+/* In these definitions, _pre refers to an index into adc5_prescale_ratios. */
 #define ADC5_CHAN(_dname, _type, _mask, _pre, _scale)			\
 	{								\
 		.datasheet_name = _dname,				\
@@ -443,63 +444,63 @@ struct adc5_channels {
 		  _pre, _scale)						\
 
 static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
-	[ADC5_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 1,
+	[ADC5_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 0,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 1,
+	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 0,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 3,
+	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 1,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 3,
+	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 1,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 1,
+	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 0,
 					SCALE_HW_CALIB_PMIC_THERM)
-	[ADC5_USB_IN_I]		= ADC5_CHAN_VOLT("usb_in_i_uv", 1,
+	[ADC5_USB_IN_I]		= ADC5_CHAN_VOLT("usb_in_i_uv", 0,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_USB_IN_V_16]	= ADC5_CHAN_VOLT("usb_in_v_div_16", 16,
+	[ADC5_USB_IN_V_16]	= ADC5_CHAN_VOLT("usb_in_v_div_16", 8,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_CHG_TEMP]		= ADC5_CHAN_TEMP("chg_temp", 1,
+	[ADC5_CHG_TEMP]		= ADC5_CHAN_TEMP("chg_temp", 0,
 					SCALE_HW_CALIB_PM5_CHG_TEMP)
 	/* Charger prescales SBUx and MID_CHG to fit within 1.8V upper unit */
-	[ADC5_SBUx]		= ADC5_CHAN_VOLT("chg_sbux", 3,
+	[ADC5_SBUx]		= ADC5_CHAN_VOLT("chg_sbux", 1,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_MID_CHG_DIV6]	= ADC5_CHAN_VOLT("chg_mid_chg", 6,
+	[ADC5_MID_CHG_DIV6]	= ADC5_CHAN_VOLT("chg_mid_chg", 3,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 1,
+	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 0,
 					SCALE_HW_CALIB_XOTHERM)
-	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
+	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
-	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 1,
+	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 0,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
-	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
+	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 0,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
-	[ADC5_AMUX_THM2]	= ADC5_CHAN_TEMP("amux_thm2", 1,
+	[ADC5_AMUX_THM2]	= ADC5_CHAN_TEMP("amux_thm2", 0,
 					SCALE_HW_CALIB_PM5_SMB_TEMP)
 };
 
 static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
-	[ADC5_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 1,
+	[ADC5_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 0,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 1,
+	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 0,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 3,
+	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 1,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 3,
+	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 1,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_VCOIN]		= ADC5_CHAN_VOLT("vcoin", 3,
+	[ADC5_VCOIN]		= ADC5_CHAN_VOLT("vcoin", 1,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 1,
+	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 0,
 					SCALE_HW_CALIB_PMIC_THERM)
-	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
+	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
-	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 1,
+	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 0,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
-	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
+	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 0,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
-	[ADC5_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_100k_pu", 1,
+	[ADC5_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_100k_pu", 0,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
-	[ADC5_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_100k_pu", 1,
+	[ADC5_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_100k_pu", 0,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
-	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm_100k_pu", 1,
+	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm_100k_pu", 0,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
 };
 
@@ -558,6 +559,9 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 			return ret;
 		}
 		prop->prescale = ret;
+	} else {
+		prop->prescale =
+			adc->data->adc_chans[prop->channel].prescale_index;
 	}
 
 	ret = of_property_read_u32(node, "qcom,hw-settle-time", &value);
-- 
2.18.1

