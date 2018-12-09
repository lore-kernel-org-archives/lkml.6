Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8CAC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1587320661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1587320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeLIV4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:56:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36174 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbeLIVzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:38 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW730-0002io-Eo; Sun, 09 Dec 2018 21:55:35 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003YM-9D; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Guenter Roeck" <linux@roeck-us.net>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.965031696@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 225/328] hwmon: (nct6775) Fix access to fan pulse
 registers
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit c793279c77035053e67937f5743c6ebfc303e7c5 upstream.

Not all fans have a fan pulse register. This can result in reading
beyond the end of REG_FAN_PULSES and FAN_PULSE_SHIFT arrays,
and was reported by smatch as possible error.

1672          for (i = 0; i < ARRAY_SIZE(data->rpm); i++) {
                              ^^^^^^^^^^^^^^^^^^^^^^^^
			      This is a 7 element array.
...
1685                  data->fan_pulses[i] =
1686                    (nct6775_read_value(data, data->REG_FAN_PULSES[i])
1687                          >> data->FAN_PULSE_SHIFT[i]) & 0x03;
                                 ^^^^^^^^^^^^^^^^^^^^^^^^
				 FAN_PULSE_SHIFT is either 5 or 6
				 elements.

To fix the problem, we have to ensure that all REG_FAN_PULSES and
FAN_PULSE_SHIFT have the appropriate length, and that REG_FAN_PULSES
is only read if the register actually exists.

Fixes: 6c009501ff200 ("hwmon: (nct6775) Add support for NCT6102D/6106D")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[bwh: Backported to 3.16:
 - NCT6776_REG_FAN_PULSES covers only 3 fans
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hwmon/nct6775.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -269,8 +269,9 @@ static const u16 NCT6775_REG_PWM_READ[]
 
 static const u16 NCT6775_REG_FAN[] = { 0x630, 0x632, 0x634, 0x636, 0x638 };
 static const u16 NCT6775_REG_FAN_MIN[] = { 0x3b, 0x3c, 0x3d };
-static const u16 NCT6775_REG_FAN_PULSES[] = { 0x641, 0x642, 0x643, 0x644, 0 };
-static const u16 NCT6775_FAN_PULSE_SHIFT[] = { 0, 0, 0, 0, 0, 0 };
+static const u16 NCT6775_REG_FAN_PULSES[NUM_FAN] = {
+	0x641, 0x642, 0x643, 0x644 };
+static const u16 NCT6775_FAN_PULSE_SHIFT[NUM_FAN] = { };
 
 static const u16 NCT6775_REG_TEMP[] = {
 	0x27, 0x150, 0x250, 0x62b, 0x62c, 0x62d };
@@ -382,7 +383,8 @@ static const u8 NCT6776_REG_PWM_MODE[] =
 static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0 };
 
 static const u16 NCT6776_REG_FAN_MIN[] = { 0x63a, 0x63c, 0x63e, 0x640, 0x642 };
-static const u16 NCT6776_REG_FAN_PULSES[] = { 0x644, 0x645, 0x646, 0, 0 };
+static const u16 NCT6776_REG_FAN_PULSES[NUM_FAN] = {
+	0x644, 0x645, 0x646 };
 
 static const u16 NCT6776_REG_WEIGHT_DUTY_BASE[] = {
 	0x13e, 0x23e, 0x33e, 0x83e, 0x93e, 0xa3e };
@@ -451,7 +453,7 @@ static const s8 NCT6779_BEEP_BITS[] = {
 
 static const u16 NCT6779_REG_FAN[] = {
 	0x4b0, 0x4b2, 0x4b4, 0x4b6, 0x4b8, 0x4ba };
-static const u16 NCT6779_REG_FAN_PULSES[] = {
+static const u16 NCT6779_REG_FAN_PULSES[NUM_FAN] = {
 	0x644, 0x645, 0x646, 0x647, 0x648, 0x649 };
 
 static const u16 NCT6779_REG_CRITICAL_PWM_ENABLE[] = {
@@ -564,8 +566,8 @@ static const u16 NCT6106_REG_TEMP_CONFIG
 
 static const u16 NCT6106_REG_FAN[] = { 0x20, 0x22, 0x24 };
 static const u16 NCT6106_REG_FAN_MIN[] = { 0xe0, 0xe2, 0xe4 };
-static const u16 NCT6106_REG_FAN_PULSES[] = { 0xf6, 0xf6, 0xf6, 0, 0 };
-static const u16 NCT6106_FAN_PULSE_SHIFT[] = { 0, 2, 4, 0, 0 };
+static const u16 NCT6106_REG_FAN_PULSES[] = { 0xf6, 0xf6, 0xf6 };
+static const u16 NCT6106_FAN_PULSE_SHIFT[] = { 0, 2, 4 };
 
 static const u8 NCT6106_REG_PWM_MODE[] = { 0xf3, 0xf3, 0xf3 };
 static const u8 NCT6106_PWM_MODE_MASK[] = { 0x01, 0x02, 0x04 };
@@ -1451,9 +1453,13 @@ static struct nct6775_data *nct6775_upda
 			if (data->has_fan_min & (1 << i))
 				data->fan_min[i] = nct6775_read_value(data,
 					   data->REG_FAN_MIN[i]);
-			data->fan_pulses[i] =
-			  (nct6775_read_value(data, data->REG_FAN_PULSES[i])
-				>> data->FAN_PULSE_SHIFT[i]) & 0x03;
+
+			if (data->REG_FAN_PULSES[i]) {
+				data->fan_pulses[i] =
+				  (nct6775_read_value(data,
+						      data->REG_FAN_PULSES[i])
+				   >> data->FAN_PULSE_SHIFT[i]) & 0x03;
+			}
 
 			nct6775_select_fan_div(dev, data, i, reg);
 		}

