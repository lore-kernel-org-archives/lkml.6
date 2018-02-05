Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeBEVg2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:36:28 -0500
Received: from terminus.zytor.com ([65.50.211.136]:56515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbeBEVgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:36:13 -0500
Date: Mon, 5 Feb 2018 13:33:48 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-sfpeesn8w0pyn3fe7vf2xmfl@git.kernel.org>
Cc: mail@maciej.szmigiero.name, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, adrian.hunter@intel.com,
        namhyung@kernel.org, tglx@linutronix.de, dsahern@gmail.com,
        jolsa@kernel.org, wangnan0@huawei.com, tiwai@suse.de, acme@redhat.com
Reply-To: adrian.hunter@intel.com, namhyung@kernel.org, tglx@linutronix.de,
        dsahern@gmail.com, acme@redhat.com, wangnan0@huawei.com, tiwai@suse.de,
        jolsa@kernel.org, mingo@kernel.org, mail@maciej.szmigiero.name,
        linux-kernel@vger.kernel.org, hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers: Synchronize sound/asound.h
Git-Commit-ID: 6bc7626c046e069ea4802f3fbc7a41059047ac77
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6bc7626c046e069ea4802f3fbc7a41059047ac77
Gitweb:     https://git.kernel.org/tip/6bc7626c046e069ea4802f3fbc7a41059047ac77
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 2 Feb 2018 13:06:04 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 2 Feb 2018 16:41:49 -0300

tools headers: Synchronize sound/asound.h

To pick up the changes from this cset:

  823dbb6eb08a ("ALSA: pcm: add SNDRV_PCM_FORMAT_{S,U}20")

It doesn't affect how the tools are built, this os done just to silence
this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'

Right now tools/perf uses this header to generate string tables to
translate ioctl commands in 'perf trace', see
tools/perf/trace/beauty/sndrv_pcm_ioctl.sh, here is an example
of a strace like system wide session, for one second:

  # perf trace -a -e ioctl sleep 1
     0.000 ( 0.019 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
     0.081 ( 0.006 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
     0.092 ( 0.006 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_STATUS_EXT, arg: 0x7f6745ec4ae0) = 0
    10.178 ( 0.013 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    10.229 ( 0.005 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    10.238 ( 0.013 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_STATUS_EXT, arg: 0x7f6745ec4ae0) = 0
    10.368 ( 0.009 ms): threaded-ml/26440 ioctl(fd: 141<socket:[111353]>, cmd: TIOCLINUX, arg: 0x7f8f70d2e1a4) = 0
    10.495 ( 0.018 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    10.526 ( 0.005 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    19.695 ( 0.018 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    19.757 ( 0.006 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x107b) = 0
    19.767 ( 0.005 ms): alsa-sink-HDMI/4219 ioctl(fd: 47</dev/snd/pcmC0D8p>, cmd: SNDRV_PCM_STATUS_EXT, arg: 0x7f6745ec4ae0) = 0
<BIG SNIP>
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-sfpeesn8w0pyn3fe7vf2xmfl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/sound/asound.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index c227ccb..07d6158 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -214,6 +214,11 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_IMA_ADPCM	((__force snd_pcm_format_t) 22)
 #define	SNDRV_PCM_FORMAT_MPEG		((__force snd_pcm_format_t) 23)
 #define	SNDRV_PCM_FORMAT_GSM		((__force snd_pcm_format_t) 24)
+#define	SNDRV_PCM_FORMAT_S20_LE	((__force snd_pcm_format_t) 25) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_S20_BE	((__force snd_pcm_format_t) 26) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_LE	((__force snd_pcm_format_t) 27) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_BE	((__force snd_pcm_format_t) 28) /* in four bytes, LSB justified */
+/* gap in the numbering for a future standard linear format */
 #define	SNDRV_PCM_FORMAT_SPECIAL	((__force snd_pcm_format_t) 31)
 #define	SNDRV_PCM_FORMAT_S24_3LE	((__force snd_pcm_format_t) 32)	/* in three bytes */
 #define	SNDRV_PCM_FORMAT_S24_3BE	((__force snd_pcm_format_t) 33)	/* in three bytes */
@@ -248,6 +253,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_LE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_LE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_LE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_LE
 #endif
 #ifdef SNDRV_BIG_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_BE
@@ -259,6 +266,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_BE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_BE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_BE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_BE
 #endif
 
 typedef int __bitwise snd_pcm_subformat_t;
