Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BAAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3E620645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3E620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeIDUYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:24:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:51068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727830AbeIDUYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 143D1B0B8;
        Tue,  4 Sep 2018 15:59:03 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/29] staging: bcm2835-audio: Simplify card object management
Date:   Tue,  4 Sep 2018 17:58:58 +0200
Message-Id: <20180904155858.8001-30-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of creating a dummy child device to manage the card object,
just use devm stuff directly for releasing with snd_card_free().
This results in a lot of code reduction.

Since the dummy child devices are gone, the device object to be passed
to the memory allocator needs to be adjusted as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c |   2 +-
 .../vc04_services/bcm2835-audio/bcm2835.c     | 120 +++++-------------
 2 files changed, 33 insertions(+), 89 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 98480d97cc2e..e66da11af5cf 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -349,7 +349,7 @@ int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, const char *name,
 			&snd_bcm2835_playback_ops);
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-		chip->card->dev->parent, 128 * 1024, 128 * 1024);
+		chip->card->dev, 128 * 1024, 128 * 1024);
 
 	if (spdif)
 		chip->pcm_spdif = pcm;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 2869f310086f..87d56ab1ffa0 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -22,38 +22,6 @@ module_param(enable_compat_alsa, bool, 0444);
 MODULE_PARM_DESC(enable_compat_alsa,
 		 "Enables ALSA compatibility virtual audio device");
 
-static void snd_devm_unregister_child(struct device *dev, void *res)
-{
-	struct device *childdev = *(struct device **)res;
-	struct bcm2835_chip *chip = dev_get_drvdata(childdev);
-	struct snd_card *card = chip->card;
-
-	snd_card_free(card);
-
-	device_unregister(childdev);
-}
-
-static int snd_devm_add_child(struct device *dev, struct device *child)
-{
-	struct device **dr;
-	int ret;
-
-	dr = devres_alloc(snd_devm_unregister_child, sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return -ENOMEM;
-
-	ret = device_add(child);
-	if (ret) {
-		devres_free(dr);
-		return ret;
-	}
-
-	*dr = child;
-	devres_add(dev, dr);
-
-	return 0;
-}
-
 static void bcm2835_devm_free_vchi_ctx(struct device *dev, void *res)
 {
 	struct bcm2835_vchi_ctx *vchi_ctx = res;
@@ -84,36 +52,6 @@ static int bcm2835_devm_add_vchi_ctx(struct device *dev)
 	return 0;
 }
 
-static void snd_bcm2835_release(struct device *dev)
-{
-}
-
-static struct device *
-snd_create_device(struct device *parent,
-		  struct device_driver *driver,
-		  const char *name)
-{
-	struct device *device;
-	int ret;
-
-	device = devm_kzalloc(parent, sizeof(*device), GFP_KERNEL);
-	if (!device)
-		return ERR_PTR(-ENOMEM);
-
-	device_initialize(device);
-	device->parent = parent;
-	device->driver = driver;
-	device->release = snd_bcm2835_release;
-
-	dev_set_name(device, "%s", name);
-
-	ret = snd_devm_add_child(parent, device);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return device;
-}
-
 typedef int (*bcm2835_audio_newpcm_func)(struct bcm2835_chip *chip,
 					 const char *name,
 					 enum snd_bcm2835_route route,
@@ -216,40 +154,36 @@ static struct bcm2835_audio_drivers children_devices[] = {
 	},
 };
 
-static int snd_add_child_device(struct device *device,
+static void bcm2835_card_free(void *data)
+{
+	snd_card_free(data);
+}
+
+static int snd_add_child_device(struct device *dev,
 				struct bcm2835_audio_driver *audio_driver,
 				u32 numchans)
 {
 	struct snd_card *card;
-	struct device *child;
 	struct bcm2835_chip *chip;
 	int err;
 
-	child = snd_create_device(device, &audio_driver->driver,
-				  audio_driver->driver.name);
-	if (IS_ERR(child)) {
-		dev_err(device,
-			"Unable to create child device %p, error %ld",
-			audio_driver->driver.name,
-			PTR_ERR(child));
-		return PTR_ERR(child);
-	}
-
-	err = snd_card_new(child, -1, NULL, THIS_MODULE, sizeof(*chip), &card);
+	err = snd_card_new(dev, -1, NULL, THIS_MODULE, sizeof(*chip), &card);
 	if (err < 0) {
-		dev_err(child, "Failed to create card");
+		dev_err(dev, "Failed to create card");
 		return err;
 	}
 
 	chip = card->private_data;
 	chip->card = card;
-	chip->dev = child;
+	chip->dev = dev;
 	mutex_init(&chip->audio_mutex);
 
-	chip->vchi_ctx = devres_find(device,
+	chip->vchi_ctx = devres_find(dev,
 				     bcm2835_devm_free_vchi_ctx, NULL, NULL);
-	if (!chip->vchi_ctx)
-		return -ENODEV;
+	if (!chip->vchi_ctx) {
+		err = -ENODEV;
+		goto error;
+	}
 
 	strcpy(card->driver, audio_driver->driver.name);
 	strcpy(card->shortname, audio_driver->shortname);
@@ -259,26 +193,36 @@ static int snd_add_child_device(struct device *device,
 		audio_driver->route,
 		numchans);
 	if (err) {
-		dev_err(child, "Failed to create pcm, error %d\n", err);
-		return err;
+		dev_err(dev, "Failed to create pcm, error %d\n", err);
+		goto error;
 	}
 
 	err = audio_driver->newctl(chip);
 	if (err) {
-		dev_err(child, "Failed to create controls, error %d\n", err);
-		return err;
+		dev_err(dev, "Failed to create controls, error %d\n", err);
+		goto error;
 	}
 
 	err = snd_card_register(card);
 	if (err) {
-		dev_err(child, "Failed to register card, error %d\n", err);
-		return err;
+		dev_err(dev, "Failed to register card, error %d\n", err);
+		goto error;
 	}
 
-	dev_set_drvdata(child, chip);
-	dev_info(child, "card created with %d channels\n", numchans);
+	dev_set_drvdata(dev, chip);
 
+	err = devm_add_action(dev, bcm2835_card_free, card);
+	if (err < 0) {
+		dev_err(dev, "Failed to add devm action, err %d\n", err);
+		goto error;
+	}
+
+	dev_info(dev, "card created with %d channels\n", numchans);
 	return 0;
+
+ error:
+	snd_card_free(card);
+	return err;
 }
 
 static int snd_add_child_devices(struct device *device, u32 numchans)
-- 
2.18.0

