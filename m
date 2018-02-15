Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224oHI3py1mYGEzSA8knyRaOqVncBmf8xWiJRtYtidA49qieUDUdPzPXFZQP0psZrhm9tKcm
ARC-Seal: i=1; a=rsa-sha256; t=1518708479; cv=none;
        d=google.com; s=arc-20160816;
        b=Fvqu3kDmemGq8KXIwlvP6MUKrGrBbXn+78jZIdg9XkSe0Dc3bkLIaZ7HC8Sj2UJtNE
         XkBfdnXEuom/laGulcEf10ItZFUq0BXPZn8UZ/pWCPMs4CCqM3q89WD/6I5GTaf19SLn
         f3gDFncKaChhMN2wOV3Op2qmNWQeWQQ4KThi4eVEJySWo+VWGQm6vrZnGNh8ktPXeCZE
         Z+ImDxLU4K2cnJJpxHeoj6TmCbra976uB3jDn+Qs7yPxP6tVBf1DrsGAChFhsP0qTaBU
         fPK3ILNB/9Li/ig84xh3LjuOGSLHQEhXONMDLi8Pg+vkr7Ei+e2Kf+4VlvKdxXbT8wUr
         rDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tnjaUfczFqRh2PSl+uUU8iEdxd9kn31KX7K+mppTVRY=;
        b=vwhKOOlTbumGpcOLygL5rNRTcE/QOK1tRmMh7S2qSaSCLSgqAjvQcXE4ezCWDOa5QK
         MJwWg3K4fQaLQvw2a/d5LULHoOuV8VIl+B8Xe3ReNxXFCGCQF13mDcUMfU9jRZAOstX8
         fygYx766lGQwZsy8z0v49EKFHXYfV5EbQg3YcoLlJ8/vfuYOo+qgbC9pZlIXpKppiljX
         tATh+t2q1bF2gY0rlzxr8KF38eigPmPBE/8tCSdRgMiEGtTVvOTB6n+ncEOaCMZZrWBk
         g0My3UoFS4Uu7n4J4kU2S4vWV7ujDKo9FF3XQ1zI/tSSkrb8cYI0De7Bg3Bkdw74jayT
         /BLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 56/88] ASoC: skl: Fix kernel warning due to zero NHTL entry
Date: Thu, 15 Feb 2018 16:17:23 +0100
Message-Id: <20180215151230.466008800@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481262920036706?=
X-GMAIL-MSGID: =?utf-8?q?1592481262920036706?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 20a1ea2222e7cbf96e9bf8579362e971491e6aea upstream.

I got the following kernel warning when loading snd-soc-skl module on
Dell Latitude 7270 laptop:
 memremap attempted on mixed range 0x0000000000000000 size: 0x0
 WARNING: CPU: 0 PID: 484 at kernel/memremap.c:98 memremap+0x8a/0x180
 Call Trace:
  skl_nhlt_init+0x82/0xf0 [snd_soc_skl]
  skl_probe+0x2ee/0x7c0 [snd_soc_skl]
  ....

It seems that the machine doesn't support the SKL DSP gives the empty
NHLT entry, and it triggers the warning.  For avoiding it, let do the
zero check before calling memremap().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/skylake/skl-nhlt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -41,7 +41,8 @@ struct nhlt_acpi_table *skl_nhlt_init(st
 	obj = acpi_evaluate_dsm(handle, OSC_UUID, 1, 1, NULL);
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
-		nhlt_table = (struct nhlt_acpi_table *)
+		if (nhlt_ptr->length)
+			nhlt_table = (struct nhlt_acpi_table *)
 				memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
 				MEMREMAP_WB);
 		ACPI_FREE(obj);
