Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqUf4hK40eTWCeUSKnJA4PnAiupQZ8zVsIPGFIZqaEFkKBX4wghuoIMfYWAOxdV0R/4c3JS
ARC-Seal: i=1; a=rsa-sha256; t=1525116498; cv=none;
        d=google.com; s=arc-20160816;
        b=ZI9nXKConEN9h2FwI1woBe22JxLyUwS6wbmCZh0riyrM6V56cHOK1aBSr0Nptdg/EC
         5DD6n2yLLIqchnz/6Pn5BwTpKjWPRIDdUazFtczCJGu6FFJNP7LNDjm5OkiLGwj1F99V
         6y0iwrLEbZCm0UUbc7W1tZqY+do//MNCzSc3gXkyD59pH/4RVOG0f+pJtkXIYBfnwBxv
         MdMkMDI9QkPl1RAW19iyzRxIUykrOt89WL0/RTbPluuorJPS3rxIEY5F8a+SyIbzNmBH
         nuw1kkGMrXQxiga4jn7V0hW0jQ3wJBesVIqLMtx0JoE9/VkoOmC+j5kHklc6thVoaxyO
         JrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kRhLgNuyJuKfV5DbDnLehxQIiaZqGneza3H/YnzJnNY=;
        b=v7sIihtcbsQ/1qJzBqjTIlu2bTomEfBnHIZ+KBoVlEiZODd2VpTLoaDvJbYPN8qGwB
         Dik4AURaDfplBjmK7qu2X1v59NSgZAZmbcv25xHPeKh5CaZVscWCT3m1Px20UbZ/YIo9
         78o+TKzoxiyEOUatIW18jMozSGhdcZAKLr00U/xvX3jsAvspvDY7C9bWVDJ3PKERlxSl
         KJ3haLsOqlHOoeJheXFXgiIyzew4C/etO7evjyqztPhD5O0XNyyW3/1zXSq4eIy7Ifra
         X4JzWTP2VsY7M0uefV4SD1i1uBNInIJkQlYx7zTQFupeAcm4hHP5yxbg0E+096ul7esP
         +saA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CDD22DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 051/113] ALSA: hda/realtek - Add some fixes for ALC233
Date: Mon, 30 Apr 2018 12:24:22 -0700
Message-Id: <20180430184017.216034799@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200410209388577?=
X-GMAIL-MSGID: =?utf-8?q?1599200557950691279?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit ea04a1dbf8b1d6af759d58e705636fde48583f8f upstream.

Fill COEF to change EAPD to verb control.
Assigned codec type.

This is an additional fix over 92f974df3460 ("ALSA: hda/realtek - New
vendor ID for ALC233").

[ More notes:
  according to Kailang, the chip is 10ec:0235 bonding for ALC233b,
  which is equivalent with ALC255.  It's only used for Lenovo.
  The chip needs no alc_process_coef_fw() for headset unlike ALC255. ]

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -331,6 +331,7 @@ static void alc_fill_eapd_coef(struct hd
 		/* fallthrough */
 	case 0x10ec0215:
 	case 0x10ec0233:
+	case 0x10ec0235:
 	case 0x10ec0236:
 	case 0x10ec0255:
 	case 0x10ec0256:
@@ -7160,6 +7161,7 @@ static int patch_alc269(struct hda_codec
 	case 0x10ec0298:
 		spec->codec_variant = ALC269_TYPE_ALC298;
 		break;
+	case 0x10ec0235:
 	case 0x10ec0255:
 		spec->codec_variant = ALC269_TYPE_ALC255;
 		break;
