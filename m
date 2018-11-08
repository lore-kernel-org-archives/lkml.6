Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FEEECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D006A20817
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHVViSG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D006A20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeKIFwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:52:23 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34190 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeKIFwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:52:23 -0500
Received: by mail-yb1-f193.google.com with SMTP id n140-v6so8887437yba.1;
        Thu, 08 Nov 2018 12:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BxbFJOzRVuNYYE5nClkVAe8F5JFbtv/j1hv7sF2oke4=;
        b=sHVViSG38AH29tX4KYViKHyE5I0BS8AxKoHFzPXi9B1F5NSPn2W/o+307GGO5968Oi
         0ey++lvswOOWgEctbhBXCNTrlDgaztC7HVXUUejF3yEEeeLMzPC5pENVpw103gcRZUps
         Yti1YtoCZFmihDrzIm9YWCBnRIfl3GGGRV5/oz6wLt0NrmuWtYJL957ui1qVOIIg6Iwd
         QdBfcr4crf/RVck6eYfcgahkbwa5ZgEGc2fbBIF/p1+K5fP+mUJaoeAPVCK3WbKOnF3D
         KPYJRGyffsyiPt4lg+2aucEjzxmUflGpcWItxqkYY/MZ0njVxSFww6ofeInLlB34Typi
         N4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BxbFJOzRVuNYYE5nClkVAe8F5JFbtv/j1hv7sF2oke4=;
        b=n1l2bTnAak9rh5MHzyms+iSP5m12kQrO7BqCE2DPZTI7RTNgFX099zMmA8VoqeXYjf
         rdIaYYnumwAF7YmWC070ZiKflGZddr0Q43T1fWBA4g8BuTV5+miWpKFKpxs3Oxe6Im6M
         +bNMqyJEZzuxJ5fdAfu0BzidxKp0xMGJ0v6wB65F4NvnZ5RJYj/sdMlwBqtjfZo65nLD
         rOezbepinm+QIU4iRXAqdo1q3lp+L+aco0WBU2HBCNfIPzUPwzXMPNkoT/gPJR7HHlra
         5uQHQci55Q7VZTvPEI0vnkzlwzI+bpHcxb+8Z2Vuat+eLkhj+EYkZxtOyNbDyfAYJdhD
         tkKg==
X-Gm-Message-State: AGRZ1gL204pNSWagbHnh+zU3xKNkbPGiHvjsWiaQcY3+vmNcMlPFjvAp
        qCFxeFcx/lRuDzJk3JZQdHdYgL4q
X-Google-Smtp-Source: AJdET5dAbF8AjbaGBEe3dObJ/zDl74BxxqxRyuuQh5d5st+KVfGGhWhxh69jeVgdkfr9QsAC4BI6IQ==
X-Received: by 2002:a25:4d41:: with SMTP id a62-v6mr5865686ybb.409.1541708118808;
        Thu, 08 Nov 2018 12:15:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:7f75])
        by smtp.gmail.com with ESMTPSA id u134-v6sm5826738ywf.86.2018.11.08.12.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:15:17 -0800 (PST)
Date:   Thu, 8 Nov 2018 12:15:15 -0800
From:   Tejun Heo <tj@kernel.org>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: [PATCH for-4.20-fixes] cgroup: fix CSS_TASK_ITER_PROCS
Message-ID: <20181108201515.GC2509588@devbig004.ftw2.facebook.com>
References: <fdb057a2-342a-d49e-587a-f1ca8680033e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdb057a2-342a-d49e-587a-f1ca8680033e@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/cgroup/cgroup.c |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6aaf5dd5383b..1f84977fab47 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4202,20 +4202,25 @@ static void css_task_iter_advance(struct css_task_iter *it)
 
 	lockdep_assert_held(&css_set_lock);
 repeat:
-	/*
-	 * Advance iterator to find next entry.  cset->tasks is consumed
-	 * first and then ->mg_tasks.  After ->mg_tasks, we move onto the
-	 * next cset.
-	 */
-	next = it->task_pos->next;
+	if (it->task_pos) {
+		/*
+		 * Advance iterator to find next entry.  cset->tasks is
+		 * consumed first and then ->mg_tasks.  After ->mg_tasks,
+		 * we move onto the next cset.
+		 */
+		next = it->task_pos->next;
 
-	if (next == it->tasks_head)
-		next = it->mg_tasks_head->next;
+		if (next == it->tasks_head)
+			next = it->mg_tasks_head->next;
 
-	if (next == it->mg_tasks_head)
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
@@ -4255,7 +4260,7 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 
 	it->cset_head = it->cset_pos;
 
-	css_task_iter_advance_css_set(it);
+	css_task_iter_advance(it);
 
 	spin_unlock_irq(&css_set_lock);
 }
