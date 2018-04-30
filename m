Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrVfdZQI2/Rrd3Z534labhDD1InMoctsm8+Jkc/bjPFEVYVhxxzZY8z6VwhyVdHS3QfTjXV
ARC-Seal: i=1; a=rsa-sha256; t=1525116358; cv=none;
        d=google.com; s=arc-20160816;
        b=rPG3xvXAAXj/hDuH/slpch9RNhApXiOeulGkp6HxQhQXIwPPX6KmwZ3OAntGhqnBpq
         ubwaF7Q9Zrv+1xM3LZbLtaP20TIzXpP09bXC7pv4jb9Z2bt9wQrCgQiuGdWutDKaUJMr
         Nje+05jZxjObUQYgQ33aL5uO5GeYDiUA/yQ2Pa/19NpTixg/9xzGNHzLERCCV4tL9Pzy
         z9we9KId347j0V4r1149GNdnyQkUoCubpHxhTGiiJY2jNKvx6roxHv8kHO4J3VUOfDnZ
         v9f8i+EAdZccPy5lhXgEcbygXU4A3Gz6SZfca+HltXLJ+RWGXU32z/ayRMOzNcCr/YNw
         aTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=O86QaZAmcu5sqbGog+5eW1E4bBOY/Qj4tvxZFDDmBsA=;
        b=i1XQjQwikOZ1FKaspBkhLms4XEmFNueoJg8hNVtCgD2OdqzHjfblPhHVsMKD49Ik6k
         SFCt9vlPOWsOsbsd6QIu2p2AUWh0ju4l04AT25pmCvn/Ao/PnGFET+YhRFy1VaYUDHGr
         9t9N37mo10iF73NdKUw94rMSbUCBi+cgy0Dm+tALI5ojdu+EnLVPpn2uM6lsdarDH2By
         +sEPs82zqi+vn4FeHjjI4qP0X7y5ywwlzbhpmlIX7d9PFkwK5bboDgh/I/DliAQvNgsP
         C6h+Z4WagQbSvT+1xpaxYseksGmDQ3wiO32ZF6MgkiKmrwM9YGbhvorStdzP87c1i/Rv
         OH9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A4722DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 29/44] ALSA: hda/realtek - Add some fixes for ALC233
Date: Mon, 30 Apr 2018 12:24:40 -0700
Message-Id: <20180430190947.500978130@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200410209388577?=
X-GMAIL-MSGID: =?utf-8?q?1599200410209388577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6296,6 +6297,7 @@ static int patch_alc269(struct hda_codec
 	case 0x10ec0298:
 		spec->codec_variant = ALC269_TYPE_ALC298;
 		break;
+	case 0x10ec0235:
 	case 0x10ec0255:
 		spec->codec_variant = ALC269_TYPE_ALC255;
 		break;
