Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48K8NBppyz6iUF1+J1K0fI8jH2pQ117otmDO0BO/gb5oiMu7wDqe/MEfPZo/sYiR8FRvLGo
ARC-Seal: i=1; a=rsa-sha256; t=1523021189; cv=none;
        d=google.com; s=arc-20160816;
        b=efqUpx8jgCz8yflBjenOmdRz6apHvv4IQgOBq6kEDCnsmC83sBpb2fBev2WT6mOM8c
         JeKsRE682YxVQpUQFs3djbk5GaSU/GaFkA/SQ+720XU4NHGi2J1D0cRaQuHuwxDEPmnZ
         p5qp7Zv4iSOYLpkA56tdQY/qVOTr5YEMm+4msPI1NT1syuQTZ4eKgwXGt03dhEwlndFf
         x/S6Zk/Zj8GrZ9yc+QNIH7J9kTeeqTMf3Vv3uNnVRx8zGEBeFZ8d/0/UQKAvBhWLJEmK
         mhuGj0JJhtl+vExpx3Fc/pTSion6LGX34uBVHiEeuPrOZWb9eFCSdFILX+vk1czbC4/t
         0I/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OozDWS29ufPqhE50wSHn2nPOoUnmtJHromVQl9vZSvE=;
        b=abeKIWFLzTzIRJVSy+MfEjacyjjCz7HjClZGiPWIFhOUcHpkYBImXzCoQG617WIfc7
         mI6wCGMV2fpLHtAuEQtSHCmHhEZIzhwx/Fci6DN4938tRLHnCTVWFUTmX54OZ9FlPHRg
         mrGWSREWa6SeHTuxu5BhPvftKz4DU5pr7lJD+64X9NW6CTeCE4LBoGLKS8q3rvVHcSjz
         K99ul8L77Cuys4YnNxFMXXr2WLDvg3H4F81EQGypCw1AWQzS3cJR1+u5tFT3GkM6HTD8
         Q2Tw7sW+qOvlQ1qi32/YglfQCP3aOe9h/ey+AHWk1SkGU7owrAIarSlsVKAc97P4PYCT
         tbaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 39/93] ALSA: pcm: potential uninitialized return values
Date: Fri,  6 Apr 2018 15:23:08 +0200
Message-Id: <20180406084226.657091187@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003466645806298?=
X-GMAIL-MSGID: =?utf-8?q?1597003466645806298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 5607dddbfca774fb38bffadcb077fe03aa4ac5c6 upstream.

Smatch complains that "tmp" can be uninitialized if we do a zero size
write.

Fixes: 02a5d6925cd3 ("ALSA: pcm: Avoid potential races between OSS ioctls and read/write")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1362,7 +1362,7 @@ static ssize_t snd_pcm_oss_write2(struct
 static ssize_t snd_pcm_oss_write1(struct snd_pcm_substream *substream, const char __user *buf, size_t bytes)
 {
 	size_t xfer = 0;
-	ssize_t tmp;
+	ssize_t tmp = 0;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	if (atomic_read(&substream->mmap_count))
@@ -1469,7 +1469,7 @@ static ssize_t snd_pcm_oss_read2(struct
 static ssize_t snd_pcm_oss_read1(struct snd_pcm_substream *substream, char __user *buf, size_t bytes)
 {
 	size_t xfer = 0;
-	ssize_t tmp;
+	ssize_t tmp = 0;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	if (atomic_read(&substream->mmap_count))
