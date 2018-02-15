Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426503AbeBOQtG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:49:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:12998 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423789AbeBOQsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:48:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="175557273"
From: abhijeet.kumar@intel.com
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>,
        Puneeth Prabhu <puneethx.prabhu@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: abhijeet.kumar@intel.com, fengguang.wu@intel.com
Subject: [PATCH v2] ASoC: hdac_hdmi : Ensuring proper setting of output widget power state
Date: Thu, 15 Feb 2018 22:26:50 +0530
Message-Id: <1518713812-17078-1-git-send-email-abhijeet.kumar@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518683739-4448-1-git-send-email-abhijeet.kumar@intel.com>
References: <1518683739-4448-1-git-send-email-abhijeet.kumar@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhijeet Kumar <abhijeet.kumar@intel.com>

In usecases like hot plug-unplug DP panel or modeset during a playback,
sometimes we observe no audio after codec resets. During no audio
condition, we have noticed that the power state of the pin or the
connector is D3. Optimizing the way we set the power mitigates the
issue. With this changes the verb is sent to set the power state and
waits until actual state reaches target state. Thus ensuring power
state is set.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index dba6f4c5074a..97fcd55205e6 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -718,10 +718,22 @@ static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm(struct hdac_ext_device *edev,
 static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
 			     hda_nid_t nid, unsigned int pwr_state)
 {
+	int count;
+	unsigned int state;
+
 	if (get_wcaps(&edev->hdev, nid) & AC_WCAP_POWER) {
-		if (!snd_hdac_check_power_state(&edev->hdev, nid, pwr_state))
-			snd_hdac_codec_write(&edev->hdev, nid, 0,
-				AC_VERB_SET_POWER_STATE, pwr_state);
+		if (!snd_hdac_check_power_state(&edev->hdev, nid, pwr_state)) {
+			for (count = 0; count < 10; count++) {
+				snd_hdac_codec_read(&edev->hdev, nid, 0,
+						AC_VERB_SET_POWER_STATE,
+						pwr_state);
+				state = snd_hdac_sync_power_state(&edev->hdev,
+						nid, pwr_state);
+				if (!(state & AC_PWRST_ERROR))
+					break;
+			}
+		}
+
 	}
 }
 
-- 
1.9.1
