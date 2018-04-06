Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/wNDWRfYeNcSTm9dwFR/mKfiix9DPxzFUCQNwzqZo2xSxIvs59DH5SWF2HjhvIp6giMY1/
ARC-Seal: i=1; a=rsa-sha256; t=1523021366; cv=none;
        d=google.com; s=arc-20160816;
        b=kI8/cuPFsOUUICdi5zbV/pJMevzvyqM0jJG9qWBBVI1whzIJ0Ut/6fAlj10aiLlnt6
         Qi4Cz9MoFejhJWJ3l1SWGRwqveC6U/DcsCpyCT+nXzbc7rN1kcUBXaI0KdDJnRrCH/m9
         YY8FymrGCR6oTSTMr1AZ9QY3tFyXb/iDWxW9249YEllTXCaeEY1Vuh/y9Owc/xVmyMEP
         gC9+URdOsfne6ppcnAQi3DcqkEre5kS/DKTdpMGqULmLdE6EGcGstkPHKxKP93T0Qh4p
         m77QprS4KeeWs9vOEbO088PAkE2jFIuqeGDsZDVmVdovLxLeZ0T/F1SnbHWrgDdtRFpg
         7i6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dqLMHpAlgrXrbC6CAjWaHhFm3cs9vU/oaewSdmYoN4Q=;
        b=zA/mKdRRZ5VzyORPOKlsc4uVCP2D+IZ+YTPflKvPXjmFQRg74GB2oT/J1QAzf3LxXj
         im+Wq/czSKBeCTD9FomV16/N1sAvrc8F3fAfMR0IY/GfoSyV1VI5+MhBhJ4fyxBaHauv
         QfCzAgYapmlZnopV1695TGGyjp1381L/DKKzv0A+S2INnStz4+aAYnD0pj70R0nLaCDd
         negfzIuQo1ujFmLL2onHTKD/KVFv7NkeOlJpu2fvFPgnVAI4k2P4h7GPYQVTBkNQhJ3a
         fVBWo2jG/DJ21awaZnrnPfdJ9/5ao1xPBW8+1k9bsrHsz1wy22Dx9R/xDachgTdZIlSP
         eg6g==
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
Subject: [PATCH 4.4 03/72] ALSA: pcm: potential uninitialized return values
Date: Fri,  6 Apr 2018 15:23:04 +0200
Message-Id: <20180406084305.423377682@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003466645806298?=
X-GMAIL-MSGID: =?utf-8?q?1597003653232589805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1361,7 +1361,7 @@ static ssize_t snd_pcm_oss_write2(struct
 static ssize_t snd_pcm_oss_write1(struct snd_pcm_substream *substream, const char __user *buf, size_t bytes)
 {
 	size_t xfer = 0;
-	ssize_t tmp;
+	ssize_t tmp = 0;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	if (atomic_read(&substream->mmap_count))
@@ -1468,7 +1468,7 @@ static ssize_t snd_pcm_oss_read2(struct
 static ssize_t snd_pcm_oss_read1(struct snd_pcm_substream *substream, char __user *buf, size_t bytes)
 {
 	size_t xfer = 0;
-	ssize_t tmp;
+	ssize_t tmp = 0;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	if (atomic_read(&substream->mmap_count))
