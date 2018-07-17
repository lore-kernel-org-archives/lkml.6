Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7130FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252A6208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252A6208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeGQHgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:36:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49631 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727600AbeGQHgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:36:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4339415459BA1;
        Tue, 17 Jul 2018 15:05:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Tue, 17 Jul 2018
 15:05:03 +0800
Message-ID: <5B4D951D.9050504@huawei.com>
Date:   Tue, 17 Jul 2018 15:05:01 +0800
From:   "Longpeng (Mike)" <longpeng2@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To:     <peterz@infradead.org>, <pjt@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
CC:     Wanpeng Li <kernellwp@gmail.com>,
        Xiexiangyou <xiexiangyou@huawei.com>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        Gonglei <arei.gonglei@huawei.com>,
        "weiqi (C)" <weiqi4@huawei.com>
Subject: [ RFC ] Set quota on VM cause large schedule latency of vcpu
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual machine has cgroup hierarchies as follow:

               root
                |
              vm_tg
              (cfs_rq)
              /    \
            (se)    (se)
            tg_A    tg_B
          (cfs_rq)    (cfs_rq)
            /          \
          (se)          (se)
          a                b

'a' and 'b' are two vcpus of the VM.

We set cfs quota on vm_tg, and the schedule latency of vcpu(a/b) may become very
large, up to more than 2S.
We use perf sched to capture the latency ( perf sched record -a sleep 10;
perf sched lat -p --sort=max ) and the result is as follow:

Task     | Runtime ms | Switches | Average delay ms | Maximum delay ms |
------------------------------------------------------------------------
CPU 0/KVM| 260.261 ms |       50 | avg:   82.017 ms | max: 2510.990 ms |
...

We test the latest kernel and the result is the same.
We add some tracepoints, found the following sequence will cause the issue:

1) 'a' is only task of tg_A, when 'a' go to sleep (e.g. vcpu halt), tg_A is
dequeued, and tg_A->se->load.weight = MIN_SHARES.

2) 'b' continue running, then trigger throttle. tg_A->cfs_rq->throttle_count=1

3) Something wakeup 'a' (e.g. vcpu receive a virq). When enqueue tg_A,
tg_A->se->load.weight can't be updated because tg_A->cfs_rq->throttle_count=1

4) After one cfs quota period, vm_tg is unthrottled

5) 'a' is running

6) After one tick, when update tg_A->se's vruntime, tg_A->se->load.weight is
still MIN_SHARES, lead tg_A->se's vruntime has grown a large value.

7) That will cause 'a' to have a large schedule latency.


We *rudely* remove the check which cause tg_A->se->load.weight didn't reweight
in step-3 as follow and the problem disappear:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f0a0be..348ccd6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3016,9 +3016,6 @@ static void update_cfs_group(struct sched_entity *se)
        if (!gcfs_rq)
                return;

-       if (throttled_hierarchy(gcfs_rq))
-               return;
-
#ifndef CONFIG_SMP
        runnable = shares = READ_ONCE(gcfs_rq->tg->shares);


So do guys you have any suggestion on this problem ? Is there a better way fix
this problem ?

-- 
Regards,
Longpeng(Mike)

