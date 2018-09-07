Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74BDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9932075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKr2mjIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9932075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeIGGXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:23:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45581 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeIGGXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:23:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id x26-v6so6128080pge.12;
        Thu, 06 Sep 2018 18:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=9B+EXncUwolg6gzPA3a9LLaKMDKc+xhDWtrsOgtryCE=;
        b=OKr2mjIi9c5CGjCIsQLkG37hDXfbEPSrHkXEosNMbjoPZ0dy0amBexsHTCCel515XN
         Bi1Zy87wuu0xQuJnv/qiilrLqEd66Uz1fGkULZdNXTHGO9w1n8H2NcDIhE7aga38Ooig
         yMgIwkLEkeSqHqlkxGA0FEaQEOLFMeRSQC8M1o1Q7M4etQJj7X7nV3gkMaeeZZl+1rHt
         qX6u90MH8whAicGIg37u1lxirarohfdx2if8K+q6JVK5tbOT9NOtwEJlUhikX8nHX3Ik
         /oO3zOoqpu7fQioVtuuf+zN2luwqJkBJuN01/sg8N4rZCzNUcfuNuOGj+OkfcEssEFr9
         EVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=9B+EXncUwolg6gzPA3a9LLaKMDKc+xhDWtrsOgtryCE=;
        b=Jn4WT5jTSowzr/KIKe0AbBoWorl6FOXX/S52MjiwTGtpf2WyMSF1sKDPK/PbTq7FCC
         cNiXqlnn88o/KfGVmM8rnxnyZ36ErGfMr2UVU8tg/Qznqh+0mMh49b6jqdK2NX/Zg1tF
         ZSsX2Y53J8Bj6KqgaGHEcV0OqtsvgdPPBxSKqpfAPo8y44Nn7xXL6cEDltDyM/vM9ccF
         QMBcjXLWo4GjmCUedRoevSoT4uW7SXM4v6c77B3fOoAsEc1dtpU8ep8X4e487k2A7opb
         vyX8fzUVmiSI7ic4HdHJMnZ3EbVcMbGqZfQiXJNx2GgH+4iJw3z7kIxbe+TQtUEYin23
         jBfQ==
X-Gm-Message-State: APzg51CKQ6brSMBGYyYjlBEMEXR/k8XlU3tsjSTY1CiH7rm4g9toCXRV
        OqKJBDzLWqDYOk1XO3zhHZAtGttV
X-Google-Smtp-Source: ANB0VdZ1fXq5ZX8lr8eCspNHFrY1rZfcZi4vcYFXsalZ+YKMXUMdseJ5Uuq5mJ0PYeL5RItYPJWb7Q==
X-Received: by 2002:a62:7d8d:: with SMTP id y135-v6mr5860210pfc.259.1536284730809;
        Thu, 06 Sep 2018 18:45:30 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k1-v6sm7590624pfi.62.2018.09.06.18.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 18:45:29 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hwmon: (nct6775) Fix access to fan pulse registers
Date:   Thu,  6 Sep 2018 18:45:27 -0700
Message-Id: <1536284727-8875-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 139781ae830b..87c316c6c341 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -299,8 +299,9 @@ static const u16 NCT6775_REG_PWM_READ[] = {
 
 static const u16 NCT6775_REG_FAN[] = { 0x630, 0x632, 0x634, 0x636, 0x638 };
 static const u16 NCT6775_REG_FAN_MIN[] = { 0x3b, 0x3c, 0x3d };
-static const u16 NCT6775_REG_FAN_PULSES[] = { 0x641, 0x642, 0x643, 0x644, 0 };
-static const u16 NCT6775_FAN_PULSE_SHIFT[] = { 0, 0, 0, 0, 0, 0 };
+static const u16 NCT6775_REG_FAN_PULSES[NUM_FAN] = {
+	0x641, 0x642, 0x643, 0x644 };
+static const u16 NCT6775_FAN_PULSE_SHIFT[NUM_FAN] = { };
 
 static const u16 NCT6775_REG_TEMP[] = {
 	0x27, 0x150, 0x250, 0x62b, 0x62c, 0x62d };
@@ -425,8 +426,8 @@ static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0 };
 
 static const u16 NCT6776_REG_FAN_MIN[] = {
 	0x63a, 0x63c, 0x63e, 0x640, 0x642, 0x64a, 0x64c };
-static const u16 NCT6776_REG_FAN_PULSES[] = {
-	0x644, 0x645, 0x646, 0x647, 0x648, 0x649, 0 };
+static const u16 NCT6776_REG_FAN_PULSES[NUM_FAN] = {
+	0x644, 0x645, 0x646, 0x647, 0x648, 0x649 };
 
 static const u16 NCT6776_REG_WEIGHT_DUTY_BASE[] = {
 	0x13e, 0x23e, 0x33e, 0x83e, 0x93e, 0xa3e };
@@ -502,8 +503,8 @@ static const s8 NCT6779_BEEP_BITS[] = {
 
 static const u16 NCT6779_REG_FAN[] = {
 	0x4b0, 0x4b2, 0x4b4, 0x4b6, 0x4b8, 0x4ba, 0x660 };
-static const u16 NCT6779_REG_FAN_PULSES[] = {
-	0x644, 0x645, 0x646, 0x647, 0x648, 0x649, 0 };
+static const u16 NCT6779_REG_FAN_PULSES[NUM_FAN] = {
+	0x644, 0x645, 0x646, 0x647, 0x648, 0x649 };
 
 static const u16 NCT6779_REG_CRITICAL_PWM_ENABLE[] = {
 	0x136, 0x236, 0x336, 0x836, 0x936, 0xa36, 0xb36 };
@@ -779,8 +780,8 @@ static const u16 NCT6106_REG_TEMP_CONFIG[] = {
 
 static const u16 NCT6106_REG_FAN[] = { 0x20, 0x22, 0x24 };
 static const u16 NCT6106_REG_FAN_MIN[] = { 0xe0, 0xe2, 0xe4 };
-static const u16 NCT6106_REG_FAN_PULSES[] = { 0xf6, 0xf6, 0xf6, 0, 0 };
-static const u16 NCT6106_FAN_PULSE_SHIFT[] = { 0, 2, 4, 0, 0 };
+static const u16 NCT6106_REG_FAN_PULSES[] = { 0xf6, 0xf6, 0xf6 };
+static const u16 NCT6106_FAN_PULSE_SHIFT[] = { 0, 2, 4 };
 
 static const u8 NCT6106_REG_PWM_MODE[] = { 0xf3, 0xf3, 0xf3 };
 static const u8 NCT6106_PWM_MODE_MASK[] = { 0x01, 0x02, 0x04 };
@@ -1682,9 +1683,13 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 			if (data->has_fan_min & BIT(i))
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
-- 
2.7.4

