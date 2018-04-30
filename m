Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqHsTcs/ecWPYat8i4jvCx/b7YWUXpKTsWyraPAUSthFRzC5stAUnfJz9GIwcjdMy/0YFSO
ARC-Seal: i=1; a=rsa-sha256; t=1525116391; cv=none;
        d=google.com; s=arc-20160816;
        b=nP37uaMKpx6hHCpHPVdif0QQQwNX+O02BXEftciOHRpGg6pmSAeesaqdDuomCqy18A
         o/8UFb2H1YmykGcYbHzRbHDaiBjw80j/MctIgRBeGxkTDOEQhb3KR+U5JLuarRm3XjJ7
         jvbLw9Qz/OF/tOT68mXLAz3gspFPsW+tgdKbGo+47+C1baPy0vCKBK8Ls0wR1ST+aJqg
         YCyDOW5YihvsPsoC4DXjuGwiprOPz1QPfsFgSDVt76XieE9XfRmFp96CtOAWw3+92c0X
         kXTRsyiR+WgV55DmsH/JWtZp1Ejy2sz6Ju9YTAhzWJ0sjvAXAnXIjWKJ8qj/i5mo0yJY
         2rKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=aW+OB4dBjMIpTxss8Kxl06QcM8zirr7Cw0d/1uIUSrc=;
        b=BJSxPuD2ktrgogjrsZdwjwIO7Wb0dFYnSTKDFx/96LTWjvCTIV8sL7j38UvJY5ttWu
         uBGtDDWXA3VvP/HYPZ3EbrYDU5CTfUrpIYG/GE11cgyhk3JT1lQ036AR9Ff+Gb/iKLZ8
         SZQLdePtlqZNNiDyM8mIBJLwp6sCqJ0nTdBvcJhvO11eIflNrhJmC8y+L0IAjDDiSceY
         9LbzxkJt/qrGJmxsOCZXTY7iv/E+fFbDH8DKg7DUNrj7nysMuxa6MfRiuZLEmYptv4dC
         l1f9WKvVQDu2FY7B6oibFr+NmB4RXR1FH4AB66uww/rN4s+/GMxDJl05W1yENK+qLzBE
         dJGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BBA22E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 32/61] ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
Date: Mon, 30 Apr 2018 12:24:35 -0700
Message-Id: <20180430183954.120329729@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200282251951106?=
X-GMAIL-MSGID: =?utf-8?q?1599200445631664245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f5e94b4c6ebdabe0f602d796e0430180927521a0 upstream.

When get_synthdev() is called for a MIDI device, it returns the fixed
midi_synth_dev without the use refcounting.  OTOH, the caller is
supposed to unreference unconditionally after the usage, so this would
lead to unbalanced refcount.

This patch corrects the behavior and keep up the refcount balance also
for the MIDI synth device.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/oss/seq_oss_synth.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -363,10 +363,14 @@ get_synthdev(struct seq_oss_devinfo *dp,
 		return NULL;
 	if (! dp->synths[dev].opened)
 		return NULL;
-	if (dp->synths[dev].is_midi)
-		return &midi_synth_dev;
-	if ((rec = get_sdev(dev)) == NULL)
-		return NULL;
+	if (dp->synths[dev].is_midi) {
+		rec = &midi_synth_dev;
+		snd_use_lock_use(&rec->use_lock);
+	} else {
+		rec = get_sdev(dev);
+		if (!rec)
+			return NULL;
+	}
 	if (! rec->opened) {
 		snd_use_lock_free(&rec->use_lock);
 		return NULL;
