Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A52C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AB82054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570737;
	bh=opijU3Bg9bJEqoWx3E+AbaxbwNa5H5O0k5jQqL6F3xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n4js0gwNgssVyIZoGtKXDcDUTATj/e/qDtJVPWNpW1rFojEX+hSc6U3aDJLZhUSJZ
	 DeDIW4UHlQR/UTkzKt8bivT81O+UpaNfR9LaWfyShe6jQdae/ajW44L3z5+47oQRyC
	 vmjf+Fb4lyKGp685a09eh9AzG8b3Vq7Sy3yt+sGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbfAOQpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387797AbfAOQp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:45:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7072054F;
        Tue, 15 Jan 2019 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570729;
        bh=opijU3Bg9bJEqoWx3E+AbaxbwNa5H5O0k5jQqL6F3xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKZrAcVGE5EXgTugYSew7GYUaTNQVeGITDghrw+OU/PaZT0hEjnQsKY0cmtliHfa6
         VxLvO5xpNjxGEru5kNCLFPg/121+Im8uH2FC24lsGopbzvPWK0o6lfEsAOKdbkzrjo
         ocQXKxQx7aARDxH0ZAIrvOnsVsbrfACJ2gxIAkeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.20 32/57] ACPI / PMIC: xpower: Fix TS-pin current-source handling
Date:   Tue, 15 Jan 2019 17:36:13 +0100
Message-Id: <20190115154912.512345811@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit 2b531d71595d2b5b12782a49b23c335869e2621e upstream.

The current-source used for the battery temp-sensor (TS) is shared with the
GPADC. For proper fuel-gauge and charger operation the TS current-source
needs to be permanently on. But to read the GPADC we need to temporary
switch the TS current-source to ondemand, so that the GPADC can use it,
otherwise we will always read an all 0 value.

The switching from on to on-ondemand is not necessary when the TS
current-source is off (this happens on devices which do not have a TS).

Prior to this commit there were 2 issues with our handling of the TS
current-source switching:

 1) We were writing hardcoded values to the ADC TS pin-ctrl register,
 overwriting various other unrelated bits. Specifically we were overwriting
 the current-source setting for the TS and GPIO0 pins, forcing it to 80ųA
 independent of its original setting. On a Chuwi Vi10 tablet this was
 causing us to get a too high adc value (due to a too high current-source)
 resulting in acpi_lpat_raw_to_temp() returning -ENOENT, resulting in:

ACPI Error: AE_ERROR, Returned by Handler for [UserDefinedRegion]
ACPI Error: Method parse/execution failed \_SB.SXP1._TMP, AE_ERROR

This commit fixes this by using regmap_update_bits to change only the
relevant bits.

 2) At the end of intel_xpower_pmic_get_raw_temp() we were unconditionally
 enabling the TS current-source even on devices where the TS-pin is not used
 and the current-source thus was off on entry of the function.

This commit fixes this by checking if the TS current-source is off when
entering intel_xpower_pmic_get_raw_temp() and if so it is left as is.

Fixes: 58eefe2f3f53 (ACPI / PMIC: xpower: Do pinswitch ... reading GPADC)
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/pmic/intel_pmic_xpower.c |   41 +++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -20,8 +20,11 @@
 #define GPI1_LDO_ON		(3 << 0)
 #define GPI1_LDO_OFF		(4 << 0)
 
-#define AXP288_ADC_TS_PIN_GPADC	0xf2
-#define AXP288_ADC_TS_PIN_ON	0xf3
+#define AXP288_ADC_TS_CURRENT_ON_OFF_MASK		GENMASK(1, 0)
+#define AXP288_ADC_TS_CURRENT_OFF			(0 << 0)
+#define AXP288_ADC_TS_CURRENT_ON_WHEN_CHARGING		(1 << 0)
+#define AXP288_ADC_TS_CURRENT_ON_ONDEMAND		(2 << 0)
+#define AXP288_ADC_TS_CURRENT_ON			(3 << 0)
 
 static struct pmic_table power_table[] = {
 	{
@@ -212,22 +215,44 @@ out:
  */
 static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
+	int ret, adc_ts_pin_ctrl;
 	u8 buf[2];
-	int ret;
 
-	ret = regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL,
-			   AXP288_ADC_TS_PIN_GPADC);
+	/*
+	 * The current-source used for the battery temp-sensor (TS) is shared
+	 * with the GPADC. For proper fuel-gauge and charger operation the TS
+	 * current-source needs to be permanently on. But to read the GPADC we
+	 * need to temporary switch the TS current-source to ondemand, so that
+	 * the GPADC can use it, otherwise we will always read an all 0 value.
+	 *
+	 * Note that the switching from on to on-ondemand is not necessary
+	 * when the TS current-source is off (this happens on devices which
+	 * do not use the TS-pin).
+	 */
+	ret = regmap_read(regmap, AXP288_ADC_TS_PIN_CTRL, &adc_ts_pin_ctrl);
 	if (ret)
 		return ret;
 
-	/* After switching to the GPADC pin give things some time to settle */
-	usleep_range(6000, 10000);
+	if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
+		ret = regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,
+					 AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
+					 AXP288_ADC_TS_CURRENT_ON_ONDEMAND);
+		if (ret)
+			return ret;
+
+		/* Wait a bit after switching the current-source */
+		usleep_range(6000, 10000);
+	}
 
 	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, 2);
 	if (ret == 0)
 		ret = (buf[0] << 4) + ((buf[1] >> 4) & 0x0f);
 
-	regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, AXP288_ADC_TS_PIN_ON);
+	if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
+		regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,
+				   AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
+				   AXP288_ADC_TS_CURRENT_ON);
+	}
 
 	return ret;
 }


