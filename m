Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZon8cnn1oja2DGPzcVYVekhCn7IQW8znDKwKm4KT2mHARvTrYnfGrAvKDOCaSvU1y/9UwPz
ARC-Seal: i=1; a=rsa-sha256; t=1526280671; cv=none;
        d=google.com; s=arc-20160816;
        b=HUxVwXyrQ0sWZ8Skz2RGJSiUggOZl8gVIU3baaAKNMEAmqVi9yUTbBPawoS1nY4D8t
         7oihVrqz9fCsL4pxValBDHdoTJ/1JjUqFpeDd1/EpCxYfFA321QUUwf73/QOK/yKYtt5
         g3Md7F+sblOTo/ok4iGzkKkDq0HpeR3iCgXxQC2OBk4heNf7Fqug7ZFJjv0CwcBOZvZU
         fIkV2UJtXAwhe7foCJHWrziufOsJ3J+OcMb1fDrkT8UBMf5/YuFFc1VBOQs+WZv6T/9N
         jrvj+AWvnwQxoYRDUwTOQhhVRa06QY6D8vXDDqaWULw+kPNfi8hTW++QnWDdeE1e6n58
         hLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=H4FUpsxVXtxclztDwJTvxA7J+EkULg4kIyCvnGbds48=;
        b=QBmilIqNRPgCE1Py7llPR7K8nbK0kKdEbhyO2HnRK0OYoHjNybjCDFcCIME5NVJwWa
         EZ71KI58b3BGPPxw9U3tv9+hF7CLSI3lTv+vko6RtbcCPDoU1NOYgtGwAx1lPnD0KF+B
         y+QMal3vqnae5EwvLq20AZOhPrNQ5H8lZ4aSuaHyixg6NUM9qzRQ+2GoMcZzIIRwOy7k
         zexg3YtjCwt7avvqyukY2wNIiA543nOsCUkkv5XRHqc90PSgb07KS+teCFIVDjCtqz7w
         4wnLMFdIqVu3mM1JDhGXSveZB/REliqaNm3EnX75Pl8wcrQzkhmQVS8PIBNBQwdTKfDg
         FDug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BHTnLNEq;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BHTnLNEq;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Rosengren <robert.rosengren@axis.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 14/56] ALSA: aloop: Mark paused device as inactive
Date: Mon, 14 May 2018 08:48:19 +0200
Message-Id: <20180514064756.432450083@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421216565384824?=
X-GMAIL-MSGID: =?utf-8?q?1600421281261916357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
