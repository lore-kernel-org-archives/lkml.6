Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B93C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83422147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eij0Bl5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83422147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeJQBFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbeJQBFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:49 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18B321479;
        Tue, 16 Oct 2018 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710065;
        bh=4Q3B5S47/VGRBmXXHfDYgv//oY9RaSwds6ss9j0LaFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eij0Bl5NmUUiPaqC2HIwTcbR2S7UXfioFzV+JKCk1d5BHqn2M4FsFLh1zTdiuMRp0
         y9zY4oP+QHs+hJKuJgBzFAUWXbQ+0JjL0FtLa1Ar4ye0OEuZrSCSd3RDrY/KyWJyUf
         QhLQOJai7NZM++/6yqsVcNAe/ZrN6hzyNVMju4aI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Kern <ulteq@web.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 093/135] hwmon: (nct6775) Fix virtual temperature sources for NCT6796D
Date:   Tue, 16 Oct 2018 19:05:23 +0200
Message-Id: <20181016170521.777485584@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/nct6775.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -207,8 +207,6 @@ superio_exit(int ioreg)
 
 #define NUM_FAN		7
 
-#define TEMP_SOURCE_VIRTUAL	0x1f
-
 /* Common and NCT6775 specific data */
 
 /* Voltage min/max registers for nr=7..14 are in bank 5 */
@@ -374,6 +372,7 @@ static const char *const nct6775_temp_la
 };
 
 #define NCT6775_TEMP_MASK	0x001ffffe
+#define NCT6775_VIRT_TEMP_MASK	0x00000000
 
 static const u16 NCT6775_REG_TEMP_ALTERNATE[32] = {
 	[13] = 0x661,
@@ -462,6 +461,7 @@ static const char *const nct6776_temp_la
 };
 
 #define NCT6776_TEMP_MASK	0x007ffffe
+#define NCT6776_VIRT_TEMP_MASK	0x00000000
 
 static const u16 NCT6776_REG_TEMP_ALTERNATE[32] = {
 	[14] = 0x401,
@@ -560,7 +560,9 @@ static const char *const nct6779_temp_la
 };
 
 #define NCT6779_TEMP_MASK	0x07ffff7e
+#define NCT6779_VIRT_TEMP_MASK	0x00000000
 #define NCT6791_TEMP_MASK	0x87ffff7e
+#define NCT6791_VIRT_TEMP_MASK	0x80000000
 
 static const u16 NCT6779_REG_TEMP_ALTERNATE[32]
 	= { 0x490, 0x491, 0x492, 0x493, 0x494, 0x495, 0, 0,
@@ -639,6 +641,7 @@ static const char *const nct6792_temp_la
 };
 
 #define NCT6792_TEMP_MASK	0x9fffff7e
+#define NCT6792_VIRT_TEMP_MASK	0x80000000
 
 static const char *const nct6793_temp_label[] = {
 	"",
@@ -676,6 +679,7 @@ static const char *const nct6793_temp_la
 };
 
 #define NCT6793_TEMP_MASK	0xbfff037e
+#define NCT6793_VIRT_TEMP_MASK	0x80000000
 
 static const char *const nct6795_temp_label[] = {
 	"",
@@ -713,6 +717,7 @@ static const char *const nct6795_temp_la
 };
 
 #define NCT6795_TEMP_MASK	0xbfffff7e
+#define NCT6795_VIRT_TEMP_MASK	0x80000000
 
 static const char *const nct6796_temp_label[] = {
 	"",
@@ -725,8 +730,8 @@ static const char *const nct6796_temp_la
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
@@ -749,7 +754,8 @@ static const char *const nct6796_temp_la
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
@@ -3644,6 +3651,7 @@ static int nct6775_probe(struct platform
 
 		data->temp_label = nct6776_temp_label;
 		data->temp_mask = NCT6776_TEMP_MASK;
+		data->virt_temp_mask = NCT6776_VIRT_TEMP_MASK;
 
 		data->REG_VBAT = NCT6106_REG_VBAT;
 		data->REG_DIODE = NCT6106_REG_DIODE;
@@ -3722,6 +3730,7 @@ static int nct6775_probe(struct platform
 
 		data->temp_label = nct6775_temp_label;
 		data->temp_mask = NCT6775_TEMP_MASK;
+		data->virt_temp_mask = NCT6775_VIRT_TEMP_MASK;
 
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
 		data->REG_VBAT = NCT6775_REG_VBAT;
@@ -3794,6 +3803,7 @@ static int nct6775_probe(struct platform
 
 		data->temp_label = nct6776_temp_label;
 		data->temp_mask = NCT6776_TEMP_MASK;
+		data->virt_temp_mask = NCT6776_VIRT_TEMP_MASK;
 
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
 		data->REG_VBAT = NCT6775_REG_VBAT;
@@ -3866,6 +3876,7 @@ static int nct6775_probe(struct platform
 
 		data->temp_label = nct6779_temp_label;
 		data->temp_mask = NCT6779_TEMP_MASK;
+		data->virt_temp_mask = NCT6779_VIRT_TEMP_MASK;
 
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
 		data->REG_VBAT = NCT6775_REG_VBAT;
@@ -3949,22 +3960,27 @@ static int nct6775_probe(struct platform
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
 
@@ -4148,7 +4164,7 @@ static int nct6775_probe(struct platform
 		 * for each fan reflects a different temperature, and there
 		 * are no duplicates.
 		 */
-		if (src != TEMP_SOURCE_VIRTUAL) {
+		if (!(data->virt_temp_mask & BIT(src))) {
 			if (mask & BIT(src))
 				continue;
 			mask |= BIT(src);


