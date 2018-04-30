Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpgA+0LQ2l01CjolYIbN5OnwBe6T+7C5Xf2xSuHeOk7OpBn5l7SMF8yXvmUXFtibQJyCT+9
ARC-Seal: i=1; a=rsa-sha256; t=1525116235; cv=none;
        d=google.com; s=arc-20160816;
        b=xWGt7Ay5HNu/Pp0vs8aI1HaBt4FVW8aM8uI+9gD0kZkT19ccHZC0No5Ly9pxdsZI+A
         hFR4NsyxppDcAwmhSa0UVC5GrE0daXhkEiqNzDmf3d6WyQLEbku1y1o32PwdeSkWpsgd
         p1DLTWRjxvTAsLG4AJijc2VAo8PmmdXIo6b95pKl2SK8fTr9mgKthqrE7jtFWU3nxfto
         zgraMkJZt4lrBiwvEkZrqVHRNYXJ21SsajxKyoSz2jPVoKNY+iEf15H5CmE5SonztKpw
         vx09tt5gxtJcTEy1lTl0fSooSfeQ9HIwQJPGjDIPOA8MPIQFM+Qrnakq6LDg7mZm8rQD
         MsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=XiBJlB0Da7vQ2iJNpQ2OVA4JgtQLmLlbsoLupOpt4qI=;
        b=c+p27l0IaW/AzRizOXqeoUeqCTE3XeH8LZ5MoOAiBTFCmtWbBf/iogFIAbsEpYabSI
         wSt/6bNxRMRTJ+zPGPvJxbgKe+032+rSODeCwn2cNlZ+Zhhfj7vj/qIgazoxaInrgGKI
         /efWS/1q5/UXn1sN+HOfivqMVVeUivf2oX3Bt9EvVzJI0qHa9IBVv2v/DG3t3Kwj9YtU
         NcKnTMOmxI/3oZi/ncIYi8yirSsBqIHVIEf4XUw4K8/gbbqw5Qp1vT5FBbLZlSh5J/vY
         nR/8GxrIV9NSJXHdbCviWFB5dVzk2J2+Izuq+MLducYhj0cIBSJkYqB1mm9kOZy+bBRT
         R7nA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FE322DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 17/25] ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
Date: Mon, 30 Apr 2018 12:23:24 -0700
Message-Id: <20180430183911.517053143@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200282251951106?=
X-GMAIL-MSGID: =?utf-8?q?1599200282251951106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
