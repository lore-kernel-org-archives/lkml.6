Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C5FC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0988E2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sw4OEqgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0988E2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeJQBFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQBFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60B020866;
        Tue, 16 Oct 2018 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710072;
        bh=plUjhf6vFOFKO6ICpDHffd7z4fOwaAsJfXzTHpYBgyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sw4OEqgt1zkNwd06y9LhDkcDiIoAerb5NRe6fHO7b06QS6oOzS51eljj229HOqkaZ
         zShbv4fK3IAUeyrrunIIytaMbrWbW0TD0kcmTu22572ATUiL1BixFzBUPzRd5yHZo/
         JZczXTo4MKhb/9rY/R6G2FEDcfViVqr976DVCTKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Kern <ulteq@web.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 094/135] hwmon: (nct6775) Fix RPM output for fan7 on NCT6796D
Date:   Tue, 16 Oct 2018 19:05:24 +0200
Message-Id: <20181016170521.839174072@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/nct6775.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -502,7 +502,7 @@ static const s8 NCT6779_BEEP_BITS[] = {
 	30, 31 };			/* intrusion0, intrusion1 */
 
 static const u16 NCT6779_REG_FAN[] = {
-	0x4b0, 0x4b2, 0x4b4, 0x4b6, 0x4b8, 0x4ba, 0x660 };
+	0x4c0, 0x4c2, 0x4c4, 0x4c6, 0x4c8, 0x4ca, 0x660 };
 static const u16 NCT6779_REG_FAN_PULSES[NUM_FAN] = {
 	0x644, 0x645, 0x646, 0x647, 0x648, 0x649 };
 
@@ -924,6 +924,11 @@ static unsigned int fan_from_reg16(u16 r
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
@@ -1284,7 +1289,7 @@ static bool is_word_sized(struct nct6775
 	case nct6795:
 	case nct6796:
 		return reg == 0x150 || reg == 0x153 || reg == 0x155 ||
-		  ((reg & 0xfff0) == 0x4b0 && (reg & 0x000f) < 0x0b) ||
+		  (reg & 0xfff0) == 0x4c0 ||
 		  reg == 0x402 ||
 		  reg == 0x63a || reg == 0x63c || reg == 0x63e ||
 		  reg == 0x640 || reg == 0x642 || reg == 0x64a ||
@@ -3868,7 +3873,7 @@ static int nct6775_probe(struct platform
 		data->ALARM_BITS = NCT6779_ALARM_BITS;
 		data->BEEP_BITS = NCT6779_BEEP_BITS;
 
-		data->fan_from_reg = fan_from_reg13;
+		data->fan_from_reg = fan_from_reg_rpm;
 		data->fan_from_reg_min = fan_from_reg13;
 		data->target_temp_mask = 0xff;
 		data->tolerance_mask = 0x07;
@@ -3949,7 +3954,7 @@ static int nct6775_probe(struct platform
 		data->ALARM_BITS = NCT6791_ALARM_BITS;
 		data->BEEP_BITS = NCT6779_BEEP_BITS;
 
-		data->fan_from_reg = fan_from_reg13;
+		data->fan_from_reg = fan_from_reg_rpm;
 		data->fan_from_reg_min = fan_from_reg13;
 		data->target_temp_mask = 0xff;
 		data->tolerance_mask = 0x07;


