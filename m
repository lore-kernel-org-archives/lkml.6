Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8471FC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5430520661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5430520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeLIW0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:26:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34724 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbeLIVzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:12 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0002iZ-MC; Sun, 09 Dec 2018 21:55:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0003Dm-I1; Sun, 09 Dec 2018 21:55:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Kalle Valo" <kvalo@codeaurora.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Daniel Mack" <daniel@zonque.org>, "Chris Ball" <chris@printf.net>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.356088620@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 021/328] libertas: fix suspend and resume for SDIO
 connected cards
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Daniel Mack <daniel@zonque.org>
Reviewed-by: Chris Ball <chris@printf.net>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 3.16: adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/libertas/dev.h     |  1 +
 drivers/net/wireless/libertas/if_sdio.c | 30 +++++++++++++++----
 2 files changed, 25 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/libertas/dev.h
+++ b/drivers/net/wireless/libertas/dev.h
@@ -102,6 +102,7 @@ struct lbs_private {
 	u8 fw_ready;
 	u8 surpriseremoved;
 	u8 setup_fw_on_resume;
+	u8 power_up_on_resume;
 	int (*hw_host_to_card) (struct lbs_private *priv, u8 type, u8 *payload, u16 nb);
 	void (*reset_card) (struct lbs_private *priv);
 	int (*power_save) (struct lbs_private *priv);
--- a/drivers/net/wireless/libertas/if_sdio.c
+++ b/drivers/net/wireless/libertas/if_sdio.c
@@ -1342,15 +1342,23 @@ static void if_sdio_remove(struct sdio_f
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
@@ -1358,9 +1366,14 @@ static int if_sdio_suspend(struct device
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
@@ -1373,7 +1386,7 @@ static int if_sdio_suspend(struct device
 	if (ret)
 		return ret;
 
-	ret = lbs_suspend(card->priv);
+	ret = lbs_suspend(priv);
 	if (ret)
 		return ret;
 
@@ -1388,6 +1401,11 @@ static int if_sdio_resume(struct device
 
 	dev_info(dev, "%s: resume: we're back\n", sdio_func_id(func));
 
+	if (card->priv->power_up_on_resume) {
+		if_sdio_power_on(card);
+		wait_event(card->pwron_waitq, card->priv->fw_ready);
+	}
+
 	ret = lbs_resume(card->priv);
 
 	return ret;

