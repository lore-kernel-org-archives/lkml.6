Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/7FbXwkylD1zBSMYArNfkw6+T5L/+0xfaV8hJiuz/iwBugdc4Fpe4pCXnoneoW6o3HLXYw
ARC-Seal: i=1; a=rsa-sha256; t=1523021934; cv=none;
        d=google.com; s=arc-20160816;
        b=rKEykeQOBnXZKhX/HZgMQ04Zr82pNivGGFi/y/xneju5ajyTBN0BBpiLROsdki+Jo0
         nlICWZ4mNkIz91UMiTfAK88uBy5BjrFMmObfNlgX30o/2Fb1IuVddb6B47U4H3QqJ4Kf
         QbaKCmTCBJNaP4IJoBP5W7wpjEapV6FzbpcTi+ol6MZ7IQpS6cocaSzkWj47UzXS8wfA
         Wz+4DNXFUcRKEYo0EU+h4yZHxs7K7Yk5dlQLaoq2E4ZFrq4OZdKZg00HcBZkdIMIbh/j
         Uwd4UbGHClyoWVKmiQtGksyq7EEp4hC60NjZqc8FYL9vVYnfwJa95WhVw+jQ+K99BKmN
         qe6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9YsdjPTG7Ac4Wngy7UsNEfquLvEUEAht025qIekEmus=;
        b=u3Jl3IPnf6Nly0TlwlxNsC/g/Lq5nE07zRV9DCGs/6R11grg5RGA/Bs2caxgP+xMcG
         AG4RunvGEFAfrdS8EOyip8vWWrMGva27t4D2t2+AvFfIX86DyH1kNbhbLB5GpvbuaqBj
         0uUHZ3yN99ZEi5reulHUsDC1HTYC4sXHrEBJl7dKEBtNsaKSeCnsJgz4wtlNKGNCQmnQ
         FXfGox35shjJYdyv0nyju1rl285XjdWWsIvinW0xQ67bDeZjR07dqxIR6BGFAXXWYdRC
         h7UXZLgk0NgCkdh6ZU1PCcDYUSDKIJ73zAwBpsy0t51praex0eZpi0TvZctTdifIP9Bk
         T5Gw==
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
Subject: [PATCH 4.14 09/67] ALSA: pcm: potential uninitialized return values
Date: Fri,  6 Apr 2018 15:23:39 +0200
Message-Id: <20180406084342.553424449@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003466645806298?=
X-GMAIL-MSGID: =?utf-8?q?1597004247785205161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1326,7 +1326,7 @@ static ssize_t snd_pcm_oss_write2(struct
 static ssize_t snd_pcm_oss_write1(struct snd_pcm_substream *substream, const char __user *buf, size_t bytes)
 {
 	size_t xfer = 0;
-	ssize_t tmp;
+	ssize_t tmp = 0;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	if (atomic_read(&substream->mmap_count))
@@ -1433,7 +1433,7 @@ static ssize_t snd_pcm_oss_read2(struct
 static ssize_t snd_pcm_oss_read1(struct snd_pcm_substream *substream, char __user *buf, size_t bytes)
 {
 	size_t xfer = 0;
-	ssize_t tmp;
+	ssize_t tmp = 0;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	if (atomic_read(&substream->mmap_count))
