Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200F6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E206921582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E206921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbeKODYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:24:21 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:50646 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732823AbeKODYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:24:20 -0500
Received: from localhost.localdomain ([77.136.84.203])
        by mwinf5d07 with ME
        id ztLD1y00K4PD7S503tLDMx; Wed, 14 Nov 2018 18:20:15 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 Nov 2018 18:20:15 +0100
X-ME-IP: 77.136.84.203
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] rtc: max8997: Fix the returned value in case of error in 'max8997_rtc_read_alarm()'
Date:   Wed, 14 Nov 2018 18:19:51 +0100
Message-Id: <20181114171951.4137-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, we return 0.
This is spurious and not consistent with the other functions of the driver.
Propagate the error code instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: re-word changelog and remove Fixes tag.
   (not sure if any should be provided, and which one would be the best)
---
 drivers/rtc/rtc-max8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
index 08c661a332ec..20e50d9fdf88 100644
--- a/drivers/rtc/rtc-max8997.c
+++ b/drivers/rtc/rtc-max8997.c
@@ -215,7 +215,7 @@ static int max8997_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 out:
 	mutex_unlock(&info->lock);
-	return 0;
+	return ret;
 }
 
 static int max8997_rtc_stop_alarm(struct max8997_rtc_info *info)
-- 
2.17.1

