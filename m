Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933058AbeCMLiQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:38:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932820AbeCMLiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:38:14 -0400
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcm: Remove VLA usage
Date: Tue, 13 Mar 2018 12:37:58 +0100
Message-Id: <20180313113758.14286-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A helper function used by snd_pcm_hw_refine() still keeps using VLA
for timestamps of hw constraint rules that are non-fixed size.

Let's replace the VLA with a simple kmalloc() array.

Reference: https://lkml.org/lkml/2018/3/7/621
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 77ba50ddcf9e..756a9a3884a5 100644
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
@@ -331,7 +331,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	struct snd_mask old_mask;
 	struct snd_interval old_interval;
 	bool again;
-	int changed;
+	int changed, err = 0;
 
 	/*
 	 * Each application of rule has own sequence number.
@@ -339,8 +339,9 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	 * Each member of 'rstamps' array represents the sequence number of
 	 * recent application of corresponding rule.
 	 */
-	for (k = 0; k < constrs->rules_num; k++)
-		rstamps[k] = 0;
+	rstamps = kcalloc(constrs->rules_num, sizeof(unsigned int), GFP_KERNEL);
+	if (!rstamps)
+		return -ENOMEM;
 
 	/*
 	 * Each member of 'vstamps' array represents the sequence number of
@@ -398,8 +399,10 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		}
 
 		changed = r->func(params, r);
-		if (changed < 0)
-			return changed;
+		if (changed < 0) {
+			err = changed;
+			goto out;
+		}
 
 		/*
 		 * When the parameter is changed, notify it to the caller
@@ -430,7 +433,9 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	if (again)
 		goto retry;
 
-	return 0;
+ out:
+	kfree(rstamps);
+	return err;
 }
 
 static int fixup_unreferenced_params(struct snd_pcm_substream *substream,
-- 
2.16.2
