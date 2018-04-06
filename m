Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48TIc0mAvFMDizFLdSuiZBIkklqX1v7WPp3yo10K6kqwRsXmQc+Y+BSunoVsaf1wTZ9lwDf
ARC-Seal: i=1; a=rsa-sha256; t=1523021104; cv=none;
        d=google.com; s=arc-20160816;
        b=wSOprnr89/MMcuy5UEaMhriNxSZoLWnj0w2LEWQRFmTdQTNHSAcx1FjS8/0Cf3RXO+
         yazSf3vm3N6pU4lJN/ghPQA56zyT7WWh6TbtyBP0rz9D7w4bPJQ4uCNGSgBW5Nkv6kle
         LdVj/UtmgKT7EhfBDE+JYqwVEDsUaefW3bsKcs4ACCmmCm0pRNaT0gE+SaBxw1Vpa6kR
         Z8pVfpFHKRpJpKwIcBY01WnoHYRWVeuICkF1pFrpHUjm6XEgTsjtJfJuR52ystuRUsNx
         aZpICjWw2qMDFoZFN2+xlA7nWCQ0s7P6QoHpfXVJ82SCK3HZRmmGhW5zp7mg/erF7uV7
         MR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w6doEwUz0e0tiMRE/sj2xjFIXDHN4n+lhXn5USPQ9b4=;
        b=dcK9DrkCuP1UH3dJg2gVvbgbr2amUAjiHzaK8OuOXjt3IyfQsb63dN3EB6i7I9Tt2j
         XzdjrVkekpiDk0QiHCMuAtRwVpFoOL5fTSY7gkYje2lEoRMW/dTL5ConaPKfuGd1Tdt/
         7sV7htDBq7txTFeohQZoClFxcu6NHDpC8NkqeankV7coyjXRbZ86BLHV9/dNSzhLToH4
         MJoCvLTN5KMawp4oPMDg/9732zWeh2vqW/QeEr7aOS+nyWxE/cCAnRPQF3BeQh0XL0c4
         MXUs2Fq/BJ1GULiVhBPNivkjrsBJoPFXagaHw68bG8s37a0WnxEADwH8rEFlSqKVJmCE
         qqWA==
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
Subject: [PATCH 3.18 01/93] ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit
Date: Fri,  6 Apr 2018 15:22:30 +0200
Message-Id: <20180406084225.029537157@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003377535296095?=
X-GMAIL-MSGID: =?utf-8?q?1597003377535296095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
