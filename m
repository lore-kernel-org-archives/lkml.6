Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48e2nD6IQSUo/EK7RD+OP3Be+O0rkH4quX5LQy8vZw9cOzr/nuFpWPcIujL2kQAJCYxXM9C
ARC-Seal: i=1; a=rsa-sha256; t=1522168213; cv=none;
        d=google.com; s=arc-20160816;
        b=0vuY0Ptn0gFUzJQ9xWMVmXxDh4LZzvCDuHBhvcGaU0iIfZ3zPxLcFkjarIhNpOXHqB
         M/v0hQyWkk0ke/PXKLQdxChqhY9Mf3+XbHdai1cRq46fdboOnWPwirIRBgbhje7aZShY
         uUw0yaD/thhz2TbMhfUHmBg02RyxbuObrlxn1zsMs2TBiAxvpgxcnPNTKQNyythaE5CU
         zX6FYZ4Y6QCWKjVUDCqWa7wrHyqPkG3KUdW0mD/B3RDFByiyqptNZI0Mvt8UztCoTokY
         zqL5RdhWnSLZzE/Y2k0gLfcSo7Ob8M5xLs99KvXd8o7D5XHHQaos64n8cpbySRbJ1u33
         xn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MnIqDu2qF0+1CoBRPsOGH54r4zhZUUS93rN3sNAGfZ0=;
        b=gpuPJOk6Dstpo8nSlH30elN3Ji92ZXf6enW/RMe4zP2pQTX4kYOb9HlGRhQqjax0cO
         uF/84hw1TkPRUi+MMbYhPs6og5UQOK59Hi6Q+LVQugvjbdU98geXacH2a4goXgu9TwR3
         Lk6SAons8SizPZyMx2WsHxKGytv+fde4qvEXCa/h1CiWt34OF3LUtQjJ+I3y6atpT7ex
         wWXuoRyVDelBI/nWjh8Yms8Bs3hEcodvhD2ZtKPy2GD/oWZ6Itp04Gm4Y3qN01xpYBNB
         qwgqJ0WwV3y/75IseiXV214a4FiF7INVIOPWLhjmZnwZQWJuhHL+xh0rI3UIlW8Hahwt
         GKkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 06/43] ALSA: hda/realtek - Always immediately update mute LED with pin VREF
Date: Tue, 27 Mar 2018 18:27:10 +0200
Message-Id: <20180327162716.740674905@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109056850158323?=
X-GMAIL-MSGID: =?utf-8?q?1596109056850158323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
