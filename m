Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rbgTxfUnjR4qN/GvczLsaJdFtFCm4ZjZ3uN6z3AzAu/X74o0zNBEnlQ9OIk/+KhWQOquO
ARC-Seal: i=1; a=rsa-sha256; t=1523399310; cv=none;
        d=google.com; s=arc-20160816;
        b=fpjI50TB88PlJXLgidWPHsMco5IxiVx5/tFvJhw6djKIoJFCa/iPxpN7BxZoPq9vW7
         IFMHmi0G/ljZAhYRhSgOU1BpXxOnxRbwKrwsJxZtjkZWK6nqfgyWoOH02XPNdXF3ZLjD
         gcMDGCqaI1lO4v7YGxU21JW9JY+c5m7bWrHdFlgwT7rrf3KcsTwNjX6wVkT01sDrn1Ch
         0GT/lJ4lhxzT5ezMpcr3/gV43JXTYt5p3UdoSs8IY2hPN1BGcoR3SYXDR0Xa1fS2jF0l
         lgPobqGCwCFjuoxs8h0CbLT1RVA/CGALUHLFsV9mvLLm2Lwwds05Ba9cO2rubfN/Lmzr
         EonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c6Ai8sqZcw1fkd4pZdFWy1GTjE+Vu/ZI9AJaTpDoEHY=;
        b=0zokV2gAJKYjSzKnK2g6hY7hOPQ/bE1gHBn5NdUvcsZCmXvOj+FwjRmzF6VopyARI1
         BfEFv9FsWgTcvPfE8zOSOY6BREllb2gY5V5BjlRn9m9bPBPpSzlzGy2utNPQl9LZPWuw
         21gXYeCY75SntaCEG0Y7uawAliBdxo5X7y38aus+HcMU8Jk6RJF4QrJ1QmUtbvFmoQsY
         PMQo9OQe9CzmUsJY5gYsQ1riw/+/natbBEUxABP/w6fLr56e4Q2fhNCfzz64jHcXUDo3
         APeLOSbPQUGNMHfZQRKieKh6k5GaUzRIpPBmjQLB3nGjGwxgx7D9LlBGubu893bocci0
         +sAg==
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
Subject: [PATCH 4.15 053/168] blk-mq: fix race between updating nr_hw_queues and switching io sched
Date: Wed, 11 Apr 2018 00:23:15 +0200
Message-Id: <20180410212802.461896555@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399955811932366?=
X-GMAIL-MSGID: =?utf-8?q?1597399955811932366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2388,6 +2388,9 @@ static void blk_mq_realloc_hw_ctxs(struc
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	blk_mq_sysfs_unregister(q);
+
+	/* protect against switching io scheduler  */
+	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int node;
 
@@ -2432,6 +2435,7 @@ static void blk_mq_realloc_hw_ctxs(struc
 		}
 	}
 	q->nr_hw_queues = i;
+	mutex_unlock(&q->sysfs_lock);
 	blk_mq_sysfs_register(q);
 }
 
