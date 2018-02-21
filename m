Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2251ZKtD7NuaZrVDa+0uEyl2V5fw81rBTZx4Pm+cGXa9kGgIwg+JzphrHjRCs7af1tbIUIhx
ARC-Seal: i=1; a=rsa-sha256; t=1519218338; cv=none;
        d=google.com; s=arc-20160816;
        b=SmIxQKvAz4rHEJe3h3we0YF94mQegsA2lBeKGxxvUzVfyPqHzLJ52DbscCL/GgEk/r
         R41NYh13fMw5B9/rcjzF0hkDHkygiptb37XajQKN6zxrYNBmUfB9pV0Db/cejFgs8R2r
         HdTYQguUvC9ZW2f1v3NW7NstT9NCBv6IDkayKx0MaW53xedYZOx6bdeJKaflQycaEY1/
         s2Yq7hldzTSWxXAjMN/oK9sFBsOw3ViZRhzm6lFSqfbW7+9q+FPcV7RfGNg6PWJC+I6a
         L7A0Ub0UU5Yx3Lj01NRhZ/Nj2586MxamFAdiZ6r6RMYa2sMnkJjZ0lmo9vrJBZp+Gh8i
         mxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5+/I93O9vpVZ0mwwYqoV0QD/FQ3JXldXG/A33eEfmd8=;
        b=If1G5LvkK5jd5T1/N8EP0W6oimLxxv9UfGYKT+fU8wbkizXAkawTcWe8iaIFvoVCL/
         v2+eXWmvP/QCQWCuZFih7ylUHqvbGcVJJDFnVX0U2VWXJXJc/gnMvb8qcG+oiAJ8Y1M0
         7wP2QYTmdLFJKevgfIcQ2YdFTrKNyh5A7bDprhqpQYyzQpAPvX8pf8/P9MWd89w/g3j4
         0maYrEb91i9jp2c23/i5Iu0KnUr5vPMkWWXNf9+OVB+3xa3t/kdJS/c+uLNfvZ3dkdKT
         aNEUPfRxG8M5BzO+a/OdPWftPWzxEqYzZ16WfJu0/mCAuLpij8e0STnVt4of5OUt1yB0
         pjtw==
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
Subject: [PATCH 4.14 149/167] ALSA: seq: Fix racy pool initializations
Date: Wed, 21 Feb 2018 13:49:20 +0100
Message-Id: <20180221124532.916634327@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015239722936389?=
X-GMAIL-MSGID: =?utf-8?q?1593015888516753594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -999,7 +999,7 @@ static ssize_t snd_seq_write(struct file
 {
 	struct snd_seq_client *client = file->private_data;
 	int written = 0, len;
-	int err = -EINVAL;
+	int err;
 	struct snd_seq_event event;
 
 	if (!(snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_OUTPUT))
@@ -1014,11 +1014,15 @@ static ssize_t snd_seq_write(struct file
 
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
