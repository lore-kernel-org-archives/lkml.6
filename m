Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753804AbeC1SRj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:17:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50456 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753720AbeC1SRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:17:35 -0400
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: topology: fix memory leak on se when kstrdup fails
Date: Wed, 28 Mar 2018 19:17:25 +0100
Message-Id: <20180328181725.17226-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case when kstrdup fails to allocation memory for kc[i].name
the error exit path does not free up 'se' leading to a small leak.
Fix this by kfree'ing 'se' before jumping to err_se and since
kc[i].private_value is zero we end up avoiding kfree'ing the
rest of the unallocated objects in se.

Detected by CoverityScan, CID#1466991 ("Reseource leak")

Fixes: 267e2c6fd7ca ("ASoC: topology: Fix kcontrol name string handling")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/soc-topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index fa27d0fca6dc..71b20d795b51 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1325,8 +1325,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 			ec->hdr.name);
 
 		kc[i].name = kstrdup(ec->hdr.name, GFP_KERNEL);
-		if (kc[i].name == NULL)
+		if (kc[i].name == NULL) {
+			kfree(se);
 			goto err_se;
+		}
 		kc[i].private_value = (long)se;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = ec->hdr.access;
-- 
2.15.1
