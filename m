Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FD6C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D78D208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS0Pd6o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D78D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbeJEXOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbeJEXOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47E321477;
        Fri,  5 Oct 2018 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756094;
        bh=pCIyhhR+5clOQDRFPM79GlDTasw01z/qqT/OMVNjnuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gS0Pd6o0m4NRzQi9frB2K3e4e4R/WpQ6/3Rr31Y1S5AYEn6r97+cSVntLznhBZ2P4
         QsVA9sqnoJQO3phBmouSQ4ABK6orCEvk6H3HmiQEPIlHBlGMoJiiOcDW2dnoL8kpHs
         pgZscGudl0pYjIOtqOeW+vbcVGoB/6cmEcl4jm4M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, Robert Kern <ulteq@web.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 32/48] hwmon: (nct6775) Fix RPM output for fan7 on NCT6796D
Date:   Fri,  5 Oct 2018 12:14:08 -0400
Message-Id: <20181005161424.20521-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit f6de298806d9cbc63a4907bca34a06162b9d7dce ]

fan7 on NCT6796D does not have a fan count register; it only has an RPM
register. Switch to using RPM registers to read the fan speed for all
chips supporting it to solve the problem for good.

Reported-by: Robert Kern <ulteq@web.de>
Cc: Robert Kern <ulteq@web.de>
Fixes: 81820059a428 ("hwmon: (nct6775) Add support for NCT6796D")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwmon/nct6775.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index f62f67fe834d..bcbf3114fa84 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -502,7 +502,7 @@ static const s8 NCT6779_BEEP_BITS[] = {
 	30, 31 };			/* intrusion0, intrusion1 */
 
 static const u16 NCT6779_REG_FAN[] = {
-	0x4b0, 0x4b2, 0x4b4, 0x4b6, 0x4b8, 0x4ba, 0x660 };
+	0x4c0, 0x4c2, 0x4c4, 0x4c6, 0x4c8, 0x4ca, 0x660 };
 static const u16 NCT6779_REG_FAN_PULSES[NUM_FAN] = {
 	0x644, 0x645, 0x646, 0x647, 0x648, 0x649 };
 
@@ -924,6 +924,11 @@ static unsigned int fan_from_reg16(u16 reg, unsigned int divreg)
 	return 1350000U / (reg << divreg);
 }
 
+static unsigned int fan_from_reg_rpm(u16 reg, unsigned int divreg)
+{
+	return reg;
+}
+
 static u16 fan_to_reg(u32 fan, unsigned int divreg)
 {
 	if (!fan)
@@ -1284,7 +1289,7 @@ static bool is_word_sized(struct nct6775_data *data, u16 reg)
 	case nct6795:
 	case nct6796:
 		return reg == 0x150 || reg == 0x153 || reg == 0x155 ||
-		  ((reg & 0xfff0) == 0x4b0 && (reg & 0x000f) < 0x0b) ||
+		  (reg & 0xfff0) == 0x4c0 ||
 		  reg == 0x402 ||
 		  reg == 0x63a || reg == 0x63c || reg == 0x63e ||
 		  reg == 0x640 || reg == 0x642 || reg == 0x64a ||
@@ -3868,7 +3873,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->ALARM_BITS = NCT6779_ALARM_BITS;
 		data->BEEP_BITS = NCT6779_BEEP_BITS;
 
-		data->fan_from_reg = fan_from_reg13;
+		data->fan_from_reg = fan_from_reg_rpm;
 		data->fan_from_reg_min = fan_from_reg13;
 		data->target_temp_mask = 0xff;
 		data->tolerance_mask = 0x07;
@@ -3949,7 +3954,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->ALARM_BITS = NCT6791_ALARM_BITS;
 		data->BEEP_BITS = NCT6779_BEEP_BITS;
 
-		data->fan_from_reg = fan_from_reg13;
+		data->fan_from_reg = fan_from_reg_rpm;
 		data->fan_from_reg_min = fan_from_reg13;
 		data->target_temp_mask = 0xff;
 		data->tolerance_mask = 0x07;
-- 
2.17.1

