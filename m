Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754994AbeEaLXq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:23:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754823AbeEaLWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:48 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH v2 17/21] ASoC: max98095: use match_string() helper
Date: Thu, 31 May 2018 19:11:22 +0800
Message-ID: <1527765086-19873-18-git-send-email-xieyisheng1@huawei.com>
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
 - split ret=xxxx and move assignment to the line before 'if' - per Andy

 sound/soc/codecs/max98095.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 6bf2d0b..3b3a10d 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1634,15 +1634,12 @@ static void max98095_handle_eq_pdata(struct snd_soc_component *component)
 static int max98095_get_bq_channel(struct snd_soc_component *component,
 				   const char *name)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bq_mode_name); i++)
-		if (strcmp(name, bq_mode_name[i]) == 0)
-			return i;
+	int ret;
 
-	/* Shouldn't happen */
-	dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
-	return -EINVAL;
+	ret = match_string(bq_mode_name, ARRAY_SIZE(bq_mode_name), name);
+	if (ret < 0)
+		dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
+	return ret;
 }
 
 static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
-- 
1.7.12.4
