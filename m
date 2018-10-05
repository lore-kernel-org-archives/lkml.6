Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7700EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EC621486
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8W0J6cD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EC621486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeJEXOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729411AbeJEXOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7A72213A2;
        Fri,  5 Oct 2018 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756093;
        bh=+Ia+xz9KmCuVEK+G+nK4yiJCi6BclssMDElnHiHdSi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8W0J6cDvH0IucsAx6MDjKkUmeVDMPCQYsbZJiBTXt9/4F7Adbx6IvhMukbq44RQc
         dAjM3aQjnqZu5vZuvOK0XLNmfCK7Ov8+DYUi7W69IYMyQbjYJxU5U6Fir4rTiuHkCg
         eWgVCRRXe6g8GSeIKY4MJ7oUiedn8kz/8lZIQbp4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, Robert Kern <ulteq@web.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 31/48] hwmon: (nct6775) Fix virtual temperature sources for NCT6796D
Date:   Fri,  5 Oct 2018 12:14:07 -0400
Message-Id: <20181005161424.20521-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 37196ba4ae95a2077d78715eb12e879e57613d43 ]

The following kernel log message is reported for the nct6775 driver
on ASUS WS X299 SAGE.

nct6775: Found NCT6796D or compatible chip at 0x2e:0x290
nct6775 nct6775.656: Invalid temperature source 11 at index 0,
			source register 0x100, temp register 0x73
nct6775 nct6775.656: Invalid temperature source 11 at index 2,
			source register 0x300, temp register 0x77
nct6775 nct6775.656: Invalid temperature source 11 at index 3,
			source register 0x800, temp register 0x79
nct6775 nct6775.656: Invalid temperature source 11 at index 4,
			source register 0x900, temp register 0x7b

A recent version of the datasheet lists temperature source 11 as reserved.
However, an older version of the datasheet lists temperature sources 10
and 11 as supported virtual temperature sources. Apparently the older
version of the datasheet is correct, so list those temperature sources
as supported.

Virtual temperature sources are different than other temperature sources:
Values are not read from a temperature sensor, but written either from
BIOS or an embedded controller. As such, each virtual temperature has to
be reported. Since there is now more than one temperature source, we have
to keep virtual temperature sources in a chip-specific mask and can no
longer rely on the assumption that there is only one virtual temperature
source with a fixed index. This accounts for most of the complexity of this
patch.

Reported-by: Robert Kern <ulteq@web.de>
Cc: Robert Kern <ulteq@web.de>
Fixes: 81820059a428 ("hwmon: (nct6775) Add support for NCT6796D")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwmon/nct6775.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 6f40a9435731..f62f67fe834d 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -207,8 +207,6 @@ superio_exit(int ioreg)
 
 #define NUM_FAN		7
 
-#define TEMP_SOURCE_VIRTUAL	0x1f
-
 /* Common and NCT6775 specific data */
 
 /* Voltage min/max registers for nr=7..14 are in bank 5 */
@@ -374,6 +372,7 @@ static const char *const nct6775_temp_label[] = {
 };
 
 #define NCT6775_TEMP_MASK	0x001ffffe
+#define NCT6775_VIRT_TEMP_MASK	0x00000000
 
 static const u16 NCT6775_REG_TEMP_ALTERNATE[32] = {
 	[13] = 0x661,
@@ -462,6 +461,7 @@ static const char *const nct6776_temp_label[] = {
 };
 
 #define NCT6776_TEMP_MASK	0x007ffffe
+#define NCT6776_VIRT_TEMP_MASK	0x00000000
 
 static const u16 NCT6776_REG_TEMP_ALTERNATE[32] = {
 	[14] = 0x401,
@@ -560,7 +560,9 @@ static const char *const nct6779_temp_label[] = {
 };
 
 #define NCT6779_TEMP_MASK	0x07ffff7e
+#define NCT6779_VIRT_TEMP_MASK	0x00000000
 #define NCT6791_TEMP_MASK	0x87ffff7e
+#define NCT6791_VIRT_TEMP_MASK	0x80000000
 
 static const u16 NCT6779_REG_TEMP_ALTERNATE[32]
 	= { 0x490, 0x491, 0x492, 0x493, 0x494, 0x495, 0, 0,
@@ -639,6 +641,7 @@ static const char *const nct6792_temp_label[] = {
 };
 
 #define NCT6792_TEMP_MASK	0x9fffff7e
+#define NCT6792_VIRT_TEMP_MASK	0x80000000
 
 static const char *const nct6793_temp_label[] = {
 	"",
@@ -676,6 +679,7 @@ static const char *const nct6793_temp_label[] = {
 };
 
 #define NCT6793_TEMP_MASK	0xbfff037e
+#define NCT6793_VIRT_TEMP_MASK	0x80000000
 
 static const char *const nct6795_temp_label[] = {
 	"",
@@ -713,6 +717,7 @@ static const char *const nct6795_temp_label[] = {
 };
 
 #define NCT6795_TEMP_MASK	0xbfffff7e
+#define NCT6795_VIRT_TEMP_MASK	0x80000000
 
 static const char *const nct6796_temp_label[] = {
 	"",
@@ -725,8 +730,8 @@ static const char *const nct6796_temp_label[] = {
 	"AUXTIN4",
 	"SMBUSMASTER 0",
 	"SMBUSMASTER 1",
-	"",
-	"",
+	"Virtual_TEMP",
+	"Virtual_TEMP",
 	"",
 	"",
 	"",
@@ -749,7 +754,8 @@ static const char *const nct6796_temp_label[] = {
 	"Virtual_TEMP"
 };
 
-#define NCT6796_TEMP_MASK	0xbfff03fe
+#define NCT6796_TEMP_MASK	0xbfff0ffe
+#define NCT6796_VIRT_TEMP_MASK	0x80000c00
 
 /* NCT6102D/NCT6106D specific data */
 
@@ -970,6 +976,7 @@ struct nct6775_data {
 	u16 reg_temp_config[NUM_TEMP];
 	const char * const *temp_label;
 	u32 temp_mask;
+	u32 virt_temp_mask;
 
 	u16 REG_CONFIG;
 	u16 REG_VBAT;
@@ -3644,6 +3651,7 @@ static int nct6775_probe(struct platform_device *pdev)
 
 		data->temp_label = nct6776_temp_label;
 		data->temp_mask = NCT6776_TEMP_MASK;
+		data->virt_temp_mask = NCT6776_VIRT_TEMP_MASK;
 
 		data->REG_VBAT = NCT6106_REG_VBAT;
 		data->REG_DIODE = NCT6106_REG_DIODE;
@@ -3722,6 +3730,7 @@ static int nct6775_probe(struct platform_device *pdev)
 
 		data->temp_label = nct6775_temp_label;
 		data->temp_mask = NCT6775_TEMP_MASK;
+		data->virt_temp_mask = NCT6775_VIRT_TEMP_MASK;
 
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
 		data->REG_VBAT = NCT6775_REG_VBAT;
@@ -3794,6 +3803,7 @@ static int nct6775_probe(struct platform_device *pdev)
 
 		data->temp_label = nct6776_temp_label;
 		data->temp_mask = NCT6776_TEMP_MASK;
+		data->virt_temp_mask = NCT6776_VIRT_TEMP_MASK;
 
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
 		data->REG_VBAT = NCT6775_REG_VBAT;
@@ -3866,6 +3876,7 @@ static int nct6775_probe(struct platform_device *pdev)
 
 		data->temp_label = nct6779_temp_label;
 		data->temp_mask = NCT6779_TEMP_MASK;
+		data->virt_temp_mask = NCT6779_VIRT_TEMP_MASK;
 
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
 		data->REG_VBAT = NCT6775_REG_VBAT;
@@ -3949,22 +3960,27 @@ static int nct6775_probe(struct platform_device *pdev)
 		case nct6791:
 			data->temp_label = nct6779_temp_label;
 			data->temp_mask = NCT6791_TEMP_MASK;
+			data->virt_temp_mask = NCT6791_VIRT_TEMP_MASK;
 			break;
 		case nct6792:
 			data->temp_label = nct6792_temp_label;
 			data->temp_mask = NCT6792_TEMP_MASK;
+			data->virt_temp_mask = NCT6792_VIRT_TEMP_MASK;
 			break;
 		case nct6793:
 			data->temp_label = nct6793_temp_label;
 			data->temp_mask = NCT6793_TEMP_MASK;
+			data->virt_temp_mask = NCT6793_VIRT_TEMP_MASK;
 			break;
 		case nct6795:
 			data->temp_label = nct6795_temp_label;
 			data->temp_mask = NCT6795_TEMP_MASK;
+			data->virt_temp_mask = NCT6795_VIRT_TEMP_MASK;
 			break;
 		case nct6796:
 			data->temp_label = nct6796_temp_label;
 			data->temp_mask = NCT6796_TEMP_MASK;
+			data->virt_temp_mask = NCT6796_VIRT_TEMP_MASK;
 			break;
 		}
 
@@ -4148,7 +4164,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		 * for each fan reflects a different temperature, and there
 		 * are no duplicates.
 		 */
-		if (src != TEMP_SOURCE_VIRTUAL) {
+		if (!(data->virt_temp_mask & BIT(src))) {
 			if (mask & BIT(src))
 				continue;
 			mask |= BIT(src);
-- 
2.17.1

