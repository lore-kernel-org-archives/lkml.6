Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Xpn4wiuiTB5g7d4bwVQBo7OYdBhrdcrlghI+un43okeBJydJACVFTeG/B++a5NAZBvobw
ARC-Seal: i=1; a=rsa-sha256; t=1519410617; cv=none;
        d=google.com; s=arc-20160816;
        b=LnF6XmARDYeHDlB6zsFkHuZ1JJoIneAM01kad8oAshGbFgXq8VQydNVl9UK5+GGCaS
         4LVmeywOd2LoD4oeRYJ3a+nOmfYdc/pdfEhWVC0h69Ei6Nsy2EUp7dSn/y5NDz/dkot4
         sSGj73TN/rzSu1841hSwzoZwr6Q2KNtDhGJi3hsxWIUjUxti8DLzmUFxXUXBmbvSMbnH
         F7LXRQXj8/elNuVZ1Eg3ckLca2RT2MhQ90W0IglaZbtLnT8bXxSqaTBxYcTTOBab+gTo
         J5LEZb1XK7PirT5yKirkU23pSmRYE/tgjONdZ6GNoDOi0ZMMd2YYlCFerMZVIv4ydBzF
         8tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZUOKvSPBdJ2ThtCY7yNRJTXNYpL/Pf1lHnvZbvXmGFQ=;
        b=W/eJqFWTJ3EMwMOTGCYjSViLwa2k/kBfMB+nG5IMC767EJxkSMofXsY+RbLEUSxqd/
         DLLA8uOGzBfOejbelPxzN9SZwa0He1WLkYrBIC7chshK+eUlUtOfz3Jdl+ooJWPUsfI9
         IZ5yXhzPSdMiPlnec2ymc1QRmMFbq2N1CeRQupVJHz5sr0izTNfcjzrznUvobRsssJT8
         Ojt+y3UuGhhCPHwiLOHLGjdyRac1fASSQksv0vWJbROOm9m7CqQAFwEySeuvweIoEhej
         O32XyVMh21SwXX5FyjNJ5ZzfGLAP5rMnZzXnqJxAQMjNSDpBCgspnREmB8s4qEU7DDzf
         KvXw==
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
Subject: [PATCH 3.18 15/58] ALSA: seq: Fix racy pool initializations
Date: Fri, 23 Feb 2018 19:26:14 +0100
Message-Id: <20180223170209.119064468@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217507940486966?=
X-GMAIL-MSGID: =?utf-8?q?1593217507940486966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
