Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsHrsxrIo41OoC8nmmyqJ1PNAwcQh08ov9v3oaHr7QkmfLZ4vwgpKhUpZ/7sSl/vAzUc/LW
ARC-Seal: i=1; a=rsa-sha256; t=1520451945; cv=none;
        d=google.com; s=arc-20160816;
        b=g+Tyk652p3stE3b6AGjH5Ofgd4G0cwtMDuEVTSaoPPMNojPZUS7OvIwn6vuOKhx78U
         1WNnVs59Xm+N7PyKt8cwMrvVkahcl5cdsWBYEqpnDDua13LZDSuKiI1DJZzXm8AssQTM
         8gu7nJUA5h5a0EiJFUk/OtVl24iFhR0ak8ttUr2J/FdekZhn9lnQ7wBAc6wOeiautZR1
         bV4z4N+vbO6/dOxyFn6bx/Bhdk3BohxmtGTMuvGp1RnNZyLVe0m8zOkkEH1QowTkxC+E
         1Fsz3KGDqO+/K8uztVkqDFkn5CQTYnIdTbSNrxwSfFc14ddql+XlDOwwQYXLKfckHDyq
         2YLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Rqpuh0TjV90m1uEwqRP7W8ofQ3VwKyHi0VEZ5X+qYwk=;
        b=aeKWFvOIJRKgSrI2dPIUsqXOrANOnpkC7roEBBbZnrt1Hs8f32OzJSpg2VJ9xiCV+M
         mdTWQL+95IQa4+mmjjaXyeym1/oTRfrefzDEgN+tzN3bgmMDxpZQUhsyHw8aglxFXW0I
         sUqHDu8yIi8Fezkgsv1ESNMWiVCSPBTNKNYMtIxRORg3bY1TosaPB5Ne5i4/Db3U239r
         CcfFTZPbSZGikPTuZoBoWWnuZgE+poJkCvy7MYfHBI0WbuGHi8SIv0/SkJOR3saKSc/m
         8jNI91aYorx7TJ2lkajxS6GL09U7/2nvxSIEOGz/FHbzce5Mtjb4j7Wfy6IGvacm2Loq
         eeNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 014/110] ALSA: hda - Fix pincfg at resume on Lenovo T470 dock
Date: Wed,  7 Mar 2018 11:37:57 -0800
Message-Id: <20180307191041.565429464@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309059227409390?=
X-GMAIL-MSGID: =?utf-8?q?1594309419146888795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4852,13 +4852,14 @@ static void alc_fixup_tpt470_dock(struct
 
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
 
