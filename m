Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CC820864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CC820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbeGPIE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:04:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46908 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbeGPIE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:04:27 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F082FC03;
        Mon, 16 Jul 2018 07:38:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.17 34/67] ALSA: hda - Handle pm failure during hotplug
Date:   Mon, 16 Jul 2018 09:35:03 +0200
Message-Id: <20180716073448.508530063@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit aaa23f86001bdb82d2f937c5c7bce0a1e11a6c5b upstream.

Obtaining the runtime pm wakeref can fail, especially in a hotplug
scenario where i915.ko has been unloaded. If we do not catch the
failure, we end up with an unbalanced pm.

v2 additions by tiwai:
hdmi_present_sense() checks the return value and handle only a
negative error case and bails out only if it's really still suspended.
Also, snd_hda_power_down() is called at the error path so that the
refcount is balanced.

Along with it, the spec->pcm_lock is taken outside
hdmi_present_sense() in the caller side, so that it won't cause
deadlock at reentrace via runtime resume.

v3 fix by tiwai:
Missing linux/pm_runtime.h is included.

References: 222bde03881c ("ALSA: hda - Fix mutex deadlock at HDMI/DP hotplug")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_hdmi.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/asoundef.h>
@@ -764,8 +765,10 @@ static void check_presence_and_report(st
 
 	if (pin_idx < 0)
 		return;
+	mutex_lock(&spec->pcm_lock);
 	if (hdmi_present_sense(get_pin(spec, pin_idx), 1))
 		snd_hda_jack_report_sync(codec);
+	mutex_unlock(&spec->pcm_lock);
 }
 
 static void jack_callback(struct hda_codec *codec,
@@ -1628,21 +1631,23 @@ static void sync_eld_via_acomp(struct hd
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 {
 	struct hda_codec *codec = per_pin->codec;
-	struct hdmi_spec *spec = codec->spec;
 	int ret;
 
 	/* no temporary power up/down needed for component notifier */
-	if (!codec_has_acomp(codec))
-		snd_hda_power_up_pm(codec);
+	if (!codec_has_acomp(codec)) {
+		ret = snd_hda_power_up_pm(codec);
+		if (ret < 0 && pm_runtime_suspended(hda_codec_dev(codec))) {
+			snd_hda_power_down_pm(codec);
+			return false;
+		}
+	}
 
-	mutex_lock(&spec->pcm_lock);
 	if (codec_has_acomp(codec)) {
 		sync_eld_via_acomp(codec, per_pin);
 		ret = false; /* don't call snd_hda_jack_report_sync() */
 	} else {
 		ret = hdmi_present_sense_via_verbs(per_pin, repoll);
 	}
-	mutex_unlock(&spec->pcm_lock);
 
 	if (!codec_has_acomp(codec))
 		snd_hda_power_down_pm(codec);
@@ -1654,12 +1659,16 @@ static void hdmi_repoll_eld(struct work_
 {
 	struct hdmi_spec_per_pin *per_pin =
 	container_of(to_delayed_work(work), struct hdmi_spec_per_pin, work);
+	struct hda_codec *codec = per_pin->codec;
+	struct hdmi_spec *spec = codec->spec;
 
 	if (per_pin->repoll_count++ > 6)
 		per_pin->repoll_count = 0;
 
+	mutex_lock(&spec->pcm_lock);
 	if (hdmi_present_sense(per_pin, per_pin->repoll_count))
 		snd_hda_jack_report_sync(per_pin->codec);
+	mutex_unlock(&spec->pcm_lock);
 }
 
 static void intel_haswell_fixup_connect_list(struct hda_codec *codec,


