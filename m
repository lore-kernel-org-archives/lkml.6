Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/cNfJyq/yIMSF303gL6pwze0yLNUXb+kAJwR+aXw8voPACIWHj1VDeRmZAn+4eKQ4z02iM
ARC-Seal: i=1; a=rsa-sha256; t=1523399721; cv=none;
        d=google.com; s=arc-20160816;
        b=IH5KdDw17ZZ5kIExSE+Qq0e+RAUflIo83aBSkv/vkzP/OPtzu8MpZL7CBcNVzjsLVs
         0RqWzWEKpYN8XdbCRETltR4I/I8lMNYkKgb/s0uv0YK1KtciI14ewhBOQBpkMRp2m5PL
         2rZNeNvCuc4mz88yk32wkwkwlSye2BSjuYaqn9JEYNaxJMwycqX301kwy0k2ibq1s/a2
         Mc6wJoMdWr+PmFAJQ7oWoEu45xmykxuofUKNIw0Kcv0lPVkKkQ2DsepIXr+t2P7FLBHq
         g9upi9kn21E/2g1YxSNQThZLpZGwKcuGkqhvqHqqK9pZrf0WlMc9kQZns5ow/NRkSyJ9
         EMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ox8L8boABGwHDdN6tZij1wfkJ4FIIEdt0vZuYedmsYk=;
        b=yQ3eh4WlstfqCHjiDJDOllE5mOll9Ms6pIVkC6GDbKoqoUdcbUsykJzyiYktFQ7AUk
         W6Ifyr1uVVKF/lb09+T41IuqRmSaifF9x7PvdxNezSMzQhZN1JUFhWqZqfVL1mG0d1yf
         0A4U5kP4k9BveJxHtz7OOBguXTf3UqCFkZE6MXMDkT3BoMFdpbdjPW5RsYoHeciyQ2uS
         LvpDFAFRLEstkULezRGo0XfqjfVPsMHEuJZwsH6dV1DXpjArx8yhXKORdkXGjn0b3ATQ
         hoxAsItU5IhPEYP4TruKFKXz32WpvJ6ZepUdytZMhlQ+z9Ti7dwnwMdLVw6MZ682x03V
         WEzQ==
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
Subject: [PATCH 4.14 040/138] blk-mq: fix race between updating nr_hw_queues and switching io sched
Date: Wed, 11 Apr 2018 00:23:50 +0200
Message-Id: <20180410212906.727621952@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399955811932366?=
X-GMAIL-MSGID: =?utf-8?q?1597400385823597083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2314,6 +2314,9 @@ static void blk_mq_realloc_hw_ctxs(struc
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	blk_mq_sysfs_unregister(q);
+
+	/* protect against switching io scheduler  */
+	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int node;
 
@@ -2358,6 +2361,7 @@ static void blk_mq_realloc_hw_ctxs(struc
 		}
 	}
 	q->nr_hw_queues = i;
+	mutex_unlock(&q->sysfs_lock);
 	blk_mq_sysfs_register(q);
 }
 
