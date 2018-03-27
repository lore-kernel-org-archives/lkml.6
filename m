Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49N1cIdyIuPYVArn5Gvz3UmkbKs7ycRq6QJVHuPnysl/k4NeIlpTP786vUEyiZpzQzgduYq
ARC-Seal: i=1; a=rsa-sha256; t=1522168481; cv=none;
        d=google.com; s=arc-20160816;
        b=l34q+1Qceagfe6zz1thXw2AdA4W8dVgAwPQH7DH76IeEPVvoir5m8FJlS2e1LCpnuA
         3Msq40VP50L+1vIMVEzaSV/e8XdMcuykhEwu44PiTw86KZTzsLQmn4xkhpCeeguSkEPN
         cblFzwIa6LvLBlXR+eHRZ8kdpBfHQPcNcwL1D4IoSMaYjFJ4meDfSu6ifXsTsNScvPdH
         s41elcTNKIdNCNM5PT6gqo482YgIzhCRlJeindtkr+UPBtdhvfb15N1AqPlgC73TuZsA
         cHm+wR5jiScaQpqlPRYys9TOgI3TEekxpAvsDH98a4sgIgp1duF9UgUdrljtBF+j2o+J
         FLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=a/9Hr6LLR1JRpgij0FgeEbZsa43cNy8PC8+yzhfHtbM=;
        b=Ezy56w+Cb9/0bxG1cHKmqQAoqALeGQ1qn/louJ6eks7ph91270ilRRwONtzknr5jZT
         B4sha2ixYXPMy37Ekmpx2YAr37Aa2aUjX9BPv3GCF6AtRdfNllInpCRCEUYyymToFnE0
         BNTxp24ECoB8yfDz79OA/2cTdyrrJjH134T0K8gOv+k/KJqtAwrLFr7+KZ5dpadWn8Oi
         izDl4TvnVZHJH/1SA1uuudSdsadEg0B4MWTVSfYuk16kQdX15k9lpfOfaCrnffkvIoJb
         3EtcIiBwgSK3L8ZS5yPyezQWs1ysHdnr96op8xgKW8lv6U4HXorSoPyRxtNSP3/FKGVt
         u+Ug==
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
Subject: [PATCH 4.14 009/101] ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit
Date: Tue, 27 Mar 2018 18:26:41 +0200
Message-Id: <20180327162750.586090865@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108963127558507?=
X-GMAIL-MSGID: =?utf-8?q?1596109337628686307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -370,7 +370,7 @@ static inline __u8 uac_processing_unit_b
 {
 	return (protocol == UAC_VERSION_1) ?
 		desc->baSourceID[desc->bNrInPins + 4] :
-		desc->baSourceID[desc->bNrInPins + 6];
+		2; /* in UAC2, this value is constant */
 }
 
 static inline __u8 *uac_processing_unit_bmControls(struct uac_processing_unit_descriptor *desc,
@@ -378,7 +378,7 @@ static inline __u8 *uac_processing_unit_
 {
 	return (protocol == UAC_VERSION_1) ?
 		&desc->baSourceID[desc->bNrInPins + 5] :
-		&desc->baSourceID[desc->bNrInPins + 7];
+		&desc->baSourceID[desc->bNrInPins + 6];
 }
 
 static inline __u8 uac_processing_unit_iProcessing(struct uac_processing_unit_descriptor *desc,
