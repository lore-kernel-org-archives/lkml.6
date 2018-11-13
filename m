Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75E4C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C412175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C412175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeKNJh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:37:27 -0500
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:18022 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeKNJh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:37:27 -0500
Received: from localhost.localdomain ([77.154.224.113])
        by mwinf5d35 with ME
        id zbcn1y0072TR6wD03bcnqo; Wed, 14 Nov 2018 00:36:50 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 Nov 2018 00:36:50 +0100
X-ME-IP: 77.154.224.113
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     cw00.choi@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] rtc: max77686: Fix the returned value in case of error in 'max77686_rtc_read_time()'
Date:   Wed, 14 Nov 2018 00:36:45 +0100
Message-Id: <20181113233645.9118-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, we return 0.
This is spurious and not consistent with the other functions of the driver.
Commit e115a2bf1426 has modified more than what is said in the commit
message. Reverse part of it znd return an error when needed, as it was
previously.

Fixes: e115a2bf1426 ("rtc: max77686: stop validating rtc_time in .read_time")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/rtc/rtc-max77686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 8a60900d6b8b..4aff349ae301 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -360,7 +360,7 @@ static int max77686_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 out:
 	mutex_unlock(&info->lock);
-	return 0;
+	return ret;
 }
 
 static int max77686_rtc_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.17.1

