Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu2bNDaEaqqqDKYe2vOk9O/Avll+8lZoibaHsEzPHQhL5ywcWAV/hAE4Op5FY/ljzNitfzV
ARC-Seal: i=1; a=rsa-sha256; t=1519981429; cv=none;
        d=google.com; s=arc-20160816;
        b=YoNasI8GRRNgrwhOMi4ZX6GY8jsVyAayBFaGax6/MVP3rybQgiCAQ9W8pPisGpO+tG
         ldYx2cFS+Ad7jeEe8SvFn7vAVNjRWOgk8QKUExU2BQL61kJ9dsKxQOvg1XAajjVGeo3Q
         NxNelijohx62DgsLDAETniHnmwEaBctWHjAlrTPH7/bBj1HkeQV0UQiKTu3rL2v9Cvua
         qVtCWNjUnyJCXqYiQu/t+YBklXzZrQraHOQs+y9JvggpKvMou//o93A3AxBEFbLc74i9
         +h0CbCw3JnJvHbtJdr468xJTqKliXzd42SdAMvm5DLAsnUBQaAsC0LI1IzQk73pTbeGp
         AHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jx6saKj/rbw3ApDfU3KR3+ycJFL46SO/hF8HaeTwi0o=;
        b=xhZpjMwY+efNLC60L/SfslkO4LLcUy+SduJK0t3DC0hvVb3I5NcUW2PbdcuhFTrl8S
         Ff9qR58ZEr2h6tt/SBTMYk5HFcUSYMIHUR9VnfdriHqzWE/eMFHC21qPDt3KRPkocE35
         8qhlSPhhYS8pdix+W3Ycj3RIa3doStQaco7Dps3n5IOAX5NWIbNfskLxeWDg1IjeDydi
         EEzEoVNAx7SMrkZPccBWDtAoarJK/tIN3m/LyV7CFZBnNO7UBUpJKdsvVsDUMQ6O4iVZ
         SEGv/WR012JmlmuKVgKhE3NtxXKcko+Ta3Ma+nTjsAIsWMsdX5Lld8KhnBM5AIIluWBN
         yHLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wen Xiong <wenxiong@us.ibm.com>,
	"chenxiang (M)" <chenxiang66@hisilicon.com>,
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 088/115] block: drain queue before waiting for q_usage_counter becoming zero
Date: Fri,  2 Mar 2018 09:51:31 +0100
Message-Id: <20180302084507.412212701@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816047688069259?=
X-GMAIL-MSGID: =?utf-8?q?1593816047688069259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>


[ Upstream commit 454be724f6f99cc7e7bbf15067128be9868186c6 ]

Now we track legacy requests with .q_usage_counter in commit 055f6e18e08f
("block: Make q_usage_counter also track legacy requests"), but that
commit never runs and drains legacy queue before waiting for this counter
becoming zero, then IO hang is caused in the test of pulling disk during IO.

This patch fixes the issue by draining requests before waiting for
q_usage_counter becoming zero, both Mauricio and chenxiang reported this
issue, and observed that it can be fixed by this patch.

Link: https://marc.info/?l=linux-block&m=151192424731797&w=2
Fixes: 055f6e18e08f("block: Make q_usage_counter also track legacy requests")
Cc: Wen Xiong <wenxiong@us.ibm.com>
Tested-by: "chenxiang (M)" <chenxiang66@hisilicon.com>
Tested-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-core.c |    9 +++++++--
 block/blk-mq.c   |    2 ++
 block/blk.h      |    2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -531,6 +531,13 @@ static void __blk_drain_queue(struct req
 	}
 }
 
+void blk_drain_queue(struct request_queue *q)
+{
+	spin_lock_irq(q->queue_lock);
+	__blk_drain_queue(q, true);
+	spin_unlock_irq(q->queue_lock);
+}
+
 /**
  * blk_queue_bypass_start - enter queue bypass mode
  * @q: queue of interest
@@ -655,8 +662,6 @@ void blk_cleanup_queue(struct request_qu
 	 */
 	blk_freeze_queue(q);
 	spin_lock_irq(lock);
-	if (!q->mq_ops)
-		__blk_drain_queue(q, true);
 	queue_flag_set(QUEUE_FLAG_DEAD, q);
 	spin_unlock_irq(lock);
 
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -159,6 +159,8 @@ void blk_freeze_queue(struct request_que
 	 * exported to drivers as the only user for unfreeze is blk_mq.
 	 */
 	blk_freeze_queue_start(q);
+	if (!q->mq_ops)
+		blk_drain_queue(q);
 	blk_mq_freeze_queue_wait(q);
 }
 
--- a/block/blk.h
+++ b/block/blk.h
@@ -362,4 +362,6 @@ static inline void blk_queue_bounce(stru
 }
 #endif /* CONFIG_BOUNCE */
 
+extern void blk_drain_queue(struct request_queue *q);
+
 #endif /* BLK_INTERNAL_H */
