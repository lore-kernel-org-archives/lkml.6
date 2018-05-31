Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754975AbeEaLXj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:23:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754567AbeEaLWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:48 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Clemens Ladisch" <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH v2 15/21] ALSA: oxygen: use match_string() helper
Date: Thu, 31 May 2018 19:11:20 +0800
Message-ID: <1527765086-19873-16-git-send-email-xieyisheng1@huawei.com>
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

Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - do not change the type of i - per Andy

 sound/pci/oxygen/oxygen_mixer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
index 4ca1266..81af21a 100644
--- a/sound/pci/oxygen/oxygen_mixer.c
+++ b/sound/pci/oxygen/oxygen_mixer.c
@@ -1052,10 +1052,10 @@ static int add_controls(struct oxygen *chip,
 		[CONTROL_CD_CAPTURE_SWITCH] = "CD Capture Switch",
 		[CONTROL_AUX_CAPTURE_SWITCH] = "Aux Capture Switch",
 	};
-	unsigned int i, j;
+	unsigned int i;
 	struct snd_kcontrol_new template;
 	struct snd_kcontrol *ctl;
-	int err;
+	int j, err;
 
 	for (i = 0; i < count; ++i) {
 		template = controls[i];
@@ -1086,11 +1086,11 @@ static int add_controls(struct oxygen *chip,
 		err = snd_ctl_add(chip->card, ctl);
 		if (err < 0)
 			return err;
-		for (j = 0; j < CONTROL_COUNT; ++j)
-			if (!strcmp(ctl->id.name, known_ctl_names[j])) {
-				chip->controls[j] = ctl;
-				ctl->private_free = oxygen_any_ctl_free;
-			}
+		j = match_string(known_ctl_names, CONTROL_COUNT, ctl->id.name);
+		if (j >= 0) {
+			chip->controls[j] = ctl;
+			ctl->private_free = oxygen_any_ctl_free;
+		}
 	}
 	return 0;
 }
-- 
1.7.12.4
