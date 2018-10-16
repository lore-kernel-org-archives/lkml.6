Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A268C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3353B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ywYMVoDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3353B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeJQBFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F592098A;
        Tue, 16 Oct 2018 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710023;
        bh=lcD1Z/SiZSVb0tPJOLh6OgsY+NW4j0uej46Jhc6piOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ywYMVoDHuVOhNP52wkS58+ZM3dmZ6Kp4xu3fjKBI6gOJWKXWjbkl//4tY9RroDmxt
         WHK2w4F7lqfvFuDwe+low0HQKBqoYIteuKsCmmeCSGoZLVMCNkbXPN0TzD69W8B/mX
         Y4fyGGFvTWD6lBEs/+XkDYM76dxu0Jl0dCmgb9N8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 077/135] hwmon: (nct6775) Fix access to fan pulse registers
Date:   Tue, 16 Oct 2018 19:05:07 +0200
Message-Id: <20181016170520.501191047@linuxfoundation.org>
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

[ Upstream commit c793279c77035053e67937f5743c6ebfc303e7c5 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/nct6775.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -299,8 +299,9 @@ static const u16 NCT6775_REG_PWM_READ[]
 
 static const u16 NCT6775_REG_FAN[] = { 0x630, 0x632, 0x634, 0x636, 0x638 };
 static const u16 NCT6775_REG_FAN_MIN[] = { 0x3b, 0x3c, 0x3d };
-static const u16 NCT6775_REG_FAN_PULSES[] = { 0x641, 0x642, 0x643, 0x644, 0 };
-static const u16 NCT6775_FAN_PULSE_SHIFT[] = { 0, 0, 0, 0, 0, 0 };
+static const u16 NCT6775_REG_FAN_PULSES[NUM_FAN] = {
+	0x641, 0x642, 0x643, 0x644 };
+static const u16 NCT6775_FAN_PULSE_SHIFT[NUM_FAN] = { };
 
 static const u16 NCT6775_REG_TEMP[] = {
 	0x27, 0x150, 0x250, 0x62b, 0x62c, 0x62d };
@@ -425,8 +426,8 @@ static const u8 NCT6776_PWM_MODE_MASK[]
 
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
@@ -779,8 +780,8 @@ static const u16 NCT6106_REG_TEMP_CONFIG
 
 static const u16 NCT6106_REG_FAN[] = { 0x20, 0x22, 0x24 };
 static const u16 NCT6106_REG_FAN_MIN[] = { 0xe0, 0xe2, 0xe4 };
-static const u16 NCT6106_REG_FAN_PULSES[] = { 0xf6, 0xf6, 0xf6, 0, 0 };
-static const u16 NCT6106_FAN_PULSE_SHIFT[] = { 0, 2, 4, 0, 0 };
+static const u16 NCT6106_REG_FAN_PULSES[] = { 0xf6, 0xf6, 0xf6 };
+static const u16 NCT6106_FAN_PULSE_SHIFT[] = { 0, 2, 4 };
 
 static const u8 NCT6106_REG_PWM_MODE[] = { 0xf3, 0xf3, 0xf3 };
 static const u8 NCT6106_PWM_MODE_MASK[] = { 0x01, 0x02, 0x04 };
@@ -1682,9 +1683,13 @@ static struct nct6775_data *nct6775_upda
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


