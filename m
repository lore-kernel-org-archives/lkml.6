Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrAYwTvgYToWrlTUaTrPGtFhX8RuNeuiAQJcyNFO8RXIKOsK0hfLvfMN2wwSlyAhqMjNYEi
ARC-Seal: i=1; a=rsa-sha256; t=1525116393; cv=none;
        d=google.com; s=arc-20160816;
        b=DwuWeASRDUm+Z3LYJbnGUMCWEgYfoOuYkjS3mbHpMmNmq0Sud6066qMIBtQYXJVFTt
         T8fjjhOHDUOFm/zRKUbhuCC1s6rcz/OHFjr4kR/n3QZDgmOyApK2ZEUrGoMNEJiQMOKu
         Gc7oDy3XyKf5SlilQijJlsZdVSExG5f8eq+jpL/rDGlQerkC4EKeWmY2aYI33FZjRnSF
         xP2EZiVTBeO2RcumHLx6vMlzK1QAZIlBvqkGRnyJXT8Y19Vro3YF+GuYyI9JRGpd715s
         FJVNRm7h+d1YFP+EIKqXk+8wW+D3kzUwvZiU92a8sEtoYmAXmGoFkAGKjjOMYdjf1DN+
         kmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kbn83g9l+hhmbOIn8R8otvnsK39XFavL3q1nr1zOWnY=;
        b=sfx+PtjrmVS+TUCjEVIDJOJv9P7V/fIlKRqgpyuXE9DgiNLwDz5RuQDnWsNopjWXzT
         DVYc1ikWXh60YXYz+s41UsYNnprVcA6Av+FHhyzxlMbCQuItnZpEXEb5GQO0JqrOhPCZ
         toepLt5znSvmgtSMzj4HjsN7eqxq2NBtEJi5/PMrNJPg3vuTddbJHItjkCs8aSmiP9w0
         wDFR87irFW4Sf5JnFiwMmDqCrkzMNgL4ImB8OjzrSBF5bSIek22CcThDV1YYEhUzeRVY
         OI4W9z0TqDz2ThNE237wY+crOynP8DGMhEzJmRyUCcmyWRrOrzY1o0Wn9+Vbsa/rdWzy
         I1jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62DB22DC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 35/61] ALSA: hda/realtek - Add some fixes for ALC233
Date: Mon, 30 Apr 2018 12:24:38 -0700
Message-Id: <20180430183954.357383618@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200410209388577?=
X-GMAIL-MSGID: =?utf-8?q?1599200446941004476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -329,6 +329,7 @@ static void alc_fill_eapd_coef(struct hd
 		break;
 	case 0x10ec0225:
 	case 0x10ec0233:
+	case 0x10ec0235:
 	case 0x10ec0236:
 	case 0x10ec0255:
 	case 0x10ec0256:
@@ -6359,6 +6360,7 @@ static int patch_alc269(struct hda_codec
 	case 0x10ec0298:
 		spec->codec_variant = ALC269_TYPE_ALC298;
 		break;
+	case 0x10ec0235:
 	case 0x10ec0255:
 		spec->codec_variant = ALC269_TYPE_ALC255;
 		break;
