Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757205AbeDXMII (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:08:08 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35125 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757056AbeDXMH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:07:56 -0400
X-Google-Smtp-Source: AIpwx485NX4m4NK3PsKVExP9KUsAuoWlYeyfJQGlmHApy7wRgeDHaPvrpfkSjakbxbXXeE1UgLLhMQ==
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
Subject: [PATCH 8/8] ALSA: add new 32-bit layout for snd_pcm_mmap_status/control
Date: Tue, 24 Apr 2018 20:06:15 +0800
Message-Id: <e7d7ed852943b5a35c5d494071f522465620371b.1524570852.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The snd_pcm_mmap_status and snd_pcm_mmap_control interfaces are one of the
trickiest areas to get right when moving to 64-bit time_t in user space.

The snd_pcm_mmap_status structure layout is incompatible with user space
that uses a 64-bit time_t, so we need a new layout for it. Since the
SNDRV_PCM_IOCTL_SYNC_PTR ioctl combines it with snd_pcm_mmap_control
into snd_pcm_sync_ptr, we need to change those two as well.

Both structures are also exported via an mmap() operation on certain
architectures, and this suffers from incompatibility between 32-bit
and 64-bit user space. As we have to change both structures anyway,
this is a good opportunity to fix the mmap() problem as well, so let's
standardize on the existing 64-bit layout of the structure where possible.

The downside is that we lose mmap() support for existing 32-bit x86 and
powerpc applications, adding that would introduce very noticeable runtime
overhead and complexity. My assumption here is that not too many people
will miss the removed feature, given that:

- Almost all x86 and powerpc users these days are on 64-bit kernels,
the majority of today's 32-bit users are on architectures that never
supported mmap (ARM, MIPS, ...).
- It never worked in compat mode (it was intentionally disabled there)
- The application already needs to work with a fallback to
SNDRV_PCM_IOCTL_SYNC_PTR, which will keep working with both the old
and new structure layout.

Both the ioctl() and mmap() based interfaces are changed at the same
time, as they are based on the same structures. Unlike other interfaces,
we change the uapi header to export both the traditional structure and
a version that is portable between 32-bit and 64-bit user space code
and that corresponds to the existing 64-bit layout. We further check the
__USE_TIME_BITS64 macro that will be defined by future C library versions
whenever we use the new time_t definition, so any existing user space
source code will not see any changes until it gets rebuilt against a new
C library. However, the new structures are all visible in addition to the
old ones, allowing applications to explicitly request the new structures.

In order to detect the difference between the old snd_pcm_mmap_status and
the new __snd_pcm_mmap_status64 structure from the ioctl command number,
we rely on one quirk in the structure definition: snd_pcm_mmap_status
must be aligned to alignof(time_t), which leads the compiler to insert
four bytes of padding in struct snd_pcm_sync_ptr after 'flags' and a
corresponding change in the size of snd_pcm_sync_ptr itself. On x86-32
(and only there), the compiler doesn't use 64-bit alignment in structure,
so I'm adding an explicit pad in the structure that has no effect on the
existing 64-bit architectures but ensures that the layout matches for x86.

The snd_pcm_uframes_t type compatibility requires another hack: we can't
easily make that 64 bit wide, so I leave the type as 'unsigned long',
but add padding before and after it, to ensure that the data is properly
aligned to the respective 64-bit field in the in-kernel structure.

For the SNDRV_PCM_MMAP_OFFSET_STATUS/CONTROL constants that are used
as the virtual file offset in the mmap() function, we also have to
introduce new constants that depend on hte __USE_TIME_BITS64 macro:
The existing macros are renamed to SNDRV_PCM_MMAP_OFFSET_STATUS_OLD
and SNDRV_PCM_MMAP_OFFSET_CONTROL_OLD, they continue to work fine on
64-bit architectures, but stop working on native 32-bit user space.
The replacement _NEW constants are now used by default for user space
built with __USE_TIME_BITS64, those now work on all new kernels for x86,
ppc and alpha (32 and 64 bit, native and compat). It might be a good idea
for a future alsa-lib to support both the _OLD and _NEW macros and use
the corresponding structures directly. Unmodified alsa-lib source code
will retain the current behavior, so it will no longer be able to use
mmap() for the status/control structures on 32-bit systems, until either
the C library gets updated to 64-bit time_t or alsa-lib gets updated to
support both mmap() layouts.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/uapi/sound/asound.h |   96 +++++++++++++++++++++++++++++++++++++++----
 sound/core/pcm_compat.c     |    9 ++--
 sound/core/pcm_lib.c        |   13 +++---
 sound/core/pcm_native.c     |   33 +++++++++------
 4 files changed, 120 insertions(+), 31 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index f368e80..18fbdcb 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -34,6 +34,8 @@
 #include <stdlib.h>
 #endif
 
+#include <asm/byteorder.h>
+
 /*
  *  protocol version
  */
@@ -300,7 +302,9 @@ enum {
 #define SNDRV_PCM_INFO_DRAIN_TRIGGER	0x40000000		/* internal kernel flag - trigger in drain */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
-
+#if (__BITS_PER_LONG == 32 && defined(__USE_TIME_BITS64)) || defined __KERNEL__
+#define __SND_STRUCT_TIME64
+#endif
 
 typedef int __bitwise snd_pcm_state_t;
 #define	SNDRV_PCM_STATE_OPEN		((__force snd_pcm_state_t) 0) /* stream is open */
@@ -316,8 +320,17 @@ enum {
 
 enum {
 	SNDRV_PCM_MMAP_OFFSET_DATA = 0x00000000,
-	SNDRV_PCM_MMAP_OFFSET_STATUS = 0x80000000,
-	SNDRV_PCM_MMAP_OFFSET_CONTROL = 0x81000000,
+	SNDRV_PCM_MMAP_OFFSET_STATUS_OLD = 0x80000000,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL_OLD = 0x81000000,
+	SNDRV_PCM_MMAP_OFFSET_STATUS_NEW = 0x82000000,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL_NEW = 0x83000000,
+#ifdef __SND_STRUCT_TIME64
+	SNDRV_PCM_MMAP_OFFSET_STATUS = SNDRV_PCM_MMAP_OFFSET_STATUS_NEW,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL = SNDRV_PCM_MMAP_OFFSET_CONTROL_NEW,
+#else
+	SNDRV_PCM_MMAP_OFFSET_STATUS = SNDRV_PCM_MMAP_OFFSET_STATUS_OLD,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL = SNDRV_PCM_MMAP_OFFSET_CONTROL_OLD,
+#endif
 };
 
 union snd_pcm_sync_id {
@@ -474,7 +487,22 @@ struct snd_pcm_status {
 	unsigned char reserved[52-2*sizeof(struct timespec)]; /* must be filled with zero */
 };
 
-struct snd_pcm_mmap_status {
+/*
+ * For mmap operations, we need the 64-bit layout, both for compat mode,
+ * and for y2038 compatibility. For 64-bit applications, the two definitions
+ * are identical, so we keep the traditional version.
+ */
+#ifdef __SND_STRUCT_TIME64
+#define __snd_pcm_mmap_status64		snd_pcm_mmap_status
+#define __snd_pcm_mmap_control64	snd_pcm_mmap_control
+#define __snd_pcm_sync_ptr64		snd_pcm_sync_ptr
+#else
+#define __snd_pcm_mmap_status		snd_pcm_mmap_status
+#define __snd_pcm_mmap_control		snd_pcm_mmap_control
+#define __snd_pcm_sync_ptr		snd_pcm_sync_ptr
+#endif
+
+struct __snd_pcm_mmap_status {
 	snd_pcm_state_t state;		/* RO: state - SNDRV_PCM_STATE_XXXX */
 	int pad1;			/* Needed for 64 bit alignment */
 	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
@@ -483,7 +511,7 @@ struct snd_pcm_mmap_status {
 	struct timespec audio_tstamp;	/* from sample counter or wall clock */
 };
 
-struct snd_pcm_mmap_control {
+struct __snd_pcm_mmap_control {
 	snd_pcm_uframes_t appl_ptr;	/* RW: appl ptr (0...boundary-1) */
 	snd_pcm_uframes_t avail_min;	/* RW: min available frames for wakeup */
 };
@@ -492,14 +520,64 @@ struct snd_pcm_mmap_control {
 #define SNDRV_PCM_SYNC_PTR_APPL		(1<<1)	/* get appl_ptr from driver (r/w op) */
 #define SNDRV_PCM_SYNC_PTR_AVAIL_MIN	(1<<2)	/* get avail_min from driver */
 
-struct snd_pcm_sync_ptr {
+struct __snd_pcm_sync_ptr {
 	unsigned int flags;
 	union {
-		struct snd_pcm_mmap_status status;
+		struct __snd_pcm_mmap_status status;
+		unsigned char reserved[64];
+	} s;
+	union {
+		struct __snd_pcm_mmap_control control;
+		unsigned char reserved[64];
+	} c;
+};
+
+struct __snd_timespec64 {
+	__s64 tv_sec;
+	__s64 tv_nsec;
+};
+
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
+typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
+typedef char __pad_after_uframe[0];
+#endif
+
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+typedef char __pad_before_uframe[0];
+typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
+#endif
+
+struct __snd_pcm_mmap_status64 {
+	__s32 state;			/* RO: state - SNDRV_PCM_STATE_XXXX */
+	__u32 pad1;			/* Needed for 64 bit alignment */
+	__pad_before_uframe __pad1;
+	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
+	__pad_after_uframe __pad2;
+	struct __snd_timespec64 tstamp;	/* Timestamp */
+	__s32 suspended_state;		/* RO: suspended stream state */
+	__u32 pad3;			/* Needed for 64 bit alignment */
+	struct __snd_timespec64 audio_tstamp; /* sample counter or wall clock */
+};
+
+struct __snd_pcm_mmap_control64 {
+	__pad_before_uframe __pad1;
+	snd_pcm_uframes_t appl_ptr;	 /* RW: appl ptr (0...boundary-1) */
+	__pad_before_uframe __pad2;
+
+	__pad_before_uframe __pad3;
+	snd_pcm_uframes_t  avail_min;	 /* RW: min available frames for wakeup */
+	__pad_after_uframe __pad4;
+};
+
+struct __snd_pcm_sync_ptr64 {
+	__u32 flags;
+	__u32 pad1;
+	union {
+		struct __snd_pcm_mmap_status64 status;
 		unsigned char reserved[64];
 	} s;
 	union {
-		struct snd_pcm_mmap_control control;
+		struct __snd_pcm_mmap_control64 control;
 		unsigned char reserved[64];
 	} c;
 };
@@ -584,6 +662,8 @@ enum {
 #define SNDRV_PCM_IOCTL_STATUS		_IOR('A', 0x20, struct snd_pcm_status)
 #define SNDRV_PCM_IOCTL_DELAY		_IOR('A', 0x21, snd_pcm_sframes_t)
 #define SNDRV_PCM_IOCTL_HWSYNC		_IO('A', 0x22)
+#define __SNDRV_PCM_IOCTL_SYNC_PTR	_IOWR('A', 0x23, struct __snd_pcm_sync_ptr)
+#define __SNDRV_PCM_IOCTL_SYNC_PTR64	_IOWR('A', 0x23, struct __snd_pcm_sync_ptr64)
 #define SNDRV_PCM_IOCTL_SYNC_PTR	_IOWR('A', 0x23, struct snd_pcm_sync_ptr)
 #define SNDRV_PCM_IOCTL_STATUS_EXT	_IOWR('A', 0x24, struct snd_pcm_status)
 #define SNDRV_PCM_IOCTL_CHANNEL_INFO	_IOR('A', 0x32, struct snd_pcm_channel_info)
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 5ed30aa..51a9447 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -497,7 +497,6 @@ enum {
 	SNDRV_PCM_IOCTL_READI_FRAMES32 = _IOR('A', 0x51, struct snd_xferi32),
 	SNDRV_PCM_IOCTL_WRITEN_FRAMES32 = _IOW('A', 0x52, struct snd_xfern32),
 	SNDRV_PCM_IOCTL_READN_FRAMES32 = _IOR('A', 0x53, struct snd_xfern32),
-	SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct snd_pcm_sync_ptr32),
 	SNDRV_PCM_IOCTL_STATUS_COMPAT64 = _IOR('A', 0x20, struct compat_snd_pcm_status64),
 	SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64 = _IOWR('A', 0x24, struct compat_snd_pcm_status64),
 #ifdef CONFIG_X86_X32
@@ -521,8 +520,8 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 
 	/*
 	 * When PCM is used on 32bit mode, we need to disable
-	 * mmap of PCM status/control records because of the size
-	 * incompatibility.
+	 * mmap of the old PCM status/control records because
+	 * of the size incompatibility.
 	 */
 	pcm_file->no_compat_mmap = 1;
 
@@ -544,6 +543,8 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 	case SNDRV_PCM_IOCTL_XRUN:
 	case SNDRV_PCM_IOCTL_LINK:
 	case SNDRV_PCM_IOCTL_UNLINK:
+	case __SNDRV_PCM_IOCTL_SYNC_PTR32:
+	case __SNDRV_PCM_IOCTL_SYNC_PTR64:
 		return snd_pcm_common_ioctl(file, substream, cmd, argp);
 	case SNDRV_PCM_IOCTL_HW_REFINE32:
 		return snd_pcm_ioctl_hw_params_compat(substream, 1, argp);
@@ -555,8 +556,6 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 		return snd_pcm_status_user32(substream, argp, false);
 	case SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT32:
 		return snd_pcm_status_user32(substream, argp, true);
-	case SNDRV_PCM_IOCTL_SYNC_PTR32:
-		return snd_pcm_ioctl_sync_ptr_compat(substream, argp);
 	case SNDRV_PCM_IOCTL_CHANNEL_INFO32:
 		return snd_pcm_ioctl_channel_info_compat(substream, argp);
 	case SNDRV_PCM_IOCTL_WRITEI_FRAMES32:
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 213f0e6..6d19e028 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -162,7 +162,8 @@ static void xrun(struct snd_pcm_substream *substream)
 		struct timespec64 tstamp;
 
 		snd_pcm_gettime(runtime, &tstamp);
-		runtime->status->tstamp = timespec64_to_timespec(tstamp);
+		runtime->status->tstamp.tv_sec = tstamp.tv_sec;
+		runtime->status->tstamp.tv_nsec = tstamp.tv_nsec;
 	}
 	snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
 	if (xrun_debug(substream, XRUN_DEBUG_BASIC)) {
@@ -253,10 +254,12 @@ static void update_audio_tstamp(struct snd_pcm_substream *substream,
 		*audio_tstamp = ns_to_timespec64(audio_nsecs);
 	}
 
-	if (!timespec_equal(&runtime->status->audio_tstamp, audio_tstamp)) {
-		runtime->status->audio_tstamp =
-			timespec64_to_timespec(*audio_tstamp);
-		runtime->status->tstamp = timespec64_to_timespec(*curr_tstamp);
+	if (runtime->status->audio_tstamp.tv_sec != audio_tstamp->tv_sec ||
+	    runtime->status->audio_tstamp.tv_nsec != audio_tstamp->tv_nsec) {
+		runtime->status->audio_tstamp.tv_sec = audio_tstamp->tv_sec;
+		runtime->status->audio_tstamp.tv_nsec = audio_tstamp->tv_nsec;
+		runtime->status->tstamp.tv_sec = curr_tstamp->tv_sec;
+		runtime->status->tstamp.tv_nsec = curr_tstamp->tv_nsec;
 	}
 
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 158e85d..7bb14d5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2820,7 +2820,6 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-#ifdef CONFIG_COMPAT
 struct snd_pcm_mmap_status32 {
 	s32 state;
 	s32 pad1;
@@ -2907,18 +2906,18 @@ static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
 	snd_pcm_stream_unlock_irq(substream);
 	if (put_user(sstatus.state, &src->s.status.state) ||
 	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
-	    compat_put_timespec(&sstatus.tstamp, &src->s.status.tstamp) ||
+	    put_user(sstatus.tstamp.tv_sec, &src->s.status.tstamp.tv_sec) ||
+	    put_user(sstatus.tstamp.tv_nsec, &src->s.status.tstamp.tv_nsec) ||
 	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
-	    compat_put_timespec(&sstatus.audio_tstamp,
-				&src->s.status.audio_tstamp) ||
+	    put_user(sstatus.audio_tstamp.tv_sec, &src->s.status.audio_tstamp.tv_sec) ||
+	    put_user(sstatus.audio_tstamp.tv_nsec, &src->s.status.audio_tstamp.tv_nsec) ||
 	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
 	    put_user(scontrol.avail_min, &src->c.control.avail_min))
 		return -EFAULT;
 
 	return 0;
 }
-#define __SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct snd_pcm_sync_ptr32),
-#endif
+#define __SNDRV_PCM_IOCTL_SYNC_PTR32 _IOWR('A', 0x23, struct snd_pcm_sync_ptr32)
 
 static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
 {
@@ -3092,7 +3091,9 @@ static int snd_pcm_common_ioctl(struct file *file,
 			return -EFAULT;
 		return 0;
 	}
-	case SNDRV_PCM_IOCTL_SYNC_PTR:
+	case __SNDRV_PCM_IOCTL_SYNC_PTR32:
+		return snd_pcm_ioctl_sync_ptr_compat(substream, arg);
+	case __SNDRV_PCM_IOCTL_SYNC_PTR64:
 		return snd_pcm_sync_ptr(substream, arg);
 #ifdef CONFIG_SND_SUPPORT_OLD_API
 	case SNDRV_PCM_IOCTL_HW_REFINE_OLD:
@@ -3472,8 +3473,6 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
 
 static bool pcm_status_mmap_allowed(struct snd_pcm_file *pcm_file)
 {
-	if (pcm_file->no_compat_mmap)
-		return false;
 	/* See pcm_control_mmap_allowed() below.
 	 * Since older alsa-lib requires both status and control mmaps to be
 	 * coupled, we have to disable the status mmap for old alsa-lib, too.
@@ -3686,11 +3685,19 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 
 	offset = area->vm_pgoff << PAGE_SHIFT;
 	switch (offset) {
-	case SNDRV_PCM_MMAP_OFFSET_STATUS:
+	case SNDRV_PCM_MMAP_OFFSET_STATUS_OLD:
+		if (pcm_file->no_compat_mmap || !IS_ENABLED(CONFIG_64BIT))
+			return -ENXIO;
+		/* fallthrough */
+	case SNDRV_PCM_MMAP_OFFSET_STATUS_NEW:
 		if (!pcm_status_mmap_allowed(pcm_file))
 			return -ENXIO;
 		return snd_pcm_mmap_status(substream, file, area);
-	case SNDRV_PCM_MMAP_OFFSET_CONTROL:
+	case SNDRV_PCM_MMAP_OFFSET_CONTROL_OLD:
+		if (pcm_file->no_compat_mmap || !IS_ENABLED(CONFIG_64BIT))
+			return -ENXIO;
+		/* fallthrough */
+	case SNDRV_PCM_MMAP_OFFSET_CONTROL_NEW:
 		if (!pcm_control_mmap_allowed(pcm_file))
 			return -ENXIO;
 		return snd_pcm_mmap_control(substream, file, area);
@@ -3850,9 +3857,9 @@ static unsigned long snd_pcm_get_unmapped_area(struct file *file,
 	unsigned long offset = pgoff << PAGE_SHIFT;
 
 	switch (offset) {
-	case SNDRV_PCM_MMAP_OFFSET_STATUS:
+	case SNDRV_PCM_MMAP_OFFSET_STATUS_NEW:
 		return (unsigned long)runtime->status;
-	case SNDRV_PCM_MMAP_OFFSET_CONTROL:
+	case SNDRV_PCM_MMAP_OFFSET_CONTROL_NEW:
 		return (unsigned long)runtime->control;
 	default:
 		return (unsigned long)runtime->dma_area + offset;
-- 
1.7.9.5
