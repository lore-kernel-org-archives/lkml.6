Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756972AbeDXMH0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:07:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37769 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756720AbeDXMHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:07:19 -0400
X-Google-Smtp-Source: AIpwx497i0kaD+OCavecwDf87U0s1VCTWkAaUhaCR26rn3NM1lcxF/95JoIwPTnUSR5u93IoknLN2g==
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
Subject: [PATCH 1/8] ALSA: Replace timespec with timespec64
Date: Tue, 24 Apr 2018 20:06:08 +0800
Message-Id: <7373ade7cb5a8d6a5fca07e78cf992ba7372bd7f.1524570852.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since timespec is not year 2038 safe on 32bit system, and we need to
convert all timespec variables to timespec64 type for sound subsystem.

This patch is used to do preparation for following patches, that will
convert all structures defined in uapi/sound/asound.h to use 64-bit
time_t.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/sound/pcm.h               |   18 +++++++++---------
 include/sound/timer.h             |    4 ++--
 sound/core/pcm_lib.c              |   33 ++++++++++++++++++++-------------
 sound/core/pcm_native.c           |   12 ++++++++----
 sound/core/timer.c                |   28 ++++++++++++++--------------
 sound/pci/hda/hda_controller.c    |   10 +++++-----
 sound/soc/intel/skylake/skl-pcm.c |    4 ++--
 7 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e054c58..973d674 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -75,7 +75,7 @@ struct snd_pcm_ops {
 	int (*trigger)(struct snd_pcm_substream *substream, int cmd);
 	snd_pcm_uframes_t (*pointer)(struct snd_pcm_substream *substream);
 	int (*get_time_info)(struct snd_pcm_substream *substream,
-			struct timespec *system_ts, struct timespec *audio_ts,
+			struct timespec64 *system_ts, struct timespec64 *audio_ts,
 			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
 			struct snd_pcm_audio_tstamp_report *audio_tstamp_report);
 	int (*fill_silence)(struct snd_pcm_substream *substream, int channel,
@@ -351,7 +351,7 @@ static inline void snd_pcm_pack_audio_tstamp_report(__u32 *data, __u32 *accuracy
 struct snd_pcm_runtime {
 	/* -- Status -- */
 	struct snd_pcm_substream *trigger_master;
-	struct timespec trigger_tstamp;	/* trigger timestamp */
+	struct timespec64 trigger_tstamp;	/* trigger timestamp */
 	bool trigger_tstamp_latched;     /* trigger timestamp latched in low-level driver/hardware */
 	int overrange;
 	snd_pcm_uframes_t avail_max;
@@ -427,7 +427,7 @@ struct snd_pcm_runtime {
 	/* -- audio timestamp config -- */
 	struct snd_pcm_audio_tstamp_config audio_tstamp_config;
 	struct snd_pcm_audio_tstamp_report audio_tstamp_report;
-	struct timespec driver_tstamp;
+	struct timespec64 driver_tstamp;
 
 #if IS_ENABLED(CONFIG_SND_PCM_OSS)
 	/* -- OSS things -- */
@@ -1175,22 +1175,22 @@ static inline void snd_pcm_set_runtime_buffer(struct snd_pcm_substream *substrea
 }
 
 /**
- * snd_pcm_gettime - Fill the timespec depending on the timestamp mode
+ * snd_pcm_gettime - Fill the timespec64 depending on the timestamp mode
  * @runtime: PCM runtime instance
- * @tv: timespec to fill
+ * @tv: timespec64 to fill
  */
 static inline void snd_pcm_gettime(struct snd_pcm_runtime *runtime,
-				   struct timespec *tv)
+				   struct timespec64 *tv)
 {
 	switch (runtime->tstamp_type) {
 	case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC:
-		ktime_get_ts(tv);
+		ktime_get_ts64(tv);
 		break;
 	case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW:
-		getrawmonotonic(tv);
+		getrawmonotonic64(tv);
 		break;
 	default:
-		getnstimeofday(tv);
+		ktime_get_real_ts64(tv);
 		break;
 	}
 }
diff --git a/include/sound/timer.h b/include/sound/timer.h
index 7ae226a..91b9baa 100644
--- a/include/sound/timer.h
+++ b/include/sound/timer.h
@@ -104,7 +104,7 @@ struct snd_timer_instance {
 			  unsigned long ticks, unsigned long resolution);
 	void (*ccallback) (struct snd_timer_instance * timeri,
 			   int event,
-			   struct timespec * tstamp,
+			   struct timespec64 * tstamp,
 			   unsigned long resolution);
 	void (*disconnect)(struct snd_timer_instance *timeri);
 	void *callback_data;
@@ -128,7 +128,7 @@ struct snd_timer_instance {
  */
 
 int snd_timer_new(struct snd_card *card, char *id, struct snd_timer_id *tid, struct snd_timer **rtimer);
-void snd_timer_notify(struct snd_timer *timer, int event, struct timespec *tstamp);
+void snd_timer_notify(struct snd_timer *timer, int event, struct timespec64 *tstamp);
 int snd_timer_global_new(char *id, int device, struct snd_timer **rtimer);
 int snd_timer_global_free(struct snd_timer *timer);
 int snd_timer_global_register(struct snd_timer *timer);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index f4a1950..213f0e6 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -158,8 +158,12 @@ static void xrun(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	trace_xrun(substream);
-	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE)
-		snd_pcm_gettime(runtime, (struct timespec *)&runtime->status->tstamp);
+	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
+		struct timespec64 tstamp;
+
+		snd_pcm_gettime(runtime, &tstamp);
+		runtime->status->tstamp = timespec64_to_timespec(tstamp);
+	}
 	snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
 	if (xrun_debug(substream, XRUN_DEBUG_BASIC)) {
 		char name[16];
@@ -217,12 +221,12 @@ int snd_pcm_update_state(struct snd_pcm_substream *substream,
 }
 
 static void update_audio_tstamp(struct snd_pcm_substream *substream,
-				struct timespec *curr_tstamp,
-				struct timespec *audio_tstamp)
+				struct timespec64 *curr_tstamp,
+				struct timespec64 *audio_tstamp)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	u64 audio_frames, audio_nsecs;
-	struct timespec driver_tstamp;
+	struct timespec64 driver_tstamp;
 
 	if (runtime->tstamp_mode != SNDRV_PCM_TSTAMP_ENABLE)
 		return;
@@ -246,18 +250,21 @@ static void update_audio_tstamp(struct snd_pcm_substream *substream,
 		}
 		audio_nsecs = div_u64(audio_frames * 1000000000LL,
 				runtime->rate);
-		*audio_tstamp = ns_to_timespec(audio_nsecs);
+		*audio_tstamp = ns_to_timespec64(audio_nsecs);
 	}
+
 	if (!timespec_equal(&runtime->status->audio_tstamp, audio_tstamp)) {
-		runtime->status->audio_tstamp = *audio_tstamp;
-		runtime->status->tstamp = *curr_tstamp;
+		runtime->status->audio_tstamp =
+			timespec64_to_timespec(*audio_tstamp);
+		runtime->status->tstamp = timespec64_to_timespec(*curr_tstamp);
 	}
 
+
 	/*
 	 * re-take a driver timestamp to let apps detect if the reference tstamp
 	 * read by low-level hardware was provided with a delay
 	 */
-	snd_pcm_gettime(substream->runtime, (struct timespec *)&driver_tstamp);
+	snd_pcm_gettime(substream->runtime, &driver_tstamp);
 	runtime->driver_tstamp = driver_tstamp;
 }
 
@@ -270,8 +277,8 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	snd_pcm_sframes_t hdelta, delta;
 	unsigned long jdelta;
 	unsigned long curr_jiffies;
-	struct timespec curr_tstamp;
-	struct timespec audio_tstamp;
+	struct timespec64 curr_tstamp;
+	struct timespec64 audio_tstamp;
 	int crossed_boundary = 0;
 
 	old_hw_ptr = runtime->status->hw_ptr;
@@ -294,9 +301,9 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 
 			/* re-test in case tstamp type is not supported in hardware and was demoted to DEFAULT */
 			if (runtime->audio_tstamp_report.actual_type == SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT)
-				snd_pcm_gettime(runtime, (struct timespec *)&curr_tstamp);
+				snd_pcm_gettime(runtime, &curr_tstamp);
 		} else
-			snd_pcm_gettime(runtime, (struct timespec *)&curr_tstamp);
+			snd_pcm_gettime(runtime, &curr_tstamp);
 	}
 
 	if (pos == SNDRV_PCM_POS_XRUN) {
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 35ffcce..c57dd4b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -884,12 +884,12 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 	status->suspended_state = runtime->status->suspended_state;
 	if (status->state == SNDRV_PCM_STATE_OPEN)
 		goto _end;
-	status->trigger_tstamp = runtime->trigger_tstamp;
+	status->trigger_tstamp = timespec64_to_timespec(runtime->trigger_tstamp);
 	if (snd_pcm_running(substream)) {
 		snd_pcm_update_hw_ptr(substream);
 		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
 			status->tstamp = runtime->status->tstamp;
-			status->driver_tstamp = runtime->driver_tstamp;
+			status->driver_tstamp = timespec64_to_timespec(runtime->driver_tstamp);
 			status->audio_tstamp =
 				runtime->status->audio_tstamp;
 			if (runtime->audio_tstamp_report.valid == 1)
@@ -902,8 +902,12 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 		}
 	} else {
 		/* get tstamp only in fallback mode and only if enabled */
-		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE)
-			snd_pcm_gettime(runtime, &status->tstamp);
+		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
+			struct timespec64 tstamp;
+
+			snd_pcm_gettime(runtime, &tstamp);
+			status->tstamp = timespec64_to_timespec(tstamp);
+		}
 	}
  _tstamp_end:
 	status->appl_ptr = runtime->control->appl_ptr;
diff --git a/sound/core/timer.c b/sound/core/timer.c
index dc87728..a77b461 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -73,7 +73,7 @@ struct snd_timer_user {
 	spinlock_t qlock;
 	unsigned long last_resolution;
 	unsigned int filter;
-	struct timespec tstamp;		/* trigger tstamp */
+	struct timespec64 tstamp;		/* trigger tstamp */
 	wait_queue_head_t qchange_sleep;
 	struct fasync_struct *fasync;
 	struct mutex ioctl_lock;
@@ -448,12 +448,12 @@ static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 	struct snd_timer *timer;
 	unsigned long resolution = 0;
 	struct snd_timer_instance *ts;
-	struct timespec tstamp;
+	struct timespec64 tstamp;
 
 	if (timer_tstamp_monotonic)
-		ktime_get_ts(&tstamp);
+		ktime_get_ts64(&tstamp);
 	else
-		getnstimeofday(&tstamp);
+		ktime_get_real_ts64(&tstamp);
 	if (snd_BUG_ON(event < SNDRV_TIMER_EVENT_START ||
 		       event > SNDRV_TIMER_EVENT_PAUSE))
 		return;
@@ -998,7 +998,7 @@ static int snd_timer_dev_disconnect(struct snd_device *device)
 	return 0;
 }
 
-void snd_timer_notify(struct snd_timer *timer, int event, struct timespec *tstamp)
+void snd_timer_notify(struct snd_timer *timer, int event, struct timespec64 *tstamp)
 {
 	unsigned long flags;
 	unsigned long resolution = 0;
@@ -1295,7 +1295,7 @@ static void snd_timer_user_append_to_tqueue(struct snd_timer_user *tu,
 
 static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
 				     int event,
-				     struct timespec *tstamp,
+				     struct timespec64 *tstamp,
 				     unsigned long resolution)
 {
 	struct snd_timer_user *tu = timeri->callback_data;
@@ -1309,7 +1309,7 @@ static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
 		return;
 	memset(&r1, 0, sizeof(r1));
 	r1.event = event;
-	r1.tstamp = *tstamp;
+	r1.tstamp = timespec64_to_timespec(*tstamp);
 	r1.val = resolution;
 	spin_lock_irqsave(&tu->qlock, flags);
 	snd_timer_user_append_to_tqueue(tu, &r1);
@@ -1332,7 +1332,7 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 {
 	struct snd_timer_user *tu = timeri->callback_data;
 	struct snd_timer_tread *r, r1;
-	struct timespec tstamp;
+	struct timespec64 tstamp;
 	int prev, append = 0;
 
 	memset(&r1, 0, sizeof(r1));
@@ -1345,14 +1345,14 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 	}
 	if (tu->last_resolution != resolution || ticks > 0) {
 		if (timer_tstamp_monotonic)
-			ktime_get_ts(&tstamp);
+			ktime_get_ts64(&tstamp);
 		else
-			getnstimeofday(&tstamp);
+			ktime_get_real_ts64(&tstamp);
 	}
 	if ((tu->filter & (1 << SNDRV_TIMER_EVENT_RESOLUTION)) &&
 	    tu->last_resolution != resolution) {
 		r1.event = SNDRV_TIMER_EVENT_RESOLUTION;
-		r1.tstamp = tstamp;
+		r1.tstamp = timespec64_to_timespec(tstamp);
 		r1.val = resolution;
 		snd_timer_user_append_to_tqueue(tu, &r1);
 		tu->last_resolution = resolution;
@@ -1366,14 +1366,14 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 		prev = tu->qtail == 0 ? tu->queue_size - 1 : tu->qtail - 1;
 		r = &tu->tqueue[prev];
 		if (r->event == SNDRV_TIMER_EVENT_TICK) {
-			r->tstamp = tstamp;
+			r->tstamp = timespec64_to_timespec(tstamp);
 			r->val += ticks;
 			append++;
 			goto __wake;
 		}
 	}
 	r1.event = SNDRV_TIMER_EVENT_TICK;
-	r1.tstamp = tstamp;
+	r1.tstamp = timespec64_to_timespec(tstamp);
 	r1.val = ticks;
 	snd_timer_user_append_to_tqueue(tu, &r1);
 	append++;
@@ -1852,7 +1852,7 @@ static int snd_timer_user_status(struct file *file,
 	if (!tu->timeri)
 		return -EBADFD;
 	memset(&status, 0, sizeof(status));
-	status.tstamp = tu->tstamp;
+	status.tstamp = timespec64_to_timespec(tu->tstamp);
 	status.resolution = snd_timer_resolution(tu->timeri);
 	status.lost = tu->timeri->lost;
 	status.overrun = tu->overrun;
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index d1eb148..c3e4516 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -502,7 +502,7 @@ static inline bool is_link_time_supported(struct snd_pcm_runtime *runtime,
 }
 
 static int azx_get_time_info(struct snd_pcm_substream *substream,
-			struct timespec *system_ts, struct timespec *audio_ts,
+			struct timespec64 *system_ts, struct timespec64 *audio_ts,
 			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
 			struct snd_pcm_audio_tstamp_report *audio_tstamp_report)
 {
@@ -522,7 +522,7 @@ static int azx_get_time_info(struct snd_pcm_substream *substream,
 		if (audio_tstamp_config->report_delay)
 			nsec = azx_adjust_codec_delay(substream, nsec);
 
-		*audio_ts = ns_to_timespec(nsec);
+		*audio_ts = ns_to_timespec64(nsec);
 
 		audio_tstamp_report->actual_type = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK;
 		audio_tstamp_report->accuracy_report = 1; /* rest of structure is valid */
@@ -539,16 +539,16 @@ static int azx_get_time_info(struct snd_pcm_substream *substream,
 			return -EINVAL;
 
 		case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW:
-			*system_ts = ktime_to_timespec(xtstamp.sys_monoraw);
+			*system_ts = ktime_to_timespec64(xtstamp.sys_monoraw);
 			break;
 
 		default:
-			*system_ts = ktime_to_timespec(xtstamp.sys_realtime);
+			*system_ts = ktime_to_timespec64(xtstamp.sys_realtime);
 			break;
 
 		}
 
-		*audio_ts = ktime_to_timespec(xtstamp.device);
+		*audio_ts = ktime_to_timespec64(xtstamp.device);
 
 		audio_tstamp_report->actual_type =
 			SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED;
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 15cb8ac..a69b56f 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1163,7 +1163,7 @@ static u64 skl_adjust_codec_delay(struct snd_pcm_substream *substream,
 }
 
 static int skl_get_time_info(struct snd_pcm_substream *substream,
-			struct timespec *system_ts, struct timespec *audio_ts,
+			struct timespec64 *system_ts, struct timespec64 *audio_ts,
 			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
 			struct snd_pcm_audio_tstamp_report *audio_tstamp_report)
 {
@@ -1181,7 +1181,7 @@ static int skl_get_time_info(struct snd_pcm_substream *substream,
 		if (audio_tstamp_config->report_delay)
 			nsec = skl_adjust_codec_delay(substream, nsec);
 
-		*audio_ts = ns_to_timespec(nsec);
+		*audio_ts = ns_to_timespec64(nsec);
 
 		audio_tstamp_report->actual_type = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK;
 		audio_tstamp_report->accuracy_report = 1; /* rest of struct is valid */
-- 
1.7.9.5
