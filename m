Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvsZjAHWxZtTSoaU048orC25btsFh2e9MBfhxYMht06tiEfxsiQCdzU8egS9KhpXln84aPA
ARC-Seal: i=1; a=rsa-sha256; t=1522168254; cv=none;
        d=google.com; s=arc-20160816;
        b=Xb5uibmxc8vdhOFC4zr0iytG3CYIF4n+Brhm9037LTlQRipsNCetQ1usRkMI3iDzY3
         O8XbLGj4LMNNSPdVH2qIdV9S1CP4d8MyEF/zvQd/ZY+jN92aXZr7e6itgXk2LwQWZhRo
         Oe3lABxutq9rtJfBrW4gDe27k7fYQ4CG8gel6jgzrHKUYM9L57Q0uNOxCa2UNuU0DuvC
         nu2LIsUEAwYtmLjepLlkEyJRbSojMOm/suiWITRRbUxTMbHGaiZhtTz4Bl+j3Uh/5pWc
         zSAxzcJUZ3m/5s/XlkYQfIqptNjlszv0dI4Zf6nlOCIk0VNz0ZJxIPz5Qhx9UzQiEZgq
         YtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9c0u8kfxUm/1XOMHBcU8Zj/zyNOuEELO7WNuKq8Mopw=;
        b=hF1DkSkY37GIZbWYr+Eb4VLuR3UfErGQFr//LzXAFFtjqIIVlVgGJPWJM914gfcopx
         b8aWennx/pViJHOtDFVYvzXws/l++21GLBlaZGVCBpXVpwTtXbHq5Wxfeqo1+xSMXXho
         oXL3juulRNAkPLLRsEUY+evXdLAjhCacrhHAqmBIkg72MIuRT9dhmN7F7w6NPXw0IANz
         7GUD579qAdHCfwMx66K/WfRCBN8cGXbibX0Cl0ThQ5a4PZ/6gQwkLOHTCiBiEaHiVxzV
         RfvdEYBqqCMxoBBSelOR8YkMdMe/EQGIMDQiU0HBYQOOCeWI9L9ZKyJ9fQE+rp0VQ/c2
         XddA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 04/67] ALSA: aloop: Sync stale timer before release
Date: Tue, 27 Mar 2018 18:26:56 +0200
Message-Id: <20180327162726.923448202@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108966146987882?=
X-GMAIL-MSGID: =?utf-8?q?1596109099745964650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 67a01afaf3d34893cf7d2ea19b34555d6abb7cb0 upstream.

The aloop driver tries to stop the pending timer via timer_del() in
the trigger callback and in the close callback.  The former is
correct, as it's an atomic operation, while the latter expects that
the timer gets really removed and proceeds the resource releases after
that.  But timer_del() doesn't synchronize, hence the running timer
may still access the released resources.

A similar situation can be also seen in the prepare callback after
trigger(STOP) where the prepare tries to re-initialize the things
while a timer is still running.

The problems like the above are seen indirectly in some syzkaller
reports (although it's not 100% clear whether this is the only cause,
as the race condition is quite narrow and not always easy to
trigger).

For addressing these issues, this patch adds the explicit alls of
timer_del_sync() in some places, so that the pending timer is properly
killed / synced.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/drivers/aloop.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -192,6 +192,11 @@ static inline void loopback_timer_stop(s
 	dpcm->timer.expires = 0;
 }
 
+static inline void loopback_timer_stop_sync(struct loopback_pcm *dpcm)
+{
+	del_timer_sync(&dpcm->timer);
+}
+
 #define CABLE_VALID_PLAYBACK	(1 << SNDRV_PCM_STREAM_PLAYBACK)
 #define CABLE_VALID_CAPTURE	(1 << SNDRV_PCM_STREAM_CAPTURE)
 #define CABLE_VALID_BOTH	(CABLE_VALID_PLAYBACK|CABLE_VALID_CAPTURE)
@@ -326,6 +331,8 @@ static int loopback_prepare(struct snd_p
 	struct loopback_cable *cable = dpcm->cable;
 	int bps, salign;
 
+	loopback_timer_stop_sync(dpcm);
+
 	salign = (snd_pcm_format_width(runtime->format) *
 						runtime->channels) / 8;
 	bps = salign * runtime->rate;
@@ -745,7 +752,7 @@ static int loopback_close(struct snd_pcm
 	struct loopback *loopback = substream->private_data;
 	struct loopback_pcm *dpcm = substream->runtime->private_data;
 
-	loopback_timer_stop(dpcm);
+	loopback_timer_stop_sync(dpcm);
 	mutex_lock(&loopback->cable_lock);
 	free_cable(substream);
 	mutex_unlock(&loopback->cable_lock);
