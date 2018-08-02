Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EDAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B06020862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QUo0mxuG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J8UqtZpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B06020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeHBDXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:23:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeHBDXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:23:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1E90560540; Thu,  2 Aug 2018 01:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533173681;
        bh=OGpHk+iqPtddHUfp+LRViLAwAvqL7aoaPEJ25uKrgBA=;
        h=Date:From:To:Cc:Subject:From;
        b=QUo0mxuGl+dlNIqNdI10VZycudufKewrtKpLX/W7UA/uIj7xMwd2t5A/B7d0XnOBF
         YS3RLwCpWQe/a4a/mGxjGxYf6V1ok5KJ6NR/jE6CoE4c+tn4lmZS1f8IzD2+3mn5qI
         k4syGTCzmP0/bN/LWLxqrckEoHI+KrP6/LlOw8bg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3D9D860540;
        Thu,  2 Aug 2018 01:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533173680;
        bh=OGpHk+iqPtddHUfp+LRViLAwAvqL7aoaPEJ25uKrgBA=;
        h=Date:From:To:Cc:Subject:From;
        b=J8UqtZpE9R8eq/m76BIhMIW6s2IwMS/tb9aFJrb36TTu+/YxD9FmFAhWenJR4OkvM
         2ESE9qWwqPqJjy5j8awIqrg8spXNUJfNCFtTLxyGIMymqMhz6CE/fMR1F+cn2Pvdpg
         vfPly/Yt0yDb7RxT5mbV+vcasyhhx6+zU+hYD+tA=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 01 Aug 2018 18:34:40 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     peterz@infradead.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, tglx@linutronix.de
Cc:     isaacm@codeaurora.org, psodagud@codeaurora.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Subject: cpu stopper threads and setaffinity leads to deadlock
Message-ID: <24eebe1d874cb8e3b9a18087554544fa@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Tglx,

We are observing another deadlock issue due to commit 
0b26351b91(stop_machine, sched: Fix migrate_swap() vs. active_balance() 
deadlock), even after taking the following fix
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1740526.html 
on the Linux-4.14.56  kernel.

Here is the scenario that leads to this deadlock.
We have used the stress-ng-64 --affinity test case to reproduce this 
issue in a controlled environment, while simultaneously running CPU hot 
plug and task migrations.

Stress-ng-affin (call stack shown below) is changing its own affinity 
from cpu3 to cpu7. Stress-ng-affin is preempted in the 
cpu_stop_queue_work() function
as soon as the stopper lock for migration/3 is released . At the same 
time, on CPU 7, cross migration of tasks happens between  cpu3 and cpu7.

=======================================================
Process: stress-ng-affin, cpu: 3 pid: 1748 start: 0xffffffd8817e4480
=====================================================
     Task name: stress-ng-affin pid: 1748 cpu: 3 start: ffffffd8817e4480
     state: 0x0 exit_state: 0x0 stack base: 0xffffff801c8e8000 Prio: 120
     Stack:
     [<ffffff87754864f4>] __switch_to+0xb8
     [<ffffff87763ebf8c>] __schedule+0x690
     [<ffffff87763ec388>] preempt_schedule_common+0x100
     [<ffffff87763eb8f4>] preempt_schedule+0x24
     [<ffffff87763f0e58>] _raw_spin_unlock_irqrestore+0x64
     [<ffffff8775574f8c>] cpu_stop_queue_work+0x9c
     [<ffffff8775574dfc>] stop_one_cpu+0x58
     [<ffffff87754e4884>] __set_cpus_allowed_ptr+0x234
     [<ffffff87754e8888>] sched_setaffinity+0x150
     [<ffffff87754e8ad8>] SyS_sched_setaffinity+0xcc
     [<ffffff87754837c0>] el0_svc_naked+0x34
     [<0>] UNKNOWN+0x0

Due to cross migration of tasks between cpu7 and cpu3, migration/7 has 
started executing and waits for the migration/3 task, so that they can 
proceed within the multi cpu stop state machine together.
Unfortunately stress-ng-affin is affine to cpu7, and since migration 7 
has started running, and has monopolized cpu7’s execution, stress-ng 
will never run on cpu7, and cpu3’s migration task is never woken up.

Essentially:
Due to the nature of the wake_q interface,  a thread can only be in at 
most one wake queue at a time.
migration/3 is currently in stress-ng-affin’s wake_q. This means that no 
other thread can add migration/3 to their wake queue.
Thus, even if any attempt is made to stop CPU 3 (e.g. cross-migration, 
hot plugging, etc), no thread will wake up migration/3.

Below change helped to fix this deadlock.
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index e190d1e..f932e1e 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -87,9 +87,9 @@ static bool cpu_stop_queue_work(unsigned int cpu, 
struct cpu_stop_work *work)
                 __cpu_stop_queue_work(stopper, work, &wakeq);
         else if (work->done)
                 cpu_stop_signal_done(work->done);
-       raw_spin_unlock_irqrestore(&stopper->lock, flags);

         wake_up_q(&wakeq);
+       raw_spin_unlock_irqrestore(&stopper->lock, flags);


-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
