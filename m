Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33467C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDF720645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwOZViHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDF720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbeJICGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbeJICGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:06:37 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD5F204FD;
        Mon,  8 Oct 2018 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024808;
        bh=YgWcEyLpG2eqsP5WD3wnamlrUZIeOwW0ElwMKqoG/jU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwOZViHdMzKVO0emtshFYQGTdwCBQgYD8ipI1gMjh2AJEguWISIvYbkxeeThITtBl
         cbBnkk11SAnkKTmOTLuXLP1fE8Gtt5Sb/qwA48atMXB0A7+IDSuSThXEcDXHTnW0U8
         zrJInZOthtxz9jyciu/go6rTggFnjo4OouK/0lLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.18 160/168] crypto: mxs-dcp - Fix wait logic on chan threads
Date:   Mon,  8 Oct 2018 20:32:20 +0200
Message-Id: <20181008175626.133439088@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leonard Crestez <leonard.crestez@nxp.com>

commit d80771c08363ad7fbf0f56f5301e7ca65065c582 upstream.

When compiling with CONFIG_DEBUG_ATOMIC_SLEEP=y the mxs-dcp driver
prints warnings such as:

WARNING: CPU: 0 PID: 120 at kernel/sched/core.c:7736 __might_sleep+0x98/0x9c
do not call blocking ops when !TASK_RUNNING; state=1 set at [<8081978c>] dcp_chan_thread_sha+0x3c/0x2ec

The problem is that blocking ops will manipulate current->state
themselves so it is not allowed to call them between
set_current_state(TASK_INTERRUPTIBLE) and schedule().

Fix this by converting the per-chan mutex to a spinlock (it only
protects tiny list ops anyway) and rearranging the wait logic so that
callbacks are called current->state as TASK_RUNNING. Those callbacks
will indeed call blocking ops themselves so this is required.

Cc: <stable@vger.kernel.org>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/mxs-dcp.c |   53 ++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -63,7 +63,7 @@ struct dcp {
 	struct dcp_coherent_block	*coh;
 
 	struct completion		completion[DCP_MAX_CHANS];
-	struct mutex			mutex[DCP_MAX_CHANS];
+	spinlock_t			lock[DCP_MAX_CHANS];
 	struct task_struct		*thread[DCP_MAX_CHANS];
 	struct crypto_queue		queue[DCP_MAX_CHANS];
 };
@@ -349,13 +349,20 @@ static int dcp_chan_thread_aes(void *dat
 
 	int ret;
 
-	do {
-		__set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
 
-		mutex_lock(&sdcp->mutex[chan]);
+		spin_lock(&sdcp->lock[chan]);
 		backlog = crypto_get_backlog(&sdcp->queue[chan]);
 		arq = crypto_dequeue_request(&sdcp->queue[chan]);
-		mutex_unlock(&sdcp->mutex[chan]);
+		spin_unlock(&sdcp->lock[chan]);
+
+		if (!backlog && !arq) {
+			schedule();
+			continue;
+		}
+
+		set_current_state(TASK_RUNNING);
 
 		if (backlog)
 			backlog->complete(backlog, -EINPROGRESS);
@@ -363,11 +370,8 @@ static int dcp_chan_thread_aes(void *dat
 		if (arq) {
 			ret = mxs_dcp_aes_block_crypt(arq);
 			arq->complete(arq, ret);
-			continue;
 		}
-
-		schedule();
-	} while (!kthread_should_stop());
+	}
 
 	return 0;
 }
@@ -409,9 +413,9 @@ static int mxs_dcp_aes_enqueue(struct ab
 	rctx->ecb = ecb;
 	actx->chan = DCP_CHAN_CRYPTO;
 
-	mutex_lock(&sdcp->mutex[actx->chan]);
+	spin_lock(&sdcp->lock[actx->chan]);
 	ret = crypto_enqueue_request(&sdcp->queue[actx->chan], &req->base);
-	mutex_unlock(&sdcp->mutex[actx->chan]);
+	spin_unlock(&sdcp->lock[actx->chan]);
 
 	wake_up_process(sdcp->thread[actx->chan]);
 
@@ -640,13 +644,20 @@ static int dcp_chan_thread_sha(void *dat
 	struct ahash_request *req;
 	int ret, fini;
 
-	do {
-		__set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
 
-		mutex_lock(&sdcp->mutex[chan]);
+		spin_lock(&sdcp->lock[chan]);
 		backlog = crypto_get_backlog(&sdcp->queue[chan]);
 		arq = crypto_dequeue_request(&sdcp->queue[chan]);
-		mutex_unlock(&sdcp->mutex[chan]);
+		spin_unlock(&sdcp->lock[chan]);
+
+		if (!backlog && !arq) {
+			schedule();
+			continue;
+		}
+
+		set_current_state(TASK_RUNNING);
 
 		if (backlog)
 			backlog->complete(backlog, -EINPROGRESS);
@@ -658,12 +669,8 @@ static int dcp_chan_thread_sha(void *dat
 			ret = dcp_sha_req_to_buf(arq);
 			fini = rctx->fini;
 			arq->complete(arq, ret);
-			if (!fini)
-				continue;
 		}
-
-		schedule();
-	} while (!kthread_should_stop());
+	}
 
 	return 0;
 }
@@ -721,9 +728,9 @@ static int dcp_sha_update_fx(struct ahas
 		rctx->init = 1;
 	}
 
-	mutex_lock(&sdcp->mutex[actx->chan]);
+	spin_lock(&sdcp->lock[actx->chan]);
 	ret = crypto_enqueue_request(&sdcp->queue[actx->chan], &req->base);
-	mutex_unlock(&sdcp->mutex[actx->chan]);
+	spin_unlock(&sdcp->lock[actx->chan]);
 
 	wake_up_process(sdcp->thread[actx->chan]);
 	mutex_unlock(&actx->mutex);
@@ -997,7 +1004,7 @@ static int mxs_dcp_probe(struct platform
 	platform_set_drvdata(pdev, sdcp);
 
 	for (i = 0; i < DCP_MAX_CHANS; i++) {
-		mutex_init(&sdcp->mutex[i]);
+		spin_lock_init(&sdcp->lock[i]);
 		init_completion(&sdcp->completion[i]);
 		crypto_init_queue(&sdcp->queue[i], 50);
 	}


