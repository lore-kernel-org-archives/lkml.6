Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29399C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C2120880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfBULzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:55:24 -0500
Received: from ns.iliad.fr ([212.27.33.1]:41980 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBULzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:55:24 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 8AA252044A;
        Thu, 21 Feb 2019 12:55:22 +0100 (CET)
Received: from [192.168.108.68] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 6C39920187;
        Thu, 21 Feb 2019 12:55:22 +0100 (CET)
Subject: [PATCH v2] regulator: core: Log forbidden DRMS operation
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <6e471922-2850-97b8-c555-34e1708cbc38@free.fr>
 <20190219163929.GA20883@sirena.org.uk>
 <5ad87a46-147f-0619-29b9-bd352810ade8@free.fr>
 <20190221101238.GB5970@sirena.org.uk>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <251e00c8-40f4-1712-f732-1351361f667a@free.fr>
Date:   Thu, 21 Feb 2019 12:55:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221101238.GB5970@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Feb 21 12:55:22 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When REGULATOR_CHANGE_DRMS is not set, drms_uA_update is a no-op.
It used to print a debug message, which was dropped in commit
8a34e979f684 ("regulator: refactor valid_ops_mask checking code")

Let's bring the debug message back, because it helps find missing
regulator-allow-set-load properties.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/regulator/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 59782a706ac4..64f91cf21846 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -930,8 +930,10 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	 * first check to see if we can set modes at all, otherwise just
 	 * tell the consumer everything is OK.
 	 */
-	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_DRMS))
+	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_DRMS)) {
+		rdev_dbg(rdev, "DRMS operation not allowed\n");
 		return 0;
+	}
 
 	if (!rdev->desc->ops->get_optimum_mode &&
 	    !rdev->desc->ops->set_load)
-- 
2.17.1
