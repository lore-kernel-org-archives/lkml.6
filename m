Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCOMhk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:37:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49174 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCOMfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:42 -0400
Message-Id: <20180315123202.472689123@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 03/11] sched/wait,media: Replace wait_on_atomic_t usage
References: <20180315121902.942902000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-wait_var-3.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the wait_on_atomic_t() usage to the new wait_var_event() API.

Unlike the wake_up_atomic_t(), wake_up_var() will issue the wakeup
even if the variable is not 0.

Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/media/platform/qcom/venus/hfi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -106,8 +106,8 @@ int hfi_core_deinit(struct venus_core *c
 
 	if (!empty) {
 		mutex_unlock(&core->lock);
-		wait_on_atomic_t(&core->insts_count, atomic_t_wait,
-				 TASK_UNINTERRUPTIBLE);
+		wait_var_event(&core->insts_count,
+			       !atomic_read(&core->insts_count));
 		mutex_lock(&core->lock);
 	}
 
@@ -229,8 +229,8 @@ void hfi_session_destroy(struct venus_in
 
 	mutex_lock(&core->lock);
 	list_del_init(&inst->list);
-	atomic_dec(&core->insts_count);
-	wake_up_atomic_t(&core->insts_count);
+	if (atomic_dec_and_test(&core->insts_count))
+		wake_up_var(&core->insts_count);
 	mutex_unlock(&core->lock);
 }
 EXPORT_SYMBOL_GPL(hfi_session_destroy);
