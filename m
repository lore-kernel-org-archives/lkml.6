Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D220C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9420206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbfAIP7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:59:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731169AbfAIP7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:59:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58DEB368DD;
        Wed,  9 Jan 2019 15:59:45 +0000 (UTC)
Received: from t460s.bristot.redhat.com (ovpn-116-128.phx2.redhat.com [10.3.116.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBE5A10A1827;
        Wed,  9 Jan 2019 15:59:43 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RT] padata: Make padata_do_serial() use get_cpu_light()
Date:   Wed,  9 Jan 2019 16:59:26 +0100
Message-Id: <5894faebe7c816c6b210ab2616a49330f067a492.1547039140.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 09 Jan 2019 15:59:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We hit the following BUG:

  BUG: scheduling while atomic: kworker/1:1/24117/0x00000002
  Preemption disabled at:
  [<ffffffffb61fd824>] padata_do_serial+0x24/0x110
  CPU: 1 PID: 24117 Comm: kworker/1:1 Not tainted 4.18.0-56.rt9.107.el8.x86_64 #1
  Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS U30 11/14/2017
  Workqueue: pencrypt padata_parallel_worker
  Call Trace:
    dump_stack+0x5c/0x80
    ? padata_do_serial+0x24/0x110
    __schedule_bug.cold.83+0x8e/0x9b
    __schedule+0x5a0/0x680
    schedule+0x39/0xd0
    rt_spin_lock_slowlock_locked+0x10e/0x2b0
    rt_spin_lock_slowlock+0x50/0x80
    padata_do_serial+0x4d/0x110
    padata_parallel_worker+0xaf/0xe0
    process_one_work+0x183/0x3b0
    ? process_one_work+0x3b0/0x3b0
    worker_thread+0x30/0x3d0
    ? process_one_work+0x3b0/0x3b0
    kthread+0x112/0x130
    ? kthread_create_worker_on_cpu+0x70/0x70
    ret_from_fork+0x35/0x40

and the cause is a spin_lock() taken inside a get_cpu() section.

Convert the get/put_cpu to get/put_cpu_light to fix the BUG while reducing the
preempt_disable section.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Reviewed-by: Clark Williams <williams@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

diff --git a/kernel/padata.c b/kernel/padata.c
index d568cc56405f..bfcbdeb20ba5 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -295,7 +295,7 @@ static void padata_reorder_timer(struct timer_list *t)
 	unsigned int weight;
 	int target_cpu, cpu;
 
-	cpu = get_cpu();
+	cpu = get_cpu_light();
 
 	/* We don't lock pd here to not interfere with parallel processing
 	 * padata_reorder() calls on other CPUs. We just need any CPU out of
@@ -321,7 +321,7 @@ static void padata_reorder_timer(struct timer_list *t)
 		padata_reorder(pd);
 	}
 
-	put_cpu();
+	put_cpu_light();
 }
 
 static void padata_serial_worker(struct work_struct *serial_work)
@@ -369,7 +369,7 @@ void padata_do_serial(struct padata_priv *padata)
 
 	pd = padata->pd;
 
-	cpu = get_cpu();
+	cpu = get_cpu_light();
 
 	/* We need to run on the same CPU padata_do_parallel(.., padata, ..)
 	 * was called on -- or, at least, enqueue the padata object into the
@@ -387,7 +387,7 @@ void padata_do_serial(struct padata_priv *padata)
 	list_add_tail(&padata->list, &pqueue->reorder.list);
 	spin_unlock(&pqueue->reorder.lock);
 
-	put_cpu();
+	put_cpu_light();
 
 	/* If we're running on the wrong CPU, call padata_reorder() via a
 	 * kernel worker.
-- 
2.17.2

