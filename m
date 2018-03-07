Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsKy8ZFH19mmhpktmMBADqNVPkuD1Nu+j0oafYH0d+kB5DZ4PhUf2QgCbgaXuI8VWnWeWCm
ARC-Seal: i=1; a=rsa-sha256; t=1520451602; cv=none;
        d=google.com; s=arc-20160816;
        b=CraWUq+FnJbRnH8pQpfnga4fPMxnk4P+ZEDF3x++/2tkDDoIA+j/7jN2DWeSCHIE7d
         POKAVY6r5qUwKmxwGeDxlHLs6IezVE2P8Uv5SBJUpPLN1NTdZMitkIcwZ3kSWqwOlU1i
         OHbyHJXn8zwMATRm2y/UTM5wUiSwOd6zTplEyYkTCsDrDIHtBghB6lAhjvZ4hNQFPKCm
         w+82xRf20/Ist/jTXGsX6orxbeLyPmLSNpnuY/8x3ttquv9gAPuI6qh1FSPOZZc80C+C
         toYxeDoGOMlmelqqdARoVF8prRMGqWp1/tVNGlpIa9dsHILIKcJKNyNave/T8HTIpJW3
         lgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mTA18Ulo3u5xt8DVptizntyA8ca4FCZOzv/TxxAsbnc=;
        b=Rdw2TYOAblwrcIN2UPMTkepT8ksvQ3ZALDw9yidnH6cCyw6jxAdqQxWwCabMhMiBlK
         xHNSUEKpnfMFRt1u3+Vgqne+VcSJDtHLhBfWm7NlluYxrfb1Ar4vAjjtO5VJR0CbkYxH
         JiDRif89E47YMJZRjSBa4MglsEF3pYdHCq6vP6XcwDgqSDdmv7AJoLYhxwbIZed7CFbB
         H2ARvI+tiHcgUp9mu9OgSGetuThImub/9oHcY8CkZ8/E4RQdc2dM9hsaxjsA53T8JiBx
         bpTDhknWDPqq9hxlTRfTRS5QchHBSGMw+AMflZb7s0I1ikwp+l+oK7ZjJnpCaxznbXdX
         IYpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 017/122] ALSA: hda - Fix pincfg at resume on Lenovo T470 dock
Date: Wed,  7 Mar 2018 11:37:09 -0800
Message-Id: <20180307191731.795894637@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309059227409390?=
X-GMAIL-MSGID: =?utf-8?q?1594309059227409390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4875,13 +4875,14 @@ static void alc_fixup_tpt470_dock(struct
 
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
 
