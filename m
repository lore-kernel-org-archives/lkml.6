Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48gr7Hp5tnk31O5mEZOcIWyZkzbYkj9LJj3KOcDXcCKaG5K1q0uk4JGANQjCp4mNzKCCEVi
ARC-Seal: i=1; a=rsa-sha256; t=1524406115; cv=none;
        d=google.com; s=arc-20160816;
        b=U40/JauHNzmZw1JqsXWmiTk/CEgwC2pSapCL5CJ5thDkkG4wd0iOZxG8fI891OBWUQ
         S2n3jBs8f7xmlbFVacgLc+CCBDmhTV9C9pPb9btaHUV/TDtQV62qodttZvudIsG5LiQ3
         kV6zD5YTqUUCDr1e3CPCN1Loe6q6qEqq+5cos3PrmHCjtbrd8V8JWYQ4Kdun00jQQfJU
         gJZq6Dmrnkq2RifB+/8YXPFwwg44epvy9FdbZx9LUmBOUJ+ojzDi51fASD/OsE+fY9Fv
         6uijjoGtNb2l5EXStdgxBlLZK+Sb2K0HsHbX3rlNWKYBSf3jMDEvK6O5PeNzFo0BeEtA
         I2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Lng6iOqC2bcanQQmvUtxLrhKpSqNmJmuXRonwu/AZZ4=;
        b=PsWLo8vI58rtJ56P1Ju8W8qtIQdMGKL8i3shx6f3magByXNOLj4aFMM+T3zFj2rB0c
         +aOa4hiUcufi/4LTHQEzVyXSXGr3YdjI/OYXvtxGzLEEf8iAyc1QUnBFa6D1s41N6AV4
         6lvqIzc+MenfAyjYPgaF0z6ph+gpxreXMRgI31ccj4lC+o1S28mcrcd0otsnmouhdhgp
         uAo8eiYrq0KaUoAUfijbkNNpWwiT7JSefh85yqmyIjxk1U8pbCfzMnyfejBWBSRDKdK/
         PDVNTw38EdPMfQZfadwfm0HJfXWfIVXwKIGRW/gw3L3GK78rGEnzom/w45tJqQYVxZXF
         aNKA==
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
Subject: [PATCH 4.14 119/164] ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation
Date: Sun, 22 Apr 2018 15:53:06 +0200
Message-Id: <20180422135140.279387400@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455089227122133?=
X-GMAIL-MSGID: =?utf-8?q?1598455667212297944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
