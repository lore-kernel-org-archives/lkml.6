Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8487AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466DC20854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466DC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbeKLGJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:09:51 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53466 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbeKLGJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:09:50 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtA-0000l7-PV; Sun, 11 Nov 2018 19:59:20 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001QX-5j; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Lee Jones" <lee.jones@linaro.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.759919650@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 056/366] mfd: tps65911-comparator: Fix an off by one bug
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lee Jones <lee.jones@linaro.org>

commit 1768391c3674b0c6bdc4947121f15fb0c2f47ec4 upstream.

The COMP1 and COMP2 elements are in 0 and 1 respectively so this code is
accessing the wrong elements and one space beyond the end of the array.

The "id" variable is never COMP (0) so that code can be removed.

Fixes: 6851ad3ab346 ("TPS65911: Comparator: Add comparator driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mfd/tps65911-comparator.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/mfd/tps65911-comparator.c
+++ b/drivers/mfd/tps65911-comparator.c
@@ -22,9 +22,8 @@
 #include <linux/gpio.h>
 #include <linux/mfd/tps65910.h>
 
-#define COMP					0
-#define COMP1					1
-#define COMP2					2
+#define COMP1					0
+#define COMP2					1
 
 /* Comparator 1 voltage selection table in millivolts */
 static const u16 COMP_VSEL_TABLE[] = {
@@ -63,9 +62,6 @@ static int comp_threshold_set(struct tps
 	int ret;
 	u8 index = 0, val;
 
-	if (id == COMP)
-		return 0;
-
 	while (curr_voltage < tps_comp.uV_max) {
 		curr_voltage = tps_comp.vsel_table[index];
 		if (curr_voltage >= voltage)
@@ -89,9 +85,6 @@ static int comp_threshold_get(struct tps
 	unsigned int val;
 	int ret;
 
-	if (id == COMP)
-		return 0;
-
 	ret = tps65910_reg_read(tps65910, tps_comp.reg, &val);
 	if (ret < 0)
 		return ret;

