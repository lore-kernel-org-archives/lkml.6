Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756077AbeDZMpp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:45:45 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:56999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755725AbeDZMpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:45:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp, alsa-devel@alsa-project.org,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/4] ALSA: replace timespec types in uapi headers
Date: Thu, 26 Apr 2018 14:44:21 +0200
Message-Id: <20180426124422.2921744-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180426124422.2921744-1-arnd@arndb.de>
References: <20180426124422.2921744-1-arnd@arndb.de>
X-Provags-ID: V03:K1:3iUdw2ouGME42UZgjbae7U/3KQRQWezzIH+ahdu44WXvDLR27Rg
 wj024UFjf6ZB+yB3VI1PjtfqXhjpGijwFU8brVXKAPTZOlsmX4zhiW1qEjsIw4uoqaU00Xq
 eMW42tATGDSJbYjgBMR9dL9hBzI8otAMWRB59BPX4BXdsLExh+dO8QY1Lb+gEbHAR61dXlL
 AmEJSi0xCp7fsf3F1zPTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5IV4do7FqX8=:FfwKp9qh+5ClKlqSsHunI9
 z1ac6LZrn4hq+z9YCY1JRrHyJQubz8dJ76XrGo+DGgbDutOYa6VNfFE0kFU/KiTif0utAMKYu
 +mzWD5oU/36lVQlEIkvd2vWCOeXJY9iZhcJZO1XNY4TgAjBu23ItkYcXroundnEYqRlSzSX1p
 iTw6UuC/50mVj5VzG19dC+uNRRfhkLw7lldE2l/Zkxg3jVi9Eh+p3Y4ok0x0EUQBosthGkZ0P
 SnK1aj7trZ/jg8EsLD21PYm8PFaaUibMf75MinJ0KnFzxR4MazZgVBii9uggiBx5PsJEqTifr
 pgD+qtyUFDam1HGay/+thjmUFOWRayGfYYBJyD1f/AWDdtkLIjQwuSbL0ezQI7DUIsTJLvml+
 jZnksgeMwc5qvPEfelyXfV66ttk9qmDc8owejYnSvszik0x5FHVWBgwbopDd7yv7G7WC5Bf4B
 +NivP+Ej0qdd6l4LI6iRn7JlSV4FWfS7PMl8WF5tItJuNgl8yGXfp5yhu5STx4MFu5cLBymUX
 LFs9Gz66rOy9lGyfsLtnLcEuI5Ojd39Gp/s0ZK/jb1SoAOzdzvxK+qjF7bjuEn509I3j/vxox
 N6C4G/qWxQa7Oz0rzLNNvV1FtfPfo9P01ZkDcqWc9rnQftsh0/P5853bnHoI+cEBFG82TWkjF
 2tZOtLOT+dIGMR5U7i4Aol0DJ8K4cg6GfHqh0Wjpm4f03rXlc3NYtyM7TmyYpdDID/XU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the user API for ALSA to not rely on time_t as the type
any more, so it can survive the update to new C libraries that redefine
time_t to 64 bit.

This is a much simpler approach than earlier patches, simply defining
the API to use '__kernel_ulong_t' for tv_sec and tv_nsec, keeping the
existing binary interface but changing the way we express it.

The downside of this approach is that it requires significant user
space changes in alsa-lib and simialr projects in order to convert back
the 32-bit timestamps into 'timespec' for consumption by applications,
and that it requires using monotonic timestamps to avoid overflowing a
timespec in y2038.

To try to counter the incompatibility with existing user sources, the
new type is only used when __USE_TIME_BITS64 is set. This gets defined
by glibc when an application is compiled with 64-bit time_t.

Unfortunately, existing alsa-lib releases come with their own copy of
sound/asound.h and don't use the version provided by the linux/libc
headers, so alsa-lib is still silently broken when rebuilt with a new
libc until it gets updated to use the new header.

I also try to be extra conservative with the naming of the structure,
giving it the rather long name 'snd_monotonic_timestamp' to clarify that
this can only be used for monotonic timestamps after we have decided
not to extend the current interface to 64 bit stamps. A separate patch
is used to allow enforcing the use of monotonic timestamps in the kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/asound.h      |  8 ++++++++
 include/uapi/sound/asound.h | 46 +++++++++++++++++++++++++++++++++++----------
 sound/core/compat.h         | 11 +++++++++++
 sound/core/pcm_compat.c     | 38 +++++++++++++++++++------------------
 sound/core/pcm_lib.c        |  6 +++---
 sound/core/pcm_native.c     |  9 ++++-----
 sound/core/rawmidi_compat.c | 12 ++++++------
 sound/core/timer.c          | 10 +++++-----
 sound/core/timer_compat.c   |  4 +++-
 9 files changed, 96 insertions(+), 48 deletions(-)
 create mode 100644 sound/core/compat.h

diff --git a/include/sound/asound.h b/include/sound/asound.h
index c2dff5369d33..8c919eb9bb45 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -37,4 +37,12 @@
 #endif
 
 #include <uapi/sound/asound.h>
+
+
+static inline struct snd_monotonic_timestamp
+timespec64_to_snd_monotonic_timestamp(struct timespec64 ts)
+{
+	return (struct snd_monotonic_timestamp) { (u32)ts.tv_sec, ts.tv_nsec };
+};
+
 #endif /* __SOUND_ASOUND_H */
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1231f0a943f1..9c61cf77beb8 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -455,10 +455,36 @@ enum {
 	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LAST = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED
 };
 
+#if (__BITS_PER_LONG == 32 && defined(__USE_TIME_BITS64)) || defined __KERNEL__
+/*
+ * We used to use 'struct timespec' here, but that no longer works on
+ * 32 bit architectures since the migration to 64-bit time_t in user
+ * space. Rather than updating all ioctls, we change the internal type
+ * to a new one with the same binary layout as before.
+ *
+ * We use a 'unsigned long' as the base type here to give us a little
+ * extra range over the traditional signed type, but this really
+ * should only be used for CLOCK_MONOTONIC timestamps, not CLOCK_REALTIME,
+ * to avoid all issues with y2038 overflow, hence the name.
+ *
+ * alsa-lib 1.1.6 and earlier are incompatible with this definition and
+ * will break either at compile time or at runtime if built against
+ * an older header while using a 64-bit time_t on a 32-bit architecture,
+ * so if you run into a build problem here, please upgrade to the latest
+ * alsa-lib.
+ */
+struct snd_monotonic_timestamp {
+	__kernel_ulong_t tv_sec;
+	__kernel_ulong_t tv_nsec;
+};
+#else
+#define snd_monotonic_timestamp timespec
+#endif
+
 struct snd_pcm_status {
 	snd_pcm_state_t state;		/* stream state */
-	struct timespec trigger_tstamp;	/* time when stream was started/stopped/paused */
-	struct timespec tstamp;		/* reference timestamp */
+	struct snd_monotonic_timestamp trigger_tstamp;/* time when stream was started/stopped/paused */
+	struct snd_monotonic_timestamp tstamp;	/* reference timestamp */
 	snd_pcm_uframes_t appl_ptr;	/* appl ptr */
 	snd_pcm_uframes_t hw_ptr;	/* hw ptr */
 	snd_pcm_sframes_t delay;	/* current delay in frames */
@@ -467,19 +493,19 @@ struct snd_pcm_status {
 	snd_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
 	snd_pcm_state_t suspended_state; /* suspended stream state */
 	__u32 audio_tstamp_data;	 /* needed for 64-bit alignment, used for configs/report to/from userspace */
-	struct timespec audio_tstamp;	/* sample counter, wall clock, PHC or on-demand sync'ed */
-	struct timespec driver_tstamp;	/* useful in case reference system tstamp is reported with delay */
+	struct snd_monotonic_timestamp audio_tstamp;	/* sample counter, wall clock, PHC or on-demand sync'ed */
+	struct snd_monotonic_timestamp driver_tstamp;	/* useful in case reference system tstamp is reported with delay */
 	__u32 audio_tstamp_accuracy;	/* in ns units, only valid if indicated in audio_tstamp_data */
-	unsigned char reserved[52-2*sizeof(struct timespec)]; /* must be filled with zero */
+	unsigned char reserved[52-2*sizeof(struct snd_monotonic_timestamp)]; /* must be filled with zero */
 };
 
 struct snd_pcm_mmap_status {
 	snd_pcm_state_t state;		/* RO: state - SNDRV_PCM_STATE_XXXX */
 	int pad1;			/* Needed for 64 bit alignment */
 	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
-	struct timespec tstamp;		/* Timestamp */
+	struct snd_monotonic_timestamp tstamp; /* Timestamp */
 	snd_pcm_state_t suspended_state; /* RO: suspended stream state */
-	struct timespec audio_tstamp;	/* from sample counter or wall clock */
+	struct snd_monotonic_timestamp audio_tstamp;	/* from sample counter or wall clock */
 };
 
 struct snd_pcm_mmap_control {
@@ -649,7 +675,7 @@ struct snd_rawmidi_params {
 
 struct snd_rawmidi_status {
 	int stream;
-	struct timespec tstamp;		/* Timestamp */
+	struct snd_monotonic_timestamp tstamp; /* Timestamp */
 	size_t avail;			/* available bytes */
 	size_t xruns;			/* count of overruns since last status (in bytes) */
 	unsigned char reserved[16];	/* reserved for future use */
@@ -761,7 +787,7 @@ struct snd_timer_params {
 };
 
 struct snd_timer_status {
-	struct timespec tstamp;		/* Timestamp - last update */
+	struct snd_monotonic_timestamp tstamp;		/* Timestamp - last update */
 	unsigned int resolution;	/* current period resolution in ns */
 	unsigned int lost;		/* counter of master tick lost */
 	unsigned int overrun;		/* count of read queue overruns */
@@ -811,7 +837,7 @@ enum {
 
 struct snd_timer_tread {
 	int event;
-	struct timespec tstamp;
+	struct snd_monotonic_timestamp tstamp;
 	unsigned int val;
 };
 
diff --git a/sound/core/compat.h b/sound/core/compat.h
new file mode 100644
index 000000000000..7a08d6e34955
--- /dev/null
+++ b/sound/core/compat.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef SND_CORE_COMPAT_H
+#define SND_CORE_COMPAT_H
+
+struct compat_snd_monotonic_timestamp {
+	__u32	tv_sec;
+	__u32	tv_nsec;
+};
+
+#endif
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index e21d3f35a724..40e9be542322 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -23,6 +23,8 @@
 #include <linux/compat.h>
 #include <linux/slab.h>
 
+#include "compat.h"
+
 static int snd_pcm_ioctl_delay_compat(struct snd_pcm_substream *substream,
 				      s32 __user *src)
 {
@@ -189,8 +191,8 @@ static int snd_pcm_channel_info_user(struct snd_pcm_substream *substream,
 
 struct snd_pcm_status32 {
 	s32 state;
-	struct compat_timespec trigger_tstamp;
-	struct compat_timespec tstamp;
+	struct compat_snd_monotonic_timestamp trigger_tstamp;
+	struct compat_snd_monotonic_timestamp tstamp;
 	u32 appl_ptr;
 	u32 hw_ptr;
 	s32 delay;
@@ -199,10 +201,10 @@ struct snd_pcm_status32 {
 	u32 overrange;
 	s32 suspended_state;
 	u32 audio_tstamp_data;
-	struct compat_timespec audio_tstamp;
-	struct compat_timespec driver_tstamp;
+	struct compat_snd_monotonic_timestamp audio_tstamp;
+	struct compat_snd_monotonic_timestamp driver_tstamp;
 	u32 audio_tstamp_accuracy;
-	unsigned char reserved[52-2*sizeof(struct compat_timespec)];
+	unsigned char reserved[52-2*sizeof(struct compat_snd_monotonic_timestamp)];
 } __attribute__((packed));
 
 
@@ -269,11 +271,9 @@ struct snd_pcm_status_x32 {
 	struct __kernel_timespec audio_tstamp;
 	struct __kernel_timespec driver_tstamp;
 	u32 audio_tstamp_accuracy;
-	unsigned char reserved[52-2*sizeof(struct timespec)];
+	unsigned char reserved[52-2*sizeof(struct __kernel_timespec)];
 } __packed;
 
-#define put_timespec(src, dst) copy_to_user(dst, src, sizeof(*dst))
-
 static int snd_pcm_status_user_x32(struct snd_pcm_substream *substream,
 				   struct snd_pcm_status_x32 __user *src,
 				   bool ext)
@@ -461,14 +461,13 @@ static int snd_pcm_ioctl_xfern_compat(struct snd_pcm_substream *substream,
 	return err;
 }
 
-
 struct snd_pcm_mmap_status32 {
 	s32 state;
 	s32 pad1;
 	u32 hw_ptr;
-	struct compat_timespec tstamp;
+	struct compat_snd_monotonic_timestamp tstamp;
 	s32 suspended_state;
-	struct compat_timespec audio_tstamp;
+	struct compat_snd_monotonic_timestamp audio_tstamp;
 } __attribute__((packed));
 
 struct snd_pcm_mmap_control32 {
@@ -535,10 +534,11 @@ static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
 	snd_pcm_stream_unlock_irq(substream);
 	if (put_user(sstatus.state, &src->s.status.state) ||
 	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
-	    compat_put_timespec(&sstatus.tstamp, &src->s.status.tstamp) ||
+	    put_user(sstatus.tstamp.tv_sec, &src->s.status.tstamp.tv_sec) ||
+	    put_user(sstatus.tstamp.tv_nsec, &src->s.status.tstamp.tv_nsec) ||
 	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
-	    compat_put_timespec(&sstatus.audio_tstamp,
-		    &src->s.status.audio_tstamp) ||
+	    put_user(sstatus.audio_tstamp.tv_sec, &src->s.status.audio_tstamp.tv_sec) ||
+	    put_user(sstatus.audio_tstamp.tv_nsec, &src->s.status.audio_tstamp.tv_nsec) ||
 	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
 	    put_user(scontrol.avail_min, &src->c.control.avail_min))
 		return -EFAULT;
@@ -553,10 +553,10 @@ struct snd_pcm_mmap_status_x32 {
 	s32 pad1;
 	u32 hw_ptr;
 	u32 pad2; /* alignment */
-	struct timespec tstamp;
+	struct __kernel_timespec tstamp;
 	s32 suspended_state;
 	s32 pad3;
-	struct timespec audio_tstamp;
+	struct __kernel_timespec audio_tstamp;
 } __packed;
 
 struct snd_pcm_mmap_control_x32 {
@@ -624,9 +624,11 @@ static int snd_pcm_ioctl_sync_ptr_x32(struct snd_pcm_substream *substream,
 	snd_pcm_stream_unlock_irq(substream);
 	if (put_user(sstatus.state, &src->s.status.state) ||
 	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
-	    put_timespec(&sstatus.tstamp, &src->s.status.tstamp) ||
+	    put_user(sstatus.tstamp.tv_sec, &src->s.status.tstamp.tv_sec) ||
+	    put_user(sstatus.tstamp.tv_nsec, &src->s.status.tstamp.tv_nsec) ||
 	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
-	    put_timespec(&sstatus.audio_tstamp, &src->s.status.audio_tstamp) ||
+	    put_user(sstatus.audio_tstamp.tv_sec, &src->s.status.audio_tstamp.tv_sec) ||
+	    put_user(sstatus.audio_tstamp.tv_nsec, &src->s.status.audio_tstamp.tv_nsec) ||
 	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
 	    put_user(scontrol.avail_min, &src->c.control.avail_min))
 		return -EFAULT;
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 9278b5ded9a2..e676356bd3be 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -162,7 +162,7 @@ static void xrun(struct snd_pcm_substream *substream)
 		struct timespec64 tstamp;
 
 		snd_pcm_gettime(runtime, &tstamp);
-		runtime->status->tstamp = timespec64_to_timespec(tstamp);
+		runtime->status->tstamp = timespec64_to_snd_monotonic_timestamp(tstamp);
 	}
 	snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
 	if (xrun_debug(substream, XRUN_DEBUG_BASIC)) {
@@ -256,8 +256,8 @@ static void update_audio_tstamp(struct snd_pcm_substream *substream,
 	if (runtime->status->audio_tstamp.tv_sec != audio_tstamp->tv_sec ||
 	    runtime->status->audio_tstamp.tv_nsec != audio_tstamp->tv_nsec) {
 		runtime->status->audio_tstamp =
-			timespec64_to_timespec(*audio_tstamp);
-		runtime->status->tstamp = timespec64_to_timespec(*curr_tstamp);
+			timespec64_to_snd_monotonic_timestamp(*audio_tstamp);
+		runtime->status->tstamp = timespec64_to_snd_monotonic_timestamp(*curr_tstamp);
 	}
 
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c57dd4b30198..d27c6252e14c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -884,14 +884,13 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 	status->suspended_state = runtime->status->suspended_state;
 	if (status->state == SNDRV_PCM_STATE_OPEN)
 		goto _end;
-	status->trigger_tstamp = timespec64_to_timespec(runtime->trigger_tstamp);
+	status->trigger_tstamp = timespec64_to_snd_monotonic_timestamp(runtime->trigger_tstamp);
 	if (snd_pcm_running(substream)) {
 		snd_pcm_update_hw_ptr(substream);
 		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
 			status->tstamp = runtime->status->tstamp;
-			status->driver_tstamp = timespec64_to_timespec(runtime->driver_tstamp);
-			status->audio_tstamp =
-				runtime->status->audio_tstamp;
+			status->driver_tstamp = timespec64_to_snd_monotonic_timestamp(runtime->driver_tstamp);
+			status->audio_tstamp = runtime->status->audio_tstamp;
 			if (runtime->audio_tstamp_report.valid == 1)
 				/* backwards compatibility, no report provided in COMPAT mode */
 				snd_pcm_pack_audio_tstamp_report(&status->audio_tstamp_data,
@@ -906,7 +905,7 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 			struct timespec64 tstamp;
 
 			snd_pcm_gettime(runtime, &tstamp);
-			status->tstamp = timespec64_to_timespec(tstamp);
+			status->tstamp = timespec64_to_snd_monotonic_timestamp(tstamp);
 		}
 	}
  _tstamp_end:
diff --git a/sound/core/rawmidi_compat.c b/sound/core/rawmidi_compat.c
index f69764d7cdd7..bf8b0c9da690 100644
--- a/sound/core/rawmidi_compat.c
+++ b/sound/core/rawmidi_compat.c
@@ -55,7 +55,7 @@ static int snd_rawmidi_ioctl_params_compat(struct snd_rawmidi_file *rfile,
 
 struct snd_rawmidi_status32 {
 	s32 stream;
-	struct compat_timespec tstamp;
+	struct snd_monotonic_timestamp tstamp;
 	u32 avail;
 	u32 xruns;
 	unsigned char reserved[16];
@@ -85,7 +85,8 @@ static int snd_rawmidi_ioctl_status_compat(struct snd_rawmidi_file *rfile,
 	if (err < 0)
 		return err;
 
-	if (compat_put_timespec(&status.tstamp, &src->tstamp) ||
+	if (put_user(status.tstamp.tv_sec, &src->tstamp.tv_sec) ||
+	    put_user(status.tstamp.tv_nsec, &src->tstamp.tv_nsec) ||
 	    put_user(status.avail, &src->avail) ||
 	    put_user(status.xruns, &src->xruns))
 		return -EFAULT;
@@ -98,14 +99,12 @@ static int snd_rawmidi_ioctl_status_compat(struct snd_rawmidi_file *rfile,
 struct snd_rawmidi_status_x32 {
 	s32 stream;
 	u32 rsvd; /* alignment */
-	struct timespec tstamp;
+	struct __kernel_timespec tstamp;
 	u32 avail;
 	u32 xruns;
 	unsigned char reserved[16];
 } __attribute__((packed));
 
-#define put_timespec(src, dst) copy_to_user(dst, src, sizeof(*dst))
-
 static int snd_rawmidi_ioctl_status_x32(struct snd_rawmidi_file *rfile,
 					struct snd_rawmidi_status_x32 __user *src)
 {
@@ -130,7 +129,8 @@ static int snd_rawmidi_ioctl_status_x32(struct snd_rawmidi_file *rfile,
 	if (err < 0)
 		return err;
 
-	if (put_timespec(&status.tstamp, &src->tstamp) ||
+	if (put_user(status.tstamp.tv_sec, &src->tstamp.tv_sec) ||
+	    put_user(status.tstamp.tv_nsec, &src->tstamp.tv_nsec) ||
 	    put_user(status.avail, &src->avail) ||
 	    put_user(status.xruns, &src->xruns))
 		return -EFAULT;
diff --git a/sound/core/timer.c b/sound/core/timer.c
index a77b4619f1b7..b7059a9e9edc 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1309,7 +1309,7 @@ static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
 		return;
 	memset(&r1, 0, sizeof(r1));
 	r1.event = event;
-	r1.tstamp = timespec64_to_timespec(*tstamp);
+	r1.tstamp = timespec64_to_snd_monotonic_timestamp(*tstamp);
 	r1.val = resolution;
 	spin_lock_irqsave(&tu->qlock, flags);
 	snd_timer_user_append_to_tqueue(tu, &r1);
@@ -1352,7 +1352,7 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 	if ((tu->filter & (1 << SNDRV_TIMER_EVENT_RESOLUTION)) &&
 	    tu->last_resolution != resolution) {
 		r1.event = SNDRV_TIMER_EVENT_RESOLUTION;
-		r1.tstamp = timespec64_to_timespec(tstamp);
+		r1.tstamp = timespec64_to_snd_monotonic_timestamp(tstamp);
 		r1.val = resolution;
 		snd_timer_user_append_to_tqueue(tu, &r1);
 		tu->last_resolution = resolution;
@@ -1366,14 +1366,14 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 		prev = tu->qtail == 0 ? tu->queue_size - 1 : tu->qtail - 1;
 		r = &tu->tqueue[prev];
 		if (r->event == SNDRV_TIMER_EVENT_TICK) {
-			r->tstamp = timespec64_to_timespec(tstamp);
+			r->tstamp = timespec64_to_snd_monotonic_timestamp(tstamp);
 			r->val += ticks;
 			append++;
 			goto __wake;
 		}
 	}
 	r1.event = SNDRV_TIMER_EVENT_TICK;
-	r1.tstamp = timespec64_to_timespec(tstamp);
+	r1.tstamp = timespec64_to_snd_monotonic_timestamp(tstamp);
 	r1.val = ticks;
 	snd_timer_user_append_to_tqueue(tu, &r1);
 	append++;
@@ -1852,7 +1852,7 @@ static int snd_timer_user_status(struct file *file,
 	if (!tu->timeri)
 		return -EBADFD;
 	memset(&status, 0, sizeof(status));
-	status.tstamp = timespec64_to_timespec(tu->tstamp);
+	status.tstamp = timespec64_to_snd_monotonic_timestamp(tu->tstamp);
 	status.resolution = snd_timer_resolution(tu->timeri);
 	status.lost = tu->timeri->lost;
 	status.overrun = tu->overrun;
diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index e00f7e399e46..960d1075071f 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -22,6 +22,8 @@
 
 #include <linux/compat.h>
 
+#include "compat.h"
+
 /*
  * ILP32/LP64 has different size for 'long' type. Additionally, the size
  * of storage alignment differs depending on architectures. Here, '__packed'
@@ -84,7 +86,7 @@ static int snd_timer_user_info_compat(struct file *file,
 }
 
 struct snd_timer_status32 {
-	struct compat_timespec tstamp;
+	struct compat_snd_monotonic_timestamp tstamp;
 	u32 resolution;
 	u32 lost;
 	u32 overrun;
-- 
2.9.0
