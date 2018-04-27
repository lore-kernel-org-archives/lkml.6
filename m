Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933942AbeD0PH0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:07:26 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:40930 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933738AbeD0OEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:04:39 -0400
From: Jiada Wang <jiada_wang@mentor.com>
To: <morten.rasmussen@arm.com>
CC: <valentin.schneider@arm.com>, <dietmar.eggemann@arm.com>,
        <vincent.guittot@linaro.org>, <gaku.inami.xh@renesas.com>,
        <linux-kernel@vger.kernel.org>, <jiada_wang@mentor.com>
Subject: Re: [PATCHv2,1/7] sched: Add static_key for asymmetric cpu capacity optimizations
Date: Fri, 27 Apr 2018 23:04:38 +0900
Message-ID: <20180427140438.7433-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <1521125224-15434-2-git-send-email-morten.rasmussen@arm.com>
References: <1521125224-15434-2-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

with this patch, if enable CONFIG_DEBUG_ATOMIC_SLEEP=y,
then I am getting following BUG report during early startup

Backtrace caused by [1] during early kernel startup:
[ 5.325288] CPU: All CPU(s) started at EL2
[ 5.325700] alternatives: patching kernel code
[ 5.329255] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:34
[ 5.329525] in_atomic(): 0, irqs_disabled(): 0, pid: 1, name: swapper/0
[ 5.329657] 2 locks held by swapper/0/1:
[ 5.329744] #0: (sched_domains_mutex){+.+.}, at: [<ffff20000957f244>] sched_init_smp+0x88/0x158
[ 5.329993] #1: (rcu_read_lock){....}, at: [<ffff200008159794>] build_sched_domains+0x9cc/0x2f08
[ 5.330233] Preemption disabled at:
[ 5.330256] [<ffff200008157b5c>] rq_attach_root+0x28/0x1d8
[ 5.330511] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.17+ #123
[ 5.330635] Hardware name: Renesas Salvator-X board based on r8a7795 ES2.0+ (DT)
[ 5.330779] Call trace:
[ 5.330853] [<ffff20000808fe88>] dump_backtrace+0x0/0x364
[ 5.330968] [<ffff200008090200>] show_stack+0x14/0x1c
[ 5.331080] [<ffff200008f365d8>] dump_stack+0x108/0x174
[ 5.331194] [<ffff200008113170>] ___might_sleep+0x43c/0x44c
[ 5.331310] [<ffff2000081132e4>] __might_sleep+0x164/0x178
[ 5.331429] [<ffff2000080b2338>] cpus_read_lock+0x38/0x12c
[ 5.331547] [<ffff2000082d5860>] static_key_enable+0x14/0x2c
[ 5.331665] [<ffff20000815bcac>] build_sched_domains+0x2ee4/0x2f08
[ 5.331789] [<ffff20000815cc9c>] sched_init_domains+0xcc/0xe8
[ 5.331908] [<ffff20000957f250>] sched_init_smp+0x94/0x158
[ 5.332026] [<ffff200009571560>] kernel_init_freeable+0x1ec/0x4c4
[ 5.332153] [<ffff200008f593a8>] kernel_init+0x10/0x128
[ 5.332264] [<ffff2000080865d4>] ret_from_fork+0x10/0x18
[ 5.343400] devtmpfs: initialized

Thanks,
Jiada
