Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226rGd5jqrr8WTpRj0gccLo11pTcHBbUzy+ZiEpYrKb+gXE4xv8jjyZgD72p6ZA3VoANKzUC
ARC-Seal: i=1; a=rsa-sha256; t=1517591717; cv=none;
        d=google.com; s=arc-20160816;
        b=tHrx0un9Htf+uQwckhN1+ucpY+hPcCU3tWMIBiAnU+bGE+UamFwflLWMyWkoL+/Q0f
         mhE7otAoCagFQfIKSkuMh8AftoBORVNb//KsjwquGCwTd1wsi019VWMRcKUDcEgjgSuh
         cVy0hexcy/Mb83I1VPsf0u0z9/xLjQ3n7qCfjWo7rsA5aWNmeorxpB5aeokOXAqqxYbe
         7FEYKqto8hZAoKfF8sZo0o8ssSJVAv1+zd7YYBiMF3HpbNoItMSDdZxKSwRvmxx1XfMv
         Yumy9wuTfkE8Ri/jqii4r/Mr5rrLzKEOck4vdeUIsm2GQUX6iDI4otw7VFsRiYIVsWuq
         GhKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M526taa+xYQEu/iEqCo8zptYdjr+gS0Fzlp9yx91KGo=;
        b=mig1R1BQdeLTMB1ar+tAOBHiZvNukFlL1ontdWku8zAq6AZF5iyYVOsnKzy5PcDk/y
         DuUMHaKFRYCPg8F1CzhMeGVzMme8OrroTMLJVOwO7tmOTy6gsX1VjFlrAnWttL/zVQtg
         IsZ88A56kNDjeIFbHE77r9Fqtkt6VSx3JkTFj57kCyAi9EMBF94RF9ilj2Z97hYgwXUV
         3FUsUMLkiJvXsst+bCog9Psfs63DgGfUGLeKD486+wNTb/d7+VaPssuI9K0LC6pO1rOA
         XIVYzwKHz5DpfhPEax9K5x/YWnNTruG8tw4ngoSwoj79ZQQniQt43viNRfX7k1eWaHM7
         MI8g==
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
Subject: [PATCH 4.15 05/55] ALSA: hda - Reduce the suspend time consumption for ALC256
Date: Fri,  2 Feb 2018 17:58:23 +0100
Message-Id: <20180202140826.536527880@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309823879821974?=
X-GMAIL-MSGID: =?utf-8?q?1591310252777113442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3154,11 +3154,13 @@ static void alc256_shutup(struct hda_cod
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
 
