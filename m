Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227d3fU20XMXuCZ7NfDQV27skgGO103OD6US9N42EiDD6QM4Q/xKu+bKJRSU5Sx77gnbAQC6
ARC-Seal: i=1; a=rsa-sha256; t=1519218749; cv=none;
        d=google.com; s=arc-20160816;
        b=MEf8+FltEJ9CBxdqaojHfKJY5JPwjUFnOgx5mFB82aYUjZs2vAeIzOJFZkEcmcpSbV
         zLpXskQypQUz7y/lFtUpAw1QLg2XhCPkJm3KdOGP+74OzUdl1oBZ7JjapMqjislaR7U3
         6VBDvfXI4sCNdMhfucDH2bsNUJ376eSrAp9S0XuZPx1sveA95hTC5GuYcQo9lWAuCWem
         Rf0685SCuqOPsNRQkLm3MxCK13FPx4l2cFUCPcg/ffVOyMVYfL18Fo5SPRxuqwnLzT7x
         dKyftXJRnE71KekDmjBr+vOYuvSHeF/YYzEPpukaIiuKMINiEGsO7tmQ1ZJxr8w1QRRb
         YGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cDAUDXK4Y3DEkVarlbgisCWqcvz8JBjntmJZO8WxgyQ=;
        b=hzn5kkyVNDODhB8tT3UmHphtLoiyVehuqKc/aZG7V/qUzHzwQC16uMnmECELprVWof
         qfi+/Vni5lcXKGGIhI89X93UgYry1uaWZ6OxabqRvHcirQZI1iV3Rhmxcwb3c3OM/EHO
         iwR4+UvL6yCe1SSQEcpOgyxwjABTuT8kDpWQZnEXS7zNQEbh/Ln9HLgclZUUf1z7YDKj
         klZ+il8bI7AEzF1U/Fbmr0mXEwH8nbCtrjYAgQ8mEMIugNaNVUKwMGb3R6RS324PIOF+
         dUa91C19wi2yM1UM60y9NVWiRpDc8ALgGPx1AJGY97tVXOKQa+uMb3bxq3JvlH4y49lG
         9yxg==
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
Subject: [PATCH 4.15 150/163] ALSA: seq: Fix racy pool initializations
Date: Wed, 21 Feb 2018 13:49:39 +0100
Message-Id: <20180221124538.314769892@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015239722936389?=
X-GMAIL-MSGID: =?utf-8?q?1593016319431575967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1003,7 +1003,7 @@ static ssize_t snd_seq_write(struct file
 {
 	struct snd_seq_client *client = file->private_data;
 	int written = 0, len;
-	int err = -EINVAL;
+	int err;
 	struct snd_seq_event event;
 
 	if (!(snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_OUTPUT))
@@ -1018,11 +1018,15 @@ static ssize_t snd_seq_write(struct file
 
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
