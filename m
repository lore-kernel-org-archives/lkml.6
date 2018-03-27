Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/fxaxr43qHm5oiqbXDG7klmwGhTHrMWmsc6aHj9TrNE2KlWNX6fwzO52SFmnV5IdHIBw90
ARC-Seal: i=1; a=rsa-sha256; t=1522168728; cv=none;
        d=google.com; s=arc-20160816;
        b=fMUuLKR0PxsCoF7RizFXCkJRnp58FDYFFuuIiJNH9JzH+6Q6Uwj+BH5ppoAzOjPdLs
         zTEQMCZ0/11lTh9s8Gp4YqJBMeb4lSZ6EbIfD9+RI7bpXunflhdlMIJN6pzZH5BG98cx
         MVlLv55PZ1FFmIiMnErw54U638X9VFZAM/9tzisd+a6q1yut+B5/GTm7/Heu6L2N7c3Y
         Goihef9k4arCZRvK9GZ2mRHptFPHO3ndKWaD20gJr6j2E66z7fOMHB2cWU/BtLyCwIJY
         ylBEcI8PP6WZLz0TvOesBumrgPlZcJ4Jj8C6lkKN9o96BIT0Ql0ONqz0hQKgxLop3/db
         XyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5Lo36IER1d9Q4qIV1YkojUCwRRfSaVDz91xLDGw/+2U=;
        b=RyXflyN59BdcqbBMYK6BtwGJ9j7lYZHA/SWsneXv/+AzhA6SA/OJtzomNE8FMGIM0F
         wsvLP40mImjuKAuSsDVMFeUgIf1Lbv+0YpjiaD92XGS89VNjEgScxogVDJpbfAKuhFEn
         KUgvdPTPyZEoMT0WI9x5zrcRYHbFBTGX4/PMVV8///T38bJpAE/ttRS9cge2AO/YBFjt
         pNgAlYcJ/HU7nGehL7pYTe9NFnFVsjx1ut6dC2FwX4z2thnveE/oX/0hZi9PUssEenMn
         0J1FtuTUIlxICitMM9B/HhPHyOI02L9/JK5ix+qgr33LHAJRstSDtZp+DzhrdoOtY4R+
         cKYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 011/105] ALSA: aloop: Fix access to not-yet-ready substream via cable
Date: Tue, 27 Mar 2018 18:26:51 +0200
Message-Id: <20180327162758.316467864@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108968683856653?=
X-GMAIL-MSGID: =?utf-8?q?1596109596701633699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 8e6b1a72a75bb5067ccb6b56d8ca4aa3a300a64e upstream.

In loopback_open() and loopback_close(), we assign and release the
substream object to the corresponding cable in a racy way.  It's
neither locked nor done in the right position.  The open callback
assigns the substream before its preparation finishes, hence the other
side of the cable may pick it up, which may lead to the invalid memory
access.

This patch addresses these: move the assignment to the end of the open
callback, and wrap with cable->lock for avoiding concurrent accesses.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/drivers/aloop.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -666,7 +666,9 @@ static void free_cable(struct snd_pcm_su
 		return;
 	if (cable->streams[!substream->stream]) {
 		/* other stream is still alive */
+		spin_lock_irq(&cable->lock);
 		cable->streams[substream->stream] = NULL;
+		spin_unlock_irq(&cable->lock);
 	} else {
 		/* free the cable */
 		loopback->cables[substream->number][dev] = NULL;
@@ -705,7 +707,6 @@ static int loopback_open(struct snd_pcm_
 		loopback->cables[substream->number][dev] = cable;
 	}
 	dpcm->cable = cable;
-	cable->streams[substream->stream] = dpcm;
 
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
 
@@ -737,6 +738,11 @@ static int loopback_open(struct snd_pcm_
 		runtime->hw = loopback_pcm_hardware;
 	else
 		runtime->hw = cable->hw;
+
+	spin_lock_irq(&cable->lock);
+	cable->streams[substream->stream] = dpcm;
+	spin_unlock_irq(&cable->lock);
+
  unlock:
 	if (err < 0) {
 		free_cable(substream);
