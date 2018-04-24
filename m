Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932796AbeDXMHn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:07:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33059 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932561AbeDXMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:07:34 -0400
X-Google-Smtp-Source: AIpwx492BU96FtgUeJE0qnlJCOSUM+Rw3gKphMcsHGIJr/MWDj0Dby1BzTLSPJPUmsT896fKDzlzIQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: perex@perex.cz, tiwai@suse.com, arnd@arndb.de
Cc: baolin.wang@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp, mingo@kernel.org,
        elfring@users.sourceforge.net, dan.carpenter@oracle.com,
        jeeja.kp@intel.com, vinod.koul@intel.com, guneshwor.o.singh@intel.com,
        subhransu.s.prusty@intel.com, bhumirks@gmail.com,
        gudishax.kranthikumar@intel.com, naveen.m@intel.com,
        hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] ALSA: Avoid using timespec for struct snd_pcm_status
Date: Tue, 24 Apr 2018 20:06:11 +0800
Message-Id: <7809a25514e8f7f72a276d19414346b2e4100945.1524570852.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct snd_pcm_status will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Userspace will use SNDRV_PCM_IOCTL_STATUS and SNDRV_PCM_IOCTL_STATUS_EXT
as commands to issue ioctl() to fill the 'snd_pcm_status' structure in
userspace. The command number is always defined through _IOR/_IOW/IORW,
so when userspace changes the definition of 'struct timespec' to use
64-bit types, the command number also changes.

Thus in the kernel, we now need to define two versions of each such ioctl
and corresponding ioctl commands to handle 32bit time_t and 64bit time_t
in native mode:
struct snd_pcm_status32 {
	......

	s32 trigger_tstamp_sec;
	s32 trigger_tstamp_nsec;

	......

	s32 audio_tstamp_sec;
	s32 audio_tstamp_nsec;

	......
};

struct snd_pcm_status64 {
	......

	s32 trigger_tstamp_sec;
	s32 trigger_tstamp_nsec;

	......

	s32 audio_tstamp_sec;
	s32 audio_tstamp_nsec;

	......
};

Moreover in compat file, we renamed or introduced new structures to handle
32bit/64bit time_t in compatible mode. The 'struct snd_pcm_status32' and
snd_pcm_status_user32() are used to handle 32bit time_t in compat mode.
'struct compat_snd_pcm_status64' and snd_pcm_status_user_compat64() are used
to handle 64bit time_t.

Finally we can replace SNDRV_PCM_IOCTL_STATUS and SNDRV_PCM_IOCTL_STATUS_EXT
with new commands and introduce new functions to fill new 'struct snd_pcm_status64'
instead of using unsafe 'struct snd_pcm_status'. Then in future, the new
commands can be matched when userspace changes 'timespec' to 64bit type
to make a size change of 'struct snd_pcm_status'. When glibc changes time_t
to 64-bit, any recompiled program will issue ioctl commands that the kernel
does not understand without this patch.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/sound/pcm.h         |   56 +++++++++++++++-
 include/uapi/sound/asound.h |    1 +
 sound/core/pcm.c            |   12 ++--
 sound/core/pcm_compat.c     |  154 +++++++++++++++----------------------------
 sound/core/pcm_native.c     |   96 ++++++++++++++++++++++-----
 5 files changed, 193 insertions(+), 126 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 973d674..398e81d 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -58,6 +58,7 @@ struct snd_pcm_hardware {
 	size_t fifo_size;		/* fifo size in bytes */
 };
 
+struct snd_pcm_status64;
 struct snd_pcm_substream;
 
 struct snd_pcm_audio_tstamp_config; /* definitions further down */
@@ -573,8 +574,8 @@ struct snd_pcm_notify {
 int snd_pcm_info(struct snd_pcm_substream *substream, struct snd_pcm_info *info);
 int snd_pcm_info_user(struct snd_pcm_substream *substream,
 		      struct snd_pcm_info __user *info);
-int snd_pcm_status(struct snd_pcm_substream *substream,
-		   struct snd_pcm_status *status);
+int snd_pcm_status64(struct snd_pcm_substream *substream,
+		     struct snd_pcm_status64 *status);
 int snd_pcm_start(struct snd_pcm_substream *substream);
 int snd_pcm_stop(struct snd_pcm_substream *substream, snd_pcm_state_t status);
 int snd_pcm_drain_done(struct snd_pcm_substream *substream);
@@ -1448,4 +1449,55 @@ static inline u64 pcm_format_to_bits(snd_pcm_format_t pcm_format)
 #define pcm_dbg(pcm, fmt, args...) \
 	dev_dbg((pcm)->card->dev, fmt, ##args)
 
+struct snd_pcm_status64 {
+	snd_pcm_state_t state;		/* stream state */
+	u8 rsvd[sizeof(time_t) - sizeof(snd_pcm_state_t)];
+	s64 trigger_tstamp_sec;		/* time when stream was started/stopped/paused */
+	s64 trigger_tstamp_nsec;
+	s64 tstamp_sec;			/* reference timestamp */
+	s64 tstamp_nsec;
+	snd_pcm_uframes_t appl_ptr;	/* appl ptr */
+	snd_pcm_uframes_t hw_ptr;	/* hw ptr */
+	snd_pcm_sframes_t delay;	/* current delay in frames */
+	snd_pcm_uframes_t avail;	/* number of frames available */
+	snd_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
+	snd_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
+	snd_pcm_state_t suspended_state; /* suspended stream state */
+	__u32 audio_tstamp_data;	 /* needed for 64-bit alignment, used for configs/report to/from userspace */
+	s64 audio_tstamp_sec;		/* sample counter, wall clock, PHC or on-demand sync'ed */
+	s64 audio_tstamp_nsec;
+	s64 driver_tstamp_sec;		/* useful in case reference system tstamp is reported with delay */
+	s64 driver_tstamp_nsec;
+	__u32 audio_tstamp_accuracy;	/* in ns units, only valid if indicated in audio_tstamp_data */
+	unsigned char reserved[52-4*sizeof(s64)]; /* must be filled with zero */
+};
+
+#define SNDRV_PCM_IOCTL_STATUS64	_IOR('A', 0x20, struct snd_pcm_status64)
+#define SNDRV_PCM_IOCTL_STATUS_EXT64	_IOWR('A', 0x24, struct snd_pcm_status64)
+
+struct snd_pcm_status32 {
+	s32 state;		/* stream state */
+	s32 trigger_tstamp_sec;	/* time when stream was started/stopped/paused */
+	s32 trigger_tstamp_nsec;
+	s32 tstamp_sec;		/* reference timestamp */
+	s32 tstamp_nsec;
+	u32 appl_ptr;		/* appl ptr */
+	u32 hw_ptr;		/* hw ptr */
+	s32 delay;		/* current delay in frames */
+	u32 avail;		/* number of frames available */
+	u32 avail_max;		/* max frames available on hw since last status */
+	u32 overrange;		/* count of ADC (capture) overrange detections from last status */
+	s32 suspended_state;	/* suspended stream state */
+	u32 audio_tstamp_data;	/* needed for 64-bit alignment, used for configs/report to/from userspace */
+	s32 audio_tstamp_sec;	/* sample counter, wall clock, PHC or on-demand sync'ed */
+	s32 audio_tstamp_nsec;
+	s32 driver_tstamp_sec;	/* useful in case reference system tstamp is reported with delay */
+	s32 driver_tstamp_nsec;
+	u32 audio_tstamp_accuracy;	/* in ns units, only valid if indicated in audio_tstamp_data */
+	unsigned char reserved[52-4*sizeof(s32)]; /* must be filled with zero */
+};
+
+#define SNDRV_PCM_IOCTL_STATUS32	_IOR('A', 0x20, struct snd_pcm_status32)
+#define SNDRV_PCM_IOCTL_STATUS_EXT32	_IOWR('A', 0x24, struct snd_pcm_status32)
+
 #endif /* __SOUND_PCM_H */
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1231f0a..c9afde4 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -457,6 +457,7 @@ enum {
 
 struct snd_pcm_status {
 	snd_pcm_state_t state;		/* stream state */
+	unsigned char pad1[sizeof(time_t) - sizeof(snd_pcm_state_t)]; /* align to timespec */
 	struct timespec trigger_tstamp;	/* time when stream was started/stopped/paused */
 	struct timespec tstamp;		/* reference timestamp */
 	snd_pcm_uframes_t appl_ptr;	/* appl ptr */
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 66ac89a..74d2580 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -456,7 +456,7 @@ static void snd_pcm_substream_proc_status_read(struct snd_info_entry *entry,
 {
 	struct snd_pcm_substream *substream = entry->private_data;
 	struct snd_pcm_runtime *runtime;
-	struct snd_pcm_status status;
+	struct snd_pcm_status64 status;
 	int err;
 
 	mutex_lock(&substream->pcm->open_mutex);
@@ -466,17 +466,17 @@ static void snd_pcm_substream_proc_status_read(struct snd_info_entry *entry,
 		goto unlock;
 	}
 	memset(&status, 0, sizeof(status));
-	err = snd_pcm_status(substream, &status);
+	err = snd_pcm_status64(substream, &status);
 	if (err < 0) {
 		snd_iprintf(buffer, "error %d\n", err);
 		goto unlock;
 	}
 	snd_iprintf(buffer, "state: %s\n", snd_pcm_state_name(status.state));
 	snd_iprintf(buffer, "owner_pid   : %d\n", pid_vnr(substream->pid));
-	snd_iprintf(buffer, "trigger_time: %ld.%09ld\n",
-		status.trigger_tstamp.tv_sec, status.trigger_tstamp.tv_nsec);
-	snd_iprintf(buffer, "tstamp      : %ld.%09ld\n",
-		status.tstamp.tv_sec, status.tstamp.tv_nsec);
+	snd_iprintf(buffer, "trigger_time: %lld.%09lld\n",
+		status.trigger_tstamp_sec, status.trigger_tstamp_nsec);
+	snd_iprintf(buffer, "tstamp      : %lld.%09lld\n",
+		status.tstamp_sec, status.tstamp_nsec);
 	snd_iprintf(buffer, "delay       : %ld\n", status.delay);
 	snd_iprintf(buffer, "avail       : %ld\n", status.avail);
 	snd_iprintf(buffer, "avail_max   : %ld\n", status.avail_max);
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index b719d0b..a4ef13b 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -187,73 +187,13 @@ static int snd_pcm_channel_info_user(struct snd_pcm_substream *substream,
 	snd_pcm_channel_info_user(s, p)
 #endif /* CONFIG_X86_X32 */
 
-struct snd_pcm_status32 {
+struct compat_snd_pcm_status64 {
 	s32 state;
-	struct compat_timespec trigger_tstamp;
-	struct compat_timespec tstamp;
-	u32 appl_ptr;
-	u32 hw_ptr;
-	s32 delay;
-	u32 avail;
-	u32 avail_max;
-	u32 overrange;
-	s32 suspended_state;
-	u32 audio_tstamp_data;
-	struct compat_timespec audio_tstamp;
-	struct compat_timespec driver_tstamp;
-	u32 audio_tstamp_accuracy;
-	unsigned char reserved[52-2*sizeof(struct compat_timespec)];
-} __attribute__((packed));
-
-
-static int snd_pcm_status_user_compat(struct snd_pcm_substream *substream,
-				      struct snd_pcm_status32 __user *src,
-				      bool ext)
-{
-	struct snd_pcm_status status;
-	int err;
-
-	memset(&status, 0, sizeof(status));
-	/*
-	 * with extension, parameters are read/write,
-	 * get audio_tstamp_data from user,
-	 * ignore rest of status structure
-	 */
-	if (ext && get_user(status.audio_tstamp_data,
-				(u32 __user *)(&src->audio_tstamp_data)))
-		return -EFAULT;
-	err = snd_pcm_status(substream, &status);
-	if (err < 0)
-		return err;
-
-	if (clear_user(src, sizeof(*src)))
-		return -EFAULT;
-	if (put_user(status.state, &src->state) ||
-	    compat_put_timespec(&status.trigger_tstamp, &src->trigger_tstamp) ||
-	    compat_put_timespec(&status.tstamp, &src->tstamp) ||
-	    put_user(status.appl_ptr, &src->appl_ptr) ||
-	    put_user(status.hw_ptr, &src->hw_ptr) ||
-	    put_user(status.delay, &src->delay) ||
-	    put_user(status.avail, &src->avail) ||
-	    put_user(status.avail_max, &src->avail_max) ||
-	    put_user(status.overrange, &src->overrange) ||
-	    put_user(status.suspended_state, &src->suspended_state) ||
-	    put_user(status.audio_tstamp_data, &src->audio_tstamp_data) ||
-	    compat_put_timespec(&status.audio_tstamp, &src->audio_tstamp) ||
-	    compat_put_timespec(&status.driver_tstamp, &src->driver_tstamp) ||
-	    put_user(status.audio_tstamp_accuracy, &src->audio_tstamp_accuracy))
-		return -EFAULT;
-
-	return err;
-}
-
-#ifdef CONFIG_X86_X32
-/* X32 ABI has 64bit timespec and 64bit alignment */
-struct snd_pcm_status_x32 {
-	s32 state;
-	u32 rsvd; /* alignment */
-	struct timespec trigger_tstamp;
-	struct timespec tstamp;
+	u8 rsvd[sizeof(time_t) - sizeof(s32)]; /* alignment */
+	s64 trigger_tstamp_sec;
+	s64 trigger_tstamp_nsec;
+	s64 tstamp_sec;
+	s64 tstamp_nsec;
 	u32 appl_ptr;
 	u32 hw_ptr;
 	s32 delay;
@@ -262,22 +202,26 @@ struct snd_pcm_status_x32 {
 	u32 overrange;
 	s32 suspended_state;
 	u32 audio_tstamp_data;
-	struct timespec audio_tstamp;
-	struct timespec driver_tstamp;
+	s64 audio_tstamp_sec;
+	s64 audio_tstamp_nsec;
+	s64 driver_tstamp_sec;
+	s64 driver_tstamp_nsec;
 	u32 audio_tstamp_accuracy;
-	unsigned char reserved[52-2*sizeof(struct timespec)];
+	unsigned char reserved[52-4*sizeof(s64)];
 } __packed;
 
 #define put_timespec(src, dst) copy_to_user(dst, src, sizeof(*dst))
 
-static int snd_pcm_status_user_x32(struct snd_pcm_substream *substream,
-				   struct snd_pcm_status_x32 __user *src,
-				   bool ext)
+static int snd_pcm_status_user_compat64(struct snd_pcm_substream *substream,
+					struct compat_snd_pcm_status64 __user *src,
+					bool ext)
 {
-	struct snd_pcm_status status;
+	struct snd_pcm_status64 status;
+	struct compat_snd_pcm_status64 compat_status64;
 	int err;
 
 	memset(&status, 0, sizeof(status));
+	memset(&compat_status64, 0, sizeof(compat_status64));
 	/*
 	 * with extension, parameters are read/write,
 	 * get audio_tstamp_data from user,
@@ -286,31 +230,39 @@ static int snd_pcm_status_user_x32(struct snd_pcm_substream *substream,
 	if (ext && get_user(status.audio_tstamp_data,
 				(u32 __user *)(&src->audio_tstamp_data)))
 		return -EFAULT;
-	err = snd_pcm_status(substream, &status);
+	err = snd_pcm_status64(substream, &status);
 	if (err < 0)
 		return err;
 
 	if (clear_user(src, sizeof(*src)))
 		return -EFAULT;
-	if (put_user(status.state, &src->state) ||
-	    put_timespec(&status.trigger_tstamp, &src->trigger_tstamp) ||
-	    put_timespec(&status.tstamp, &src->tstamp) ||
-	    put_user(status.appl_ptr, &src->appl_ptr) ||
-	    put_user(status.hw_ptr, &src->hw_ptr) ||
-	    put_user(status.delay, &src->delay) ||
-	    put_user(status.avail, &src->avail) ||
-	    put_user(status.avail_max, &src->avail_max) ||
-	    put_user(status.overrange, &src->overrange) ||
-	    put_user(status.suspended_state, &src->suspended_state) ||
-	    put_user(status.audio_tstamp_data, &src->audio_tstamp_data) ||
-	    put_timespec(&status.audio_tstamp, &src->audio_tstamp) ||
-	    put_timespec(&status.driver_tstamp, &src->driver_tstamp) ||
-	    put_user(status.audio_tstamp_accuracy, &src->audio_tstamp_accuracy))
+
+	compat_status64 = (struct compat_snd_pcm_status64) {
+		.state = status.state,
+		.trigger_tstamp_sec = status.trigger_tstamp_sec,
+		.trigger_tstamp_nsec = status.trigger_tstamp_nsec,
+		.tstamp_sec = status.tstamp_sec,
+		.tstamp_nsec = status.tstamp_nsec,
+		.appl_ptr = status.appl_ptr,
+		.hw_ptr = status.hw_ptr,
+		.delay = status.delay,
+		.avail = status.avail,
+		.avail_max = status.avail_max,
+		.overrange = status.overrange,
+		.suspended_state = status.suspended_state,
+		.audio_tstamp_data = status.audio_tstamp_data,
+		.audio_tstamp_sec = status.audio_tstamp_sec,
+		.audio_tstamp_nsec = status.audio_tstamp_nsec,
+		.driver_tstamp_sec = status.audio_tstamp_sec,
+		.driver_tstamp_nsec = status.audio_tstamp_nsec,
+		.audio_tstamp_accuracy = status.audio_tstamp_accuracy,
+	};
+
+	if (copy_to_user(src, &compat_status64, sizeof(compat_status64)))
 		return -EFAULT;
 
 	return err;
 }
-#endif /* CONFIG_X86_X32 */
 
 /* both for HW_PARAMS and HW_REFINE */
 static int snd_pcm_ioctl_hw_params_compat(struct snd_pcm_substream *substream,
@@ -633,8 +585,8 @@ enum {
 	SNDRV_PCM_IOCTL_HW_REFINE32 = _IOWR('A', 0x10, struct snd_pcm_hw_params32),
 	SNDRV_PCM_IOCTL_HW_PARAMS32 = _IOWR('A', 0x11, struct snd_pcm_hw_params32),
 	SNDRV_PCM_IOCTL_SW_PARAMS32 = _IOWR('A', 0x13, struct snd_pcm_sw_params32),
-	SNDRV_PCM_IOCTL_STATUS32 = _IOR('A', 0x20, struct snd_pcm_status32),
-	SNDRV_PCM_IOCTL_STATUS_EXT32 = _IOWR('A', 0x24, struct snd_pcm_status32),
+	SNDRV_PCM_IOCTL_STATUS_COMPAT32 = _IOR('A', 0x20, struct snd_pcm_status32),
+	SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT32 = _IOWR('A', 0x24, struct snd_pcm_status32),
 	SNDRV_PCM_IOCTL_DELAY32 = _IOR('A', 0x21, s32),
 	SNDRV_PCM_IOCTL_CHANNEL_INFO32 = _IOR('A', 0x32, struct snd_pcm_channel_info32),
 	SNDRV_PCM_IOCTL_REWIND32 = _IOW('A', 0x46, u32),
@@ -644,10 +596,10 @@ enum {
 	SNDRV_PCM_IOCTL_WRITEN_FRAMES32 = _IOW('A', 0x52, struct snd_xfern32),
 	SNDRV_PCM_IOCTL_READN_FRAMES32 = _IOR('A', 0x53, struct snd_xfern32),
 	SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct snd_pcm_sync_ptr32),
+	SNDRV_PCM_IOCTL_STATUS_COMPAT64 = _IOR('A', 0x20, struct compat_snd_pcm_status64),
+	SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64 = _IOWR('A', 0x24, struct compat_snd_pcm_status64),
 #ifdef CONFIG_X86_X32
 	SNDRV_PCM_IOCTL_CHANNEL_INFO_X32 = _IOR('A', 0x32, struct snd_pcm_channel_info),
-	SNDRV_PCM_IOCTL_STATUS_X32 = _IOR('A', 0x20, struct snd_pcm_status_x32),
-	SNDRV_PCM_IOCTL_STATUS_EXT_X32 = _IOWR('A', 0x24, struct snd_pcm_status_x32),
 	SNDRV_PCM_IOCTL_SYNC_PTR_X32 = _IOWR('A', 0x23, struct snd_pcm_sync_ptr_x32),
 #endif /* CONFIG_X86_X32 */
 };
@@ -697,10 +649,10 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 		return snd_pcm_ioctl_hw_params_compat(substream, 0, argp);
 	case SNDRV_PCM_IOCTL_SW_PARAMS32:
 		return snd_pcm_ioctl_sw_params_compat(substream, argp);
-	case SNDRV_PCM_IOCTL_STATUS32:
-		return snd_pcm_status_user_compat(substream, argp, false);
-	case SNDRV_PCM_IOCTL_STATUS_EXT32:
-		return snd_pcm_status_user_compat(substream, argp, true);
+	case SNDRV_PCM_IOCTL_STATUS_COMPAT32:
+		return snd_pcm_status_user32(substream, argp, false);
+	case SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT32:
+		return snd_pcm_status_user32(substream, argp, true);
 	case SNDRV_PCM_IOCTL_SYNC_PTR32:
 		return snd_pcm_ioctl_sync_ptr_compat(substream, argp);
 	case SNDRV_PCM_IOCTL_CHANNEL_INFO32:
@@ -719,11 +671,11 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 		return snd_pcm_ioctl_rewind_compat(substream, argp);
 	case SNDRV_PCM_IOCTL_FORWARD32:
 		return snd_pcm_ioctl_forward_compat(substream, argp);
+	case SNDRV_PCM_IOCTL_STATUS_COMPAT64:
+		return snd_pcm_status_user_compat64(substream, argp, false);
+	case SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64:
+		return snd_pcm_status_user_compat64(substream, argp, true);
 #ifdef CONFIG_X86_X32
-	case SNDRV_PCM_IOCTL_STATUS_X32:
-		return snd_pcm_status_user_x32(substream, argp, false);
-	case SNDRV_PCM_IOCTL_STATUS_EXT_X32:
-		return snd_pcm_status_user_x32(substream, argp, true);
 	case SNDRV_PCM_IOCTL_SYNC_PTR_X32:
 		return snd_pcm_ioctl_sync_ptr_x32(substream, argp);
 	case SNDRV_PCM_IOCTL_CHANNEL_INFO_X32:
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c57dd4b..0c2ec6d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -857,8 +857,8 @@ static int snd_pcm_sw_params_user(struct snd_pcm_substream *substream,
 	return err;
 }
 
-int snd_pcm_status(struct snd_pcm_substream *substream,
-		   struct snd_pcm_status *status)
+int snd_pcm_status64(struct snd_pcm_substream *substream,
+		     struct snd_pcm_status64 *status)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -884,14 +884,22 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 	status->suspended_state = runtime->status->suspended_state;
 	if (status->state == SNDRV_PCM_STATE_OPEN)
 		goto _end;
-	status->trigger_tstamp = timespec64_to_timespec(runtime->trigger_tstamp);
+	status->trigger_tstamp_sec = runtime->trigger_tstamp.tv_sec;
+	status->trigger_tstamp_nsec = runtime->trigger_tstamp.tv_nsec;
 	if (snd_pcm_running(substream)) {
 		snd_pcm_update_hw_ptr(substream);
 		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
-			status->tstamp = runtime->status->tstamp;
-			status->driver_tstamp = timespec64_to_timespec(runtime->driver_tstamp);
-			status->audio_tstamp =
-				runtime->status->audio_tstamp;
+			status->tstamp_sec = runtime->status->tstamp.tv_sec;
+			status->tstamp_nsec =
+				runtime->status->tstamp.tv_nsec;
+			status->driver_tstamp_sec =
+				runtime->driver_tstamp.tv_sec;
+			status->driver_tstamp_nsec =
+				runtime->driver_tstamp.tv_nsec;
+			status->audio_tstamp_sec =
+				runtime->status->audio_tstamp.tv_sec;
+			status->audio_tstamp_nsec =
+				runtime->status->audio_tstamp.tv_nsec;
 			if (runtime->audio_tstamp_report.valid == 1)
 				/* backwards compatibility, no report provided in COMPAT mode */
 				snd_pcm_pack_audio_tstamp_report(&status->audio_tstamp_data,
@@ -906,7 +914,8 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 			struct timespec64 tstamp;
 
 			snd_pcm_gettime(runtime, &tstamp);
-			status->tstamp = timespec64_to_timespec(tstamp);
+			status->tstamp_sec = tstamp.tv_sec;
+			status->tstamp_nsec = tstamp.tv_nsec;
 		}
 	}
  _tstamp_end:
@@ -936,11 +945,11 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int snd_pcm_status_user(struct snd_pcm_substream *substream,
-			       struct snd_pcm_status __user * _status,
-			       bool ext)
+static int snd_pcm_status_user64(struct snd_pcm_substream *substream,
+				 struct snd_pcm_status64 __user * _status,
+				 bool ext)
 {
-	struct snd_pcm_status status;
+	struct snd_pcm_status64 status;
 	int res;
 
 	memset(&status, 0, sizeof(status));
@@ -952,7 +961,7 @@ static int snd_pcm_status_user(struct snd_pcm_substream *substream,
 	if (ext && get_user(status.audio_tstamp_data,
 				(u32 __user *)(&_status->audio_tstamp_data)))
 		return -EFAULT;
-	res = snd_pcm_status(substream, &status);
+	res = snd_pcm_status64(substream, &status);
 	if (res < 0)
 		return res;
 	if (copy_to_user(_status, &status, sizeof(status)))
@@ -960,6 +969,55 @@ static int snd_pcm_status_user(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int snd_pcm_status_user32(struct snd_pcm_substream *substream,
+				 struct snd_pcm_status32 __user * _status,
+				 bool ext)
+{
+	struct snd_pcm_status64 status64;
+	struct snd_pcm_status32 status32;
+	int res;
+
+	memset(&status64, 0, sizeof(status64));
+	memset(&status32, 0, sizeof(status32));
+	/*
+	 * with extension, parameters are read/write,
+	 * get audio_tstamp_data from user,
+	 * ignore rest of status structure
+	 */
+	if (ext && get_user(status64.audio_tstamp_data,
+			    (u32 __user *)(&_status->audio_tstamp_data)))
+		return -EFAULT;
+	res = snd_pcm_status64(substream, &status64);
+	if (res < 0)
+		return res;
+
+	status32 = (struct snd_pcm_status32) {
+		.state = status64.state,
+		.trigger_tstamp_sec = status64.trigger_tstamp_sec,
+		.trigger_tstamp_nsec = status64.trigger_tstamp_nsec,
+		.tstamp_sec = status64.tstamp_sec,
+		.tstamp_nsec = status64.tstamp_nsec,
+		.appl_ptr = status64.appl_ptr,
+		.hw_ptr = status64.hw_ptr,
+		.delay = status64.delay,
+		.avail = status64.avail,
+		.avail_max = status64.avail_max,
+		.overrange = status64.overrange,
+		.suspended_state = status64.suspended_state,
+		.audio_tstamp_data = status64.audio_tstamp_data,
+		.audio_tstamp_sec = status64.audio_tstamp_sec,
+		.audio_tstamp_nsec = status64.audio_tstamp_nsec,
+		.driver_tstamp_sec = status64.audio_tstamp_sec,
+		.driver_tstamp_nsec = status64.audio_tstamp_nsec,
+		.audio_tstamp_accuracy = status64.audio_tstamp_accuracy,
+	};
+
+	if (copy_to_user(_status, &status32, sizeof(status32)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int snd_pcm_channel_info(struct snd_pcm_substream *substream,
 				struct snd_pcm_channel_info * info)
 {
@@ -2896,10 +2954,14 @@ static int snd_pcm_common_ioctl(struct file *file,
 		return snd_pcm_hw_free(substream);
 	case SNDRV_PCM_IOCTL_SW_PARAMS:
 		return snd_pcm_sw_params_user(substream, arg);
-	case SNDRV_PCM_IOCTL_STATUS:
-		return snd_pcm_status_user(substream, arg, false);
-	case SNDRV_PCM_IOCTL_STATUS_EXT:
-		return snd_pcm_status_user(substream, arg, true);
+	case SNDRV_PCM_IOCTL_STATUS32:
+		return snd_pcm_status_user32(substream, arg, false);
+	case SNDRV_PCM_IOCTL_STATUS_EXT32:
+		return snd_pcm_status_user32(substream, arg, true);
+	case SNDRV_PCM_IOCTL_STATUS64:
+		return snd_pcm_status_user64(substream, arg, false);
+	case SNDRV_PCM_IOCTL_STATUS_EXT64:
+		return snd_pcm_status_user64(substream, arg, true);
 	case SNDRV_PCM_IOCTL_CHANNEL_INFO:
 		return snd_pcm_channel_info_user(substream, arg);
 	case SNDRV_PCM_IOCTL_PREPARE:
-- 
1.7.9.5
