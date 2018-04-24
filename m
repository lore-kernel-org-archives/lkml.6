Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756684AbeDXMIu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:08:50 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38351 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932588AbeDXMHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:07:39 -0400
X-Google-Smtp-Source: AIpwx49OaG5F233LLcu45LOL4d/Qcf69KMZFuctig3dXfQjn2MGQgEQ188zo3zyQsL4ME7Tz/Ln3BA==
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
Subject: [PATCH 5/8] ALSA: Avoid using timespec for struct snd_rawmidi_status
Date: Tue, 24 Apr 2018 20:06:12 +0800
Message-Id: <4b52b5726f66313347519c7e11168f1d0f9b2143.1524570852.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct snd_rawmidi_status will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Thus we introduced 'struct snd_rawmidi_status32' and 'struct snd_rawmidi_status64'
to handle 32bit time_t and 64bit time_t in native mode, which replace
timespec with s64 type.

In compat mode, we renamed or introduced new structures to handle 32bit/64bit
time_t in compatible mode. The 'struct snd_rawmidi_status32' and
snd_rawmidi_ioctl_status32() are used to handle 32bit time_t in compat mode.
'struct compat_snd_rawmidi_status64' is used to handle 64bit time_t.

When glibc changes time_t to 64-bit, any recompiled program will issue ioctl
commands that the kernel does not understand without this patch.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/uapi/sound/asound.h |    1 +
 sound/core/rawmidi.c        |  131 ++++++++++++++++++++++++++++++++++---------
 sound/core/rawmidi_compat.c |   87 ++++++++--------------------
 3 files changed, 126 insertions(+), 93 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index c9afde4..fad66ad 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -650,6 +650,7 @@ struct snd_rawmidi_params {
 
 struct snd_rawmidi_status {
 	int stream;
+	unsigned char pad1[sizeof(time_t) - sizeof(int)];
 	struct timespec tstamp;		/* Timestamp */
 	size_t avail;			/* available bytes */
 	size_t xruns;			/* count of overruns since last status (in bytes) */
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 69616d0..421b899 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -63,6 +63,29 @@
 #define rmidi_dbg(rmidi, fmt, args...) \
 	dev_dbg(&(rmidi)->dev, fmt, ##args)
 
+struct snd_rawmidi_status32 {
+	s32 stream;
+	s32 tstamp_sec;			/* Timestamp */
+	s32 tstamp_nsec;
+	u32 avail;			/* available bytes */
+	u32 xruns;			/* count of overruns since last status (in bytes) */
+	unsigned char reserved[16];	/* reserved for future use */
+};
+
+#define SNDRV_RAWMIDI_IOCTL_STATUS32	_IOWR('W', 0x20, struct snd_rawmidi_status32)
+
+struct snd_rawmidi_status64 {
+	int stream;
+	u8 rsvd[sizeof(time_t) - sizeof(int)]; /* alignment */
+	s64 tstamp_sec;			/* Timestamp */
+	s64 tstamp_nsec;
+	size_t avail;			/* available bytes */
+	size_t xruns;			/* count of overruns since last status (in bytes) */
+	unsigned char reserved[16];	/* reserved for future use */
+};
+
+#define SNDRV_RAWMIDI_IOCTL_STATUS64	_IOWR('W', 0x20, struct snd_rawmidi_status64)
+
 static struct snd_rawmidi *snd_rawmidi_search(struct snd_card *card, int device)
 {
 	struct snd_rawmidi *rawmidi;
@@ -689,7 +712,7 @@ int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 EXPORT_SYMBOL(snd_rawmidi_input_params);
 
 static int snd_rawmidi_output_status(struct snd_rawmidi_substream *substream,
-				     struct snd_rawmidi_status * status)
+				     struct snd_rawmidi_status64 * status)
 {
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 
@@ -702,7 +725,7 @@ static int snd_rawmidi_output_status(struct snd_rawmidi_substream *substream,
 }
 
 static int snd_rawmidi_input_status(struct snd_rawmidi_substream *substream,
-				    struct snd_rawmidi_status * status)
+				    struct snd_rawmidi_status64 * status)
 {
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 
@@ -716,6 +739,80 @@ static int snd_rawmidi_input_status(struct snd_rawmidi_substream *substream,
 	return 0;
 }
 
+static int snd_rawmidi_ioctl_status32(struct snd_rawmidi_file *rfile,
+				      struct snd_rawmidi_status32 __user *argp)
+{
+	int err = 0;
+	struct snd_rawmidi_status32 __user *status = argp;
+	struct snd_rawmidi_status32 status32;
+	struct snd_rawmidi_status64 status64;
+
+	if (copy_from_user(&status32, argp,
+			   sizeof(struct snd_rawmidi_status32)))
+		return -EFAULT;
+
+	switch (status32.stream) {
+	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (rfile->output == NULL)
+			return -EINVAL;
+		err = snd_rawmidi_output_status(rfile->output, &status64);
+		break;
+	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (rfile->input == NULL)
+			return -EINVAL;
+		err = snd_rawmidi_input_status(rfile->input, &status64);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (err < 0)
+		return err;
+
+	status32 = (struct snd_rawmidi_status32) {
+		.stream = status64.stream,
+		.tstamp_sec = status64.tstamp_sec,
+		.tstamp_nsec = status64.tstamp_nsec,
+		.avail = status64.avail,
+		.xruns = status64.xruns,
+	};
+
+	if (copy_to_user(status, &status32, sizeof(*status)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int snd_rawmidi_ioctl_status64(struct snd_rawmidi_file *rfile,
+				      struct snd_rawmidi_status64 __user *argp)
+{
+	int err = 0;
+	struct snd_rawmidi_status64 status;
+
+	if (copy_from_user(&status, argp, sizeof(struct snd_rawmidi_status64)))
+		return -EFAULT;
+
+	switch (status.stream) {
+	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (rfile->output == NULL)
+			return -EINVAL;
+		err = snd_rawmidi_output_status(rfile->output, &status);
+		break;
+	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (rfile->input == NULL)
+			return -EINVAL;
+		err = snd_rawmidi_input_status(rfile->input, &status);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (err < 0)
+		return err;
+	if (copy_to_user(argp, &status,
+			 sizeof(struct snd_rawmidi_status64)))
+		return -EFAULT;
+	return 0;
+}
+
 static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct snd_rawmidi_file *rfile;
@@ -760,32 +857,10 @@ static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long
 			return -EINVAL;
 		}
 	}
-	case SNDRV_RAWMIDI_IOCTL_STATUS:
-	{
-		int err = 0;
-		struct snd_rawmidi_status status;
-		if (copy_from_user(&status, argp, sizeof(struct snd_rawmidi_status)))
-			return -EFAULT;
-		switch (status.stream) {
-		case SNDRV_RAWMIDI_STREAM_OUTPUT:
-			if (rfile->output == NULL)
-				return -EINVAL;
-			err = snd_rawmidi_output_status(rfile->output, &status);
-			break;
-		case SNDRV_RAWMIDI_STREAM_INPUT:
-			if (rfile->input == NULL)
-				return -EINVAL;
-			err = snd_rawmidi_input_status(rfile->input, &status);
-			break;
-		default:
-			return -EINVAL;
-		}
-		if (err < 0)
-			return err;
-		if (copy_to_user(argp, &status, sizeof(struct snd_rawmidi_status)))
-			return -EFAULT;
-		return 0;
-	}
+	case SNDRV_RAWMIDI_IOCTL_STATUS32:
+		return snd_rawmidi_ioctl_status32(rfile, argp);
+	case SNDRV_RAWMIDI_IOCTL_STATUS64:
+		return snd_rawmidi_ioctl_status64(rfile, argp);
 	case SNDRV_RAWMIDI_IOCTL_DROP:
 	{
 		int val;
diff --git a/sound/core/rawmidi_compat.c b/sound/core/rawmidi_compat.c
index e30e30b..c817441 100644
--- a/sound/core/rawmidi_compat.c
+++ b/sound/core/rawmidi_compat.c
@@ -55,19 +55,22 @@ static int snd_rawmidi_ioctl_params_compat(struct snd_rawmidi_file *rfile,
 	return -EINVAL;
 }
 
-struct snd_rawmidi_status32 {
+struct compat_snd_rawmidi_status64 {
 	s32 stream;
-	struct compat_timespec tstamp;
+	u8 rsvd[sizeof(time_t) - sizeof(s32)]; /* alignment */
+	s64 tstamp_sec;
+	s64 tstamp_nsec;
 	u32 avail;
 	u32 xruns;
 	unsigned char reserved[16];
 } __attribute__((packed));
 
-static int snd_rawmidi_ioctl_status_compat(struct snd_rawmidi_file *rfile,
-					   struct snd_rawmidi_status32 __user *src)
+static int snd_rawmidi_ioctl_status_compat64(struct snd_rawmidi_file *rfile,
+					     struct compat_snd_rawmidi_status64 __user *src)
 {
 	int err;
-	struct snd_rawmidi_status status;
+	struct snd_rawmidi_status64 status;
+	struct compat_snd_rawmidi_status64 compat_status;
 
 	if (get_user(status.stream, &src->stream))
 		return -EFAULT;
@@ -89,68 +92,24 @@ static int snd_rawmidi_ioctl_status_compat(struct snd_rawmidi_file *rfile,
 	if (err < 0)
 		return err;
 
-	if (compat_put_timespec(&status.tstamp, &src->tstamp) ||
-	    put_user(status.avail, &src->avail) ||
-	    put_user(status.xruns, &src->xruns))
-		return -EFAULT;
-
-	return 0;
-}
-
-#ifdef CONFIG_X86_X32
-/* X32 ABI has 64bit timespec and 64bit alignment */
-struct snd_rawmidi_status_x32 {
-	s32 stream;
-	u32 rsvd; /* alignment */
-	struct timespec tstamp;
-	u32 avail;
-	u32 xruns;
-	unsigned char reserved[16];
-} __attribute__((packed));
-
-#define put_timespec(src, dst) copy_to_user(dst, src, sizeof(*dst))
-
-static int snd_rawmidi_ioctl_status_x32(struct snd_rawmidi_file *rfile,
-					struct snd_rawmidi_status_x32 __user *src)
-{
-	int err;
-	struct snd_rawmidi_status status;
-
-	if (get_user(status.stream, &src->stream))
-		return -EFAULT;
-
-	switch (status.stream) {
-	case SNDRV_RAWMIDI_STREAM_OUTPUT:
-		if (!rfile->output)
-			return -EINVAL;
-		err = snd_rawmidi_output_status(rfile->output, &status);
-		break;
-	case SNDRV_RAWMIDI_STREAM_INPUT:
-		if (!rfile->input)
-			return -EINVAL;
-		err = snd_rawmidi_input_status(rfile->input, &status);
-		break;
-	default:
-		return -EINVAL;
-	}
-	if (err < 0)
-		return err;
+	compat_status = (struct compat_snd_rawmidi_status64) {
+		.stream = status.stream,
+		.tstamp_sec = status.tstamp_sec,
+		.tstamp_nsec = status.tstamp_nsec,
+		.avail = status.avail,
+		.xruns = status.xruns,
+	};
 
-	if (put_timespec(&status.tstamp, &src->tstamp) ||
-	    put_user(status.avail, &src->avail) ||
-	    put_user(status.xruns, &src->xruns))
+	if (copy_to_user(src, &compat_status, sizeof(*src)))
 		return -EFAULT;
 
 	return 0;
 }
-#endif /* CONFIG_X86_X32 */
 
 enum {
 	SNDRV_RAWMIDI_IOCTL_PARAMS32 = _IOWR('W', 0x10, struct snd_rawmidi_params32),
-	SNDRV_RAWMIDI_IOCTL_STATUS32 = _IOWR('W', 0x20, struct snd_rawmidi_status32),
-#ifdef CONFIG_X86_X32
-	SNDRV_RAWMIDI_IOCTL_STATUS_X32 = _IOWR('W', 0x20, struct snd_rawmidi_status_x32),
-#endif /* CONFIG_X86_X32 */
+	SNDRV_RAWMIDI_IOCTL_STATUS_COMPAT32 = _IOWR('W', 0x20, struct snd_rawmidi_status32),
+	SNDRV_RAWMIDI_IOCTL_STATUS_COMPAT64 = _IOWR('W', 0x20, struct compat_snd_rawmidi_status64),
 };
 
 static long snd_rawmidi_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
@@ -167,12 +126,10 @@ static long snd_rawmidi_ioctl_compat(struct file *file, unsigned int cmd, unsign
 		return snd_rawmidi_ioctl(file, cmd, (unsigned long)argp);
 	case SNDRV_RAWMIDI_IOCTL_PARAMS32:
 		return snd_rawmidi_ioctl_params_compat(rfile, argp);
-	case SNDRV_RAWMIDI_IOCTL_STATUS32:
-		return snd_rawmidi_ioctl_status_compat(rfile, argp);
-#ifdef CONFIG_X86_X32
-	case SNDRV_RAWMIDI_IOCTL_STATUS_X32:
-		return snd_rawmidi_ioctl_status_x32(rfile, argp);
-#endif /* CONFIG_X86_X32 */
+	case SNDRV_RAWMIDI_IOCTL_STATUS_COMPAT32:
+		return snd_rawmidi_ioctl_status32(rfile, argp);
+	case SNDRV_RAWMIDI_IOCTL_STATUS_COMPAT64:
+		return snd_rawmidi_ioctl_status_compat64(rfile, argp);
 	}
 	return -ENOIOCTLCMD;
 }
-- 
1.7.9.5
