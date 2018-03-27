Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+usMwdHwQBhwKL4+jLg6LKzcvzI840FO7kt7j7X4XpN42qZEISS6R9k9zdt+T/956Jwxfk
ARC-Seal: i=1; a=rsa-sha256; t=1522168260; cv=none;
        d=google.com; s=arc-20160816;
        b=QOm4QzUmWU4TmDrdXwKjX2y+/dXQtIwh1MdNU7HSiELKJ+aqvN9Ybq8CmdQvu2Buoj
         pTnsigD0a8a45pIFu/p1+dW826eoRSHNg7CF9gI/1adNuTLl+MJcOhcjyHdOTaMm/ew6
         15xXcN0R8ngIchWM0dGeGpJkOKb15//3mKw46td8yA227DcmmCxVtf7pWnSOHbXQxGeD
         aL1HofFryyX9529zV5tYiVNQopAr1CfXeRE44sxSye5VLz5biCF88q4FsdCd91p4oM+v
         U6V1Vq2eVcUiTN+VVwHyMBJVXL/FDnH7XBN/goMwSBq4HKq2vbxoeCUqYDD0G/9KZ+VX
         kxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CY4utsT3MhyPGuD5XO1oLx4/qHuFXcenA5f1Mi+xwuA=;
        b=W6exMDPk9qNudXO9CqDy7yTqMYY4EFjNXTYTqI7LAKhkwagEA6p9StefitC3AX54ek
         dMnp4WcHUoDM2Guzcd8MU1Rs6l/AKmLrnh7QK55/i9wur9+WV4vTeByCc4r0NxPAcrHM
         pRFftYbbNSDzCfDRRv2NV9eB4ww1FtzOaQdqwTjTmftHLdTvkLBkudzVIBz5/AVNqwN0
         YepCQs+BE76zHTc/5sy1HiJpD2eJ2zPEQT/mGSC0m964Ze8yMIKVEPQ5DxKVfS/NAf1l
         LcKQdydhWpYu9rVzwOJuw42e0CaDrkgiVOiUf+AkjReUC6MIHJfJjTDHzlHRuA5s3rtF
         yl0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 06/67] ALSA: hda/realtek - Always immediately update mute LED with pin VREF
Date: Tue, 27 Mar 2018 18:26:58 +0200
Message-Id: <20180327162727.022274592@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109056850158323?=
X-GMAIL-MSGID: =?utf-8?q?1596109105662309667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit e40bdb03d3cd7da66bd0bc1e40cbcfb49351265c upstream.

Some HP laptops have a mute mute LED controlled by a pin VREF.  The
Realtek codec driver updates the VREF via vmaster hook by calling
snd_hda_set_pin_ctl_cache().

This works fine as long as the driver is running in a normal mode.
However, when the VREF change happens during the codec being in
runtime PM suspend, the regmap access will skip and postpone the
actual register change.  This ends up with the unchanged LED status
until the next runtime PM resume even if you change the Master mute
switch.  (Interestingly, the machine keeps the LED status even after
the codec goes into D3 -- but it's another story.)

For improving this usability, let the driver temporarily powering up /
down only during the pin VREF change.  This can be achieved easily by
wrapping the call with snd_hda_power_up_pm() / *_down_pm().

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199073
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3261,8 +3261,12 @@ static void alc269_fixup_mic_mute_hook(v
 	pinval = snd_hda_codec_get_pin_target(codec, spec->mute_led_nid);
 	pinval &= ~AC_PINCTL_VREFEN;
 	pinval |= enabled ? AC_PINCTL_VREF_HIZ : AC_PINCTL_VREF_80;
-	if (spec->mute_led_nid)
+	if (spec->mute_led_nid) {
+		/* temporarily power up/down for setting VREF */
+		snd_hda_power_up_pm(codec);
 		snd_hda_set_pin_ctl_cache(codec, spec->mute_led_nid, pinval);
+		snd_hda_power_down_pm(codec);
+	}
 }
 
 /* Make sure the led works even in runtime suspend */
