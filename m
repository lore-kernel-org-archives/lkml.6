Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFF6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C6620651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mbmLl44g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfAPSm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:42:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39737 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfAPSm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:42:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so6267376edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QcX86HO5efLkf6puBxvbFpxHB6+66GFgK3rJrAkhTQw=;
        b=mbmLl44g3r5uAuYroHp36LZZJ2ni1O503MmKwJSZkZ1jl6/sBgUpXOKdzmW1vhXUOH
         WuSMzqWqYle0zR+BYY2motnWYt+yYOulE+EW4j6aw5MeCptT1gbjK27NfS6Ovf9ELWID
         45kIZz0KdnGP6f0Vy4X4UkGuaiyQxjWqAY3vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QcX86HO5efLkf6puBxvbFpxHB6+66GFgK3rJrAkhTQw=;
        b=lcvtVt/iAXd92xJklWKkbTl4T8a2FFgX3yli96Bbh59Al3c45TffbLAfW/PyGO+JZa
         lcNghyx/+IjoWe+M9nQtIK7ii642NUlU88zUNmiew7k3EGVvNVBW/sAOoMVniAiMPUYj
         GZkd9bsTp4Ds2xMaGXkyWsjqdAKMOybdE/j/wuEifl5gfuRPRl2ZhjdcY+QI3WLxXT6/
         lN5SKV0Wm18oLAmV+4YAdPe0BD4ZCpvZfeky9SL7gUxXOMP+99IH4LlqQO721iwNn7A2
         J+ZTJZfs0Z70TWWgdIHgzICrHS+dNsftQzQItj9oiE3WbqtZxYvEx8E8BNGcE81cdEbt
         cfBQ==
X-Gm-Message-State: AJcUukf8etuB8Tjo3lWiqE1p8By7ReFGhkgY7kCIiFsEZ8dxX2OrFhF1
        eDaVMhIfJiK7zLjA6lsXDwEhtx6kHG/IXw==
X-Google-Smtp-Source: ALg8bN51Oi0StwWCKr5egBGLZ5OhIA2nlEqKAEstQLBjM2/UkbFr1kxnTwaF6uT/+gzhlyeoO8TvPQ==
X-Received: by 2002:a50:d643:: with SMTP id c3mr8288825edj.178.1547664175186;
        Wed, 16 Jan 2019 10:42:55 -0800 (PST)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id l18sm5570286edq.87.2019.01.16.10.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:42:54 -0800 (PST)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] sched: Use READ_ONCE()/WRITE_ONCE() in task_cpu()/__set_task_cpu()
Date:   Wed, 16 Jan 2019 19:42:18 +0100
Message-Id: <20190116184218.13757-1-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smp_wmb() in move_queued_task() (c.f., __set_task_cpu()) pairs with
the composition of the dependency and the ACQUIRE in task_rq_lock():

	move_queued_task()		task_rq_lock()

	[S] ->on_rq = MIGRATING		[L] rq = task_rq()
	WMB (__set_task_cpu())		ACQUIRE (rq->lock);
	[S] ->cpu = new_cpu		[L] ->on_rq

where "[L] rq = task_rq()" is ordered before "ACQUIRE (rq->lock)" by an
address dependency and, in turn, "ACQUIRE (rq->lock)" is ordered before
"[L] ->on_rq" by the ACQUIRE itself.

Use READ_ONCE() to load ->cpu in task_rq() (c.f., task_cpu()) to honour
this address dependency between loads; also, mark the store to ->cpu in
__set_task_cpu() by using WRITE_ONCE() in order to tell the compiler to
not mess/tear this (synchronizing) memory access.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 include/linux/sched.h | 4 ++--
 kernel/sched/sched.h  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 224666226e87b..2bb02c9635bd8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1753,9 +1753,9 @@ static __always_inline bool need_resched(void)
 static inline unsigned int task_cpu(const struct task_struct *p)
 {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-	return p->cpu;
+	return READ_ONCE(p->cpu);
 #else
-	return task_thread_info(p)->cpu;
+	return READ_ONCE(task_thread_info(p)->cpu);
 #endif
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d04530bf251fe..270a3333589d2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1460,9 +1460,9 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 	 */
 	smp_wmb();
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-	p->cpu = cpu;
+	WRITE_ONCE(p->cpu, cpu);
 #else
-	task_thread_info(p)->cpu = cpu;
+	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
 #endif
 	p->wake_cpu = cpu;
 #endif
-- 
2.17.1

