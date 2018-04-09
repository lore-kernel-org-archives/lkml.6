Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeDIKrQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:47:16 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44233 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeDIKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:47:14 -0400
X-Google-Smtp-Source: AIpwx482wtw7W3UpWpyyiwJQGBCBd75Ob0PP5a0bRYWiUFI8g5J9Ntz1zKcSXtL3RkRaklC+TVC4IQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, pradeep.d.tewani@intel.com,
        subhransu.s.prusty@intel.com, dharageswari.r@intel.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] sound: soc: intel: bxt_rt298: Replace GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe
Date: Mon,  9 Apr 2018 18:47:07 +0800
Message-Id: <1523270827-22735-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

broxton_audio_probe() is never called in atomic context.
This function is only set as ".probe" in "struct platform_driver".

Despite never getting called from atomic context,
broxton_audio_probe() calls devm_kzalloc() with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
to avoid busy waiting and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 7843104..8257830 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -578,7 +578,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
 		}
 	}
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
-- 
1.9.1
