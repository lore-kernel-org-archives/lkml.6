Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8477DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFA9208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFA9208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH0Xqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:46:34 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Xqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:46:34 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MFRbQ-1g6Ubj1Fvo-00EQ4F; Mon, 27 Aug 2018 21:58:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-media@vger.kernel.org
Cc:     y2038@lists.linaro.org, awalls@md.metrocast.net,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] media: dvb: move most compat_ioctl handling into drivers
Date:   Mon, 27 Aug 2018 21:56:24 +0200
Message-Id: <20180827195649.4170969-4-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827195649.4170969-1-arnd@arndb.de>
References: <20180827195649.4170969-1-arnd@arndb.de>
X-Provags-ID: V03:K1:5egVA6rFp+A1tJJqbXrYNEV0eYmpKfGlxI2RarjmXHeNb3BLMAy
 Klj2dtBADbPHL/U9GT7UtyoMg1AgfPkl9gDA1+vxbICRs7cGJ6vrjobnwE+RzBbVH/wEtUU
 s50AC+HthkkX8Kk+SQBKaQVG0Wtovvaa8+4RXmQ52L8XwihC+49j55PR4nIcHevYYTYOVhv
 akzbSQTM0E7O/Vuqlme1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5eFbzR6KJ9U=:k6e908XXoWXeoawFadEQV4
 N8c+wFv9NOyWinrnyR1v34Z0i+4kfKo7buAIjNv0Da8m+bpnla00Zzo5e5jFhEU0iuyi+Teq5
 nKqCQZehrpWpHI6PoLgMstAm3orjJN2/ioJcbBRtY0hkzREqA4WtdUT16uPf/u387qsYlwJPD
 mSymn8iLSrgJUsvHXmMgoaIzhD7uby7KODvgnACLxjDJefQ094mhNtO/HC2rJ4OIphF/p/Qw6
 9Ql4fA7euqh/RJILRz2jwh4jakoSMTDA/zSpzzECk9foXvtXTSKI9tjW9WYW6d++weO/Mkupr
 1vYRMsepUGlGFjomcfT2eKNJwyYNYKoLMUQltawu8tgwPMedrh5JPHNZS6oPhaWCmemQgDyxT
 6idmW///X5PEQjUXHlc/CTVhwv84TSrRZcxW/W/ypxJAW9CT+FxmpG5MZSpZF4E+dAworxM0Q
 s2ox/pazZuQ6QxQbMn6ngzk9hS3iLrMoYRZfsraZuU1Jx/EIftSIY31V7MSwwLr0Q9qKbuJvX
 EFKzI1V63sYLQClvXPfiTpOXEkUqyLRlTl0oO/p882XNhuX4q/OPynjFdRmmfRQNU7P1S6ED+
 vhdy9ktFWBXY+sP4Sjqo30LBFito2o5DxURXuompBPadZceiJwWDEUFpSKeGFv9MuXOVX9pBa
 XHEOgPBcyw5UjboX2TS10CEZ5xvBCKN0Mf9Fa9P5+Wo2pcua7gJHpm7x2WYLK35q+TFI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most DVB audio and video ioctl commands are completely compatible,
and are implemented by just two drivers: ttpci and ivtv. In both
cases, we can use the same ioctl handler for both native and
compat ioctl handling, and remove the entries from the global
lookup table.

In case of ttpci, this directly hooks into the file_operations
structure, and for ivtv, we have to set the compat_ioctl32
method in v4l2_file_operations. For all I can tell, setting it
to video_ioctl2 will still do the right thing for all commands.

Note that for the VIDEO_STILLPICTURE and VIDEO_GET_EVENT commands,
a translation handler in fs/compat_ioctl.c is still used. This
works because the command numbers are different on 32-bit
systems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/pci/ivtv/ivtv-streams.c |  9 ++++++++
 drivers/media/pci/ttpci/av7110_av.c   |  2 ++
 fs/compat_ioctl.c                     | 31 ---------------------------
 3 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-streams.c b/drivers/media/pci/ivtv/ivtv-streams.c
index d27c6df97566..a641f20e3f86 100644
--- a/drivers/media/pci/ivtv/ivtv-streams.c
+++ b/drivers/media/pci/ivtv/ivtv-streams.c
@@ -51,6 +51,9 @@ static const struct v4l2_file_operations ivtv_v4l2_enc_fops = {
 	.write = ivtv_v4l2_write,
 	.open = ivtv_v4l2_open,
 	.unlocked_ioctl = video_ioctl2,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl32 = video_ioctl2, /* for ivtv_default() */
+#endif
 	.release = ivtv_v4l2_close,
 	.poll = ivtv_v4l2_enc_poll,
 };
@@ -61,6 +64,9 @@ static const struct v4l2_file_operations ivtv_v4l2_dec_fops = {
 	.write = ivtv_v4l2_write,
 	.open = ivtv_v4l2_open,
 	.unlocked_ioctl = video_ioctl2,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl32 = video_ioctl2, /* for ivtv_default() */
+#endif
 	.release = ivtv_v4l2_close,
 	.poll = ivtv_v4l2_dec_poll,
 };
@@ -69,6 +75,9 @@ static const struct v4l2_file_operations ivtv_v4l2_radio_fops = {
 	.owner = THIS_MODULE,
 	.open = ivtv_v4l2_open,
 	.unlocked_ioctl = video_ioctl2,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl32 = video_ioctl2, /* for ivtv_default() */
+#endif
 	.release = ivtv_v4l2_close,
 	.poll = ivtv_v4l2_enc_poll,
 };
diff --git a/drivers/media/pci/ttpci/av7110_av.c b/drivers/media/pci/ttpci/av7110_av.c
index ef1bc17cdc4d..e738b2cef6f6 100644
--- a/drivers/media/pci/ttpci/av7110_av.c
+++ b/drivers/media/pci/ttpci/av7110_av.c
@@ -1533,6 +1533,7 @@ static const struct file_operations dvb_video_fops = {
 	.owner		= THIS_MODULE,
 	.write		= dvb_video_write,
 	.unlocked_ioctl	= dvb_generic_ioctl,
+	.compat_ioctl	= dvb_generic_ioctl,
 	.open		= dvb_video_open,
 	.release	= dvb_video_release,
 	.poll		= dvb_video_poll,
@@ -1552,6 +1553,7 @@ static const struct file_operations dvb_audio_fops = {
 	.owner		= THIS_MODULE,
 	.write		= dvb_audio_write,
 	.unlocked_ioctl	= dvb_generic_ioctl,
+	.compat_ioctl	= dvb_generic_ioctl,
 	.open		= dvb_audio_open,
 	.release	= dvb_audio_release,
 	.poll		= dvb_audio_poll,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 33f48933a865..7a1fac9cd1c2 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1164,37 +1164,6 @@ COMPATIBLE_IOCTL(HIDIOCGFLAG)
 COMPATIBLE_IOCTL(HIDIOCSFLAG)
 COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINDEX)
 COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINFO)
-/* dvb */
-COMPATIBLE_IOCTL(AUDIO_STOP)
-COMPATIBLE_IOCTL(AUDIO_PLAY)
-COMPATIBLE_IOCTL(AUDIO_PAUSE)
-COMPATIBLE_IOCTL(AUDIO_CONTINUE)
-COMPATIBLE_IOCTL(AUDIO_SELECT_SOURCE)
-COMPATIBLE_IOCTL(AUDIO_SET_MUTE)
-COMPATIBLE_IOCTL(AUDIO_SET_AV_SYNC)
-COMPATIBLE_IOCTL(AUDIO_SET_BYPASS_MODE)
-COMPATIBLE_IOCTL(AUDIO_CHANNEL_SELECT)
-COMPATIBLE_IOCTL(AUDIO_GET_STATUS)
-COMPATIBLE_IOCTL(AUDIO_GET_CAPABILITIES)
-COMPATIBLE_IOCTL(AUDIO_CLEAR_BUFFER)
-COMPATIBLE_IOCTL(AUDIO_SET_ID)
-COMPATIBLE_IOCTL(AUDIO_SET_MIXER)
-COMPATIBLE_IOCTL(AUDIO_SET_STREAMTYPE)
-COMPATIBLE_IOCTL(VIDEO_STOP)
-COMPATIBLE_IOCTL(VIDEO_PLAY)
-COMPATIBLE_IOCTL(VIDEO_FREEZE)
-COMPATIBLE_IOCTL(VIDEO_CONTINUE)
-COMPATIBLE_IOCTL(VIDEO_SELECT_SOURCE)
-COMPATIBLE_IOCTL(VIDEO_SET_BLANK)
-COMPATIBLE_IOCTL(VIDEO_GET_STATUS)
-COMPATIBLE_IOCTL(VIDEO_SET_DISPLAY_FORMAT)
-COMPATIBLE_IOCTL(VIDEO_FAST_FORWARD)
-COMPATIBLE_IOCTL(VIDEO_SLOWMOTION)
-COMPATIBLE_IOCTL(VIDEO_GET_CAPABILITIES)
-COMPATIBLE_IOCTL(VIDEO_CLEAR_BUFFER)
-COMPATIBLE_IOCTL(VIDEO_SET_STREAMTYPE)
-COMPATIBLE_IOCTL(VIDEO_SET_FORMAT)
-COMPATIBLE_IOCTL(VIDEO_GET_SIZE)
 /* joystick */
 COMPATIBLE_IOCTL(JSIOCGVERSION)
 COMPATIBLE_IOCTL(JSIOCGAXES)
-- 
2.18.0

