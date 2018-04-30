Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrDAUMxoob2vmhiJ5npOvErZPArvAf+Uh6UHxfpjN6X3OTiOjING1vIoUaXG/h0r6sZOz1p
ARC-Seal: i=1; a=rsa-sha256; t=1525116497; cv=none;
        d=google.com; s=arc-20160816;
        b=TNMmseFZ0C0KGTjqrEvNv5LqLZWLX8ss3rk41lPkBDrk5zDZhj/Cz0+RrQ+7eTzvH8
         AiF95wouju7ewNdyW/5cr6gaqaw+xrqEdNj/Zjy8E9CSDf/s3Ht/DYZE17STrAZVzlY5
         c6wxTyIHSxIiyLJTzyT0W+fNmc/Yjycfq3ovB3VOJ4wygkRsI+23WkzlGHSpxQ6CxkrL
         yyxJsHeP/1e+lbrS9Guyx+tMn1490oLXxPShQy3m3OwrWW6V/8omcS+KOS+L7iH6nqvR
         DQXgXMopow18PDA60/5ZgrypAwpYcuYUcbPJyZKeSCKNyg270ABpaJjDYLPmlZ0DJjcS
         TF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=UafsftucGLMpLcydjHq/Q0M27cvCip5NOHmE1GjZj/k=;
        b=rUpLiJeVHPxyuQZ7VyxT9aBEksuexRquAvb0xLBaS3uZEAYZvFZv5DvTalSBCNAiPE
         8Qf3CQ8J/H6uM8x5VPrvEUd+GgRr0XjVV9GO/RN1fYYCmXMYaJ1YiI5Aff1FGOAMiXka
         0VSXVdfGNDpXBVe36ALO5mAvS+xvozyRTBFAGK2nlZGhqXRktxqQuDyrUYn+Q+MHVLvl
         WSsL1QGCT0BTlWmlKFN7QrcUh48yKue0GcnmPtJuDJ0CDBEXtiDEE5mGJE1ecXWOMSBV
         EoFEOkckHb23VaGqSPYFv3j1ED/33jRuZQrNixSnnli/LGtHgMvK4+KJ5z4L362G8oeZ
         L1Rg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB5A22DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 048/113] ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
Date: Mon, 30 Apr 2018 12:24:19 -0700
Message-Id: <20180430184017.086433596@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200282251951106?=
X-GMAIL-MSGID: =?utf-8?q?1599200555883603569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
