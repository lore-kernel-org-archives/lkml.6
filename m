Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48OyretYtDnkbQo1zYpdXgB06sBINxIDk/ZPTpH4TzfQjI0P9s2g+x59aZ9m4rSRbOFk+c1
ARC-Seal: i=1; a=rsa-sha256; t=1524406872; cv=none;
        d=google.com; s=arc-20160816;
        b=gJAWd8DmI2I+aunQhgqz4k99gkODqqXDHliqsbWO5bigtVinyhsV8ZJMzIXWaGsueo
         cMNQdf7KOug/diqtoehZbLuiiJvRtdYXK/YwSqDV7ReykWW9MPpBJLEqgaM6SEy5WGBN
         9zAcztogcg1VCS5GHesdC4xKKk2rPN3Dz7OgiZ1/t9NtPoc37G0h6kpMjvxw5HrNBtVD
         yM4Dgb5vVxJ/ofTvjWnae/wh+g+6Bh+kRzfJtqyJxrXRuriONMGLrjLzSrab4TjFFLdS
         7dH6/uDRuCKH344mMReY0vWk0JsP5BE7+uMtnFpIz1+B/xdlbnSEVF/1C3bHi7voAgGP
         uokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r+4KuXhB8ATOeI51nctZYZj9gNym8V8OPMUQS+8jwCU=;
        b=R42ZNIYFQYrQuKotvTzdIqvDZJtu39824FpK3WEyh4fwV3U90NJ+KSJNKaidAyJs0e
         ESHsyKK4jwekoi+FKq4ivJmGXsoNfQNPR8hAGfnebW25G+bEdrojgjN1KyasirZggJKc
         pvfEsyfFmzik5B0DBrIS77zJCqIJt4/wAt0jlScm1PJoMQQKL1jkTBK5mTdnPDAKzoDU
         2uwlCpWHNCncB1xCglqwsRMByXcKwnZAIe8/9n77V9Pst3sgNuRzmGUjSODuKKP7Gn28
         Ufn0e6q5ASw4knyKE8tDmSB200X4DKRlytd/yO9NbGzzxlZS74WY3ERTMKI9JWxjXiwu
         ItAw==
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
Subject: [PATCH 3.18 36/52] ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation
Date: Sun, 22 Apr 2018 15:54:09 +0200
Message-Id: <20180422135317.083787173@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455089227122133?=
X-GMAIL-MSGID: =?utf-8?q?1598456461244250113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1139,13 +1139,14 @@ static int snd_pcm_oss_get_active_substr
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
