Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeDHX6g (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 19:58:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36746 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeDHX6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 19:58:34 -0400
X-Google-Smtp-Source: AIpwx4+kLknQV5BTMdV1D/FOFBmIEp9UxkA1ugZpHm9itL0MI++Uxu7lnER9y2235+YiRa2WlCGETg==
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org, marex@denx.de
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
        lgirdwood@gmail.com, fabio.estevam@nxp.com
Subject: [PATCH] ASoC: fsl_esai: Fix divisor calculation failure at lower ratio
Date: Sun,  8 Apr 2018 16:57:35 -0700
Message-Id: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the desired ratio is less than 256, the savesub (tolerance)
in the calculation would become 0. This will then fail the loop-
search immediately without reporting any errors.

But if the ratio is smaller enough, there is no need to calculate
the tolerance because PM divisor alone is enough to get the ratio.

So a simple fix could be just to set PM directly instead of going
into the loop-search.

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Marek Vasut <marex@denx.de>
---
 sound/soc/fsl/fsl_esai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 40a7004..da8fd98 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -144,6 +144,13 @@ static int fsl_esai_divisor_cal(struct snd_soc_dai *dai, bool tx, u32 ratio,
 
 	psr = ratio <= 256 * maxfp ? ESAI_xCCR_xPSR_BYPASS : ESAI_xCCR_xPSR_DIV8;
 
+	/* Do not loop-search if PM (1 ~ 256) alone can serve the ratio */
+	if (ratio <= 256) {
+		pm = ratio;
+		fp = 1;
+		goto out;
+	}
+
 	/* Set the max fluctuation -- 0.1% of the max devisor */
 	savesub = (psr ? 1 : 8)  * 256 * maxfp / 1000;
 
-- 
2.7.4
