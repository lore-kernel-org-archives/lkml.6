Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CB8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E91208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmIi1Nxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E91208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeJEXYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbeJEXOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57CD2208E7;
        Fri,  5 Oct 2018 16:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756095;
        bh=AbZx+9dtDRux4yHEJ+PM1CZvxd9dBcBol9URnFg53XY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OmIi1Nxtc2dHHPzvIk2NcwyTnpp8NBsr+zrqTgycsCPO3cWme9ae2souQcFs1dwBk
         S7a4Nac7NiFmkKMYf4/dyS4F+hCQEL6288EfVaEtdai2wQs4xFnhzzlAjCdYDHpqqL
         5MU/DZBufNVVqrnKhnERjl6QTwK9WzmWdPHKn9co=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, Robert Kern <ulteq@web.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 34/48] hwmon: (nct6775) Use different register to get fan RPM for fan7
Date:   Fri,  5 Oct 2018 12:14:10 -0400
Message-Id: <20181005161424.20521-34-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 55066354285b36ee09dc50e2527f43a97c567177 ]

The documented register to retrieve the fan RPM for fan7 is found
to be unreliable at least with NCT6796D revision 3. Let's use
register 0x4ce instead. This is undocumented for NCT6796D, but
documented for NCT6797D and NCT6798D and known to be working.

Reported-by: Robert Kern <ulteq@web.de>
Cc: Robert Kern <ulteq@web.de>
Fixes: 81820059a428 ("hwmon: (nct6775) Add support for NCT6796D")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwmon/nct6775.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index bcbf3114fa84..8859f5572885 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -502,7 +502,7 @@ static const s8 NCT6779_BEEP_BITS[] = {
 	30, 31 };			/* intrusion0, intrusion1 */
 
 static const u16 NCT6779_REG_FAN[] = {
-	0x4c0, 0x4c2, 0x4c4, 0x4c6, 0x4c8, 0x4ca, 0x660 };
+	0x4c0, 0x4c2, 0x4c4, 0x4c6, 0x4c8, 0x4ca, 0x4ce };
 static const u16 NCT6779_REG_FAN_PULSES[NUM_FAN] = {
 	0x644, 0x645, 0x646, 0x647, 0x648, 0x649 };
 
@@ -1293,7 +1293,7 @@ static bool is_word_sized(struct nct6775_data *data, u16 reg)
 		  reg == 0x402 ||
 		  reg == 0x63a || reg == 0x63c || reg == 0x63e ||
 		  reg == 0x640 || reg == 0x642 || reg == 0x64a ||
-		  reg == 0x64c || reg == 0x660 ||
+		  reg == 0x64c ||
 		  reg == 0x73 || reg == 0x75 || reg == 0x77 || reg == 0x79 ||
 		  reg == 0x7b || reg == 0x7d;
 	}
-- 
2.17.1

