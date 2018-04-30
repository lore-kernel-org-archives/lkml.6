Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq871Xny68hTeycU+O2eQ7XonnuFiqVuniQ8qZkhvz1EmO3DvFTTiQwPnD1lvGtrdfcUVYY
ARC-Seal: i=1; a=rsa-sha256; t=1525116495; cv=none;
        d=google.com; s=arc-20160816;
        b=dAEVa/H+qns/d2EywBGcwz1F+hXGcMyb6X4tp9ZjEgJOqLK+fzAO9rX6RJQDxLv62y
         yf2+DwdwHomyayEHMkM/e4zEt1osEIabY1pFx0nE7fA/hjCwXw8jK3sAw9nmy5PyVWZA
         fOKlGma4/TZRmQA4GtbZlYzyNz0c0p2lpIWePaHHa6FIHcKhnYsPZi8XESVDppFGpMuG
         Vx4rdvYPm1Ef7CfF1bhexdrgP2mQ17Dpvp3phSP+XqW5Xmb0tkJT3NQygbfKYuBnS8dP
         295lNxbvTCl3ujwkp+3TBT/ZmS9WEGyOo3HYPmaRiqQACzKhnZddzGJ4ZNuR/FH8gKi2
         Z4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=EEORpjBbA404ctVRJ/0C0YgG5deoIM3OCXU0ixSeQu0=;
        b=fjlSwf7ReI8Xnv7c9GNLXEA8wV4OgOH0O9XDIc3g+lAGbO7oTv/C1TePUruqtheRh1
         g8uDGmtVOf+UvlPh3Dz2IFyWyPj+MYbKmlY8x3RLh8vON8wYncSQRF21fflqpPpg1ZsS
         mmLDOfMHlVnlyeXhiKa/uBBEo2An8jU/DIB+QlGam+lOcOfQ/U34TD3xN3dTbO54Hw4s
         0+/Gwfof9CHyLLiR/x/7VW4B7EbKZ8d26s0gdQvK4YEkcN1Xc/YTyU1TBDQ/lajyfvYh
         qEtXVUpTHdRRdDoqnSiAP5CTsHS7KcWFmepcCAHOv/p8s0IFJD2gDRsl5A9sbj5pk5C8
         pQuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AC622E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeffery Miller <jmiller@neverware.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 046/113] ALSA: pcm: Return negative delays from SNDRV_PCM_IOCTL_DELAY.
Date: Mon, 30 Apr 2018 12:24:17 -0700
Message-Id: <20180430184016.993790918@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200491876239874?=
X-GMAIL-MSGID: =?utf-8?q?1599200554729189740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeffery Miller <jmiller@neverware.com>

commit 912e4c332037e7ed063c164985c36fb2b549ea3a upstream.

The commit c2c86a97175f ("ALSA: pcm: Remove set_fs() in PCM core code")
changed SNDRV_PCM_IOCTL_DELAY to return an inconsistent error instead of a
negative delay.  Originally the call would succeed and return the negative
delay.  The Chromium OS Audio Server (CRAS) gets confused and hangs when
the error is returned instead of the negative delay.

Help CRAS avoid the issue by rolling back the behavior to return a
negative delay instead of an error.

Fixes: c2c86a97175f ("ALSA: pcm: Remove set_fs() in PCM core code")
Signed-off-by: Jeffery Miller <jmiller@neverware.com>
Cc: <stable@vger.kernel.org> # v4.13+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_compat.c |    7 ++++---
 sound/core/pcm_native.c |   23 +++++++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -27,10 +27,11 @@ static int snd_pcm_ioctl_delay_compat(st
 				      s32 __user *src)
 {
 	snd_pcm_sframes_t delay;
+	int err;
 
-	delay = snd_pcm_delay(substream);
-	if (delay < 0)
-		return delay;
+	err = snd_pcm_delay(substream, &delay);
+	if (err)
+		return err;
 	if (put_user(delay, src))
 		return -EFAULT;
 	return 0;
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2687,7 +2687,8 @@ static int snd_pcm_hwsync(struct snd_pcm
 	return err;
 }
 		
-static snd_pcm_sframes_t snd_pcm_delay(struct snd_pcm_substream *substream)
+static int snd_pcm_delay(struct snd_pcm_substream *substream,
+			 snd_pcm_sframes_t *delay)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
@@ -2703,7 +2704,9 @@ static snd_pcm_sframes_t snd_pcm_delay(s
 		n += runtime->delay;
 	}
 	snd_pcm_stream_unlock_irq(substream);
-	return err < 0 ? err : n;
+	if (!err)
+		*delay = n;
+	return err;
 }
 		
 static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
@@ -2911,11 +2914,13 @@ static int snd_pcm_common_ioctl(struct f
 		return snd_pcm_hwsync(substream);
 	case SNDRV_PCM_IOCTL_DELAY:
 	{
-		snd_pcm_sframes_t delay = snd_pcm_delay(substream);
+		snd_pcm_sframes_t delay;
 		snd_pcm_sframes_t __user *res = arg;
+		int err;
 
-		if (delay < 0)
-			return delay;
+		err = snd_pcm_delay(substream, &delay);
+		if (err)
+			return err;
 		if (put_user(delay, res))
 			return -EFAULT;
 		return 0;
@@ -3003,13 +3008,7 @@ int snd_pcm_kernel_ioctl(struct snd_pcm_
 	case SNDRV_PCM_IOCTL_DROP:
 		return snd_pcm_drop(substream);
 	case SNDRV_PCM_IOCTL_DELAY:
-	{
-		result = snd_pcm_delay(substream);
-		if (result < 0)
-			return result;
-		*frames = result;
-		return 0;
-	}
+		return snd_pcm_delay(substream, frames);
 	default:
 		return -EINVAL;
 	}
