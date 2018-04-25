Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49uVzOGOrxO1VSxTKp1I/d/1aFP1ZY7R9A41avZhpoglIumQRuVS0htaRzcekU2Fmjavj0e
ARC-Seal: i=1; a=rsa-sha256; t=1524653067; cv=none;
        d=google.com; s=arc-20160816;
        b=t6VYY+KHz4oJ7rZMwS07aHmLVFBAaEne3uv4MSxGyNtXnZqXB93q278bMHyP6pPGsh
         RRAK9tYN0/Y6xtzA8nh8NoFWmAIryc3atNCbH58aAB9dl/ZxErvBJs9Dp/+W6do6o9cq
         RwRPipyM7k5SCg03UKIgSiQnyeP/qgZG/4BNeHGRvTGXxwAxjRD26ml/m2O2VpcUUGIT
         hx80aZjjVUj2jNn5krE/lqKyER0nRB5ifozQIrlx++FGQeOFxvcQR/7VyFp7Vt/X2dSa
         e1PNhdrG0Ico06jYuSwIIMwa48wvMAikV4MTXn6vJ5xBVXFmIHUhIqc8xuVZ6sxe1QSK
         aplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wRJ7ww7S3PUiDKRPI/3M12e88T3SqTgGjX9KNElwF6A=;
        b=BnL4ko3sAQ8HANS7BVov6kwYeZz4xX7MZjKyNdvLzoTNbY9VYYx5fJ04q3xyEQBaUJ
         aywOYC6ddCOoW8HIgukUnvwMWXpi9dVCQx20wTBT7lIGwM7V0uDOfhyX9CRv3AeVcdbc
         fKmsoxjbNMEXMbwq9qCy7O70uJzDasPpEoY4/O04euPg6qgvvIAtFulQHJFF4ezO3k2c
         5c8sgiwBVuw3Lv9SzYZVfBV/ue1pGqj9Uv2TIXd/qSFGmA0EyK0Qi85flBCYOtNpfPUx
         ZdrUNNIPF3pVaDewRQmerdZzppgJCGoCD9u8OYLSwc32VEkBzhvAEyDSz+OXXlfeIek0
         kfMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Salter <msalter@redhat.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 171/183] irqchip/gic-v3: Change pr_debug message to pr_devel
Date: Wed, 25 Apr 2018 12:36:31 +0200
Message-Id: <20180425103249.384808464@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714615040749175?=
X-GMAIL-MSGID: =?utf-8?q?1598714615040749175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Salter <msalter@redhat.com>


[ Upstream commit b6dd4d83dc2f78cebc9a7e6e7e4bc2be4d29b94d ]

The pr_debug() in gic-v3 gic_send_sgi() can trigger a circular locking
warning:

 GICv3: CPU10: ICC_SGI1R_EL1 5000400
 ======================================================
 WARNING: possible circular locking dependency detected
 4.15.0+ #1 Tainted: G        W
 ------------------------------------------------------
 dynamic_debug01/1873 is trying to acquire lock:
  ((console_sem).lock){-...}, at: [<0000000099c891ec>] down_trylock+0x20/0x4c

 but task is already holding lock:
  (&rq->lock){-.-.}, at: [<00000000842e1587>] __task_rq_lock+0x54/0xdc

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #2 (&rq->lock){-.-.}:
        __lock_acquire+0x3b4/0x6e0
        lock_acquire+0xf4/0x2a8
        _raw_spin_lock+0x4c/0x60
        task_fork_fair+0x3c/0x148
        sched_fork+0x10c/0x214
        copy_process.isra.32.part.33+0x4e8/0x14f0
        _do_fork+0xe8/0x78c
        kernel_thread+0x48/0x54
        rest_init+0x34/0x2a4
        start_kernel+0x45c/0x488

 -> #1 (&p->pi_lock){-.-.}:
        __lock_acquire+0x3b4/0x6e0
        lock_acquire+0xf4/0x2a8
        _raw_spin_lock_irqsave+0x58/0x70
        try_to_wake_up+0x48/0x600
        wake_up_process+0x28/0x34
        __up.isra.0+0x60/0x6c
        up+0x60/0x68
        __up_console_sem+0x4c/0x7c
        console_unlock+0x328/0x634
        vprintk_emit+0x25c/0x390
        dev_vprintk_emit+0xc4/0x1fc
        dev_printk_emit+0x88/0xa8
        __dev_printk+0x58/0x9c
        _dev_info+0x84/0xa8
        usb_new_device+0x100/0x474
        hub_port_connect+0x280/0x92c
        hub_event+0x740/0xa84
        process_one_work+0x240/0x70c
        worker_thread+0x60/0x400
        kthread+0x110/0x13c
        ret_from_fork+0x10/0x18

 -> #0 ((console_sem).lock){-...}:
        validate_chain.isra.34+0x6e4/0xa20
        __lock_acquire+0x3b4/0x6e0
        lock_acquire+0xf4/0x2a8
        _raw_spin_lock_irqsave+0x58/0x70
        down_trylock+0x20/0x4c
        __down_trylock_console_sem+0x3c/0x9c
        console_trylock+0x20/0xb0
        vprintk_emit+0x254/0x390
        vprintk_default+0x58/0x90
        vprintk_func+0xbc/0x164
        printk+0x80/0xa0
        __dynamic_pr_debug+0x84/0xac
        gic_raise_softirq+0x184/0x18c
        smp_cross_call+0xac/0x218
        smp_send_reschedule+0x3c/0x48
        resched_curr+0x60/0x9c
        check_preempt_curr+0x70/0xdc
        wake_up_new_task+0x310/0x470
        _do_fork+0x188/0x78c
        SyS_clone+0x44/0x50
        __sys_trace_return+0x0/0x4

 other info that might help us debug this:

 Chain exists of:
   (console_sem).lock --> &p->pi_lock --> &rq->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&rq->lock);
                                lock(&p->pi_lock);
                                lock(&rq->lock);
   lock((console_sem).lock);

  *** DEADLOCK ***

 2 locks held by dynamic_debug01/1873:
  #0:  (&p->pi_lock){-.-.}, at: [<000000001366df53>] wake_up_new_task+0x40/0x470
  #1:  (&rq->lock){-.-.}, at: [<00000000842e1587>] __task_rq_lock+0x54/0xdc

 stack backtrace:
 CPU: 10 PID: 1873 Comm: dynamic_debug01 Tainted: G        W        4.15.0+ #1
 Hardware name: GIGABYTE R120-T34-00/MT30-GS2-00, BIOS T48 10/02/2017
 Call trace:
  dump_backtrace+0x0/0x188
  show_stack+0x24/0x2c
  dump_stack+0xa4/0xe0
  print_circular_bug.isra.31+0x29c/0x2b8
  check_prev_add.constprop.39+0x6c8/0x6dc
  validate_chain.isra.34+0x6e4/0xa20
  __lock_acquire+0x3b4/0x6e0
  lock_acquire+0xf4/0x2a8
  _raw_spin_lock_irqsave+0x58/0x70
  down_trylock+0x20/0x4c
  __down_trylock_console_sem+0x3c/0x9c
  console_trylock+0x20/0xb0
  vprintk_emit+0x254/0x390
  vprintk_default+0x58/0x90
  vprintk_func+0xbc/0x164
  printk+0x80/0xa0
  __dynamic_pr_debug+0x84/0xac
  gic_raise_softirq+0x184/0x18c
  smp_cross_call+0xac/0x218
  smp_send_reschedule+0x3c/0x48
  resched_curr+0x60/0x9c
  check_preempt_curr+0x70/0xdc
  wake_up_new_task+0x310/0x470
  _do_fork+0x188/0x78c
  SyS_clone+0x44/0x50
  __sys_trace_return+0x0/0x4
 GICv3: CPU0: ICC_SGI1R_EL1 12000

This could be fixed with printk_deferred() but that might lessen its
usefulness for debugging. So change it to pr_devel to keep it out of
production kernels. Developers working on gic-v3 can enable it as
needed in their kernels.

Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-gic-v3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -645,7 +645,7 @@ static void gic_send_sgi(u64 cluster_id,
 	       MPIDR_TO_SGI_AFFINITY(cluster_id, 1)	|
 	       tlist << ICC_SGI1R_TARGET_LIST_SHIFT);
 
-	pr_debug("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
+	pr_devel("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
 	gic_write_sgi1r(val);
 }
 
