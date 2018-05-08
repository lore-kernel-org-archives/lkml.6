Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZquIRAZKlewp5LWUlbdKIZ2+T8fdOzdz3yjnePpB3CJKP2HwXria7G/ch48XnsREy2Jx6qr
ARC-Seal: i=1; a=rsa-sha256; t=1525767312; cv=none;
        d=google.com; s=arc-20160816;
        b=s8czka4yAK+coRdI/vg0uKRoje6C7uNcZrYLvmF4XP3mSYtB83R+Gxr0pyKivWEi2o
         iGtXODDqoGqVn1/dp4TbEOvL7DTTxAbMNOe4vUiAZ9Gcvsq6g1Nwh/RfnHE7o1S4mtDx
         lZSJUS+N29Hx6HfGtI4JtAyFZHcA4XS1Ig7bmJccS5afaJEVW0tfB9E6PECt6npcAlgr
         9wBMbaNDqRImFtxpScKP1Yv9JRIr8EIJrIIua1gmGI6oVilqLSK4XuRvxrI/iqX3iqlF
         ISfyUxwNaHxzuy+U9i9p+3F9bHaBR1m3TGgR71Q6hfDB6ShjHlTWSu7sZcUAXp1vixiS
         qN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=MwvdR+T4dpYe6VTpfHbLnmTlEnpRB0vGji07QSzizag=;
        b=glVIeSfoKD4ZbJxpcVZEPVwFKVAhNJTBqdTxPH/uhh0alU4KJPO079sJ8IVTmg7yuV
         duAJ4ZO+UCeT3hqkQ6SxFK7TrPDEm8S4fEwwDiZRDUA3l+CAyHD6TU11ysPgGThfWQXp
         OFvhFNN6kaZpDuUYpXa+U7xllWB2whvCF9cZ8QSQIm44fm8ICaOLylktOg0XnZdsBH4V
         ciIM7tTvgGsjyn1A+wOVJxC2WM8ctwgin9H5LfE/H97hU3sSqz9YDplaS93JujfLqAKB
         raJX8mNbT4iLZtcdpYUBhQ6eWrbugFUr63j2XPmmDT3HpoAJlV8d/BqgyyVBVVJeQFX2
         Pavg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=frTuCnLx;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=frTuCnLx;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Rosengren <robert.rosengren@axis.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 11/43] ALSA: aloop: Mark paused device as inactive
Date: Tue,  8 May 2018 10:10:30 +0200
Message-Id: <20180508074005.732715304@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882794600699949?=
X-GMAIL-MSGID: =?utf-8?q?1599882985731674245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
