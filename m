Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227aGK/j9SpQQrcKYCgqX3Ij3NqfumLp9v72nntppIWLQCBlsn9ALsfHe+edt2bMW09HpDZb
ARC-Seal: i=1; a=rsa-sha256; t=1519217167; cv=none;
        d=google.com; s=arc-20160816;
        b=clsTZoDbzDiHgKMoqX+7KDJuNhONT1utIA/qEfU58bOKHWIR20BTM449AweyXlvdyT
         08cswfm3p4F/1j81Iy7GByS2FksOFkWCtNCtji7T3ldtFpjuBcX/Jbedq2Z6p3yoc6d+
         9eyZFxmzK0vej/3sNWsev4Kwyr2tk5nen1sqcwvLolBCD6h4gsEAYxzifkBhqnpxp0/U
         /64Ceu9uSuS6Ljm5t+1aXJQ/Dd8ECPq64UMX1qIxglVNYrQSOUuTMXcnu3cX9/1n1FqJ
         ZNylt60pY9faekjWuRbDTWgNTnYAfJLAQ6C0RhMdSPfC10rHBWrjv22RUuzpWYtPyOw4
         EpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gbrpzSUuv6uhYnqmfPSbrrY6QvG229JRzUNLvhzgpR0=;
        b=eH4cD6kn+CtgRkjS52pNGd6C41TTBqLp7UK350EGpiVRrOsdmnLoqD1LG5GKO1VYP2
         thEQ19cnkEZZnobGW/rzdxgmjmJoJK/IuCA4CTBme8BnS6kAg+8Pcf7Q060SeljOGm2z
         O/+vPCjEqyUNUlCfml9ayn7sKz2FbAq6A2fgsNXQzFBJqhdThJwlReKMjailP9QOwJ/Q
         uG/kXp4AHE1WtZgKaZ7FaJT6s3T9ChgZRu5ywUerTnA6ZvurGiAKspWX1uBfHpxoJsob
         tTxdzU5UZrYmtCo6rX2i92eNGkDkCdNI3TUDPqbruljTcrh6dc5c5rQm+QDlAWzn1ddS
         V/gQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?=E8=8C=83=E9=BE=99=E9=A3=9E?= <long7573@126.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 26/33] ALSA: seq: Fix racy pool initializations
Date: Wed, 21 Feb 2018 13:45:09 +0100
Message-Id: <20180221124410.970901445@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014660626611900?=
X-GMAIL-MSGID: =?utf-8?q?1593014660626611900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit d15d662e89fc667b90cd294b0eb45694e33144da upstream.

ALSA sequencer core initializes the event pool on demand by invoking
snd_seq_pool_init() when the first write happens and the pool is
empty.  Meanwhile user can reset the pool size manually via ioctl
concurrently, and this may lead to UAF or out-of-bound accesses since
the function tries to vmalloc / vfree the buffer.

A simple fix is to just wrap the snd_seq_pool_init() call with the
recently introduced client->ioctl_mutex; as the calls for
snd_seq_pool_init() from other side are always protected with this
mutex, we can avoid the race.

Reported-by: 范龙飞 <long7573@126.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_clientmgr.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1012,7 +1012,7 @@ static ssize_t snd_seq_write(struct file
 {
 	struct snd_seq_client *client = file->private_data;
 	int written = 0, len;
-	int err = -EINVAL;
+	int err;
 	struct snd_seq_event event;
 
 	if (!(snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_OUTPUT))
@@ -1027,11 +1027,15 @@ static ssize_t snd_seq_write(struct file
 
 	/* allocate the pool now if the pool is not allocated yet */ 
 	if (client->pool->size > 0 && !snd_seq_write_pool_allocated(client)) {
-		if (snd_seq_pool_init(client->pool) < 0)
+		mutex_lock(&client->ioctl_mutex);
+		err = snd_seq_pool_init(client->pool);
+		mutex_unlock(&client->ioctl_mutex);
+		if (err < 0)
 			return -ENOMEM;
 	}
 
 	/* only process whole events */
+	err = -EINVAL;
 	while (count >= sizeof(struct snd_seq_event)) {
 		/* Read in the event header from the user */
 		len = sizeof(event);
