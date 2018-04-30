Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoM5A+F1ZjtcW/T6TlUtq0t9UPXuds8CHaavElRsWW6K52XScCUqYnUBnFSd7xOQEZtOnzv
ARC-Seal: i=1; a=rsa-sha256; t=1525116440; cv=none;
        d=google.com; s=arc-20160816;
        b=G7H/x/cSP+QegpnLA+cZHmTQc6z74EhiqwBuAZVDz4AemOXXzrPZeJuKhzlDZ5gEAh
         W6FGqPNC2g0ShObOxMDSa9EwYpCQ0A6SR79zAEVAeMRTaQe7lET0v3BQgGzXg0JrfSrP
         QDwszSycAY15feFPTAPSInn9bIhQlHFpENbZiZloJvhejohBXmJtxn0BmdJEFCkvKNz7
         Jnw4MlYUUvOC0+g1d2awwSPM9gQblQjVL9mPz9zZYyYi6zE8V+EcSA2DfbNNxCxm1gU+
         mRsqFle0SwADzGTXvO/Qu4DAXS/yxMOG0ea8p2YWKCk08BLB+H8BjtYlJHCrETl1C1DQ
         5hNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=seNYW/0kOb67BJkhYOjJmFcpPyiMw57FnrkHOlFL6Dw=;
        b=U3Oybq2iyCML0BgYUUY9L99xF7FL1COZ13GD7jvHcLSj8xukG56tinP25gZgtfo+FD
         PkyItGgtRyn0Myb0kt3XV8H8y7KdCTbSirVA0xySZahHm1ATBWq7o9jNiopIG3XFBVy5
         A/78qzOfTbE8xuwlJwOY7TD8HTZTd/cTI3iRElBLnwcfS4Xr6i7r9/+OQ4xcd3ScPZGN
         lJCKmMIhk7RbMEArDiTL/YQr9X13lGW7pVNp+I1LJV89CWjQxLRhaA32I0YSe9odhDY5
         EOG7tcrKIfU1vYZ8bx/YjHnfb91rgyhWJXAJ7U5yve7L8P2EnWzNjPXuFtnha0CPy0Jw
         4FrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3A422E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 48/91] ALSA: hda/realtek - Update ALC255 depop optimize
Date: Mon, 30 Apr 2018 12:24:30 -0700
Message-Id: <20180430184006.690617418@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200496509330414?=
X-GMAIL-MSGID: =?utf-8?q?1599200496509330414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit ab3b8e5159b5335c81ba2d09ee5054d4a1b5a7a6 upstream.

Add ALC255 its own depop functions for alc_init and alc_shutup.
Assign it to ALC256 usage.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7019,6 +7019,8 @@ static int patch_alc269(struct hda_codec
 	case 0x10ec0235:
 	case 0x10ec0255:
 		spec->codec_variant = ALC269_TYPE_ALC255;
+		spec->shutup = alc256_shutup;
+		spec->init_hook = alc256_init;
 		break;
 	case 0x10ec0236:
 	case 0x10ec0256:
