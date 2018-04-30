Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpLMVWmvlMaYE4TJNUfmbgvJ0nLmz603IrOkcROmTfOC60eoupNgVoVF9fSAWHBAQNx8Oqb
ARC-Seal: i=1; a=rsa-sha256; t=1525116508; cv=none;
        d=google.com; s=arc-20160816;
        b=BHtRBD7KPvH1rhIGFjhkuXaLEVPadTW+iszd8htjAb7vEKN3VhLmmMdn50yyELtz+T
         Z9nqwPTunbill2KfEJnHvipZyZtrulD/Lcz7rFjAh6neR3Nqrr1NUiVvWD9deqo9qFxM
         esn4iBGXCfksnnd6uyR93IQrF4kdZJLpGTFfnhKHwlVghlFLh2BOgtNuIJ9HEDp5mp5b
         MvqXF06udXYmztGO3seV3Oophv9n0lCfa4h3gT7O9g49vULAHHoK9V5rhWrFtE/AequN
         WC4V2cSTrSJYb/rVgrSu4Y5+tWZeA3DvI88mUNptgHv6Jaqnl8cXGywHikfmNrz6IiZp
         6dcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=tIOyW98+GmdJGKInuP4LepZKGBF3e4dMKWM6StN7uQQ=;
        b=yQQz5cfzJCjrW5x+Bi4c4d/4OnRAfn2ErtYH+mtRsVG7IQsLiY6Rrazn+Zgav2FgSh
         T6bCcq1UkNdcMmXLRlryHM4lZbY2OVHvcVsLgRRu+wBk/Tx0SlWSHCjznW/QrxMtiQgS
         HQQrtD8o912Xg3cSLGXc54r7wFa4F8aqNt0MoJnlYTD8wUWUbgXMQckuJkl0DnDLsvXA
         uTwysg7jh1a1+SekTfv6dYuoWf6NyyAlDmF4etuYCEa9CHG7nx68IslsSweAkObXEdVK
         y4AkdFUQ/VIidM244XPZADY+sodzEAmLa7dkfcX0xt3P3tV3IYU00qhnReSMWoF0DcP8
         Ob/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2886822DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Alan Jenkins <alan.christopher.jenkins@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 065/113] block: do not use interruptible wait anywhere
Date: Mon, 30 Apr 2018 12:24:36 -0700
Message-Id: <20180430184017.968356287@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200568646349332?=
X-GMAIL-MSGID: =?utf-8?q?1599200568646349332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Jenkins <alan.christopher.jenkins@gmail.com>

commit 1dc3039bc87ae7d19a990c3ee71cfd8a9068f428 upstream.

When blk_queue_enter() waits for a queue to unfreeze, or unset the
PREEMPT_ONLY flag, do not allow it to be interrupted by a signal.

The PREEMPT_ONLY flag was introduced later in commit 3a0a529971ec
("block, scsi: Make SCSI quiesce and resume work reliably").  Note the SCSI
device is resumed asynchronously, i.e. after un-freezing userspace tasks.

So that commit exposed the bug as a regression in v4.15.  A mysterious
SIGBUS (or -EIO) sometimes happened during the time the device was being
resumed.  Most frequently, there was no kernel log message, and we saw Xorg
or Xwayland killed by SIGBUS.[1]

[1] E.g. https://bugzilla.redhat.com/show_bug.cgi?id=1553979

Without this fix, I get an IO error in this test:

# dd if=/dev/sda of=/dev/null iflag=direct & \
  while killall -SIGUSR1 dd; do sleep 0.1; done & \
  echo mem > /sys/power/state ; \
  sleep 5; killall dd  # stop after 5 seconds

The interruptible wait was added to blk_queue_enter in
commit 3ef28e83ab15 ("block: generic request_queue reference counting").
Before then, the interruptible wait was only in blk-mq, but I don't think
it could ever have been correct.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -829,7 +829,6 @@ int blk_queue_enter(struct request_queue
 
 	while (true) {
 		bool success = false;
-		int ret;
 
 		rcu_read_lock();
 		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
@@ -861,14 +860,12 @@ int blk_queue_enter(struct request_queue
 		 */
 		smp_rmb();
 
-		ret = wait_event_interruptible(q->mq_freeze_wq,
-				(atomic_read(&q->mq_freeze_depth) == 0 &&
-				 (preempt || !blk_queue_preempt_only(q))) ||
-				blk_queue_dying(q));
+		wait_event(q->mq_freeze_wq,
+			   (atomic_read(&q->mq_freeze_depth) == 0 &&
+			    (preempt || !blk_queue_preempt_only(q))) ||
+			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
-		if (ret)
-			return ret;
 	}
 }
 
