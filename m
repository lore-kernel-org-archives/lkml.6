Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeC0OaL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:30:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47202 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeC0OaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:30:10 -0400
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Andrew Chant <achant@google.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: fix memory leak on cval
Date: Tue, 27 Mar 2018 15:30:01 +0100
Message-Id: <20180327143001.13870-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

With the current exit return path of the ctl_info allocation failure
cval is not being freed resulting in a memory leak. Fix this by kfree'ing
it on the return.

Detected by CoverityScan, CID#1466878 ("Resource Leak")

Fixes: 21e9b3e931f7 ("ALSA: usb-audio: fix uac control query argument")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/mixer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 04dab6f65535..301ad61ed426 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1365,8 +1365,10 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 	cval->cmask = ctl_mask;
 
 	ctl_info = get_feature_control_info(control);
-	if (!ctl_info)
+	if (!ctl_info) {
+		kfree(cval);
 		return;
+	}
 	if (state->mixer->protocol == UAC_VERSION_1)
 		cval->val_type = ctl_info->type;
 	else /* UAC_VERSION_2 */
-- 
2.15.1
