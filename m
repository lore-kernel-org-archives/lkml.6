Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeEUMK4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:10:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753025AbeEUMJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:27 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH 28/33] ALSA: dice use match_string() helper
Date: Mon, 21 May 2018 19:58:05 +0800
Message-ID: <1526903890-35761-29-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 sound/firewire/dice/dice.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 96bb01b..0639074 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -35,19 +35,13 @@ static bool force_two_pcm_support(struct fw_unit *unit)
 		"SAFFIRE_PRO_40_1",
 	};
 	char model[32];
-	unsigned int i;
 	int err;
 
 	err = fw_csr_string(unit->directory, CSR_MODEL, model, sizeof(model));
 	if (err < 0)
 		return false;
 
-	for (i = 0; i < ARRAY_SIZE(models); i++) {
-		if (strcmp(models[i], model) == 0)
-			break;
-	}
-
-	return i < ARRAY_SIZE(models);
+	return match_string(models, ARRAY_SIZE(models), model) >= 0;
 }
 
 static int check_dice_category(struct fw_unit *unit)
-- 
1.7.12.4
