Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeBHAA2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 19:00:28 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33929 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbeBHAA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 19:00:27 -0500
X-Google-Smtp-Source: AH8x226+V9c9+/LUzJVq8jGk8dm9GvvbFSvb+1UNWYHZzxIaZI5THO+LeDBw3OVgMsoG7b9ISaVKRw==
From: Sergio Valverde <vlvrdv@gmail.com>
Cc: Sergio Valverde <vlvrdv@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: optimize mmc_calc_max_discard
Date: Wed,  7 Feb 2018 17:59:40 -0600
Message-Id: <1518047981-23958-1-git-send-email-vlvrdv@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the max_discard value is zero, the conditional branch that checks the
trim capabilities will never update this value with max_trim.

Change the condition statement to also check the max_discard value in order
to avoid an unnecessary call to mmc_do_calc_max_discard.

Signed-off-by: Sergio Valverde <vlvrdv@gmail.com>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1f0f44f..97856b1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2567,7 +2567,7 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 		return card->pref_erase;
 
 	max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
-	if (mmc_can_trim(card)) {
+	if (mmc_can_trim(card) && max_discard) {
 		max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
 		if (max_trim < max_discard)
 			max_discard = max_trim;
-- 
2.7.4
