Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuaitGh4+FgjP6FHBBE0TtaUbjD8yNSstbfECWQFIlmv6Y/DaIb1OB2AGB+ygJfCMvc19n0
ARC-Seal: i=1; a=rsa-sha256; t=1521483483; cv=none;
        d=google.com; s=arc-20160816;
        b=Wzqxj0JQMBdbGNVvxG27Hy9u6yH6kqO+QoIj1iUtztDoEhiM2jsjGj1WX9kYPdA0+q
         WpsC2OxZs27Zd1p+w757uoChvKLMCNxEk0fSS70e8m7SVxOexllh/LfF8eAUw6crTcQe
         NjrYUUqeLkmxfgxKf4cy4G1b1KWqohAZjQ938z+hP1NaWp8CK3czA2b73Ftnh/NteY56
         cpQWOcUIBvGcliX0I0sRNkEDkuvve1/re0Mxtwxsh+pS2801/b+H6Ze84Jv0F5kIcOVh
         hpVW5yl7Vcqkqok7iOdaR1vD78iG+WG/k15GKnQ8vuupU1gNXsozKqQl1Is+ilB9Yyvg
         RSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ilq4mdJl3s6OL6GL/cRSmjomu1IkbZ8fyVtwmGhydaQ=;
        b=ww66AVT0p62J7spSGdS9slda6jO7dqWnoQbZ5dJuT4iky2GiGKd1UHIY08NZU5fGm9
         T2D3pl3CyrOYjD15yCPp/kUq+d6rvFLIIkMm3SxzfLYDsa39RTUjwW0M4nW5W5O9+P11
         gZqee351iRNu8vqmHCqLc3X2XalLIW+ga2pjdbh2UU9uh4bKPOYZPRSr3nnuhgrX6tWg
         J/UPs601sX5+Yvg8g/vIyqWHg8Y4Dtd243TX7DO2m8Gqh9lbjXVT9PMhChGw6Svqu7e6
         Hxaf4uC3FJn0762pq0LCv9BLm6vu9rBpU8VhSxY4cHo6lFl18fLL+ZBKaNGLKj28y3uU
         eNMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+4090700a4f13fccaf648@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 116/134] ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()
Date: Mon, 19 Mar 2018 19:06:39 +0100
Message-Id: <20180319171906.027474870@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390642761119786?=
X-GMAIL-MSGID: =?utf-8?q?1595391064426864044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 01c0b4265cc16bc1f43f475c5944c55c10d5768f upstream.

snd_pcm_oss_get_formats() has an obvious use-after-free around
snd_mask_test() calls, as spotted by syzbot.  The passed format_mask
argument is a pointer to the hw_params object that is freed before the
loop.  What a surprise that it has been present since the original
code of decades ago...

Reported-by: syzbot+4090700a4f13fccaf648@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1814,10 +1814,9 @@ static int snd_pcm_oss_get_formats(struc
 		return -ENOMEM;
 	_snd_pcm_hw_params_any(params);
 	err = snd_pcm_hw_refine(substream, params);
-	format_mask = *hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT); 
-	kfree(params);
 	if (err < 0)
-		return err;
+		goto error;
+	format_mask = *hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	for (fmt = 0; fmt < 32; ++fmt) {
 		if (snd_mask_test(&format_mask, fmt)) {
 			int f = snd_pcm_oss_format_to(fmt);
@@ -1825,7 +1824,10 @@ static int snd_pcm_oss_get_formats(struc
 				formats |= f;
 		}
 	}
-	return formats;
+
+ error:
+	kfree(params);
+	return err < 0 ? err : formats;
 }
 
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, int format)
