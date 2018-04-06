Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49IVvqImGL8zx6OrZx6RyikXKffwJ6U/104fAli5CN/sLfSOyM2BdGunS3B50et6BYnOCwN
ARC-Seal: i=1; a=rsa-sha256; t=1523021115; cv=none;
        d=google.com; s=arc-20160816;
        b=IQq8KhxPyLPIzfTaBMgNn4KKHfvV8rg3mr9uGWUhqiF7ZOvsl6Rs+9Jhzmdy9feOky
         cbLucgAcWoEeFAcksKR/njpPVFOK6dNb/KGg+/rkvrr878j7D3EDh8+c7o2gWCq3eYUI
         uHfZEM/D+VvRXmUGpvZ+C00B7hnFQIHDzOxf20X9PxbsuTsU9GieVXBRXtpeo/73a7D6
         9KtQuPydkLm0asnUvE3Orhqp0jiOmEWuEEyJV20URVk1lWMyuOUCJsmx9294fvzzPWrh
         MwFnBPB4tgfEPhalniKnF0vPjbr64ykPg+F/72REiBTQICGKvLBI+lCuwFYFE6XYFZnZ
         b+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xclvzu+614zQuYz/sR+cO0c5oA4M5xlRIy4ph92NZ5w=;
        b=XpBkjBLgdae/JIKiJLsodTOBwYHIHxa2LBn5VkFGLj95eWUGD9zI4tOXRK633aX3L9
         fe6VK2G9qecYsGgRtvcocXagxjfF34lb22MfgWUrVezNc0BlHjeHLh0dtZHlPWHW6aVA
         rDbtc321YLOOEbtZuwKPdwTqd76jFANbPuNxTekK00I3QbIktsqfWTcyxjvHwv+rC1Bo
         aNvvAw9r1cSFNGoeyLUSS0pWO6Xtw0I75YKcjRuTJzL8NpgatyuFci6m8oxruOKkwIFj
         Q7iH6SLtj2s58vR0+W+8txEYMy6SvvF94uxp7E92pnXaw5+hp96gDJ/q5TEue18PquLy
         JkTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 03/93] ALSA: aloop: Fix access to not-yet-ready substream via cable
Date: Fri,  6 Apr 2018 15:22:32 +0200
Message-Id: <20180406084225.112487482@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003389336109965?=
X-GMAIL-MSGID: =?utf-8?q?1597003389336109965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -667,7 +667,9 @@ static void free_cable(struct snd_pcm_su
 		return;
 	if (cable->streams[!substream->stream]) {
 		/* other stream is still alive */
+		spin_lock_irq(&cable->lock);
 		cable->streams[substream->stream] = NULL;
+		spin_unlock_irq(&cable->lock);
 	} else {
 		/* free the cable */
 		loopback->cables[substream->number][dev] = NULL;
@@ -707,7 +709,6 @@ static int loopback_open(struct snd_pcm_
 		loopback->cables[substream->number][dev] = cable;
 	}
 	dpcm->cable = cable;
-	cable->streams[substream->stream] = dpcm;
 
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
 
@@ -739,6 +740,11 @@ static int loopback_open(struct snd_pcm_
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
