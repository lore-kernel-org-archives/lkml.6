Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqQTrVcLgueqRbhsS1jBYAHNqjl4xrYaxVHZBMWTtYXVdJeQcnV9JyRIn+1zmwGF2JPMuZR
ARC-Seal: i=1; a=rsa-sha256; t=1525767315; cv=none;
        d=google.com; s=arc-20160816;
        b=wg/YA2zoDpLXNyEULDZ3NXYCjIvINyhn8UeuNgWuEWBEI3tXHPhCM8P7K5AS60Mipg
         ifYaQSoqDjixJKmpQCXQGwRZuTGLQ+DLehjmmLI1+5FphNVPA1oUBIsksghPHb9CoPWZ
         JaPMp2zOmg9BH1AFS4ngb0qBrRYrdSv3GMYc+rjZ860TaRi6os+ECA4wDPwyaQgcLL9l
         FBgb3Wb8wmDahKcB27UDgesOM0Y0jtFO62AFInJXmtx8ZDVukfSDHjBFWxwyFqGIj93D
         XyqOlRaROCsAp4ZXeUUBC7LxueMjeXOKq5Y74+18Me+1TTcGpPa55OG4lX/seuvkGNeZ
         w+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Mf1IJ10pqSr842BJg1YZdNFxdXRRVlhxbn3WQuE9YKE=;
        b=hpe/K2tlOr+izGnAuzcUYUFgwUrds6dHEiAap3fEZrZ1lfjKZy5e9dyyxZJ9vvJ//B
         r+TTSgCmTM448BF3ZRrz09ficNHebEMwTdP4SRPqP87W5hX5lCXxduSJyR6m1kz6H5fZ
         VxYSPfP4A6lP7FNQDjMwRR8celA2d96M11buoBkwOy8OSSwn3GNq5DZdQS/oTkkPp9lm
         XRe9UhGbgnB/dG9CvPTBPNEHHUI/U5+wZXkpw67EEQDESORNkdguLjs3fZDJzU3wZmxl
         hu5ReFaa5XS84m/FpsX+B/AbmICV+aRrRD4/iyyQtw5K0wyTxAOfC7w1As9IxHc9CUPq
         6GMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hg1q8iX5;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hg1q8iX5;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	DaeRyong Jeong <threeearcat@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 12/43] ALSA: aloop: Add missing cable lock to ctl API callbacks
Date: Tue,  8 May 2018 10:10:31 +0200
Message-Id: <20180508074005.991296878@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882797717667467?=
X-GMAIL-MSGID: =?utf-8?q?1599882988780467344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
