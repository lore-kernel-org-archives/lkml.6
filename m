Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755015AbeEaLXv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:23:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754825AbeEaLWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:48 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH v2 18/21] ASoC: dapm: use match_string() helper
Date: Thu, 31 May 2018 19:11:23 +0800
Message-ID: <1527765086-19873-19-git-send-email-xieyisheng1@huawei.com>
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - add Reviewed-by tag.

 sound/soc/soc-dapm.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2d97091..1e9a363 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -724,18 +724,14 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 		item = 0;
 	}
 
-	for (i = 0; i < e->items; i++) {
-		if (!(strcmp(control_name, e->texts[i]))) {
-			path->name = e->texts[i];
-			if (i == item)
-				path->connect = 1;
-			else
-				path->connect = 0;
-			return 0;
-		}
-	}
+	i = match_string(e->texts, e->items, control_name);
+	if (i < 0)
+		return -ENODEV;
+
+	path->name = e->texts[i];
+	path->connect = (i == item);
+	return 0;
 
-	return -ENODEV;
 }
 
 /* set up initial codec paths */
-- 
1.7.12.4
