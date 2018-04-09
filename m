Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDINDf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:03:35 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39853 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeDINDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:03:34 -0400
X-Google-Smtp-Source: AIpwx4/NX1BWBfZbVAgLp84WqOUU4JCJ1Gi3IJx9scvztcENf1E20WAI5ku/laQcJU7P7AaZPmN/6Q==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: T-Bone@parisc-linux.org, perex@perex.cz, tiwai@suse.com
Cc: linux-parisc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] sound: ad1889: Replace mdelay with usleep_range in snd_ad1889_init
Date: Mon,  9 Apr 2018 21:03:20 +0800
Message-Id: <1523279000-23973-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_ad1889_init() is never called in atomic context.

The call chain ending up at snd_ad1889_init() is:
[1] snd_ad1889_init() <- snd_ad1889_create() <- snd_ad1889_probe()

snd_ad1889_probe() is only set as ".probe" in struct pci_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, snd_ad1889_init()
calls mdelay for busy wait.
This is not necessary and can be replaced with usleep_range to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/pci/ad1889.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 0bf2c04..d4965eb 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -872,7 +872,7 @@ struct snd_ad1889 {
 	ad1889_writew(chip, AD_DS_CCS, AD_DS_CCS_CLKEN); /* turn on clock */
 	ad1889_readw(chip, AD_DS_CCS);	/* flush posted write */
 
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	/* enable Master and Target abort interrupts */
 	ad1889_writel(chip, AD_DMA_DISR, AD_DMA_DISR_PMAE | AD_DMA_DISR_PTAE);
-- 
1.9.1
