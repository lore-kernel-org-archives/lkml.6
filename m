Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+g+KvGXcIWitg0EO7H8/r66xTHqncgS8SXipgI373xXo2Qg4UR6FpFuvIgwFx3qGfLnYqj
ARC-Seal: i=1; a=rsa-sha256; t=1522168725; cv=none;
        d=google.com; s=arc-20160816;
        b=llEplTUsj4sG/rLxFWcPS7tEok/v1Bbo6bvRdxkUGyA9rwDgfbeX02v5hQPPJ8Xet0
         pbGrfGbpiPTo2xzZlBmijO0sM0TlvETv6Rubv5o8mP5bMhuUnPc84HPGwMZ3QUXmBjCa
         5WTVdPLpM7DeMR8O9xfeg8zIkfGmzTHIC86pekN4ENR5nOKy6EsKOs/5ZzfNcFAYDvlj
         S7omr2Uj/oIYCJPTeWmeKGqRgDbl791D/3VNaXTBMjnvKKO5k9WIvKY4VjIXcp+UVTA4
         9HA4A3TJ8k0aVTk15Ba9xMkZza3/xpOO26IN4ocuLSvfmusB/tXUDL+GEn36Wc6V8utv
         /naA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mAaxx8W25p2iwaZKkMfJeTbRIoaKotYPqaKBRuzs5bI=;
        b=P2ysP8bFQc+uszaxcvWj1TCbcisU+HIdzrTC9c/RaAF7TtSBZCQPTObQDmll1hdL6m
         aH3QXXQ+8wWvFwTf49YSHMzW1qAkK43lddJ8AlzU0Bkubwf5yYNo6nxyhBwQjWQJMMDI
         QZaADLUO4hsxoc6BR6vzBR/bct2J0SqvoxgobpxXLjHc0nwSjpgrmiZTj+gbGEK3HRQF
         +/kPQQVbbOUiRAlCcZZmlYWOVyk4G+cvZDt1R/YrxOCUP/iahwAKhnEN5OxbifYy+8zx
         VTP9qnCZ/LWtprMw8mEnxV54owz8jA+TA1n0JxO38tSzj3RlKb+GBAybVocosc9DMR2+
         JGTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 010/105] ALSA: aloop: Sync stale timer before release
Date: Tue, 27 Mar 2018 18:26:50 +0200
Message-Id: <20180327162758.275427660@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108966146987882?=
X-GMAIL-MSGID: =?utf-8?q?1596109593982571296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -744,7 +751,7 @@ static int loopback_close(struct snd_pcm
 	struct loopback *loopback = substream->private_data;
 	struct loopback_pcm *dpcm = substream->runtime->private_data;
 
-	loopback_timer_stop(dpcm);
+	loopback_timer_stop_sync(dpcm);
 	mutex_lock(&loopback->cable_lock);
 	free_cable(substream);
 	mutex_unlock(&loopback->cable_lock);
