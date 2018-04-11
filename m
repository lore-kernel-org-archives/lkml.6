Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49yzHZmm6ObWTV8NY6nrSHFowRBdfb3fQWD46009sAuvXflmXzd4OXvbKBMcHzVN6zkc+MW
ARC-Seal: i=1; a=rsa-sha256; t=1523473223; cv=none;
        d=google.com; s=arc-20160816;
        b=Bij04QqPgUH6+CQ1mxRflXJcVq25saWsiewRxrx4GE6kr0MFk8TVk1BXVB+gMCimOZ
         FdIhp+UP/l/tW4A4Yla9Y39hv0I0K1JQ/zTgKmcS+HWFZnnwxjlXdEm0uBisvcwphgpr
         ANq1iTPWZbbb720ag7trAq94Bzww4awL0FoDdBySqvNrgjVF5naYysb0QgEThx1iS7Sl
         8OkebHPNaNzIMAtn7W+Cu8ComK3waFknfaHrWkH5f5knvOZ6rHb5sc6POgTn/IYObij4
         /LQics6Q9+nkGC+l2HMCHWG7sFsNqytZZ+MSa9E2NncuQJ/GZcIYSHzq+GtqbHP4xMuX
         E4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HonUURB7H/i81cv7rFQLmGpRWWvtKIB6gp9gpaocSP4=;
        b=JDbHSSKS6OK6X427U/4x1ZORnp67LzJkAOt/M2kkbNDVTR7P035gv0X/OO8rNYxL1C
         PcMlcGNpZRSB9RXQn3XYQ+QGr2AxfBgPmqa9JTWTWUXQhTtKdVKKFR5c9EnGjFrGNfXJ
         E3XSsmFBlMRpykHxvyrfVEuJCNW6zGNCfJwl9aq1jvXRzB7Fbb7YTbxWFCxHcPPHCl9V
         Exadi4mwKL+30Ki96Q3fjySTkMPdaAqSb5G36AWyIcVJAgt5Me1kiFQVOXm11hNedox/
         CmBojtZPGvOL0y289egYO3kwPADnAahZZFMFPJS9uYlaE15ssUwUqNh6Z0P9hZnDACMx
         sAcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Yi Zhang <yi.zhang@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 142/310] blk-mq: fix race between updating nr_hw_queues and switching io sched
Date: Wed, 11 Apr 2018 20:34:41 +0200
Message-Id: <20180411183628.557715299@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477458757996535?=
X-GMAIL-MSGID: =?utf-8?q?1597477458757996535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>


[ Upstream commit fb350e0ad99359768e1e80b4784692031ec340e4 ]

In both elevator_switch_mq() and blk_mq_update_nr_hw_queues(), sched tags
can be allocated, and q->nr_hw_queue is used, and race is inevitable, for
example: blk_mq_init_sched() may trigger use-after-free on hctx, which is
freed in blk_mq_realloc_hw_ctxs() when nr_hw_queues is decreased.

This patch fixes the race be holding q->sysfs_lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1907,6 +1907,9 @@ static void blk_mq_realloc_hw_ctxs(struc
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	blk_mq_sysfs_unregister(q);
+
+	/* protect against switching io scheduler  */
+	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int node;
 
@@ -1956,6 +1959,7 @@ static void blk_mq_realloc_hw_ctxs(struc
 		}
 	}
 	q->nr_hw_queues = i;
+	mutex_unlock(&q->sysfs_lock);
 	blk_mq_sysfs_register(q);
 }
 
