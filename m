Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C32C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3280F2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866839;
	bh=2ER6Ou7Va0oDSs+rySjxakUKb/0WL1tMloqcqXdtEnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0pteRylmiCE5KwjisNnYYhIXR/Hv6LxQnyERLAtaO+I1J5S99UKsWgGTKbqpCmR/7
	 jOyN8zcbqDvVTpq8h3ZbpBqjWi8q/nLoGcFbdX+QmsYDGUPVac6iluA6Qh6ppdm/m1
	 m3viNXzSX74O1LDDx6lv4iGWcSdaLkjChOmqe7eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbfAGNN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:13:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfAGNDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:03:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 142A82183F;
        Mon,  7 Jan 2019 13:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866191;
        bh=2ER6Ou7Va0oDSs+rySjxakUKb/0WL1tMloqcqXdtEnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oijmRsm2TVreOWXA1BNUDAaHvH1Iy6To7tv74QyrVQFa0Cz60z+QMiS1kUktPKzNM
         mYD+yM0PXoFKJMFLrGIEdNih1HVIfW8LVoIPGfDv0Qu19rVKlFi9CBbcGyFQ3ioI/S
         vVgefN7N3t6dcJa8sitLeiPnOKtGFxLeCxw6jYFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 4.14 075/101] cgroup: fix CSS_TASK_ITER_PROCS
Date:   Mon,  7 Jan 2019 13:33:03 +0100
Message-Id: <20190107105337.073441015@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit e9d81a1bc2c48ea9782e3e8b53875f419766ef47 upstream.

CSS_TASK_ITER_PROCS implements process-only iteration by making
css_task_iter_advance() skip tasks which aren't threadgroup leaders;
however, when an iteration is started css_task_iter_start() calls the
inner helper function css_task_iter_advance_css_set() instead of
css_task_iter_advance().  As the helper doesn't have the skip logic,
when the first task to visit is a non-leader thread, it doesn't get
skipped correctly as shown in the following example.

  # ps -L 2030
    PID   LWP TTY      STAT   TIME COMMAND
   2030  2030 pts/0    Sl+    0:00 ./test-thread
   2030  2031 pts/0    Sl+    0:00 ./test-thread
  # mkdir -p /sys/fs/cgroup/x/a/b
  # echo threaded > /sys/fs/cgroup/x/a/cgroup.type
  # echo threaded > /sys/fs/cgroup/x/a/b/cgroup.type
  # echo 2030 > /sys/fs/cgroup/x/a/cgroup.procs
  # cat /sys/fs/cgroup/x/a/cgroup.threads
  2030
  2031
  # cat /sys/fs/cgroup/x/cgroup.procs
  2030
  # echo 2030 > /sys/fs/cgroup/x/a/b/cgroup.threads
  # cat /sys/fs/cgroup/x/cgroup.procs
  2031
  2030

The last read of cgroup.procs is incorrectly showing non-leader 2031
in cgroup.procs output.

This can be fixed by updating css_task_iter_advance() to handle the
first advance and css_task_iters_tart() to call
css_task_iter_advance() instead of the inner helper.  After the fix,
the same commands result in the following (correct) result:

  # ps -L 2062
    PID   LWP TTY      STAT   TIME COMMAND
   2062  2062 pts/0    Sl+    0:00 ./test-thread
   2062  2063 pts/0    Sl+    0:00 ./test-thread
  # mkdir -p /sys/fs/cgroup/x/a/b
  # echo threaded > /sys/fs/cgroup/x/a/cgroup.type
  # echo threaded > /sys/fs/cgroup/x/a/b/cgroup.type
  # echo 2062 > /sys/fs/cgroup/x/a/cgroup.procs
  # cat /sys/fs/cgroup/x/a/cgroup.threads
  2062
  2063
  # cat /sys/fs/cgroup/x/cgroup.procs
  2062
  # echo 2062 > /sys/fs/cgroup/x/a/b/cgroup.threads
  # cat /sys/fs/cgroup/x/cgroup.procs
  2062

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Fixes: 8cfd8147df67 ("cgroup: implement cgroup v2 thread support")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/cgroup/cgroup.c |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4080,20 +4080,25 @@ static void css_task_iter_advance(struct
 
 	lockdep_assert_held(&css_set_lock);
 repeat:
-	/*
-	 * Advance iterator to find next entry.  cset->tasks is consumed
-	 * first and then ->mg_tasks.  After ->mg_tasks, we move onto the
-	 * next cset.
-	 */
-	next = it->task_pos->next;
-
-	if (next == it->tasks_head)
-		next = it->mg_tasks_head->next;
-
-	if (next == it->mg_tasks_head)
+	if (it->task_pos) {
+		/*
+		 * Advance iterator to find next entry.  cset->tasks is
+		 * consumed first and then ->mg_tasks.  After ->mg_tasks,
+		 * we move onto the next cset.
+		 */
+		next = it->task_pos->next;
+
+		if (next == it->tasks_head)
+			next = it->mg_tasks_head->next;
+
+		if (next == it->mg_tasks_head)
+			css_task_iter_advance_css_set(it);
+		else
+			it->task_pos = next;
+	} else {
+		/* called from start, proceed to the first cset */
 		css_task_iter_advance_css_set(it);
-	else
-		it->task_pos = next;
+	}
 
 	/* if PROCS, skip over tasks which aren't group leaders */
 	if ((it->flags & CSS_TASK_ITER_PROCS) && it->task_pos &&
@@ -4133,7 +4138,7 @@ void css_task_iter_start(struct cgroup_s
 
 	it->cset_head = it->cset_pos;
 
-	css_task_iter_advance_css_set(it);
+	css_task_iter_advance(it);
 
 	spin_unlock_irq(&css_set_lock);
 }


