Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqWJe8iZzY+sq5DDZD0GnADy4vfzu/9hj7vgEfrZfnKGlIecbn1V2wB2iWf6IHIx7fM++qg
ARC-Seal: i=1; a=rsa-sha256; t=1525767130; cv=none;
        d=google.com; s=arc-20160816;
        b=ZY6r2V6kU4k1CyjGFeuOh3+gvGEOVTXUaoqX415reTO2cVlB3zrb/vDFqPvmpLNfdn
         pu0nNHbepA7KqFqOTiPiQJlWttG5ZVbxaLmzXUF+g8zf31hBdL+447Mmc7RwJePaGt2Y
         jAxQXQ66xeZOa3KUD3CxT3jgdhboeLkb0O9kx/rB9i+Nhc9tazSvhJvclS+T5qM9vdmp
         gKaPShYgjct9f9gvV+Kc3uT1mu6kM/J4cYLooumzA9X36FowqgNCZ9pwzYefy5b0yveE
         pYMG4P3fQxeBSg/H4mhaoLb9jb9TM6m9QeqZC8uy2fY13hkV/TaKSfAbgcf3l5GCHTfZ
         5GBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=byJPUyF9BNaU/W1J6eU2iGje5WM10k6pkn68KiuzObs=;
        b=qR9yKvZ4t6ONZKqJdA7xAxD0iCWXL1eyt9KRcez89QsWUW6BfGF4mvDeXiVeN9Uvoh
         vb3USQA+tLPv6se1GwTLsxf292OJ/ryNBl2eFxrSyjx9FZi/KUmrm56T1EqOAWjCsLuf
         F8muj1ktfwjGYxkW0xI5MI+dvFfmGYZY/ntXXSEiSHWWtDPhdffgywaYIutGYjPh0pQ5
         xb8r/3+piLbsBteu+d2lrnoay6yXcW4HmRfvFqlT2jpne93X7yoTyv2SG89rIP9c/ckF
         MuyatiN7EYm+y7+SBGfLTVq1pkPTAaI5oRvno0yYNn6iD6HZ7lM533su1S9DuPrhVqQ/
         UFEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TlRkwZ+b;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TlRkwZ+b;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Rosengren <robert.rosengren@axis.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 07/52] ALSA: aloop: Mark paused device as inactive
Date: Tue,  8 May 2018 10:10:05 +0200
Message-Id: <20180508073928.969981342@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882794600699949?=
X-GMAIL-MSGID: =?utf-8?q?1599882794600699949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Rosengren <robert.rosengren@axis.com>

commit 306a4f3ca7f3c7dfa473ebd19d66e40e59d99734 upstream.

Show paused ALSA aloop device as inactive, i.e. the control
"PCM Slave Active" set as false. Notification sent upon state change.

This makes it possible for client capturing from aloop device to know if
data is expected. Without it the client expects data even if playback
is paused.

Signed-off-by: Robert Rosengren <robert.rosengren@axis.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/drivers/aloop.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -296,6 +296,8 @@ static int loopback_trigger(struct snd_p
 		cable->pause |= stream;
 		loopback_timer_stop(dpcm);
 		spin_unlock(&cable->lock);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			loopback_active_notify(dpcm);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -304,6 +306,8 @@ static int loopback_trigger(struct snd_p
 		cable->pause &= ~stream;
 		loopback_timer_start(dpcm);
 		spin_unlock(&cable->lock);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			loopback_active_notify(dpcm);
 		break;
 	default:
 		return -EINVAL;
@@ -892,9 +896,11 @@ static int loopback_active_get(struct sn
 			[kcontrol->id.subdevice][kcontrol->id.device ^ 1];
 	unsigned int val = 0;
 
-	if (cable != NULL)
-		val = (cable->running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ?
-									1 : 0;
+	if (cable != NULL) {
+		unsigned int running = cable->running ^ cable->pause;
+
+		val = (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ? 1 : 0;
+	}
 	ucontrol->value.integer.value[0] = val;
 	return 0;
 }
