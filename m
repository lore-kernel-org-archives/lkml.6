Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1A5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4212173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="zcbQYQu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfA1Nbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:31:53 -0500
Received: from mail1.perex.cz ([77.48.224.245]:44304 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfA1Nbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:31:52 -0500
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D14BCA003F;
        Mon, 28 Jan 2019 14:31:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D14BCA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1548682308; bh=3vE8vR9Zjf5cupztn5uK8ddS0qmSzYx1A3xQUYqXM5s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zcbQYQu1NgdKhIuv8k1/DTm495Yn5WUzsuZxPRHKgH7xPnUKlplLNHtkJt6lbHLJq
         +alRTePPcsFwPdFoX+ST9d3v10BLDvdqb61O1pYY8uSfyezqd5oQjksTgfUeIsHwsR
         fC6ZacTlDl4bjye74fp97BIMW1LGAsEcS94xlYY8=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 28 Jan 2019 14:31:23 +0100 (CET)
Subject: Re: [alsa-devel] [RFC PATCH] ALSA: core: Add DMA share buffer support
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        gustavo@embeddedor.com, srinivas.kandagatla@linaro.org,
        mchehab+samsung@kernel.org, sr@denx.de, daniel.thompson@linaro.org,
        corbet@lwn.net, philburk@google.com, willy@infradead.org,
        jmiller@neverware.com, keescook@chromium.org, arnd@arndb.de,
        colyli@suse.de, ckeepax@opensource.wolfsonmicro.com,
        anna-maria@linutronix.de, mathieu.poirier@linaro.org,
        Baolin Wang <baolin.wang@linaro.org>, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Leo Yan <leo.yan@linaro.org>, joe@perches.com
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk> <s5hzhrxzrez.wl-tiwai@suse.de>
 <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
 <20190122202535.GK7579@sirena.org.uk> <s5h4l9z4mbo.wl-tiwai@suse.de>
 <20190123124658.GE15906@leoy-ThinkPad-X240s> <s5himyczxgl.wl-tiwai@suse.de>
 <20190125182515.GD6939@sirena.org.uk>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <b8750850-17c4-9ced-06e5-6d957d953b5f@perex.cz>
Date:   Mon, 28 Jan 2019 14:31:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190125182515.GD6939@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 25.1.2019 v 19:25 Mark Brown napsal(a):
> On Fri, Jan 25, 2019 at 02:19:22PM +0100, Takashi Iwai wrote:
>> Leo Yan wrote:
> 
>>> If we directly use the device node /dev/snd/ as file descriptor, even
>>> though we specify flag O_EXCL when open it, but it still is not an
>>> anon inode file descriptor.  Thus this is not safe enough and will be
>>> blocked by SELinux.  On the other hand, this patch wants to use
>>> dma-buf framework to provide file descriptor for the audio buffer, and
>>> this audio buffer can be one of mutiple audio buffers in the system
>>> and it can be shared to any audio client program.
> 
>> Hrm, it sounds like a workaround just to bypass SELinux check...
> 
>> The sound server can open another PCM stream with O_APPEND, and pass
>> that fd to the client, too?
> 
> So long as we can teach SELinux that they're safe to export, yeah.

It seems that SELinux works with the file, so the SELinux will block the
fd pass, because the file descriptor (through standard dup()) continues
to use the /dev/snd inode.

I would propose to implement a dup ioctl to return a new
anon_inode:snd-pcm file descriptor (see bellow).

If we agree on this, I can propose the full solution.

--
Subject: [PATCH] ALSA: pcm: implement the anonymous dup (inode file
 descriptor)

This patch implements new SNDRV_PCM_IOCTL_ANONYMOUS_DUP ioctl which
returns the new duplicated anonymous inode file descriptor
(anon_inode:snd-pcm) which can be passed to the restricted clients.

This implementation is just a concept for comments - it does not contain
the additional restriction control.

TODO: The clients might be restricted to disallow a set of
controls (ioctls) for the audio stream.

This patch is meant to be the alternative for the dma-buf interface. Both
implementation have some pros and cons:

anon_inode:dmabuf

- a bit standard export API for the DMA buffers
- fencing for the concurrent access [1]
- driver/kernel interface for the DMA buffer [1]
- multiple attach/detach scheme [1]

[1] the real usage for the sound PCM is unknown at the moment for this feature

anon_inode:snd-pcm

- simple (no problem with ref-counting, non-standard mmap implementation etc.)
- allow to use more sound interfaces for the file descriptor like status ioctls
- more fine grained security policies (another anon_inode name unshared with
  other drivers)
---
 include/uapi/sound/asound.h |  1 +
 sound/core/pcm_compat.c     |  1 +
 sound/core/pcm_native.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 404d4b9ffe76..ad821a52f970 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -576,6 +576,7 @@ enum {
 #define SNDRV_PCM_IOCTL_TSTAMP		_IOW('A', 0x02, int)
 #define SNDRV_PCM_IOCTL_TTSTAMP		_IOW('A', 0x03, int)
 #define SNDRV_PCM_IOCTL_USER_PVERSION	_IOW('A', 0x04, int)
+#define SNDRV_PCM_IOCTL_ANONYMOUS_DUP   _IOW('A', 0x05, int)
 #define SNDRV_PCM_IOCTL_HW_REFINE	_IOWR('A', 0x10, struct snd_pcm_hw_params)
 #define SNDRV_PCM_IOCTL_HW_PARAMS	_IOWR('A', 0x11, struct snd_pcm_hw_params)
 #define SNDRV_PCM_IOCTL_HW_FREE		_IO('A', 0x12)
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 946ab080ac00..22446cd574ee 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -675,6 +675,7 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 	case SNDRV_PCM_IOCTL_TSTAMP:
 	case SNDRV_PCM_IOCTL_TTSTAMP:
 	case SNDRV_PCM_IOCTL_USER_PVERSION:
+	case SNDRV_PCM_IOCTL_ANONYMOUS_DUP:
 	case SNDRV_PCM_IOCTL_HWSYNC:
 	case SNDRV_PCM_IOCTL_PREPARE:
 	case SNDRV_PCM_IOCTL_RESET:
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 26afb6b0889a..a21bb482b4b0 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -37,6 +37,8 @@
 #include <sound/minors.h>
 #include <linux/uio.h>
 #include <linux/delay.h>
+#include <linux/anon_inodes.h>
+#include <linux/syscalls.h>

 #include "pcm_local.h"

@@ -2836,6 +2838,42 @@ static int snd_pcm_forward_ioctl(struct snd_pcm_substream *substream,
 	return result < 0 ? result : 0;
 }

+static int snd_pcm_anonymous_dup(struct file *file,
+				 struct snd_pcm_substream *substream,
+				 int __user *arg)
+{
+	int fd;
+	int res;
+	int dup_mode;
+	int flags;
+	struct file *nfile;
+	struct snd_pcm_substream *rsubstream;
+
+	if (get_user(dup_mode, (int __user *)arg))
+		return -EFAULT;
+	if (dup_mode != 0)
+		return -ENOSYS;
+	flags = file->f_flags & (O_RDWR|O_NONBLOCK);
+	flags |= O_APPEND | O_CLOEXEC;
+	fd = get_unused_fd_flags(flags);
+	if (fd < 0)
+		return fd;
+	nfile = anon_inode_getfile("snd-pcm", file->f_op, NULL, flags);
+	if (IS_ERR(nfile)) {
+		put_unused_fd(fd);
+		return PTR_ERR(nfile);
+	}
+	fd_install(fd, nfile);
+	res = snd_pcm_open_substream(substream->pcm, substream->number,
+				     nfile, &rsubstream);
+	if (res < 0) {
+		ksys_close(fd);
+		return res;
+	}
+	put_user(fd, (int __user *)arg);
+	return 0;
+}
+
 static int snd_pcm_common_ioctl(struct file *file,
 				 struct snd_pcm_substream *substream,
 				 unsigned int cmd, void __user *arg)
@@ -2864,6 +2902,8 @@ static int snd_pcm_common_ioctl(struct file *file,
 			     (unsigned int __user *)arg))
 			return -EFAULT;
 		return 0;
+	case SNDRV_PCM_IOCTL_ANONYMOUS_DUP:
+		return snd_pcm_anonymous_dup(file, substream, (int __user *)arg);
 	case SNDRV_PCM_IOCTL_HW_REFINE:
 		return snd_pcm_hw_refine_user(substream, arg);
 	case SNDRV_PCM_IOCTL_HW_PARAMS:
-- 

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
