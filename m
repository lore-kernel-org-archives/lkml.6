Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqbJ5bWmUGk4+l/zhE3jJsmPw7hnmFVRjrs4h/W2QuUVUeVs0ux2qyU+2Z+66T2XCG+KZd8
ARC-Seal: i=1; a=rsa-sha256; t=1526280674; cv=none;
        d=google.com; s=arc-20160816;
        b=sIMVpwC7+ojnqdaMq1Q4ZTvSXdgNM3YAAQ7/e0N2cGNgC5ptEK5i8lIxEjfsG4W7Dl
         YKha2X5HGDFGP9WbHRCXKGFLk+zGV8YUEGJ7btCmAUNRBl+kXPmZi4g00IFVSIly+AHj
         kTazWsvp2NfbpH8PgOPanBKVXJwYdGlp2r0aWC2/sV6nTvIraHAO0MjnGBfHNKxGvipl
         KGJee3WM2jWqurtID2jb51F6qHU5R56FHp71P8Ex/z/n1yXKP3e/PrBU6meFSFX4rd89
         m1p7rRnsppHRmi2nxNdPuxuya1+U1K7CrZFf+aN/fkWLFRpRzukW2D+9RBelES1wGKE0
         f2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=t0TzgKFqlEIlfS5hnqAGhXHNJ+bBGReGXy5MOHpE7N0=;
        b=C1JJ3Vi7iFKi9/sF6plhrEF3V2fIl6uZYz9Ce5fXEO6aTyrnSF4M89zW19ZuJ3Rg+o
         dSkTIsI6JD89UxVGs3Bii4IdI2W4S/qSD67Ifevh5V/BnwIQidhhEm5cZEpMeAmrz47V
         S510+9eLQc7kr4fbgCtt7A5imfGuweR2+4Yj0uc0QyUSWYg9GHtkJPvzDhWzVJNTT6Pa
         +Z3nEhXjmBNVL8YpyPrALfK20C9K/p9UcC6q2kK0BRZmnzEbzwtpY4VG0+cJ/QjQ/++x
         TgUeeRdB8mOr0k5H5waI1kpr8Fcg4HPVD98+j5SQKi8QbEN/d91nDbfEkKFRl+j9c3VT
         4ysQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wtxOrIEs;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wtxOrIEs;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	DaeRyong Jeong <threeearcat@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 15/56] ALSA: aloop: Add missing cable lock to ctl API callbacks
Date: Mon, 14 May 2018 08:48:20 +0200
Message-Id: <20180514064756.523645687@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421218895255772?=
X-GMAIL-MSGID: =?utf-8?q?1600421284441914645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -832,9 +832,11 @@ static int loopback_rate_shift_get(struc
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].rate_shift;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -866,9 +868,11 @@ static int loopback_notify_get(struct sn
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].notify;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -880,12 +884,14 @@ static int loopback_notify_put(struct sn
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
 
@@ -893,15 +899,18 @@ static int loopback_active_get(struct sn
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
@@ -944,9 +953,11 @@ static int loopback_rate_get(struct snd_
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].rate;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -966,9 +977,11 @@ static int loopback_channels_get(struct
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].channels;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
