Return-Path: <k.marinushkin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521439850; cv=none;
        d=google.com; s=arc-20160816;
        b=xS9zOxELmQCfWARQDXkT4UX8YCOTYeCnOFPS7xq5rmbrFtxd3owaZsYU1j7g9s6RcF
         nw+pPmmECrKXF48MZmbY1qN8N+C5Ctp0m+euEpSDp5+pMSwFN9DGUyvvvch58vuOe4bo
         74X78ffE022QErb95CNi8XRUp88JtRfMQN9gHZcvcqcfkbCCkRVVGSNtEz+h0CfOh9Wb
         0UAtwQ3fvhxogQu5FNfJ79pdHknbrgIqVeNLR+ezpADvnxazjcaeUEdsrOImpjaJt/P0
         kPkvmA+k5oEFsz+taZZFSeyRzlR59aDPlCmkuUfuekNKr2E2rPrr/GPG0hXm/yJcSIgY
         lWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=WeCQzlB6i5q/Mc80NhoPVqkp7KvwMOaBmrSbCZiP0s4=;
        b=m9iJrjJps6w7RC6V6g+YE6uficzZZeZVwDuqJIoGJ1nPWN5geXO4/9qJfmPl4ao8G1
         2R7dTLZ1e7FU53bZYLvpHMoFU/RohYzEqfw1Jk7rPvaIGG4zAlM6a3SUOBu1z6MS7tQ2
         rPkF/Mo6hO4s2GgGVzKQy+kBlFvL+/iG6V5fxMZC/KV5VqFB51/evok1v7iERdVW3on3
         wu+6rxtVrUOOhOqmA5Km/+fL7CNY+7ZkZQWZYcxyLKIo/iYGoWIcfmNjBOSX7C5d7Eki
         Yk+A2B6vibRrSn8gSpBsQBnfreW8qRNXJwja8zq1SZJc48MCihQkvQyTzK0xQDutsTeP
         SA5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JsXH4Rx/;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JsXH4Rx/;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvKkfsoVTFi7hCJBfjEXoy9Bqsi/4ouCl478mQFn2GWsFNHsrK2EAZFbOFIXpqq9DGQ9+BlUw==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ruslan Bilovol <ruslan.bilovol@gmail.com>,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit
Date: Mon, 19 Mar 2018 07:11:08 +0100
Message-Id: <20180319061108.24178-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595345312154569888?=
X-GMAIL-MSGID: =?utf-8?q?1595345312154569888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently, the offsets in the UAC2 processing unit descriptor are
calculated incorrectly. It causes an issue when connecting the device which
provides such a feature:

~~~~
[84126.724420] usb 1-1.3.1: invalid Processing Unit descriptor (id 18)
~~~~

After this patch is applied, the UAC2 processing unit inits w/o this error.

Fixes: 5e1ddb481776 ("UAPI: (Scripted) Disintegrate include/linux/usb")
Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
---
 include/uapi/linux/usb/audio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
index 17a022c5b414..da3315ed1bcd 100644
--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -370,7 +370,7 @@ static inline __u8 uac_processing_unit_bControlSize(struct uac_processing_unit_d
 {
 	return (protocol == UAC_VERSION_1) ?
 		desc->baSourceID[desc->bNrInPins + 4] :
-		desc->baSourceID[desc->bNrInPins + 6];
+		2; /* in UAC2, this value is constant */
 }
 
 static inline __u8 *uac_processing_unit_bmControls(struct uac_processing_unit_descriptor *desc,
@@ -378,7 +378,7 @@ static inline __u8 *uac_processing_unit_bmControls(struct uac_processing_unit_de
 {
 	return (protocol == UAC_VERSION_1) ?
 		&desc->baSourceID[desc->bNrInPins + 5] :
-		&desc->baSourceID[desc->bNrInPins + 7];
+		&desc->baSourceID[desc->bNrInPins + 6];
 }
 
 static inline __u8 uac_processing_unit_iProcessing(struct uac_processing_unit_descriptor *desc,
-- 
2.13.6
