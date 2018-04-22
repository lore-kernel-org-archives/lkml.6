Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ds8bCfP1zLGpXLBK1xeqIxLx+saEef/JqbnfZyB9dvOLT6Ob1lhLw6RJD4j5debmZN+7H
ARC-Seal: i=1; a=rsa-sha256; t=1524406511; cv=none;
        d=google.com; s=arc-20160816;
        b=Y7YmTzL8SjX6Ubj9TCDwUVc7HKRmsUepvbAeabOE5aQX2MJ+pSA33C5+cvhKUngO1e
         ShpKTwoXtXKTsZh2SUWHyDgtk68LyqWpB3sBXKzW0s+oB2PctdgmZfd+56upPmdFL3ZN
         gddxjdqPm4tqID+QDjB6Rd2bHlCea47y5dwN03LbzpcjpsU5WHTvKtKdXqxS+F4dsmdd
         95U7EswJn9SSYis89+CODq0Ui6rb0ci6xX/Gg4l3QWIhJ5ZRa5Ofb0vQ+axw25m6Ye+D
         qlRFqXxiLlI+9S0Pv/W+Uvm/O4mc+bxhluqeVWuLxnH/Y9OpgjLVkgkGWdmCgpq/NU9E
         ZzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YFLrAMxVFvCbMs+e66+uFg7uGlCu6WQuRKKWE1Dpyqs=;
        b=NTHbU4743K/yp34amGvRISgIK2KzxVbuEldLp4FfZmdnM029ZwSkE6WMezd50f3Hg7
         t5osXizZXuNGtPzulQWtaua+9+/l9t9qBb1/gp/5egoUgAZ7DKAbmga4ZOj43y81iZ58
         Kq6n629jNYOMahVG7GHEVq6cJz8lYVax54YAwoqSFLtT54cbx6/rivvYqOAixeOm+A1r
         xOs6dOqKIrYBdMp8ExfYGJb9usuGjJht3ribLh0nCeArI/hoWK6GkstIwrcqGaFWqNNO
         sEsXnI5MWBXIUrsHc9XH9httOfnRVXukkrrn3b80Pdn4k/OPNT6HZ9bQKzCWpSn+S7qf
         4TKA==
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
Subject: [PATCH 4.9 64/95] ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation
Date: Sun, 22 Apr 2018 15:53:33 +0200
Message-Id: <20180422135213.044412251@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455089227122133?=
X-GMAIL-MSGID: =?utf-8?q?1598456081903510713?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
