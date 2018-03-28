Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeC1WLb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:11:31 -0400
Received: from p3plsmtpa11-08.prod.phx3.secureserver.net ([68.178.252.109]:37081
        "EHLO p3plsmtpa11-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752606AbeC1WLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:11:30 -0400
From: Kyle Spiers <kyle@spiers.me>
To: perex@perex.cz
Cc: tiwai@suse.com, o-takashi@sakamocchi.jp, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Kyle Spiers <kyle@spiers.me>
Subject: [PATCH] pcm_native: Remove VLA usage
Date: Wed, 28 Mar 2018 15:11:19 -0700
Message-Id: <1522275079-2229-1-git-send-email-kyle@spiers.me>
X-Mailer: git-send-email 2.7.4
X-CMAE-Envelope: MS4wfLRYLtkZJ5yrQjfzlbkbzPhSV5zYfhyNtNewILTHLhSpuBlXqsI/Ukk8PLScwGCTvZvt91nE1lx4ubRwBkChcCuJbKrQ6zxTv+U7VRGZMDbTBu/y+MHF
 687Cj1YTchr/iaZ7H8Qq7d07Rbhn0N+syr1/vIG0PJ2eexClO5itOLp8qVQfnybSVOywUkdScc8ajJN/aAwoxEp0OukesZeey9Wh/uI81tvgSZFTARWcmLJP
 7mHQ/JxX0lkSiOVDYDIQNqVgF7rd83VXrpypwDS9JldUnjzr4rt8w+yTir2cHV6lRN5IRCRhu/usDZGm2zQb5bR+uHOEE82I/iktVhflhWyHAS3y4+Dt4f9u
 vXw2uc/OOLJsKQGTAA/nJkfYyzGVdw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the effort to remove VLAs from the kernel[1], this changes
the allocation of the rstamps array from being on the stack to being
kcalloc()ed. This also allows for the removal of the explicit zeroing
loop.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kyle Spiers <kyle@spiers.me>
---
 sound/core/pcm_native.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 77ba50d..57240b8 100644
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
@@ -399,6 +399,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 
 		changed = r->func(params, r);
 		if (changed < 0)
+			kfree(rstamps);
 			return changed;
 
 		/*
@@ -430,6 +431,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	if (again)
 		goto retry;
 
+	kfree(rstamps);
 	return 0;
 }
 
-- 
2.7.4
