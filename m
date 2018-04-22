Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/OdOWGAEJVoUzAKCt5vTipz4sANjHOSFLSsFOE2hF3zx2lalo7QPDEKJebEac1EnAC4FuA
ARC-Seal: i=1; a=rsa-sha256; t=1524405564; cv=none;
        d=google.com; s=arc-20160816;
        b=XoYVh6uyYYhDJRSsCdRiMkAP9uKi68ClzUE1sGW1v4wRYFn/34hrMdGPG4xytzlm10
         0Zxwis7xvViPgS0tyrOuSMD6l0rdwfSKrRwUyCssnoXiV4suqAxetdbrsPO/XJgWzXMG
         lH0vV+nM/EH3jKQ5gZgmfCakQgF3WwT7EHMn3WtJCC88Lli4bAvFa3N85w9yxsZGiu0s
         OZOd8A7Vm9W7hl6HtDcRVpjSP8IokpevRxhc54n9s7QMxBtvIiEHlGYuYlBtnJgj+zCF
         AUuFy+jYNbWFNcbBkGAGnVM2WUcRWtNpiiEsSpFYVgrSftTf173nhryoKFctuvXVsgxw
         WjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1xXTowv0GVTbTuRSpKRtaTedE2ZQUrEYPFfD64lL6FU=;
        b=uJbvAi6CbVnZkti7cD59K/cUIkt+RRInJnWWXC3Jw0eyjMNsgiYjqOs73yHhoJghF2
         dIWU7+k3yIPB7CJdy3/L+oLJtpqmxrzeP440H5PApZgnE9+OI2M5VnbMYTkYhlm+OnWi
         BtBKtEKaBJVj38KBpQLzGmip8WAJMalQNWCaElmfTa9ufPHkK8KLkHK8YxbqPsleOtPQ
         ZNjzeBWed2Wuh0w9qINq566ImZemkYFOveRE7VsXg9Gvgvo3GKn2EBTB39mrmrZs5NXS
         qIEtHqOD5PmFZm4W4oDDMMWZgwuLQJj/Xd0ygW1PjPYGIwn4MkmX6kuiLiMdaKc+WvFI
         EMRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+150189c103427d31a053@syzkaller.appspotmail.com,
	syzbot+7e3f31a52646f939c052@syzkaller.appspotmail.com,
	syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 112/196] ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation
Date: Sun, 22 Apr 2018 15:52:12 +0200
Message-Id: <20180422135110.065203129@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455089227122133?=
X-GMAIL-MSGID: =?utf-8?q?1598455089227122133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit e15dc99dbb9cf99f6432e8e3c0b3a8f7a3403a86 upstream.

The commit 02a5d6925cd3 ("ALSA: pcm: Avoid potential races between OSS
ioctls and read/write") split the PCM preparation code to a locked
version, and it added a sanity check of runtime->oss.prepare flag
along with the change.  This leaded to an endless loop when the stream
gets XRUN: namely, snd_pcm_oss_write3() and co call
snd_pcm_oss_prepare() without setting runtime->oss.prepare flag and
the loop continues until the PCM state reaches to another one.

As the function is supposed to execute the preparation
unconditionally, drop the invalid state check there.

The bug was triggered by syzkaller.

Fixes: 02a5d6925cd3 ("ALSA: pcm: Avoid potential races between OSS ioctls and read/write")
Reported-by: syzbot+150189c103427d31a053@syzkaller.appspotmail.com
Reported-by: syzbot+7e3f31a52646f939c052@syzkaller.appspotmail.com
Reported-by: syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1128,13 +1128,14 @@ static int snd_pcm_oss_get_active_substr
 }
 
 /* call with params_lock held */
+/* NOTE: this always call PREPARE unconditionally no matter whether
+ * runtime->oss.prepare is set or not
+ */
 static int snd_pcm_oss_prepare(struct snd_pcm_substream *substream)
 {
 	int err;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	if (!runtime->oss.prepare)
-		return 0;
 	err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_PREPARE, NULL);
 	if (err < 0) {
 		pcm_dbg(substream->pcm,
