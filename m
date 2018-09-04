Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6430AC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2829220843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2829220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeIDUZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:25:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:50972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727770AbeIDUYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EB44B0B0;
        Tue,  4 Sep 2018 15:59:02 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/29] staging: bcm2835-audio: Use card->private_data
Date:   Tue,  4 Sep 2018 17:58:50 +0200
Message-Id: <20180904155858.8001-22-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of allocating a separate snd_device object, let snd_card_new()
allocate the private resource.  This simplifies the code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835.c     | 91 +++----------------
 1 file changed, 13 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 6876a5eadc07..55e7fbc3ec44 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -86,9 +86,6 @@ static int bcm2835_devm_add_vchi_ctx(struct device *dev)
 
 static void snd_bcm2835_release(struct device *dev)
 {
-	struct bcm2835_chip *chip = dev_get_drvdata(dev);
-
-	kfree(chip);
 }
 
 static struct device *
@@ -117,69 +114,6 @@ snd_create_device(struct device *parent,
 	return device;
 }
 
-/* component-destructor
- * (see "Management of Cards and Components")
- */
-static int snd_bcm2835_dev_free(struct snd_device *device)
-{
-	struct bcm2835_chip *chip = device->device_data;
-	struct snd_card *card = chip->card;
-
-	snd_device_free(card, chip);
-
-	return 0;
-}
-
-/* chip-specific constructor
- * (see "Management of Cards and Components")
- */
-static int snd_bcm2835_create(struct snd_card *card,
-			      struct bcm2835_chip **rchip)
-{
-	struct bcm2835_chip *chip;
-	int err;
-	static struct snd_device_ops ops = {
-		.dev_free = snd_bcm2835_dev_free,
-	};
-
-	*rchip = NULL;
-
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-
-	chip->card = card;
-	mutex_init(&chip->audio_mutex);
-
-	chip->vchi_ctx = devres_find(card->dev->parent,
-				     bcm2835_devm_free_vchi_ctx, NULL, NULL);
-	if (!chip->vchi_ctx) {
-		kfree(chip);
-		return -ENODEV;
-	}
-
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err) {
-		kfree(chip);
-		return err;
-	}
-
-	*rchip = chip;
-	return 0;
-}
-
-static struct snd_card *snd_bcm2835_card_new(struct device *dev)
-{
-	struct snd_card *card;
-	int ret;
-
-	ret = snd_card_new(dev, -1, NULL, THIS_MODULE, 0, &card);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return card;
-}
-
 typedef int (*bcm2835_audio_newpcm_func)(struct bcm2835_chip *chip,
 					 const char *name,
 					 enum snd_bcm2835_route route,
@@ -292,25 +226,26 @@ static int snd_add_child_device(struct device *device,
 		return PTR_ERR(child);
 	}
 
-	card = snd_bcm2835_card_new(child);
-	if (IS_ERR(card)) {
+	err = snd_card_new(child, -1, NULL, THIS_MODULE, sizeof(*chip), &card);
+	if (err < 0) {
 		dev_err(child, "Failed to create card");
-		return PTR_ERR(card);
+		return err;
 	}
 
-	snd_card_set_dev(card, child);
+	chip = card->private_data;
+	chip->card = card;
+	chip->dev = child;
+	mutex_init(&chip->audio_mutex);
+
+	chip->vchi_ctx = devres_find(device,
+				     bcm2835_devm_free_vchi_ctx, NULL, NULL);
+	if (!chip->vchi_ctx)
+		return -ENODEV;
+
 	strcpy(card->driver, audio_driver->driver.name);
 	strcpy(card->shortname, audio_driver->shortname);
 	strcpy(card->longname, audio_driver->longname);
 
-	err = snd_bcm2835_create(card, &chip);
-	if (err) {
-		dev_err(child, "Failed to create chip, error %d\n", err);
-		return err;
-	}
-
-	chip->dev = child;
-
 	err = audio_driver->newpcm(chip, audio_driver->shortname,
 		audio_driver->route,
 		numchans);
-- 
2.18.0

