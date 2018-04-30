Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqYNlAv+PMWw2F5PznILMq+GqFn/C5YWnbRE8r+v9vjrr6IerF3HOhR69IovGftsdRTgEQa
ARC-Seal: i=1; a=rsa-sha256; t=1525116439; cv=none;
        d=google.com; s=arc-20160816;
        b=hKXd8gFTkgTUllP5bPG51bUnxQdhJe2lqkMUGouAR0KVxOobS+lx/6YPxlagBChudd
         EdlrDouUDGe95GZkdB71nGF/9lrm+J/shB8cH6l+iUitsKriRaxi/AErCqqDnN9n21F2
         YKpXzEG5Gea1aiHT72f3F70Pk93GOv+9gQutvH086eCq4/5w5jxzYK3NghOxAx7EiAmY
         6aT/suIfxzIqK9SqOSQR6zH4T1CwtUFCnSqr9JV1+D0n5QvnlZ6RaYZG+rAG6m/B0Ffn
         j12xb8y2wZSJWRuFP0ozdZ62+QmCblm/dPS0NeN7BdkhdsnIoS8NtS1PTJdHE7jH3Y1p
         j1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=IHE9UUpa0VDO7UbZu613+yFAVAdljxat05fwqkI9Ilc=;
        b=M2uWEq7esHLhCvTWeGVWpyZTF1lzCNmnqU8IMva3Npy7sROPeflK9DmkcuTTjTWWcq
         ChRq7LaCY7kZ7ljuuZJU8dEVO+IkLI9QgpRnoo9V9TVWjPjSnVBMmNPkxB3KcETTWJTU
         nxC2g6wc6q6o2r3YkN/8LPx4JyNerM3mlQuwAxNS3UvwLF0arNePLWO4aT85np+7/qC4
         N2IURQjSukuYNUtulrKpI4z1gMJKL4uzBDsf/FgsUGxvF6QhrT4vLfDXrfW/WQojonwC
         wX/lQ/Y8FigVcHykANt0N9jbK5kbfROrYnIxtMMY9Arq54nf9fD0rZ5ifu2C8BDDBslu
         qHzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB0722DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 47/91] ALSA: hda/realtek - Add some fixes for ALC233
Date: Mon, 30 Apr 2018 12:24:29 -0700
Message-Id: <20180430184006.647880215@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200410209388577?=
X-GMAIL-MSGID: =?utf-8?q?1599200495754413435?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -7015,6 +7016,7 @@ static int patch_alc269(struct hda_codec
 	case 0x10ec0298:
 		spec->codec_variant = ALC269_TYPE_ALC298;
 		break;
+	case 0x10ec0235:
 	case 0x10ec0255:
 		spec->codec_variant = ALC269_TYPE_ALC255;
 		break;
