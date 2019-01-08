Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDFB20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977867;
	bh=PnqgOVsckHKUZK2V0zZ24v5f3g2oEoPYHUH4QLC2OLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fbOJk/keRzZMkrXnF6WAF+LrsYVTyP+WV2a/e1YF5bLQ8vj9IsBYmpCQh8oCcizuO
	 l/1JwbOabewfoCT2o6JD2BDmloKSN5FQD65VcsArtAKwx8ByEuZhfFqpXVtvwJswpb
	 FngZpUfYUxO94NmE8bOWC8snqsuKqVnSrbFCq2Q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbfAHUE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:04:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbfAHT2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:28:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC9A20827;
        Tue,  8 Jan 2019 19:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975712;
        bh=PnqgOVsckHKUZK2V0zZ24v5f3g2oEoPYHUH4QLC2OLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hb0CQYn+PG3gmpPmFCoImY8i9ZGk3YcaBV2DeAtwk7H0QwxuhPTIyfqgDgQ2fZa/c
         09URSEBZM5wXFwcWlaqct9CZJ/QO4iMxTszBx97o9eF5qCW+uyUJHN46pnreafnhdW
         Xh3cv6zB8G4XFDUtHpReIwDOBuS0pLSzHd8C+qmo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 069/117] iio: adc: qcom-spmi-adc5: Initialize prescale properly
Date:   Tue,  8 Jan 2019 14:25:37 -0500
Message-Id: <20190108192628.121270-69-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

[ Upstream commit db23d88756abd38e0995ea8449d0025b3de4b26b ]

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
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 58 +++++++++++++++++---------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index f9af6b082916..6a866cc187f7 100644
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
2.19.1

