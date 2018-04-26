Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756148AbeDZMpq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:45:46 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755873AbeDZMpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:45:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp, alsa-devel@alsa-project.org,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 4/4] ALSA: Deprecate CLOCK_REALTIME timestamps
Date: Thu, 26 Apr 2018 14:44:22 +0200
Message-Id: <20180426124422.2921744-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180426124422.2921744-1-arnd@arndb.de>
References: <20180426124422.2921744-1-arnd@arndb.de>
X-Provags-ID: V03:K1:p7oOHxqsY0PquRttUOx8oMhfBUij6xId9+ve+ooS9bGlKjv4uir
 rWYd46+5vcYGx3IWNxO3i7VFNI1Tixr3hcM/osA/3TGUP0t93pSAKlnhQq5BggTH+HRwk4R
 pW7qLPEoEBnlSMKF0zJDhjI5sIAH/q5r1Oma1R9Ey4DLlJU8ZSnY4zsDsEq7+KWiE3BHBJb
 zZJ4uebvhjRhM0uCvZmPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wciMYjq1mik=:/4cwklliaRmkOhBMJoFzne
 yGQpdC7dNjDknEbnar1L/RMraLjTm2UOGy0KLkXSqPgdvzpXjEiuso4CnaFKo7DQhevP+qCuT
 FddkHC9RYNzYfzbYCAGLXBLItBwx0ESGwWxyfxMn8lLRX71Rf7wiGFPRw984t0ZdYR1TzWdHx
 BLQwdSGibIYmJIyTwnrbpXDo4J9XgxHPI6k/OqLC3WaUsmiUjSDgb4cb6yTf80karDwz6Vg12
 7uHwMXDVa48N4EXOgV/dkThj9T6QDUZgxQ61+cGZtRQfX1Av0/nP7lw0xqsuvRWWdxWHKcBM9
 2ry3LYTSQZ7Rjdrb2xvxZDP+emElfHm3t8OWSicm4k+GkvgNh4VdY5jSAKrhDQaxsKdO6SYe7
 Ua0exH3WIwOZ7Lk3lFK31I2dUjgrQHWitRruNR18LOP01GxYtzVQYOorHGukrPhENS3afo2lW
 2gAg8WA2Rnh64y402jdtnub/miURJlL3igQcYZLb95h5VKEmQYdsi4Dev9EY2ZNmXA7RVChpu
 6dLlBl7ksU2HtfQuw0ZYwYf/XtVV3edn3YaktKgIi8KlYTQ+fj60OfgRfzNrxFM0MLxIsYxVo
 /bolfU7CB7XLKnIys+2IDhx7oOFZJy8HpqLsPMm14yR5c7NhFy+33FwK+/UGmxzLe26Mkz/wg
 GsCQUqPRRXHIIJvqtiRMBaA2oKyeZMn2O6sXCoHr6hEm4huChNnvf+lAhNRPRgcHNAfg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has supported monotonic timestamps since linux-2.6.25,
but it still defaults to CLOCK_REALTIME, which has multiple problems:
It skips backwards for every leap second, it may skip at any time from
settimeofday() or NTP updates, and it overflows in year 2038.

alsa-lib already tries to use monotonic timestamps whenever they are
available, so user space should generally be fine with it.

To be on the safe side, I'm adding a Kconfig option that allows retaining
the current behavior, while making the default to disallow CLOCK_REALTIME
stamps. That default makes sense because of the decision to not extend
the ioctl interface to 64-bit time stamps. We need today's kernels to
run beyond 2038 in certain embedded markets, so it's better to discover
any possible problems now rather than running into them only after time
stamps overflow.

I'm defaulting to SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW behavior rather
than SNDRV_PCM_TSTAMP_TYPE_MONOTONIC since the latter is not supported
by the HDA hardware timestamps.

A similar change was done in the DRM subsystem and it turned out that
nothing relied on CLOCK_REALTIME behavior for their timestamps, and the
option was subsequently removed. If the same turns out to be true here,
we can do the same and clean it out in a few years.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/pcm.h            |  4 ++++
 include/uapi/sound/asound.h    |  4 +++-
 sound/core/Kconfig             | 11 +++++++++++
 sound/core/pcm.c               |  3 +++
 sound/core/pcm_native.c        | 10 ++++++++++
 sound/pci/hda/hda_controller.c |  4 ++++
 6 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 973d6745217a..5d5daa190b08 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1190,7 +1190,11 @@ static inline void snd_pcm_gettime(struct snd_pcm_runtime *runtime,
 		getrawmonotonic64(tv);
 		break;
 	default:
+#ifdef CONFIG_SND_TSTAMP_REALTIME
 		ktime_get_real_ts64(tv);
+#else
+		ktime_get_ts64(tv);
+#endif
 		break;
 	}
 }
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 9c61cf77beb8..1d8546731306 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -542,8 +542,10 @@ struct snd_xfern {
 };
 
 enum {
+#if !(__BITS_PER_LONG == 32 && defined(__USE_TIME_BITS64))
 	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
-	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
+#endif
+	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC = 1,	/* posix_clock_monotonic equivalent */
 	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,    /* monotonic_raw (no NTP) */
 	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 };
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 6e937a8146a1..6dedb0661fa4 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -100,6 +100,17 @@ config SND_HRTIMER
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-hrtimer.
 
+config SND_TSTAMP_REALTIME
+	bool "allow CLOCK_REALTIME timestamps"
+	help
+	  Say Y here if you have user space applications that rely on
+	  the traditional CLOCK_REALTIME based timestamps rather than
+	  using CLOCK_MONOTONIC or CLOCK_MONOTONIC_RAW.
+	  CLOCK_REALTIME has problems with overflow in year 2038, with
+	  leap seconds and concurrent time updates (e.g. through NTP).
+
+	  If unsure, say N.
+
 config SND_DYNAMIC_MINORS
 	bool "Dynamic device file minor numbers"
 	help
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 66ac89aad681..aaed96566bde 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1028,6 +1028,9 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 
 	init_waitqueue_head(&runtime->sleep);
 	init_waitqueue_head(&runtime->tsleep);
+#ifdef CONFIG_SND_TSTAMP_REALTIME
+	runtime->tstamp_type = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW;
+#endif
 
 	runtime->status->state = SNDRV_PCM_STATE_OPEN;
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index d27c6252e14c..a2196208b057 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -811,6 +811,11 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
 	if (params->proto >= SNDRV_PROTOCOL_VERSION(2, 0, 12) &&
 	    params->tstamp_type > SNDRV_PCM_TSTAMP_TYPE_LAST)
 		return -EINVAL;
+#ifndef CONFIG_SND_TSTAMP_REALTIME
+	/* all other types are invalid here, and fall back to raw mono */
+	if (params->tstamp_type != SNDRV_PCM_TSTAMP_TYPE_MONOTONIC)
+		params->tstamp_type = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW;
+#endif
 	if (params->avail_min == 0)
 		return -EINVAL;
 	if (params->silence_size >= runtime->boundary) {
@@ -2769,6 +2774,11 @@ static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
 		return -EFAULT;
 	if (arg < 0 || arg > SNDRV_PCM_TSTAMP_TYPE_LAST)
 		return -EINVAL;
+#ifndef CONFIG_SND_TSTAMP_REALTIME
+	/* all other types are invalid here, and fall back to raw mono */
+	if (arg != SNDRV_PCM_TSTAMP_TYPE_MONOTONIC)
+		arg = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW;
+#endif
 	runtime->tstamp_type = arg;
 	return 0;
 }
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index c3e45168b848..a2fca77582d5 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -543,7 +543,11 @@ static int azx_get_time_info(struct snd_pcm_substream *substream,
 			break;
 
 		default:
+#ifdef CONFIG_SND_TSTAMP_REALTIME
 			*system_ts = ktime_to_timespec64(xtstamp.sys_realtime);
+#else
+			*system_ts = ktime_to_timespec64(xtstamp.sys_monoraw);
+#endif
 			break;
 
 		}
-- 
2.9.0
