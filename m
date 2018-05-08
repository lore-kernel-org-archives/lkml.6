Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755226AbeEHNnt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:43:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36142 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeEHNnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:43:47 -0400
X-Google-Smtp-Source: AB8JxZpkDzo4AfLC61M9dT4QwW5MucoN7hsQbmRXZTo5XTDvEjv+c+55wjfnvMnDg2AcP7NDdrgDduNB/qwu9aDdhhg=
MIME-Version: 1.0
In-Reply-To: <20180222073330.36259-1-carmark.dlut@gmail.com>
References: <20180222073330.36259-1-carmark.dlut@gmail.com>
From: Vegard Nossum <vegard.nossum@gmail.com>
Date: Tue, 8 May 2018 15:43:44 +0200
Message-ID: <CAOMGZ=H=5vHP8wAMccPWhFOM12NEv-tK3WzwRYqHHoc-jNpc4Q@mail.gmail.com>
Subject: Re: [PATCH] fscache: fix a kernel BUG at fs/fscache/operation.c:69!
To: David Howells <dhowells@redhat.com>
Cc: carmark.dlut@gmail.com, linux-cachefs@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48DhrHv015854

On 22 February 2018 at 08:33,  <carmark.dlut@gmail.com> wrote:
> From: Lei Xue <carmark.dlut@gmail.com>
>
> There is a potential race in fscache operation enqueuing for reading and
> copying multiple pages from cachefiles to netfs.
> Under some heavy load system, it will happen very often.
>
> If this race occurs, an oops similar to the following is seen:
>
>  kernel BUG at fs/fscache/operation.c:69!
>  invalid opcode: 0000 [#1] SMP
>  …
>  #0 [ffff883fff0838d8] machine_kexec at ffffffff81051beb
>  #1 [ffff883fff083938] crash_kexec at ffffffff810f2542
>  #2 [ffff883fff083a08] oops_end at ffffffff8163e1a8
>  #3 [ffff883fff083a30] die at ffffffff8101859b
>  #4 [ffff883fff083a60] do_trap at ffffffff8163d860
>  #5 [ffff883fff083ab0] do_invalid_op at ffffffff81015204
>  #6 [ffff883fff083b60] invalid_op at ffffffff8164701e
>     [exception RIP: fscache_enqueue_operation+246]
>     RIP: ffffffffa0b793c6  RSP: ffff883fff083c18  RFLAGS: 00010046
>     RAX: 0000000000000019  RBX: ffff8832ed1a9ec0  RCX: 0000000000000006
>     RDX: 0000000000000000  RSI: 0000000000000046  RDI: 0000000000000046
>     RBP: ffff883fff083c20   R8: 0000000000000086   R9: 000000000000178f
>     R10: ffffffff816aeb00  R11: ffff883fff08392e  R12: ffff8802f0525620
>     R13: ffff88407ffc01d8  R14: 0000000000000000  R15: 0000000000000003
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
>  #7 [ffff883fff083c10] fscache_enqueue_operation at ffffffffa0b793c6
>  #8 [ffff883fff083c28] cachefiles_read_waiter at ffffffffa0b15a48
>  #9 [ffff883fff083c48] __wake_up_common at ffffffff810af028
>
> Signed-off-by: Lei Xue <carmark.dlut@gmail.com>
> ---
>  fs/cachefiles/rdwr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
> index 883bc7bb12c5..9d5d13e150fb 100644
> --- a/fs/cachefiles/rdwr.c
> +++ b/fs/cachefiles/rdwr.c
> @@ -58,9 +58,9 @@ static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
>
>         spin_lock(&object->work_lock);
>         list_add_tail(&monitor->op_link, &monitor->op->to_do);
> +       fscache_enqueue_retrieval(monitor->op);
>         spin_unlock(&object->work_lock);
>
> -       fscache_enqueue_retrieval(monitor->op);
>         return 0;
>  }

Hi,

Just wondering what the status of this patch is?

We've been hitting a similar problem and arrived at the same patch as
a potential fix for it.

Our crashes look like this:

WARNING: CPU: 0 PID: 120693 at kernel/workqueue.c:618 insert_work+0x5f/0x70
Modules linked in: nbd
CPU: 0 PID: 120693 Comm: sh Not tainted 4.16.2-0 #1
Hardware name: Oracle Corporation  Sun Fire X4800/20434, BIOS 11080200
   08/12/2016
RIP: 0010:insert_work+0x5f/0x70
RSP: 0018:ffff88103fa039b8 EFLAGS: 00010046
RAX: ffff88103f443f00 RBX: ffff880187c37c00 RCX: 0000000000000005
RDX: ffff880187c37c20 RSI: ffff8807c04dec00 RDI: 0000000000000000
RBP: ffff88103fa039c8 R08: 0000000000000101 R09: 0000000000000001
R10: ffff887eee68fd40 R11: 0000000000000001 R12: ffff88503fafc600
R13: 000000000001cf60 R14: ffff880187c37c00 R15: ffff88103f443f00
FS:  0000000000000000(0000) GS:ffff88103fa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f394d2780a0 CR3: 0000000bcc936000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 __queue_work+0x11f/0x320
 queue_work_on+0x19/0x30
 fscache_enqueue_operation+0x83/0x160
 cachefiles_read_waiter+0xd2/0x130
 __wake_up_common+0x81/0x120
 __wake_up_locked_key_bookmark+0x16/0x20
 wake_up_page_bit+0x97/0xe0
 unlock_page+0x20/0x30
 page_endio+0x21/0xa0
 mpage_end_io+0x41/0x60
 bio_endio+0x78/0x90
 dec_pending+0x140/0x250
 ? linear_status+0x40/0x40
 clone_endio+0x86/0x100
 bio_endio+0x78/0x90
 blk_update_request+0x8d/0x2b0
 scsi_end_request+0x36/0x200
 scsi_io_completion+0x12a/0x5e0
 scsi_finish_command+0xf2/0x150
 scsi_softirq_done+0x13e/0x160
 __blk_mq_complete_request+0xb8/0x180
 blk_mq_complete_request+0x57/0x70
 scsi_mq_done+0x10/0x20
 megasas_complete_cmd+0xdf/0x620
 megasas_complete_cmd_dpc+0x8f/0x100
 tasklet_action+0x9a/0xb0
 __do_softirq+0xbf/0x1c8
 irq_exit+0x9c/0xb0
 do_IRQ+0x5b/0xe0
 common_interrupt+0xf/0xf
 </IRQ>
RIP: 0010:_raw_spin_unlock_irqrestore+0x9/0x10
RSP: 0018:ffffc900309e3cf8 EFLAGS: 00000296 ORIG_RAX: ffffffffffffffde
RAX: 0000000000000002 RBX: 0000000000000002 RCX: 0000000000000001
RDX: ffffea0006793fe0 RSI: 0000000000000296 RDI: ffff88107ffff800
RBP: ffffc900309e3cf8 R08: 0000000000000002 R09: 000000000011b912
R10: 00000000000000e7 R11: 0000000000000000 R12: ffffea0014baa000
R13: ffff88103fa1d120 R14: ffff88107fff6000 R15: ffff88107fff6000
 pagevec_lru_move_fn+0xb7/0xe0
 ? pagevec_move_tail_fn+0x350/0x350
 __pagevec_lru_add+0x12/0x20
 lru_add_drain_cpu+0xc4/0xe0
 lru_add_drain+0x10/0x20
 exit_mmap+0x58/0x190
 ? __handle_mm_fault+0x9a4/0x1540
 ? hrtimer_try_to_cancel+0x1b/0xa0
 mmput+0x4e/0x100
 do_exit+0x22f/0xa10
 do_group_exit+0x3a/0xa0
 SyS_exit_group+0x12/0x20
 do_syscall_64+0x61/0x110
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x7f394d325fa8
RSP: 002b:00007ffda407e668 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f394d603830 RCX: 00007f394d325fa8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffffa8
R10: 00007f394d6097e0 R11: 0000000000000246 R12: 00007f394d603830
R13: 00007ffda407f8b2 R14: 0000000000000000 R15: 0000000000000000
Code: 48 89 4e 10 4c 89 01 e8 30 f8 ff ff f0 83 44 24 fc 00 8b 83 40
03 00 00 85 c0 75 08 f0 ff ff 48 83 c4 08 5b 5d c3 <0f> 0b eb b7 66 66
66 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5
---[ end trace e5ddade8fd0233c4 ]---

Some inconclusive notes, FWIW:

First we get the workqueue warning where it's hitting the warning in
set_work_data() where it checks that the work is not pending:

static inline void set_work_data(struct work_struct *work, unsigned long data,
                                 unsigned long flags)
{
        WARN_ON_ONCE(!work_pending(work));
        atomic_long_set(&work->data, data | flags | work_static(work));
}

This is odd because the flag should have been set just a few moments
before, in queue_work_on():

bool queue_work_on(int cpu, struct workqueue_struct *wq,
                   struct work_struct *work)
{
        bool ret = false;
        unsigned long flags;

        local_irq_save(flags);

        if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
                __queue_work(cpu, wq, work);
                ret = true;
        }

        local_irq_restore(flags);
        return ret;
}

Then we have the next part giving a few more clues:

FS-Cache:
FS-Cache: Assertion failed
FS-Cache: 6 == 5 is false
------------[ cut here ]------------
kernel BUG at fs/fscache/operation.c:494!
invalid opcode: 0000 [#1] SMP
Modules linked in: nbd
CPU: 1 PID: 122494 Comm: kworker/u257:3 Tainted: G        W        4.16.2-0 #1
Hardware name: Oracle Corporation  Sun Fire X4800/20434, BIOS 11080200
   08/12/2016
Workqueue: fscache_operation fscache_op_work_func
RIP: 0010:fscache_put_operation+0x1e3/0x1f0
RSP: 0018:ffffc9002ff8be08 EFLAGS: 00010296
RAX: 0000000000000019 RBX: ffff8807c04dec00 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffff88103fa56398 RDI: ffff88103fa56398
RBP: ffffc9002ff8be18 R08: 0000000000000000 R09: 0000000000000771
R10: ffffffff820afc80 R11: 0000000000000770 R12: ffff8807c04dec00
R13: ffff88103f443f00 R14: 0000000000000000 R15: ffff880187c37c00
FS:  0000000000000000(0000) GS:ffff88103fa40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002343008 CR3: 000000000240a000 CR4: 00000000000006e0
Call Trace:
 fscache_op_work_func+0x26/0x50
 process_one_work+0x131/0x290
 worker_thread+0x45/0x360
 kthread+0xf8/0x130
 ? create_worker+0x190/0x190
 ? kthread_cancel_work_sync+0x10/0x10
 ret_from_fork+0x1f/0x30
Code: 31 c0 e8 26 11 ef ff 48 c7 c7 92 ee 2c 82 31 c0 e8 18 11 ef ff
8b 73 40 ba 05 00 00 ad 2a 82 31 c0 e8 02 11 ef ff <0f> 0b 66 66 2e 0f
1f 84 00 00 00 00 00 55 48 89 e5 53 48 8
RIP: fscache_put_operation+0x1e3/0x1f0 RSP: ffffc9002ff8be08
---[ end trace e5ddade8fd0233c5 ]---

The assertion comes from fscache_put_operation():

        ASSERTIFCMP(op->state != FSCACHE_OP_ST_INITIALISED &&
                    op->state != FSCACHE_OP_ST_COMPLETE,
                    op->state, ==, FSCACHE_OP_ST_CANCELLED);

It expects op->state to be either INITIALISED, COMPLETE, or CANCELLED,
but it is in fact DEAD.The only place that sets it to DEAD is
fscache_put_operation() itself (a few lines after this assert). So we
somehow have an operation that manages to have its refcount drop to 0
twice in a row -- without hitting the assertion that checks for a
positive refcount.

We can tell from the first stack trace that we were just in
fscache_enqueue_operation(), which has the following code:

                atomic_inc(&op->usage);
                if (!queue_work(fscache_op_wq, &op->work))
                        fscache_put_operation(op);

The reason we don't hit the positive refcount assertion is that the
atomic_inc() above probably brings it from 0 to 1.

It does smell a lot like a race causing premature free +
use-after-free explaining the weird diagnostics.

It takes about 15-20 minutes to reproduce the crash, with the patch
above it's gone, but we can test alternative patches.


Vegard
