Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E84ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA78A20685
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA78A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbeIXRmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:42:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeIXRmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:42:50 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9083D1072;
        Mon, 24 Sep 2018 11:41:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jamie Iles <jamie.iles@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 3.18 035/105] kthread: Fix use-after-free if kthread fork fails
Date:   Mon, 24 Sep 2018 13:33:21 +0200
Message-Id: <20180924113117.450989434@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vegard Nossum <vegard.nossum@oracle.com>

commit 4d6501dce079c1eb6bf0b1d8f528a5e81770109e upstream.

If a kthread forks (e.g. usermodehelper since commit 1da5c46fa965) but
fails in copy_process() between calling dup_task_struct() and setting
p->set_child_tid, then the value of p->set_child_tid will be inherited
from the parent and get prematurely freed by free_kthread_struct().

    kthread()
     - worker_thread()
        - process_one_work()
        |  - call_usermodehelper_exec_work()
        |     - kernel_thread()
        |        - _do_fork()
        |           - copy_process()
        |              - dup_task_struct()
        |                 - arch_dup_task_struct()
        |                    - tsk->set_child_tid = current->set_child_tid // implied
        |              - ...
        |              - goto bad_fork_*
        |              - ...
        |              - free_task(tsk)
        |                 - free_kthread_struct(tsk)
        |                    - kfree(tsk->set_child_tid)
        - ...
        - schedule()
           - __schedule()
              - wq_worker_sleeping()
                 - kthread_data(task)->flags // UAF

The problem started showing up with commit 1da5c46fa965 since it reused
->set_child_tid for the kthread worker data.

A better long-term solution might be to get rid of the ->set_child_tid
abuse. The comment in set_kthread_struct() also looks slightly wrong.

Debugged-by: Jamie Iles <jamie.iles@oracle.com>
Fixes: 1da5c46fa965 ("kthread: Make struct kthread kmalloc'ed")
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jamie Iles <jamie.iles@oracle.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20170509073959.17858-1-vegard.nossum@oracle.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/fork.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1243,6 +1243,18 @@ static struct task_struct *copy_process(
 	if (!p)
 		goto fork_out;
 
+	/*
+	 * This _must_ happen before we call free_task(), i.e. before we jump
+	 * to any of the bad_fork_* labels. This is to avoid freeing
+	 * p->set_child_tid which is (ab)used as a kthread's data pointer for
+	 * kernel threads (PF_KTHREAD).
+	 */
+	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? child_tidptr : NULL;
+	/*
+	 * Clear TID on mm_release()?
+	 */
+	p->clear_child_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? child_tidptr : NULL;
+
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
@@ -1406,11 +1418,6 @@ static struct task_struct *copy_process(
 			goto bad_fork_cleanup_io;
 	}
 
-	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? child_tidptr : NULL;
-	/*
-	 * Clear TID on mm_release()?
-	 */
-	p->clear_child_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? child_tidptr : NULL;
 #ifdef CONFIG_BLOCK
 	p->plug = NULL;
 #endif


