Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225gGcX5FV5qk0uuToCt9DV7aBesxxx6Ez5OjZjGA8mzGwRnBJHPhWxoFjQZgPAsxh0G/0bj
ARC-Seal: i=1; a=rsa-sha256; t=1517591308; cv=none;
        d=google.com; s=arc-20160816;
        b=JL5UYdQhvsofVqQZvNWCyP267GGT+4r4cxztpdJR5ZfifWAhwyFgl8XYnFuMa7SUEg
         FR03WPEDc5M+oXq7gsMYyx0a+rpYz9XA+fe/VeqofZu77cL6RnDq50F7CP+xWbudoF2b
         3qbdnKaE2MjqKgT/ClkAuIO9QhNM+jav5K1pYC6Ah4G0njiAi5dHT74F12SXV2eL6gh3
         HYaQU46sXUiS6EuTrUTrSckk2BZz98Gx7jBscCUJoAEz1kge2F/g/o4KUGSsZU0fVGtZ
         VtAcEosIwu14e5BFi/7OZ8MFLgVfPxzJHJtVicRcOLOw0KeOVs1KGKAesmU8wjmAeT2t
         j0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dUkWD2ZxVFah9jB25GZSVYAyYCOO+3+WcoDa0zFAX5Q=;
        b=DxPazF8UWt8I0GHj9bFWLUTtCzCr+/GDCPiFUrUleJFtv0cwdaHpSjVTUPsqhAAYBm
         ZntotyOu5rvm3hI58rAdgSbP0e855roCGdUQfASHFRRf0+H9Jn5aDY+2a1LLqKApl3DZ
         G/PGxbZHmAq4yFuMpmPcnBd5ZVy3rNnr9tNr6FwY0UlKHhAqGmut+NskoSpXomARikep
         5QJgl3lad8lfo9Y/SUAIKZWYPdl+8I3zcG+zh+sbiINFK6mlNqoMUD92k8XRvMBLxOrA
         ND3stj7wRVZ2fcdo1ci7+WLVg1nIbD1XpIMh09D1Ptsav1m5cSu9n2dW+aczC7ftp/K5
         TZCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 007/156] ALSA: hda - Reduce the suspend time consumption for ALC256
Date: Fri,  2 Feb 2018 17:56:28 +0100
Message-Id: <20180202140840.650973613@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309823879821974?=
X-GMAIL-MSGID: =?utf-8?q?1591309823879821974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 1c9609e3a8cf5997bd35205cfda1ff2218ee793b upstream.

ALC256 has its own quirk to override the shutup call, and it contains
the COEF update for pulling down the headset jack control.  Currently,
the COEF update is called after clearing the headphone pin, and this
seems triggering a stall of the codec communication, and results in a
long delay over a second at suspend.

A quick resolution is to swap the calls: at first with the COEF
update, then clear the headphone pin.

Fixes: 4a219ef8f370 ("ALSA: hda/realtek - Add ALC256 HP depop function")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198503
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3131,11 +3131,13 @@ static void alc256_shutup(struct hda_cod
 	if (hp_pin_sense)
 		msleep(85);
 
+	/* 3k pull low control for Headset jack. */
+	/* NOTE: call this before clearing the pin, otherwise codec stalls */
+	alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
+
 	snd_hda_codec_write(codec, hp_pin, 0,
 			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
 
-	alc_update_coef_idx(codec, 0x46, 0, 3 << 12); /* 3k pull low control for Headset jack. */
-
 	if (hp_pin_sense)
 		msleep(100);
 
