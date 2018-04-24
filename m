Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757126AbeDXMH5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:07:57 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46752 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756817AbeDXMHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:07:49 -0400
X-Google-Smtp-Source: AIpwx4+lVyPF0JLIeN0JsbznmpDeWX+BXEgPZwNzugSBT8+/2avEDBTtGcztRtt1ncyiXCfH/fxbww==
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
Subject: [PATCH 7/8] ALSA: move snd_pcm_ioctl_sync_ptr_compat into pcm_native.c
Date: Tue, 24 Apr 2018 20:06:14 +0800
Message-Id: <1d250179d195adac2ba479f62ad56e0240173715.1524570852.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is a preparation patch, moving the compat handler for
snd_pcm_ioctl_sync_ptr_compat from pcm_compat.c to pcm_native.c.
No other changes are indented.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 sound/core/pcm_compat.c |   98 ---------------------------------------------
 sound/core/pcm_native.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 98 deletions(-)

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index a4ef13b..5ed30aa 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -102,19 +102,6 @@ struct snd_pcm_sw_params32 {
 	unsigned char reserved[56];
 };
 
-/* recalcuate the boundary within 32bit */
-static snd_pcm_uframes_t recalculate_boundary(struct snd_pcm_runtime *runtime)
-{
-	snd_pcm_uframes_t boundary;
-
-	if (! runtime->buffer_size)
-		return 0;
-	boundary = runtime->buffer_size;
-	while (boundary * 2 <= 0x7fffffffUL - runtime->buffer_size)
-		boundary *= 2;
-	return boundary;
-}
-
 static int snd_pcm_ioctl_sw_params_compat(struct snd_pcm_substream *substream,
 					  struct snd_pcm_sw_params32 __user *src)
 {
@@ -405,91 +392,6 @@ static int snd_pcm_ioctl_xfern_compat(struct snd_pcm_substream *substream,
 	return err;
 }
 
-
-struct snd_pcm_mmap_status32 {
-	s32 state;
-	s32 pad1;
-	u32 hw_ptr;
-	struct compat_timespec tstamp;
-	s32 suspended_state;
-	struct compat_timespec audio_tstamp;
-} __attribute__((packed));
-
-struct snd_pcm_mmap_control32 {
-	u32 appl_ptr;
-	u32 avail_min;
-};
-
-struct snd_pcm_sync_ptr32 {
-	u32 flags;
-	union {
-		struct snd_pcm_mmap_status32 status;
-		unsigned char reserved[64];
-	} s;
-	union {
-		struct snd_pcm_mmap_control32 control;
-		unsigned char reserved[64];
-	} c;
-} __attribute__((packed));
-
-static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
-					 struct snd_pcm_sync_ptr32 __user *src)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	volatile struct snd_pcm_mmap_status *status;
-	volatile struct snd_pcm_mmap_control *control;
-	u32 sflags;
-	struct snd_pcm_mmap_control scontrol;
-	struct snd_pcm_mmap_status sstatus;
-	snd_pcm_uframes_t boundary;
-	int err;
-
-	if (snd_BUG_ON(!runtime))
-		return -EINVAL;
-
-	if (get_user(sflags, &src->flags) ||
-	    get_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
-	    get_user(scontrol.avail_min, &src->c.control.avail_min))
-		return -EFAULT;
-	if (sflags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
-		err = snd_pcm_hwsync(substream);
-		if (err < 0)
-			return err;
-	}
-	status = runtime->status;
-	control = runtime->control;
-	boundary = recalculate_boundary(runtime);
-	if (! boundary)
-		boundary = 0x7fffffff;
-	snd_pcm_stream_lock_irq(substream);
-	/* FIXME: we should consider the boundary for the sync from app */
-	if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL))
-		control->appl_ptr = scontrol.appl_ptr;
-	else
-		scontrol.appl_ptr = control->appl_ptr % boundary;
-	if (!(sflags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
-		control->avail_min = scontrol.avail_min;
-	else
-		scontrol.avail_min = control->avail_min;
-	sstatus.state = status->state;
-	sstatus.hw_ptr = status->hw_ptr % boundary;
-	sstatus.tstamp = status->tstamp;
-	sstatus.suspended_state = status->suspended_state;
-	sstatus.audio_tstamp = status->audio_tstamp;
-	snd_pcm_stream_unlock_irq(substream);
-	if (put_user(sstatus.state, &src->s.status.state) ||
-	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
-	    compat_put_timespec(&sstatus.tstamp, &src->s.status.tstamp) ||
-	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
-	    compat_put_timespec(&sstatus.audio_tstamp,
-		    &src->s.status.audio_tstamp) ||
-	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
-	    put_user(scontrol.avail_min, &src->c.control.avail_min))
-		return -EFAULT;
-
-	return 0;
-}
-
 #ifdef CONFIG_X86_X32
 /* X32 ABI has 64bit timespec and 64bit alignment */
 struct snd_pcm_mmap_status_x32 {
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 0c2ec6d..158e85d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -19,6 +19,7 @@
  *
  */
 
+#include <linux/compat.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/file.h>
@@ -2819,6 +2820,106 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+struct snd_pcm_mmap_status32 {
+	s32 state;
+	s32 pad1;
+	u32 hw_ptr;
+	struct compat_timespec tstamp;
+	s32 suspended_state;
+	struct compat_timespec audio_tstamp;
+} __attribute__((packed));
+
+struct snd_pcm_mmap_control32 {
+	u32 appl_ptr;
+	u32 avail_min;
+};
+
+struct snd_pcm_sync_ptr32 {
+	u32 flags;
+	union {
+		struct snd_pcm_mmap_status32 status;
+		unsigned char reserved[64];
+	} s;
+	union {
+		struct snd_pcm_mmap_control32 control;
+		unsigned char reserved[64];
+	} c;
+} __attribute__((packed));
+
+/* recalcuate the boundary within 32bit */
+static snd_pcm_uframes_t recalculate_boundary(struct snd_pcm_runtime *runtime)
+{
+	snd_pcm_uframes_t boundary;
+
+	if (! runtime->buffer_size)
+		return 0;
+	boundary = runtime->buffer_size;
+	while (boundary * 2 <= 0x7fffffffUL - runtime->buffer_size)
+		boundary *= 2;
+	return boundary;
+}
+
+static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
+					 struct snd_pcm_sync_ptr32 __user *src)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	volatile struct snd_pcm_mmap_status *status;
+	volatile struct snd_pcm_mmap_control *control;
+	u32 sflags;
+	struct snd_pcm_mmap_control scontrol;
+	struct snd_pcm_mmap_status sstatus;
+	snd_pcm_uframes_t boundary;
+	int err;
+
+	if (snd_BUG_ON(!runtime))
+		return -EINVAL;
+
+	if (get_user(sflags, &src->flags) ||
+	    get_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
+	    get_user(scontrol.avail_min, &src->c.control.avail_min))
+		return -EFAULT;
+	if (sflags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
+		err = snd_pcm_hwsync(substream);
+		if (err < 0)
+			return err;
+	}
+	status = runtime->status;
+	control = runtime->control;
+	boundary = recalculate_boundary(runtime);
+	if (! boundary)
+		boundary = 0x7fffffff;
+	snd_pcm_stream_lock_irq(substream);
+	/* FIXME: we should consider the boundary for the sync from app */
+	if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL))
+		control->appl_ptr = scontrol.appl_ptr;
+	else
+		scontrol.appl_ptr = control->appl_ptr % boundary;
+	if (!(sflags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
+		control->avail_min = scontrol.avail_min;
+	else
+		scontrol.avail_min = control->avail_min;
+	sstatus.state = status->state;
+	sstatus.hw_ptr = status->hw_ptr % boundary;
+	sstatus.tstamp = status->tstamp;
+	sstatus.suspended_state = status->suspended_state;
+	sstatus.audio_tstamp = status->audio_tstamp;
+	snd_pcm_stream_unlock_irq(substream);
+	if (put_user(sstatus.state, &src->s.status.state) ||
+	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
+	    compat_put_timespec(&sstatus.tstamp, &src->s.status.tstamp) ||
+	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
+	    compat_put_timespec(&sstatus.audio_tstamp,
+				&src->s.status.audio_tstamp) ||
+	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
+	    put_user(scontrol.avail_min, &src->c.control.avail_min))
+		return -EFAULT;
+
+	return 0;
+}
+#define __SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct snd_pcm_sync_ptr32),
+#endif
+
 static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-- 
1.7.9.5
