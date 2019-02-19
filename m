Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1BCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525B62147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfBSQDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:03:06 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:24806 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBSQDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:03:05 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id E529D13F89D;
        Tue, 19 Feb 2019 17:02:46 +0100 (CET)
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v1] regulator: core: Log forbidden DRMS operation
Message-ID: <6e471922-2850-97b8-c555-34e1708cbc38@free.fr>
Date:   Tue, 19 Feb 2019 17:02:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When REGULATOR_CHANGE_DRMS is not set, drms_uA_update is a no-op.
It used to print a debug message, which was dropped in commit
8a34e979f684 ("regulator: refactor valid_ops_mask checking code")

Let's bring the debug message back as KERN_INFO, because it is very
useful to diagnose missing regulator-allow-set-load properties.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/regulator/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 59782a706ac4..2ff9b55cfcd8 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -930,8 +930,10 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	 * first check to see if we can set modes at all, otherwise just
 	 * tell the consumer everything is OK.
 	 */
-	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_DRMS))
+	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_DRMS)) {
+		rdev_info(rdev, "DRMS operation not allowed\n");
 		return 0;
+	}
 
 	if (!rdev->desc->ops->get_optimum_mode &&
 	    !rdev->desc->ops->set_load)
-- 
2.17.1
