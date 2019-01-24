Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7A4C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF4D21903
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358632;
	bh=jDaBucAAmfG1fg/H82mq26e+ejx7KWGY7I3Smeask7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=isqLKKpAkhNzwhdGF2RuxMeaNnW1QN7Ty5OE0lZa2+6tW0Ri97OB4uRoj2Bgy31gv
	 odjNLjJ66iUmeeEyrsGp1+E5BTD/nY6uwdp5s4DjBFfjxVhB52xqV0CsJunGUe78x1
	 Fxgk+d55QDbDy0LAf8NJ/V9EBBoUIY91ASNUFgcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbfAXThK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732042AbfAXThG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:37:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B909921907;
        Thu, 24 Jan 2019 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358625;
        bh=jDaBucAAmfG1fg/H82mq26e+ejx7KWGY7I3Smeask7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuWhToemWb2LTEVbse35GonZSGN7gUjH8Pe83VzxyCrB7tgBsJ7zyFtzDbLVcHfxZ
         kCAIDmqVBPtdPIE3btR7JA8Du/QrlDJayfUbh5T5BtKriJ7/3BM08NPRFyBI1A6xYJ
         s/h5hjR+p0Z5KklcmdMm0XMKFzwl11G2rd8oDeQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikos Tsironis <ntsironis@arrikto.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/106] dm kcopyd: Fix bug causing workqueue stalls
Date:   Thu, 24 Jan 2019 20:20:32 +0100
Message-Id: <20190124190211.041940775@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d7e6b8dfc7bcb3f4f3a18313581f67486a725b52 ]

When using kcopyd to run callbacks through dm_kcopyd_do_callback() or
submitting copy jobs with a source size of 0, the jobs are pushed
directly to the complete_jobs list, which could be under processing by
the kcopyd thread. As a result, the kcopyd thread can continue running
completed jobs indefinitely, without releasing the CPU, as long as
someone keeps submitting new completed jobs through the aforementioned
paths. Processing of work items, queued for execution on the same CPU as
the currently running kcopyd thread, is thus stalled for excessive
amounts of time, hurting performance.

Running the following test, from the device mapper test suite [1],

  dmtest run --suite snapshot -n parallel_io_to_many_snaps_N

, with 8 active snapshots, we get, in dmesg, messages like the
following:

[68899.948523] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 95s!
[68899.949282] Showing busy workqueues and worker pools:
[68899.949288] workqueue events: flags=0x0
[68899.949295]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=2/256
[68899.949306]     pending: vmstat_shepherd, cache_reap
[68899.949331] workqueue mm_percpu_wq: flags=0x8
[68899.949337]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
[68899.949345]     pending: vmstat_update
[68899.949387] workqueue dm_bufio_cache: flags=0x8
[68899.949392]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256
[68899.949400]     pending: work_fn [dm_bufio]
[68899.949423] workqueue kcopyd: flags=0x8
[68899.949429]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
[68899.949437]     pending: do_work [dm_mod]
[68899.949452] workqueue kcopyd: flags=0x8
[68899.949458]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=2/256
[68899.949466]     in-flight: 13:do_work [dm_mod]
[68899.949474]     pending: do_work [dm_mod]
[68899.949487] workqueue kcopyd: flags=0x8
[68899.949493]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
[68899.949501]     pending: do_work [dm_mod]
[68899.949515] workqueue kcopyd: flags=0x8
[68899.949521]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
[68899.949529]     pending: do_work [dm_mod]
[68899.949541] workqueue kcopyd: flags=0x8
[68899.949547]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
[68899.949555]     pending: do_work [dm_mod]
[68899.949568] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=95s workers=4 idle: 27130 27223 1084

Fix this by splitting the complete_jobs list into two parts: A user
facing part, named callback_jobs, and one used internally by kcopyd,
retaining the name complete_jobs. dm_kcopyd_do_callback() and
dispatch_job() now push their jobs to the callback_jobs list, which is
spliced to the complete_jobs list once, every time the kcopyd thread
wakes up. This prevents kcopyd from hogging the CPU indefinitely and
causing workqueue stalls.

Re-running the aforementioned test:

  * Workqueue stalls are eliminated
  * The maximum writing time among all targets is reduced from 09m37.10s
    to 06m04.85s and the total run time of the test is reduced from
    10m43.591s to 7m19.199s

[1] https://github.com/jthornber/device-mapper-test-suite

Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-kcopyd.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 2fc4213e02b5..671c24332802 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -56,15 +56,17 @@ struct dm_kcopyd_client {
 	atomic_t nr_jobs;
 
 /*
- * We maintain three lists of jobs:
+ * We maintain four lists of jobs:
  *
  * i)   jobs waiting for pages
  * ii)  jobs that have pages, and are waiting for the io to be issued.
- * iii) jobs that have completed.
+ * iii) jobs that don't need to do any IO and just run a callback
+ * iv) jobs that have completed.
  *
- * All three of these are protected by job_lock.
+ * All four of these are protected by job_lock.
  */
 	spinlock_t job_lock;
+	struct list_head callback_jobs;
 	struct list_head complete_jobs;
 	struct list_head io_jobs;
 	struct list_head pages_jobs;
@@ -625,6 +627,7 @@ static void do_work(struct work_struct *work)
 	struct dm_kcopyd_client *kc = container_of(work,
 					struct dm_kcopyd_client, kcopyd_work);
 	struct blk_plug plug;
+	unsigned long flags;
 
 	/*
 	 * The order that these are called is *very* important.
@@ -633,6 +636,10 @@ static void do_work(struct work_struct *work)
 	 * list.  io jobs call wake when they complete and it all
 	 * starts again.
 	 */
+	spin_lock_irqsave(&kc->job_lock, flags);
+	list_splice_tail_init(&kc->callback_jobs, &kc->complete_jobs);
+	spin_unlock_irqrestore(&kc->job_lock, flags);
+
 	blk_start_plug(&plug);
 	process_jobs(&kc->complete_jobs, kc, run_complete_job);
 	process_jobs(&kc->pages_jobs, kc, run_pages_job);
@@ -650,7 +657,7 @@ static void dispatch_job(struct kcopyd_job *job)
 	struct dm_kcopyd_client *kc = job->kc;
 	atomic_inc(&kc->nr_jobs);
 	if (unlikely(!job->source.count))
-		push(&kc->complete_jobs, job);
+		push(&kc->callback_jobs, job);
 	else if (job->pages == &zero_page_list)
 		push(&kc->io_jobs, job);
 	else
@@ -858,7 +865,7 @@ void dm_kcopyd_do_callback(void *j, int read_err, unsigned long write_err)
 	job->read_err = read_err;
 	job->write_err = write_err;
 
-	push(&kc->complete_jobs, job);
+	push(&kc->callback_jobs, job);
 	wake(kc);
 }
 EXPORT_SYMBOL(dm_kcopyd_do_callback);
@@ -888,6 +895,7 @@ struct dm_kcopyd_client *dm_kcopyd_client_create(struct dm_kcopyd_throttle *thro
 		return ERR_PTR(-ENOMEM);
 
 	spin_lock_init(&kc->job_lock);
+	INIT_LIST_HEAD(&kc->callback_jobs);
 	INIT_LIST_HEAD(&kc->complete_jobs);
 	INIT_LIST_HEAD(&kc->io_jobs);
 	INIT_LIST_HEAD(&kc->pages_jobs);
@@ -939,6 +947,7 @@ void dm_kcopyd_client_destroy(struct dm_kcopyd_client *kc)
 	/* Wait for completion of all jobs submitted by this client. */
 	wait_event(kc->destroyq, !atomic_read(&kc->nr_jobs));
 
+	BUG_ON(!list_empty(&kc->callback_jobs));
 	BUG_ON(!list_empty(&kc->complete_jobs));
 	BUG_ON(!list_empty(&kc->io_jobs));
 	BUG_ON(!list_empty(&kc->pages_jobs));
-- 
2.19.1



