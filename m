Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp4Mf0m9oEfOD2iuKVvdNwJoJjP+HORp+ULF3wYh4YKBIk4h/+paVcsW3dYIdTrNWYUQB6d
ARC-Seal: i=1; a=rsa-sha256; t=1525767443; cv=none;
        d=google.com; s=arc-20160816;
        b=Gl3mseYFs00V4ZPvaYu7iPCd1zkBqhmPd6BSE77p1wUhrRHd5RxC2lkwdrqm/UEndq
         rmKpQ7+sb+jtW1DNUWs7M7mrhLf74UNQnrVQSflE+N3FxuhonIcC9UsYzz4ECxW1ixFx
         eHRbzXyxTnOIXkv8AVJp0PwoFYLsFzPzofodMnK1u5Wsg4KgYMw5h+Lzfv5A+UyPxFiH
         5TjrBc5pjpdV7aN8A27JXLR53kkEh5/POpbTuBVxfExCVVJ9xS1yQwXVdqWStAob9vCb
         dPxsUQ0NDzAxmZ1gLyELWZYSnWENSlLC9NcDuC/xmGdFgllnUN81W/GHEaPVRwPIIAT7
         wrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=bRRX/ppeCTFoMUgkh+IU/fhGoKkI2YPIHp+tR/Vs0PE=;
        b=mp5aPDfi4IffRA3uMvml5NrCi51ip2WzNS9yDuKc54psXvbUs/Eq3lOoFu7mVECLCv
         PLDDbxD9+JiRH1mnElys00sT2bJViJEuRfGHZVnXnPs10jqnHEEVzRd4Sxvf5KA+jm6Q
         4dxDEc+pS6sV9ZulslsOY32n5VEjBekMriiKSoxPhgCMyIH0wWGo/i7U40sz2/0o09qz
         tNs36eKxFOXF/E/7voBf8ZTU+ZXwtE90e726PEdLowTaxtvkoyRFo2un51oUE4/nF1r4
         uVtZTztv2NzlE+e8AQsARDKmn9BEcsC9T3h1+NV3dQng9x2DBIHNCV6rICKjnx9gzUm9
         qYhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JytgR/Hh;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JytgR/Hh;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Rosengren <robert.rosengren@axis.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 10/32] ALSA: aloop: Mark paused device as inactive
Date: Tue,  8 May 2018 10:10:50 +0200
Message-Id: <20180508074010.473492576@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882794600699949?=
X-GMAIL-MSGID: =?utf-8?q?1599883122635355232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -893,9 +897,11 @@ static int loopback_active_get(struct sn
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
