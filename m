Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrXKYDGpl7x2IQdeqKYhpRytYegJJyP2nJXFf5qllWCOgfFGfbFFJGbigc0NeyObBGGJ7dI
ARC-Seal: i=1; a=rsa-sha256; t=1525116435; cv=none;
        d=google.com; s=arc-20160816;
        b=ED1jzaPdYaGK7K1K3VWoKjFbEPv8p2/bCi2U94pqomGc0qffyP9h5NCugIZ7UgD2uv
         5tcn3LUjMN8N5YG7rc3pjfFXpr0Cb9Wf3g1iQijd9XcXkK4Y45OAT0PQuRZKxwFXhO+C
         gY5jNDH7XbNavt7JrSNyDuuwGVQ+DshIGN/8MRoA/c2JDBXAoa/e7xVKjUJSYbtnVUwz
         VxpVMRXkZlI96GKOtt4F7CntJvEudOknUYBpuIsag6EUxlhkX2ucYcqUlho61j87xPl3
         jxOlS9pQ4izgKLtVAJqPUbOdVAZHnylak77O1uIPuWrWuff3WXSgJ9dq7Kw0nJKbl6HC
         jN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=V5XRDg4yJryQhM9joMsG4dEhM7BttmM9TxqqJ8Ftruc=;
        b=J+paFN7hA5fvsi1u9WJfsPKVgzNLRHeD9l2h6qO6NK098JyOdS5wkjW1G2WZcJC3eM
         DehGJpmaFSEVVz1gm17PbrZg1M1C/6/aJWEWXvtoGNEy0TLLDeyRzBgllR8dfhV6ANs/
         S4gCeIx/4Wo+R4EhVQ+vks0JT8gfekRrYiNTXBOlI0041tmz1Sb9zWId6h3OeH1AIu+u
         REmWRwQm/b+aTC0sRtoe457QtomR/Z8WKRYBqgZH3UKjrNoMwH6/iUVvivAviw45N0aG
         H8SEPbLZKiNRZ4KaJunkMlUxNYtcLN7Yd979sZiQ839wN0tvRKtTQcZAuwLAitf/VnBD
         AzmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E31222DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeffery Miller <jmiller@neverware.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 42/91] ALSA: pcm: Return negative delays from SNDRV_PCM_IOCTL_DELAY.
Date: Mon, 30 Apr 2018 12:24:24 -0700
Message-Id: <20180430184006.379687812@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200491876239874?=
X-GMAIL-MSGID: =?utf-8?q?1599200491876239874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2689,7 +2689,8 @@ static int snd_pcm_hwsync(struct snd_pcm
 	return err;
 }
 		
-static snd_pcm_sframes_t snd_pcm_delay(struct snd_pcm_substream *substream)
+static int snd_pcm_delay(struct snd_pcm_substream *substream,
+			 snd_pcm_sframes_t *delay)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
@@ -2705,7 +2706,9 @@ static snd_pcm_sframes_t snd_pcm_delay(s
 		n += runtime->delay;
 	}
 	snd_pcm_stream_unlock_irq(substream);
-	return err < 0 ? err : n;
+	if (!err)
+		*delay = n;
+	return err;
 }
 		
 static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
@@ -2913,11 +2916,13 @@ static int snd_pcm_common_ioctl(struct f
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
@@ -3005,13 +3010,7 @@ int snd_pcm_kernel_ioctl(struct snd_pcm_
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
