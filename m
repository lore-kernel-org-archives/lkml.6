Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuPcYor5neN7nOzqfNO1X2VgYxraEazFxW14oan5g3GgPiqDf4O6kudjBQPma+C9xj0QC8W
ARC-Seal: i=1; a=rsa-sha256; t=1521484162; cv=none;
        d=google.com; s=arc-20160816;
        b=kNUz7iJRwHPeScG/vVouf/Ca0BnKVGTZAqRgbMNFCSPtUOSHNSjgNVCn5gGHxFWGKm
         n3X7ShYxDEcGnFzV9VaemaxocxjnoMrMTRco2A6U2J6SDh8tmFYuzW0/KPcM8RNSEYQL
         XRbyiq4co4wFclawHylSMiGuwUjyME2Q4GMrvkXjEp78jQqIH571EoFHvalvNNDp1ccK
         KW5CcbfYy325EOyeWYSbajqKDW7DTYpqhBL35scOtTD0o+UHyAwUcQYUqGEKRR/DimiA
         UiuetDMZJkpBhLTMnI4DOCCnEtXvtE99sdXO4I8VkTSrTdC7PvjSoo4i5kt5nn5W3gl9
         IlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0jGjX/TxaCCk8QD/P8XsOysdk8MAJ/F2v9LUGfvW4So=;
        b=Qxfa1gOCnA8+l8isbGgqV59nEyo1GypSdxVa9ASrRkEOqih/hiuFJOss0QxNNq2g9A
         bJyn3bggcbjC60+r2PDkynzOku2kDehQRi94DwN48zVxoAol7/bSTsZnpsZbhTA6UjrA
         PQcF4SQhU7QNthCI5FinM6CwxWmwxyyNb+CX0hi1RdOf63nkWynEtCLDTtB8xdbSh4wX
         tsks3E18LLdxOANPf9wR5YtugqX4Nu9nUjpYXxpcCiYQ0KIcjmMsWsVQxSnzueGZqlLX
         xrqlaL3BZvrpa3i/4fPT9+fxYU7+t68IIKnHS+FBM0DSlqSEEP4laOWgmkP/t5riklEz
         v+BA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+4090700a4f13fccaf648@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 13/41] ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()
Date: Mon, 19 Mar 2018 19:08:13 +0100
Message-Id: <20180319180733.068995288@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390642761119786?=
X-GMAIL-MSGID: =?utf-8?q?1595391776271314015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 01c0b4265cc16bc1f43f475c5944c55c10d5768f upstream.

snd_pcm_oss_get_formats() has an obvious use-after-free around
snd_mask_test() calls, as spotted by syzbot.  The passed format_mask
argument is a pointer to the hw_params object that is freed before the
loop.  What a surprise that it has been present since the original
code of decades ago...

Reported-by: syzbot+4090700a4f13fccaf648@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1762,10 +1762,9 @@ static int snd_pcm_oss_get_formats(struc
 		return -ENOMEM;
 	_snd_pcm_hw_params_any(params);
 	err = snd_pcm_hw_refine(substream, params);
-	format_mask = hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
-	kfree(params);
 	if (err < 0)
-		return err;
+		goto error;
+	format_mask = hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	for (fmt = 0; fmt < 32; ++fmt) {
 		if (snd_mask_test(format_mask, fmt)) {
 			int f = snd_pcm_oss_format_to(fmt);
@@ -1773,7 +1772,10 @@ static int snd_pcm_oss_get_formats(struc
 				formats |= f;
 		}
 	}
-	return formats;
+
+ error:
+	kfree(params);
+	return err < 0 ? err : formats;
 }
 
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, int format)
