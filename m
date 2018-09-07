Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1F0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF232075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF232075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeIHBzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:55:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40674 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeIHBzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:55:49 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 535A6F07;
        Fri,  7 Sep 2018 21:13:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Chris Ball <chris@printf.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.18 021/145] libertas: fix suspend and resume for SDIO connected cards
Date:   Fri,  7 Sep 2018 23:08:07 +0200
Message-Id: <20180907210905.263356261@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Mack <daniel@zonque.org>

commit 7444a8092906ed44c09459780c56ba57043e39b1 upstream.

Prior to commit 573185cc7e64 ("mmc: core: Invoke sdio func driver's PM
callbacks from the sdio bus"), the MMC core used to call into the power
management functions of SDIO clients itself and removed the card if the
return code was non-zero. IOW, the mmc handled errors gracefully and didn't
upchain them to the pm core.

Since this change, the mmc core relies on generic power management
functions which treat all errors as a reason to cancel the suspend
immediately. This causes suspend attempts to fail when the libertas
driver is loaded.

To fix this, power down the card explicitly in if_sdio_suspend() when we
know we're about to lose power and return success. Also set a flag in these
cases, and power up the card again in if_sdio_resume().

Fixes: 573185cc7e64 ("mmc: core: Invoke sdio func driver's PM callbacks from the sdio bus")
Cc: <stable@vger.kernel.org>
Signed-off-by: Daniel Mack <daniel@zonque.org>
Reviewed-by: Chris Ball <chris@printf.net>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/libertas/dev.h     |    1 
 drivers/net/wireless/marvell/libertas/if_sdio.c |   30 +++++++++++++++++++-----
 2 files changed, 25 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/marvell/libertas/dev.h
+++ b/drivers/net/wireless/marvell/libertas/dev.h
@@ -104,6 +104,7 @@ struct lbs_private {
 	u8 fw_ready;
 	u8 surpriseremoved;
 	u8 setup_fw_on_resume;
+	u8 power_up_on_resume;
 	int (*hw_host_to_card) (struct lbs_private *priv, u8 type, u8 *payload, u16 nb);
 	void (*reset_card) (struct lbs_private *priv);
 	int (*power_save) (struct lbs_private *priv);
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -1290,15 +1290,23 @@ static void if_sdio_remove(struct sdio_f
 static int if_sdio_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
-	int ret;
 	struct if_sdio_card *card = sdio_get_drvdata(func);
+	struct lbs_private *priv = card->priv;
+	int ret;
 
 	mmc_pm_flag_t flags = sdio_get_host_pm_caps(func);
+	priv->power_up_on_resume = false;
 
 	/* If we're powered off anyway, just let the mmc layer remove the
 	 * card. */
-	if (!lbs_iface_active(card->priv))
-		return -ENOSYS;
+	if (!lbs_iface_active(priv)) {
+		if (priv->fw_ready) {
+			priv->power_up_on_resume = true;
+			if_sdio_power_off(card);
+		}
+
+		return 0;
+	}
 
 	dev_info(dev, "%s: suspend: PM flags = 0x%x\n",
 		 sdio_func_id(func), flags);
@@ -1306,9 +1314,14 @@ static int if_sdio_suspend(struct device
 	/* If we aren't being asked to wake on anything, we should bail out
 	 * and let the SD stack power down the card.
 	 */
-	if (card->priv->wol_criteria == EHS_REMOVE_WAKEUP) {
+	if (priv->wol_criteria == EHS_REMOVE_WAKEUP) {
 		dev_info(dev, "Suspend without wake params -- powering down card\n");
-		return -ENOSYS;
+		if (priv->fw_ready) {
+			priv->power_up_on_resume = true;
+			if_sdio_power_off(card);
+		}
+
+		return 0;
 	}
 
 	if (!(flags & MMC_PM_KEEP_POWER)) {
@@ -1321,7 +1334,7 @@ static int if_sdio_suspend(struct device
 	if (ret)
 		return ret;
 
-	ret = lbs_suspend(card->priv);
+	ret = lbs_suspend(priv);
 	if (ret)
 		return ret;
 
@@ -1336,6 +1349,11 @@ static int if_sdio_resume(struct device
 
 	dev_info(dev, "%s: resume: we're back\n", sdio_func_id(func));
 
+	if (card->priv->power_up_on_resume) {
+		if_sdio_power_on(card);
+		wait_event(card->pwron_waitq, card->priv->fw_ready);
+	}
+
 	ret = lbs_resume(card->priv);
 
 	return ret;


