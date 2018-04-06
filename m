Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Ht3/HUT9mGUHdzOg4kHHCF0oxe4JIFM9hM3CErE/UudKg6Z3s58g7jJOnX7QbSt2OGaNb
ARC-Seal: i=1; a=rsa-sha256; t=1523021112; cv=none;
        d=google.com; s=arc-20160816;
        b=nX3uGb3qkPr+QXVCvzNuqh9AVvN8upVuRHOeX6EnTf0rDMABoZ+QflyQ4aMar2z7e9
         dOtOR2Sv/Ag9DaAdwhtowpXVFcDhrKamLlZDNrqsRpMITv41VUt6hJCFm9G76NdDcLEO
         7FNnsb1hypoqX8BpOfnhdWYOR+xc2mYEOutTNpIAJLOVDgEBQgpMMLwZ88TMeLTwz7/5
         vd+JgACKCSgqPourk9//6nCVgA8WvErBPrqdcBRcdeXmGd22y90vSb+adbw2ljIIM+/d
         E+AWywAXzboj8ZNrzRDBvyTH0crbJiKxzwecd74fmExDDOVyyPN/kgJ/swrA2xk8+/GM
         xJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RyLNTA8uFu9Pq45+lg5y3I31JbaDNI8pcvYpShz/T4c=;
        b=inukjwc7lf1pMOwbJKi5gYIbhnrnnX8uhKgZT+w3ezxEci3iuef/yU4Gk5jhrgnfVv
         9D0sLOA7J/b5fKFB2SC+lI297XKTLWYZvesggojiL8TbLeYB3/8tpY1yWYO+d9sgb+fJ
         yQHr9qO1QfU32s7jSU2fBY9LwOSCiD/YaKd1mpsK+ie4g9Kks0LAlgziNqgUEKjelKeP
         Y5XYmSebL+BcZLo3Iigo/rh05qRByORoQD6mG1Crwuku41OmavVJ8V3dZKDijFZ85uvS
         jUT0xWHsHNeAq0athP86zOYDtRtANrCyPlnaW0DfIn2BX6Zndv4xUaaEjBR3awlj0yAU
         uXHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 02/93] ALSA: aloop: Sync stale timer before release
Date: Fri,  6 Apr 2018 15:22:31 +0200
Message-Id: <20180406084225.074898637@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003386169480341?=
X-GMAIL-MSGID: =?utf-8?q?1597003386169480341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -193,6 +193,11 @@ static inline void loopback_timer_stop(s
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
@@ -327,6 +332,8 @@ static int loopback_prepare(struct snd_p
 	struct loopback_cable *cable = dpcm->cable;
 	int bps, salign;
 
+	loopback_timer_stop_sync(dpcm);
+
 	salign = (snd_pcm_format_width(runtime->format) *
 						runtime->channels) / 8;
 	bps = salign * runtime->rate;
@@ -746,7 +753,7 @@ static int loopback_close(struct snd_pcm
 	struct loopback *loopback = substream->private_data;
 	struct loopback_pcm *dpcm = substream->runtime->private_data;
 
-	loopback_timer_stop(dpcm);
+	loopback_timer_stop_sync(dpcm);
 	mutex_lock(&loopback->cable_lock);
 	free_cable(substream);
 	mutex_unlock(&loopback->cable_lock);
