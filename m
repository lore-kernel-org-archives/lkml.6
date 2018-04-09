Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933007AbeDIBpd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 21:45:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33808 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932490AbeDIAen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:43 -0400
X-Google-Smtp-Source: AIpwx49cy/6Y0GkzIwma+Jr+2ipIS5dQk0yypnO6yXpDY1r9xqaAj1NPnKFnI9+Xte18+FiQAEtiOw==
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
        lgirdwood@gmail.com, fabio.estevam@nxp.com
Subject: [PATCH] ASoC: fsl_esai: Add freq check in set_dai_sysclk()
Date: Sun,  8 Apr 2018 17:33:54 -0700
Message-Id: <1523234034-33018-1-git-send-email-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The freq parameter indicates the physical frequency of an actual
input clock or a desired frequency of an output clock for HCKT/R.
It should never be passed 0. This might cause Division-by-zero.

So this patch adds a check to fix it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_esai.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index da8fd98..d79e99e 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -226,6 +226,12 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	unsigned long clk_rate;
 	int ret;
 
+	if (freq == 0) {
+		dev_err(dai->dev, "%sput freq of HCK%c should not be 0Hz\n",
+			in ? "in" : "out", tx ? 'T' : 'R');
+		return -EINVAL;
+	}
+
 	/* Bypass divider settings if the requirement doesn't change */
 	if (freq == esai_priv->hck_rate[tx] && dir == esai_priv->hck_dir[tx])
 		return 0;
-- 
2.7.4
