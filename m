Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeDIKuG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:50:06 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45637 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeDIKuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:50:04 -0400
X-Google-Smtp-Source: AIpwx49L5PrcEpSVXmyFvk68gYs9LiNaPZQT1cNQopbL96PF0B+mrzmDi5iyqR6kiaybwGhHuB+MiA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, subhransu.s.prusty@intel.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] sound: soc: intel: skl_rt286: Replace GFP_ATOMIC with GFP_KERNEL in skylake_audio_probe
Date: Mon,  9 Apr 2018 18:49:58 +0800
Message-Id: <1523270998-23130-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skylake_audio_probe() is never called in atomic context.
This function is only set as ".probe" in "struct platform_driver".

Despite never getting called from atomic context,
skylake_audio_probe() calls devm_kzalloc() with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
to avoid busy waiting and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/soc/intel/boards/skl_rt286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 2bc4cfc..bb7187b 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -527,7 +527,7 @@ static int skylake_audio_probe(struct platform_device *pdev)
 {
 	struct skl_rt286_private *ctx;
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
-- 
1.9.1
