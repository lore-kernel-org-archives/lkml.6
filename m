Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/qdAKJgK9/x8V/FXZ4k59oNQ7Ipj8qb3PNjz/5JyJn8k7Xkaoo00EhHewuQR8IZJzoV3HH
ARC-Seal: i=1; a=rsa-sha256; t=1523021627; cv=none;
        d=google.com; s=arc-20160816;
        b=ro55ewtz/b7chsRcNUl1FOii8nnGq6+Jb1AYSgi1+G1j1+qbr21nwJSO+tSUiR3Amh
         rYEG1LX1BUxOJX2XmE9a/hyCJ3lRzmZXlaTipMBOE7oqBGKdIM9QomqwAKLYh0c6VD6P
         k3zjBTbSxccaJZ2gzHOeaeYekMNFXsbUyNSrkaHtvaLl20iMr0JJp6MKUYgCTYPQNvQ1
         kizuBdCu9hcpNzi4wrpsnDYLTCuQpccl1XuSa7ejBKZ6aMVtHxM684qBsGgukqsM6YwW
         vlKp8dNYrbOC/2BaP16Yb5C+8OsIGujzfo3P7rd6Afp7bR2595SRsWuwpqn31r+yGKKV
         p/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cVCEN8sfogjjJzl9yx2o2aLys0JVWBMIY29BRclV0IQ=;
        b=HsBB+iTThpg6zviCrcicxQ73aZCHyfAgJVk6l4GGCEm7j5HuMhMut5pebSYKIBghXm
         fFAT6Rs50xH2Ee0ttw5291Qs1ra4cwQYrc57MusrlYr3vHMUb7d5TG0bNi5t0PrmFIH9
         c+ECax6qxYRqiyF22eyIhS6ieca8XxlFAYK1Zn3P5gBSAwAOo/R7NF1Nh8BesGDjxIC6
         XI5JlNCMaNqnr7qe1cS1MT7mpBEhPcGCoqrrCLmnYJKQkQG8lqmG7X7NpvrDvpwRIvn0
         bDr8M9+7bnNX+J8BdRdgNWIJP0UK4+DYBVZB0gkcu3XdncaBz5bM0F2Wu/NO0nU6GvVh
         MN4g==
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
Subject: [PATCH 4.9 005/102] ALSA: pcm: potential uninitialized return values
Date: Fri,  6 Apr 2018 15:22:46 +0200
Message-Id: <20180406084332.205311261@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003466645806298?=
X-GMAIL-MSGID: =?utf-8?q?1597003926059095845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
