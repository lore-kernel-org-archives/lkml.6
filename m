Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4985flx5umplhnLPwKLMlVoXLDmHQ1CoPT54doqlYiXtdccgPgfx0fyaDGLsqp4K3gxNAyB
ARC-Seal: i=1; a=rsa-sha256; t=1523022082; cv=none;
        d=google.com; s=arc-20160816;
        b=QMUpZ+DQ5qkXtd1YXp8rSzHyKJrQwu6nBx7bNdDeBQIDp22W8BMYALwa06z2eM/ZNh
         nN0VrsLcbrkXYQxpodPPgHa50FqbQEv1Ioezk/KRSdNZUYBh8acTBXUluOwF7d8jNgP6
         CfQ6tt8tl/itnAsj7ZiIghFI1hSywXbh8YLWtmlMs5rg/6jWEEOEmMScoP3JVGsk+f4P
         E1eCHwCByRxouqczgiZdUrbHcXauA4ljuOjkdIaVjnebQjWp/wmJo62LStRkukE8SlwJ
         9oeHh/tT3F6P10rvgmQaaBAt+3TpVltBJXEBbj6SUIks30IgqYnyjfFu5wxnmBpUBk7e
         vO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QxnL1sBD1DKWP4B5QoU1XCFO8+KfD0vuahhWtQUCHWw=;
        b=jo0K4xyAaVOikDaoUkKo3oVT9ZCkEyTgCh/bSp7slHpTXq0KnY45xlXmljG8/KqiEj
         4xV5eBjBxohJCzrcyj6lVWdbsGZb8KtulZ4PrmMOYeNOBRFDBMQvLoq0djicWo+drW4q
         3ddXesV0EEDlEqEUa93vXSQAc1K07FY68N2hfpjJE1AB5M500hWCwMeqxY0hx5e7MvsC
         /F3AR90EVww7TsIXcscAUjwdXMnyU2NfxjgdEB7uQ1zh/F2/PCUnLHsL6zKCmf8Im9ZQ
         h4XR6MD5QsOl30DyqQgfZsoUXIoUX63hBU5VXHCbr5yy74ISaX4YqAHiEG4h8U7+8nWx
         jFIg==
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
Subject: [PATCH 4.15 09/72] ALSA: pcm: potential uninitialized return values
Date: Fri,  6 Apr 2018 15:23:44 +0200
Message-Id: <20180406084350.274923949@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003466645806298?=
X-GMAIL-MSGID: =?utf-8?q?1597004403289581944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
