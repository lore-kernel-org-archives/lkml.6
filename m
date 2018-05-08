Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqJv0IiNm2lu3qEjzXeH7PywEyE45lYMDtMlYtNrC0vi4U/fF2DKYYG/uU3ezInz1FC8gQu
ARC-Seal: i=1; a=rsa-sha256; t=1525767133; cv=none;
        d=google.com; s=arc-20160816;
        b=1JKpR8GwtLCyw0DegFOEtC5i0h8WZrRp6dQ268EvKkWazr8FNxxigz7MQSt+3NjXF7
         64GGlfva9mdkBC21Sb6OzzdCCI3FPsk05zH2uoCpdRJnrYiunZQXaTkimXEsp8UOf6jx
         PCIPbkifVMVu5mVYwA0z0UOPBAxUdm/lyQAvFhTXi+nI3X0KXlSaXAQ5Irt1p0hQykiz
         ezM88+XLUnaFgOsi3x4gYz6355pzSk9RmjWZ4QY8a2iX2LJIQ17lLQhpstR29TzgfmZp
         bmHJq4uxCLfgGt3Dp8X0RxYO/oFKblebomFNi53fjvCYTub5VO8pBwKsrHkxt9nDEjEN
         3NEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=r2x4VrelQzHlxMHnkmzHes7qtFyQXHIPF3izZlfjvvs=;
        b=OwgclIK6dje7kyWKBlDFqkCQmhg0tpQk2l+KIFvX2iCcEOJLtzEuSBOn78p172NZqD
         NAqwxYPqNI2ikttgJY5gMeTu+O9jBNUTlY3bnpoXVznHzQ78EJMl3TiUOYQBV9KF0RrI
         hUk41K7xX2KB6g2QBT+kfxJ+KMEOlax0EvpIOl3dlN3l7ywoom00rHdj2C7StlGa+L5B
         V5/Hk3smkWHmEF4Ez014KSdggOXySqudv9laE+e4nUp+zoxoMvbMPkZLMpqT90Q/aCQX
         nucFqXymBMvCS2K5nghKMwQk0kVtgB0ODgQdTSh9YNGLukL/WvqepIOnnYRW4fDj2k8v
         iUJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JGoMVAGY;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JGoMVAGY;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	DaeRyong Jeong <threeearcat@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 08/52] ALSA: aloop: Add missing cable lock to ctl API callbacks
Date: Tue,  8 May 2018 10:10:06 +0200
Message-Id: <20180508073929.113393774@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882797717667467?=
X-GMAIL-MSGID: =?utf-8?q?1599882797717667467?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 76b3421b39bd610546931fc923edcf90c18fa395 upstream.

Some control API callbacks in aloop driver are too lazy to take the
loopback->cable_lock and it results in possible races of cable access
while it's being freed.  It eventually lead to a UAF, as reported by
fuzzer recently.

This patch covers such control API callbacks and add the proper mutex
locks.

Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/drivers/aloop.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -831,9 +831,11 @@ static int loopback_rate_shift_get(struc
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].rate_shift;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -865,9 +867,11 @@ static int loopback_notify_get(struct sn
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].notify;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -879,12 +883,14 @@ static int loopback_notify_put(struct sn
 	int change = 0;
 
 	val = ucontrol->value.integer.value[0] ? 1 : 0;
+	mutex_lock(&loopback->cable_lock);
 	if (val != loopback->setup[kcontrol->id.subdevice]
 				[kcontrol->id.device].notify) {
 		loopback->setup[kcontrol->id.subdevice]
 			[kcontrol->id.device].notify = val;
 		change = 1;
 	}
+	mutex_unlock(&loopback->cable_lock);
 	return change;
 }
 
@@ -892,15 +898,18 @@ static int loopback_active_get(struct sn
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
-	struct loopback_cable *cable = loopback->cables
-			[kcontrol->id.subdevice][kcontrol->id.device ^ 1];
+	struct loopback_cable *cable;
+
 	unsigned int val = 0;
 
+	mutex_lock(&loopback->cable_lock);
+	cable = loopback->cables[kcontrol->id.subdevice][kcontrol->id.device ^ 1];
 	if (cable != NULL) {
 		unsigned int running = cable->running ^ cable->pause;
 
 		val = (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ? 1 : 0;
 	}
+	mutex_unlock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] = val;
 	return 0;
 }
@@ -943,9 +952,11 @@ static int loopback_rate_get(struct snd_
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].rate;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -965,9 +976,11 @@ static int loopback_channels_get(struct
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].channels;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
