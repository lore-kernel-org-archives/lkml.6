Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E3EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD62A2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217798;
	bh=HSy0PShW78QjUYOCtkPfzlh9PHLODduW5SbZ5xurru8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ONRALJlgFzTnwHydMM3BWv2j6/ejqgaxXFirp0qB+3CM8qKrSEHz4pwOfbs8g2IgB
	 FJzzfw1v3DilBvfVak4KEZC6E/J4NGCA8QTLonaYIv8WZaCbQYV7BMM1xUhLJkd6yL
	 oj7/rWbdR+68K8s4mwqxtDj4k8SBWb3MVUk6iM4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391222AbfAKOnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403980AbfAKOnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC60B2184A;
        Fri, 11 Jan 2019 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217791;
        bh=HSy0PShW78QjUYOCtkPfzlh9PHLODduW5SbZ5xurru8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjgssrJug+tbo5Srr5Hbe49sPoa7XGYAFyIgoh+oct1QYE3Tx02QsLk5cyj0lKVSe
         Ph1fluonKT/a9fbfR3pcJszkz3N/tjwlFwPdDwZ/Vq+8XPg3ODSKXtZbtq5Yr0v+d+
         a74JuvUHjhj+H4W7Y7lWw7Dt0OxuYRR4LZ8Rfzf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.20 43/65] iio: adc: qcom-spmi-adc5: Initialize prescale properly
Date:   Fri, 11 Jan 2019 15:15:29 +0100
Message-Id: <20190111131102.331712210@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Evan Green <evgreen@chromium.org>

commit db23d88756abd38e0995ea8449d0025b3de4b26b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/qcom-spmi-adc5.c |   58 ++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

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
 
@@ -558,6 +559,9 @@ static int adc5_get_dt_channel_data(stru
 			return ret;
 		}
 		prop->prescale = ret;
+	} else {
+		prop->prescale =
+			adc->data->adc_chans[prop->channel].prescale_index;
 	}
 
 	ret = of_property_read_u32(node, "qcom,hw-settle-time", &value);


