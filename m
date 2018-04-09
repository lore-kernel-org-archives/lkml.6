Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeDINDt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:03:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35067 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeDINDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:03:45 -0400
X-Google-Smtp-Source: AIpwx486wri9NwmZYHfbp79BtnlTrC/6RkppW9tPoZtjrMIwWwL5tkDrARbqTDnfGJ+wrt/ytQlv9A==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: T-Bone@parisc-linux.org, perex@perex.cz, tiwai@suse.com
Cc: linux-parisc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] sound: ad1889: Replace mdelay with usleep_range in snd_ad1889_ac97_ready
Date: Mon,  9 Apr 2018 21:03:38 +0800
Message-Id: <1523279018-24017-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_ad1889_ac97_ready() is never called in atomic context.

The call chain ending up at snd_ad1889_ac97_ready() is:
[1] snd_ad1889_ac97_ready() <- snd_ad1889_ac97_xinit() <- 
	snd_ad1889_ac97_init() <- snd_ad1889_probe()

snd_ad1889_probe() is only set as ".probe" in struct pci_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, snd_ad1889_ac97_ready()
calls mdelay for busy wait.
This is not necessary and can be replaced with usleep_range to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/pci/ad1889.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 0bf2c04..a2a8e1d 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -258,7 +258,7 @@ struct snd_ad1889 {
 	
 	while (!(ad1889_readw(chip, AD_AC97_ACIC) & AD_AC97_ACIC_ACRDY) 
 			&& --retry)
-		mdelay(1);
+		usleep_range(1000, 2000);
 	if (!retry) {
 		dev_err(chip->card->dev, "[%s] Link is not ready.\n",
 			__func__);
-- 
1.9.1
