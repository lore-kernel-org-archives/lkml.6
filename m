Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49TpNK7edpc1jpr7fpNz4p+EKgHxmoqx3BLUj7K2yjLMSJDBeHNLCgTbLMahcGOS2/g/ENM
ARC-Seal: i=1; a=rsa-sha256; t=1522168252; cv=none;
        d=google.com; s=arc-20160816;
        b=WDyb8rdCs+H0mhLj5V3Sr28x1ivu3O0oaShYr7TBaekKmXr4jaN85PBsj4dbWUere2
         U8RcuSwSXfH1ayedOXSv6yi5oR0QEJpJfp3mzI6+mTaQ33UwE8/QMtE8H29dt+CCrGiS
         petBOChjn0kooPicwVspEdokLPg+dsvJ1tww9n2cidabMn3y14a30OnoXz48IuhKMQXN
         qIKPxxrelNVEKRh9UtLB0kdvheZe2qPg6UVWuOqXGY1Rot/gyAkE4hPdcV3v8iIg+Bnv
         xTGzrsXebYdnVc/hDY9lGEEc/E74Vgd6plCMA8xsNYmlWjN8xbXPdr4UAnwV3lQZ6Yiu
         f/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=slsUZ8xooCUY0vdmDANDxqSVpXDAainAZeJlC3OWBYI=;
        b=MzaWK3WsWKOTp+iSpRGYaz1C9ZjgFVp4/64FL2yp0Q1BmoXVEmDvJE0u5tSuUMmB3C
         O/50yMtqOj2c64/dmTGUGGFOKOAry7dRESKdRIp8V0RXwD2hNpjYXwp4J/BO0JuQOqmv
         HAooE25mIJ6mKt1YNL5UcLx1NeeHRQlZa5OVZFMOTRY0TIiKuJT26NsSeWNty/lNP9O3
         4AhZ+bFvArj+FNsZnx/16+VjVQuU5KZ3me6X0R76h4h0LhhFOE8jjDcKo5rXuG1Z5VUF
         Bf49GzKk5e9EUPEFTJlEZqq1ZbctaoO/+HwDfvAeea24dpUd0lv17ax1H4ZQaK/8aceQ
         m4Yw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kirill Marinushkin <k.marinushkin@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 03/67] ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit
Date: Tue, 27 Mar 2018 18:26:55 +0200
Message-Id: <20180327162726.875732341@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108963127558507?=
X-GMAIL-MSGID: =?utf-8?q?1596109097322905506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Marinushkin <k.marinushkin@gmail.com>

commit a6618f4aedb2b60932d766bd82ae7ce866e842aa upstream.

Currently, the offsets in the UAC2 processing unit descriptor are
calculated incorrectly. It causes an issue when connecting the device which
provides such a feature:

~~~~
[84126.724420] usb 1-1.3.1: invalid Processing Unit descriptor (id 18)
~~~~

After this patch is applied, the UAC2 processing unit inits w/o this error.

Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/usb/audio.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -369,7 +369,7 @@ static inline __u8 uac_processing_unit_b
 {
 	return (protocol == UAC_VERSION_1) ?
 		desc->baSourceID[desc->bNrInPins + 4] :
-		desc->baSourceID[desc->bNrInPins + 6];
+		2; /* in UAC2, this value is constant */
 }
 
 static inline __u8 *uac_processing_unit_bmControls(struct uac_processing_unit_descriptor *desc,
@@ -377,7 +377,7 @@ static inline __u8 *uac_processing_unit_
 {
 	return (protocol == UAC_VERSION_1) ?
 		&desc->baSourceID[desc->bNrInPins + 5] :
-		&desc->baSourceID[desc->bNrInPins + 7];
+		&desc->baSourceID[desc->bNrInPins + 6];
 }
 
 static inline __u8 uac_processing_unit_iProcessing(struct uac_processing_unit_descriptor *desc,
