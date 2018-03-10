Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtpp7t11M4KZLUTaWVZ3IgFDn10pEbB9TQjHkYz4WrvotEUZbbhoc1jSW+VvuEMIdRjueVi
ARC-Seal: i=1; a=rsa-sha256; t=1520641259; cv=none;
        d=google.com; s=arc-20160816;
        b=uhMrTb7VkMb1iTjZPfJOIdnCRYC/F6YHcmJgo25yGItRgvB6e1BJH3sAi3bosMu+MG
         MEOEJbQGaIlHccSs5kTSbE1vmeOrFEEWA9szVOQI4tzvkcrztoDb7Ymgna0h8qejl1k/
         39AgYA2ikCyC019NFXVLVsJdb6oIfbEUlb7S/vdaARfgISfke4thshtNfUCSHAXXOb6g
         /PQu40xEqf8ISMIPwmSIkHAxcYtMbagua1r3vkG5BXmd44zcMeBK0cTGi0k/cXX0+4v9
         +nLWKpJW0sAVwSqqrHSWQvdKtRsshYLlwOiv0uuthYbSrh7b++Lx/NhFLOWaCQyfXrtX
         X2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xcn3qDca0UAdTpAvX07M6GJBw0aFgORArIgz/nDCI98=;
        b=z/gfK6tt9f7r5+0qsuX3vdqKjC8rUBr/tRWMKZXTzqtYNUfqy4ScV4os3NuRdbB0HP
         HkP2fEuE6mGkSXkMyjuVS+CzoXQS6pWDtdOfgT1I9w2KbO3A/OqLJFnLOVNMmTA7jnfO
         VwaGKwV/MBDQ3vQTx2UCMdICRg+sdASYQOBI/uh7Od787wDnA4+cHI5oMQm0jdXWJceu
         l2AvvQxvz4KG7kuwDt/US7BRBz/3ZoUTo91Cd4bJlS94rUH7h+rBU73YqZ4VwpOgfDHX
         ruLfWAFUEZD91c+C61XJnR5jD+05SxYRPc6HauyjlD7UQ54C+OIoEwMWNpVp7CCQPUcI
         v6Cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 10/65] ALSA: hda - Fix pincfg at resume on Lenovo T470 dock
Date: Fri,  9 Mar 2018 16:18:10 -0800
Message-Id: <20180310001825.741472068@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507929689414271?=
X-GMAIL-MSGID: =?utf-8?q?1594507929689414271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 71db96ddfa72671bd43cacdcc99ca178d90ba267 upstream.

We've added a quirk to enable the recent Lenovo dock support, where it
overwrites the pin configs of NID 0x17 and 19, not only updating the
pin config cache.  It works right after the boot, but the problem is
that the pin configs are occasionally cleared when the machine goes to
PM.  Meanwhile the quirk writes the pin configs only at the pre-probe,
so this won't be applied any longer.

For addressing that issue, this patch moves the code to overwrite the
pin configs into HDA_FIXUP_ACT_INIT section so that it's always
applied at both probe and resume time.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195161
Fixes: 61fcf8ece9b6 ("ALSA: hda/realtek - Enable Thinkpad Dock device for ALC298 platform")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4480,13 +4480,14 @@ static void alc_fixup_tpt470_dock(struct
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
+		snd_hda_apply_pincfgs(codec, pincfgs);
+	} else if (action == HDA_FIXUP_ACT_INIT) {
 		/* Enable DOCK device */
 		snd_hda_codec_write(codec, 0x17, 0,
 			    AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0);
 		/* Enable DOCK device */
 		snd_hda_codec_write(codec, 0x19, 0,
 			    AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0);
-		snd_hda_apply_pincfgs(codec, pincfgs);
 	}
 }
 
