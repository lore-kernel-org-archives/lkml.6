Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeDIKsk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:48:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41635 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeDIKsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:48:38 -0400
X-Google-Smtp-Source: AIpwx4+lt7AP/9bB6bk6PGkUJfH6boWWQflZEJomb3tVb8UDX60HhEGAkvzt5tAJNmqI6+gY+2nboQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] sound: soc: intel: cht_bsw_rt5645: Replace GFP_ATOMIC with GFP_KERNEL in snd_cht_mc_probe
Date: Mon,  9 Apr 2018 18:48:31 +0800
Message-Id: <1523270911-22937-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_cht_mc_probe() is never called in atomic context.
This function is only set as ".probe" in "struct platform_driver".

Despite never getting called from atomic context,
snd_cht_mc_probe() calls devm_kzalloc() with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
to avoid busy waiting and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 5bcde01..d31d0e4 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -555,7 +555,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	bool found = false;
 	bool is_bytcr = false;
 
-	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 
-- 
1.9.1
