Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226gVHOBcGz2BoK3dXc86z1wPpzLpolyoX2Gg3AOYp8GRKufhb+vtYo4fy91dROoJ7Np0fXA
ARC-Seal: i=1; a=rsa-sha256; t=1519217719; cv=none;
        d=google.com; s=arc-20160816;
        b=kf+ypyB34v5K+mfqIAW/pIF0ArwzaEyzIU7xjEY2V67HcE7Hvcz/D74iL30McycP2c
         QjD+Rdj92CZeJT/DUcY1TOnkEgHmnDIY89H633c+392FHAe9r2byrRIf9S1sAAmyXuEX
         KS1fb2xf5PcHMryihF+SFtFZ6Uf+o49acoBk/Ev4Ie8i65HO0d6/q6pz2fAdj+e/Zzpd
         RGaoXOneEqsgELiV3Xpsxn7aw6jq/No9ORwbt8kfdCWJg0A6rzz3gElO2bgk8gXDCec6
         dmKPUKAXAexRLPdMRxVEnchhIsKh/0sqiWZvaghwWdtXGwqn78PjYe2Z9G5pBSh4zYYk
         puAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=f2Y6DNTMW5aTa93FCUcQdfIG/GvpFmZmZKVqujbA8/I=;
        b=AGoOVjOcHB6J102rSUPEC/1c54+pHMN8MDnJ4fYHywqv+DLkfgyy0HjKIRD8DE4ars
         00qGblRWVWFkXi8oMgssXkxwtMxcyd4z57cOgUHlXj94hkuW9tQO8TbEVYoGdE2HnXJ4
         R7zhrbzUfyrAA7zbY0IwgzRRHmO7tyROF7jgoDkOwBStgaISvmCi68DuVS8MTM/u8fpi
         Vvj6yDMyAvFUy4F7Cp0H1aYmNuiz6AygI8SPM/dAMfIJtGM2iroB6fsJDP2YgVO4bnQz
         ZxyMrs4taCsbgUYemv46+CXViS3tiZ/YdnTfR0uQLIm235sbC8kawywu2ibJvXYBClWU
         dA4Q==
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
Subject: [PATCH 4.9 30/77] ALSA: seq: Fix racy pool initializations
Date: Wed, 21 Feb 2018 13:48:39 +0100
Message-Id: <20180221124433.464801589@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015239722936389?=
X-GMAIL-MSGID: =?utf-8?q?1593015239722936389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
