Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo60I0xVuq9GF016Q9DQVkzx1r4Sj8gaWuE0YtEu+LJLVpG9LNsIy1U6a0tV1+cTTI03k3F
ARC-Seal: i=1; a=rsa-sha256; t=1526280609; cv=none;
        d=google.com; s=arc-20160816;
        b=NgeR0M4MQblEjiFM0GTW8rCLuDs/bO89KOuJ9zE7ddh+ptMWD80Xtdiily9OoEoDRV
         TkHDij5HmdIVPTVNVsJxx2Gwk0NNNdfhOggz7BAZWN72x2ms75ALOge86xGdq5uAEKws
         40+RVZGShgX3PGnHyB71aNxSvgusoV7M9M0KI9OdkoVyn5Sy+UeZzopHMdkXtDgzCQdc
         xw0vx5en7YlvWMKj39dDKBJ5z6/fB2nezKdpW2NB2IIgh6qvQH3kVhsZgq1aCgniODa3
         GwPvlPRe6EqJXbeunLYdpmebCqB26qfZQGSZamMQ3ujOSHuaOdpOeOHhUhMx/J7/4iGa
         aF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=cPtPTIA8KmwXvSQmQxFD42QZxqLoKC3IcPAAObZsQIA=;
        b=cCxxuYI9A+ts0xWrjncrg4qYSQxs5Sh4PZO0wnoxrXbYXwlPa2FexOGF4qHV4vK8CO
         4vI3n6aPPzDFxE6LQMet/wgpjahPGfJNSrAOgYtMci2x/pUsA4RtH9qG/Hx/oNtAFqaQ
         J0x4h2PC/AXVX1F9W2p9QdMqEyPbfuuWF0Xe731t+px9MJNQId8+3FgWxRmdQkHxeWR2
         Rk+NgcWGnEnMovL/H7xD3iln/Kc2vakxtpAeMtc+dATZBux5RS1tPFrq6baAC85ftB0w
         l4Ndk+74h/qW00KdZB5PHRNR7D2yZ7WLRmbGXfDPM9V8Lhgqwmf5VGnP/WgGgUhElnVT
         vG0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zln3ObOV;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zln3ObOV;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Rosengren <robert.rosengren@axis.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 06/23] ALSA: aloop: Mark paused device as inactive
Date: Mon, 14 May 2018 08:48:35 +0200
Message-Id: <20180514064704.324642743@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421216565384824?=
X-GMAIL-MSGID: =?utf-8?q?1600421216565384824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -297,6 +297,8 @@ static int loopback_trigger(struct snd_p
 		cable->pause |= stream;
 		loopback_timer_stop(dpcm);
 		spin_unlock(&cable->lock);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			loopback_active_notify(dpcm);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -305,6 +307,8 @@ static int loopback_trigger(struct snd_p
 		cable->pause &= ~stream;
 		loopback_timer_start(dpcm);
 		spin_unlock(&cable->lock);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			loopback_active_notify(dpcm);
 		break;
 	default:
 		return -EINVAL;
@@ -894,9 +898,11 @@ static int loopback_active_get(struct sn
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
