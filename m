Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225fiy1lWxEE2V+DJXf96+vicqbDe345xHqtHY2E4KXCS/wMAM335EXpSoawHbxjBj4lkrvu
ARC-Seal: i=1; a=rsa-sha256; t=1518708539; cv=none;
        d=google.com; s=arc-20160816;
        b=q2HqNcGVxlwJ+zxmWYUuHLfiAkpqdO300r/y7IplwWaopaBhG+fBPGzurDLzRdiv6B
         iOZw/Fdy/HuIi4+gpx8EUEvJeJkXx6+jl7hrMAvcxnWqdOCYNQrOl0OR5TjCKMQyu+mG
         Qf6S/0+v8TcW/sPM51LldGo4djhicEhN+n3vr3N37kcMpm0x3XE4w+C+fkUvRz5O4JY1
         dqo5StIzWFogMzdBOUhtmiJ/d6sOnOyefvJTB8qjRGTG2MbrRJTWTRIpWa+e91GT+pGM
         Enp9yaS1UQH+pjWgmRehuDWX2WkGYvFAUk0WCzxKR0ZKNo7eIxzX92SZwZUK6J3s2cqm
         mGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=a6A6gJFvn01fegqKbtMUUd8MK4NFjq/lElmUlQyhK+o=;
        b=V8qAVvKROUzfpmc2LOdnR14gRB9hROwesvblH6LE9l6sgz2ffbCrseiBKWwTaR0uG3
         jzeB4WLApokPFrtQkq2aK15N3SBGh+25gnPIgzo1MAWg+cgTZIwG3RpC/X3URzecIPfm
         WrLorqWb3qkcVCujdQcp3X81NWTcrHonPgy4G4V5jgvE68AVTJTcc08ES/Tm1MpJwpBD
         3QHi9h9GUQor8MuuuopRGGwtEnsxNjaAKWhj7H5AjfavppFgFPkqrKLmPTSyatKJxcc6
         Mt513G9Jp+YoFAitCDWJ7rj6T0ACdyGlX9/ctiSxrwMhLJXoBrl/2Ew+N5z5UASshmKZ
         Rsqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 78/88] pktcdvd: Fix pkt_setup_dev() error path
Date: Thu, 15 Feb 2018 16:17:45 +0100
Message-Id: <20180215151233.271622412@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480777385037111?=
X-GMAIL-MSGID: =?utf-8?q?1592481325435049099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 5a0ec388ef0f6e33841aeb810d7fa23f049ec4cd upstream.

Commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
modified add_disk() and disk_release() but did not update any of the
error paths that trigger a put_disk() call after disk->queue has been
assigned. That introduced the following behavior in the pktcdvd driver
if pkt_new_dev() fails:

Kernel BUG at 00000000e98fd882 [verbose debug info unavailable]

Since disk_release() calls blk_put_queue() anyway if disk->queue != NULL,
fix this by removing the blk_cleanup_queue() call from the pkt_setup_dev()
error path.

Fixes: commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/pktcdvd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2779,7 +2779,7 @@ static int pkt_setup_dev(dev_t dev, dev_
 	pd->pkt_dev = MKDEV(pktdev_major, idx);
 	ret = pkt_new_dev(pd, dev);
 	if (ret)
-		goto out_new_dev;
+		goto out_mem2;
 
 	/* inherit events of the host device */
 	disk->events = pd->bdev->bd_disk->events;
@@ -2797,8 +2797,6 @@ static int pkt_setup_dev(dev_t dev, dev_
 	mutex_unlock(&ctl_mutex);
 	return 0;
 
-out_new_dev:
-	blk_cleanup_queue(disk->queue);
 out_mem2:
 	put_disk(disk);
 out_mem:
