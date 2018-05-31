Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754868AbeEaLXA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:23:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754857AbeEaLWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:53 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH v2 16/21] ASoC: max98088: use match_string() helper
Date: Thu, 31 May 2018 19:11:21 +0800
Message-ID: <1527765086-19873-17-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - split ret=xxx and move assignment to the line before 'if'
 - fix error return value - both per Andy

 sound/soc/codecs/max98088.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 865f64c..fb515aa 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1382,15 +1382,12 @@ static int max98088_set_bias_level(struct snd_soc_component *component,
 
 static int max98088_get_channel(struct snd_soc_component *component, const char *name)
 {
-	int i;
+	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(eq_mode_name); i++)
-		if (strcmp(name, eq_mode_name[i]) == 0)
-			return i;
-
-	/* Shouldn't happen */
-	dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
-	return -EINVAL;
+	ret = match_string(eq_mode_name, ARRAY_SIZE(eq_mode_name), name);
+	if (ret < 0)
+		dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
+	return ret;
 }
 
 static void max98088_setup_eq1(struct snd_soc_component *component)
-- 
1.7.12.4
