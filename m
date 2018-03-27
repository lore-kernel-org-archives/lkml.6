Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ixGBM+kD035dsq09K2ZH1ynPmGK/igieNB2n4jBgk/l4NalFKzCKiv5t6U4ZqRelt4VZu
ARC-Seal: i=1; a=rsa-sha256; t=1522168812; cv=none;
        d=google.com; s=arc-20160816;
        b=sX20cgfNSMr1MDCgCbeAcjL7YOwNIY6xXjUj3V4kjPTdwExpum5rqzQca/nJmClz7t
         r4vCcJHn8PezogIO77gNmGdI5Fb8Aky4cDFeoVRXopuUpZVNsH813WCiP4kalKZwAHYQ
         eJIjW4X92WBqI9W3153+XXwabNoN0kBP/lYGrnLYDVMaraQisScySOIofgjgLMwwoIgM
         qzOjwx8c6tqWNRrwX6xQXcxbeczBcO1mfSMcl0gSDl2KjKXICXkSUcI200WEu41OUfQC
         yg8Af6p7CmkcPUdSUO/+K3OcMLnNxlzTdhmuZCMJ4jQX162/R8D7RuI5t7YDfG6u4FMb
         hgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Go33aKfL4lIF198pmKmM7hhN6NmLNUC5QOqR4vsTsTY=;
        b=xlwLT213GciJnSkiGKQBiHWwQvGZi9axtz3hu9wO1rxgA6to4pxUfv2E8sbYVmQjFJ
         Dl8iIvLkhwgvsJrCawiywp8rXUHMMmeoPh2yWN/+GE3wLQ5SQtbKLtj34dNKdzDCfrY+
         LFtw8okghYMGftUXOcYb+Q3s4tWyPZq/q9SDtQP9olACbV6Fr+ta6lamy/Ol0JnyOidD
         MPI8h9yVDz/pjfGGU9jOEiXfPy4GfYxHK6N5UaIBJPLcyBPlUGcaB+WR6TL+Mc7e2tCE
         PsDGH8bU3jV2XrRcyUiMXtCy3XYOlVvuvK51XtwhnOffv9uLVNAKAFNaQbh3+EaolMKH
         9OMg==
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
Subject: [PATCH 4.15 009/105] ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit
Date: Tue, 27 Mar 2018 18:26:49 +0200
Message-Id: <20180327162758.234163852@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108963127558507?=
X-GMAIL-MSGID: =?utf-8?q?1596109684383844259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
