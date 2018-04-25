Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/PUzYzcx0PCTzgX101o5ArRQv3NzYX67eLFYtw3fw2Tk0O5Q21z0id5oSswucoT5il5PZG
ARC-Seal: i=1; a=rsa-sha256; t=1524652730; cv=none;
        d=google.com; s=arc-20160816;
        b=g2a9zWnKUDaZXCqd4Tu3mA4cAq2jllMBz4wHsRwYg6y2Iso/pdo28Hk264fzM1xZej
         hzhzM4R1SpeBXvTtbdKAFVTADdh4/wXq2ly/J095eXAS5+AaHIPr1eCrEZ7bmLxa0n2A
         mUNZWv/sHzj2Ip0+p+F/ZurNS7N1Yzc48SpkqQydDbahq2BUAQx+w4mxF8Uizsqqx2YX
         sZS2KLj3hx6C8qdmVIbzOJx6mRR7aAvrJWHy3KGvkKvUQB35GvY1iDIgawWYVI9E3d8R
         Tg4QxBPwGfuCGp6rtbMYcwxLH40kPrRdGwsuG4t+CWRuT1tJQOdxbsX743jwncNwCUIJ
         aMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fkDgSCACzuACG/zLUYfvBMCHlaITGc68KMd5cC7zq4s=;
        b=StndUpfVysoZVZ9S4Yhbkh47wNZ61r4tmByPuR/gGsfP7AFuVWYAxKZILZZjY/hS/A
         ugTTxShsx/xe5BcX+PB6lmjQQcVgpKWW1b5AYa77uJDQaRev4uRONThhca2moRmyWsGV
         9tSiSUM1aBOI+/rqDbv6qYOj/P9yeUD45HjLcb6pb8Cd+CuUCgi5QtfI8WPshKUbMJ7V
         C1sgduP/zlcJ91cyBA9yXuzC/J6fgi19MJJqoyx5LQ9KGSPshZ3jGlQrRU62McYi50qY
         9/i/p4hNUlDnF6K+B28aV4+z44efVd944e1O0WiLbXYLrgz515mVmGtdFkGa+Wt9Tc+h
         kOqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	"jianchao.wang" <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 048/183] blk-mq: turn WARN_ON in __blk_mq_run_hw_queue into printk
Date: Wed, 25 Apr 2018 12:34:28 +0200
Message-Id: <20180425103244.490454373@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714261869187543?=
X-GMAIL-MSGID: =?utf-8?q?1598714261869187543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>


[ Upstream commit 7df938fbc4ee641e70e05002ac67c24b19e86e74 ]

We know this WARN_ON is harmless and in reality it may be trigged,
so convert it to printk() and dump_stack() to avoid to confusing
people.

Also add comment about two releated races here.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1143,9 +1143,27 @@ static void __blk_mq_run_hw_queue(struct
 	/*
 	 * We should be running this queue from one of the CPUs that
 	 * are mapped to it.
+	 *
+	 * There are at least two related races now between setting
+	 * hctx->next_cpu from blk_mq_hctx_next_cpu() and running
+	 * __blk_mq_run_hw_queue():
+	 *
+	 * - hctx->next_cpu is found offline in blk_mq_hctx_next_cpu(),
+	 *   but later it becomes online, then this warning is harmless
+	 *   at all
+	 *
+	 * - hctx->next_cpu is found online in blk_mq_hctx_next_cpu(),
+	 *   but later it becomes offline, then the warning can't be
+	 *   triggered, and we depend on blk-mq timeout handler to
+	 *   handle dispatched requests to this hctx
 	 */
-	WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
-		cpu_online(hctx->next_cpu));
+	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
+		cpu_online(hctx->next_cpu)) {
+		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
+			raw_smp_processor_id(),
+			cpumask_empty(hctx->cpumask) ? "inactive": "active");
+		dump_stack();
+	}
 
 	/*
 	 * We can't run the queue inline with ints disabled. Ensure that
