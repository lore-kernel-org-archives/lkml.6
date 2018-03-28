Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeC1WYF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:24:05 -0400
Received: from p3plsmtpa12-05.prod.phx3.secureserver.net ([68.178.252.234]:42161
        "EHLO p3plsmtpa12-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752447AbeC1WYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:24:04 -0400
From: Kyle Spiers <kyle@spiers.me>
To: perex@perex.cz
Cc: tiwai@suse.com, o-takashi@sakamocchi.jp, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Kyle Spiers <kyle@spiers.me>
Subject: [PATCH v2] pcm_native: Remove VLA usage
Date: Wed, 28 Mar 2018 15:24:00 -0700
Message-Id: <1522275840-14092-1-git-send-email-kyle@spiers.me>
X-Mailer: git-send-email 2.7.4
X-CMAE-Envelope: MS4wfOxlpo33EfCkmGtMdLTobtKxHOHW5QK4DVb5lTLxyD/cKbdIDnHFUIVS2AaLWt8yZNYuXHItRiypgvqZnl/6JIpyonpzEdvYEMlWe6Dogr1uX3vyfaur
 If2w8XeBRGgmmW5qkWsdbKoKHpHN23qVTodpaoPXkNuk7BANYv8K+XXz+6VmmdTb60dgexBn8FjHhYC0OStCzv30ohv2VGT1s1emQlC4p/HDWD6YNDCwDyiD
 81lRsdfLxhc0hSGrnqlob2K3qSC7Vft1a7xU7xAyOkW6yrhGHhf0/PbmY8vNB5XMtML4WmiMdE7dHE/ttv0KtjhrlYoOWe1yIBJr6p+2rUhWfTz7VCPlnlP3
 AOCXhrw4YeeUoW2kHWNlxyOxodKL3w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the effort to remove VLAs from the kernel[1], this changes
the allocation of the rstamps array from being on the stack to being
kcalloc()ed. This also allows for the removal of the explicit zeroing
loop.

Signed-off-by: Kyle Spiers <kyle@spiers.me>
---
 sound/core/pcm_native.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 77ba50d..db5e3c5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -323,7 +323,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_constraints *constrs =
 					&substream->runtime->hw_constraints;
 	unsigned int k;
-	unsigned int rstamps[constrs->rules_num];
+	unsigned int *rstamps;
 	unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST_INTERVAL + 1];
 	unsigned int stamp;
 	struct snd_pcm_hw_rule *r;
@@ -339,8 +339,8 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	 * Each member of 'rstamps' array represents the sequence number of
 	 * recent application of corresponding rule.
 	 */
-	for (k = 0; k < constrs->rules_num; k++)
-		rstamps[k] = 0;
+
+	rstamps = kcalloc(constrs->rules_num, sizeof(*rstamps), GFP_KERNEL);
 
 	/*
 	 * Each member of 'vstamps' array represents the sequence number of
@@ -398,8 +398,10 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		}
 
 		changed = r->func(params, r);
-		if (changed < 0)
+		if (changed < 0) {
+			kfree(rstamps);
 			return changed;
+		}
 
 		/*
 		 * When the parameter is changed, notify it to the caller
@@ -430,6 +432,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	if (again)
 		goto retry;
 
+	kfree(rstamps);
 	return 0;
 }
 
-- 
2.7.4
