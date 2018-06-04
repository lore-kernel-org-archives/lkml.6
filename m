Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeFDLPh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:15:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35136 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeFDLPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:15:35 -0400
X-Google-Smtp-Source: ADUXVKIv1ziHWp8b+zLXqzMFMWB5eiCe9/9lXZcP3j60E4nKA2CzWjRePo37O9AoaYuRRYGoJva1JA==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] ASoC: dapm: delete dapm_kcontrol_data paths list before freeing it
Date: Mon,  4 Jun 2018 12:13:26 +0100
Message-Id: <20180604111326.15708-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dapm_kcontrol_data is freed as part of dapm_kcontrol_free(), leaving the
paths pointer dangling in the list.

This leads to system crash when we try to unload and reload sound card.
I hit this bug during ADSP crash/reboot test case on Dragon board DB410c.

Without this patch, on SLAB Poisoning enabled build, kernel crashes with
"BUG kmalloc-128 (Tainted: G        W        ): Poison overwritten"

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	-remove unnecessary very long bug trace.

 sound/soc/soc-dapm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1e9a36389667..36a39ba30226 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -433,6 +433,8 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kctl);
+
+	list_del(&data->paths);
 	kfree(data->wlist);
 	kfree(data);
 }
-- 
2.16.2
