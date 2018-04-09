Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeDIKrp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:47:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44756 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeDIKro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:47:44 -0400
X-Google-Smtp-Source: AIpwx4+e6jbZeOuANkFIw8OKy8qza/y9601hEH8NjNbE5IEhzjBYJyR3xM1KlfREq3Py8IaXPhTFow==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] sound: soc: intel: bytcr_rt5640: Replace GFP_ATOMIC with GFP_KERNEL in snd_byt_rt5640_mc_probe
Date: Mon,  9 Apr 2018 18:47:37 +0800
Message-Id: <1523270857-22795-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_byt_rt5640_mc_probe() is never called in atomic context.
This function is only set as ".probe" in "struct platform_driver".

Despite never getting called from atomic context,
snd_byt_rt5640_mc_probe() calls devm_kzalloc() with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
to avoid busy waiting and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 4a76b09..e7705e0 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -766,7 +766,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	struct byt_rt5640_private *priv;
 
 	is_bytcr = false;
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-- 
1.9.1
