Return-Path: <net147@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521991560; cv=none;
        d=google.com; s=arc-20160816;
        b=XP/tqD0Zn5YT7y5KsdaWUrETXvGBLvjthVF239F8NyZhLhT5aMzV71vgKHBhv3Zdpt
         Lx6GhZOlvaErLpXAZn4L+SoKYc7/443tVk7YSVfQIPtOJnSl2iQZBKjFEy4kG9nOyHls
         44tJHaPtHwt0YKph2S6DLjDnpXlsQW9JlVn6K1vEe4ZvyWcE5goUzrTmomlKZ5LDpW2d
         VBAG5MimwPBlmmpCpacWkoDuVbwxsvkPpKjJcNnZw/rfPT9wYFZEQKlmo2vNoTlMipHT
         WC/U+DY9tLB+lC9j8nVYlWeuD7cbW8kvIrbLWcNv2JCOp+X5/1DB93zeFRWqaR0c3yeD
         0kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=brgvCCetpXW1NFkkBk1rkYZFVVcLfWzSvAOLNC31UX4=;
        b=axvYpTrVwVKYT5LS2cacnHySkyFlN636gtZFbFHNWNA8nP09gb4qX8PxNANwly4lpb
         0UkRhjEVOptRvqt1gMXXYYiBWY/3hQnPu8/1wwy0hPHmtZkqHeI/bxJh3jmJmOqPRD2L
         Y36zEbYJlNfNTQPHX98dEeM2r5WTJhnOzu9ltNPmbfPdVOwOPPkwuaRNPGOrJMwdvdha
         2Z0evPHlKHG+ds87krQZoWYJF5NAwpSQ6Rn6F9y85oamq6tuYVGxdMUVRfV3zQ1O0oYD
         O8fel0LCWLK9P56w1t9OlgWVvCPIPPvJM1ULTsZQAl1bqtvRwywNgEEWB1S+ZRhhPFns
         QzbA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=t3jR/mkE;
       spf=pass (google.com: domain of net147@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=net147@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=t3jR/mkE;
       spf=pass (google.com: domain of net147@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=net147@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+sZNVmPYxr0JB/2Wjf19719Jf2G2eOrFQr7EcHb3MiPRVusViwMA+p2EHNvHohtO2LNpPOQTpbJQr4lcWaRaM=
MIME-Version: 1.0
In-Reply-To: <CANwerB1BBnQhGoCrna48dtwb36iqC1UcsYJ-1Xnk6K0ce2OiGg@mail.gmail.com>
References: <20180208035501.10711-1-jeffy.chen@rock-chips.com> <CANwerB1BBnQhGoCrna48dtwb36iqC1UcsYJ-1Xnk6K0ce2OiGg@mail.gmail.com>
From: Jonathan Liu <net147@gmail.com>
Date: Mon, 26 Mar 2018 02:25:59 +1100
Message-ID: <CANwerB3QwzexOWCnFfxL+si7cVj2Gb0m_hak8QTmxTb8t8swsw@mail.gmail.com>
Subject: Re: [v6] usb: ohci: Proper handling of ed_rm_list to handle race
 condition between usb_kill_urb() and finish_unlinks()
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>, mka@chromium.org,
	Douglas Anderson <dianders@chromium.org>, AMAN DEEP <aman.deep@samsung.com>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591803495381541713?=
X-GMAIL-MSGID: =?utf-8?q?1595923822248932756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 25 March 2018 at 12:21, Jonathan Liu <net147@gmail.com> wrote:
> On 8 February 2018 at 14:55, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> From: AMAN DEEP <aman.deep@samsung.com>
>>
>> There is a race condition between finish_unlinks->finish_urb() function
>> and usb_kill_urb() in ohci controller case. The finish_urb calls
>> spin_unlock(&ohci->lock) before usb_hcd_giveback_urb() function call,
>> then if during this time, usb_kill_urb is called for another endpoint,
>> then new ed will be added to ed_rm_list at beginning for unlink, and
>> ed_rm_list will point to newly added.
>>
>> When finish_urb() is completed in finish_unlinks() and ed->td_list
>> becomes empty as in below code (in finish_unlinks() function):
>>
>>         if (list_empty(&ed->td_list)) {
>>                 *last = ed->ed_next;
>>                 ed->ed_next = NULL;
>>         } else if (ohci->rh_state == OHCI_RH_RUNNING) {
>>                 *last = ed->ed_next;
>>                 ed->ed_next = NULL;
>>                 ed_schedule(ohci, ed);
>>         }
>>
>> The *last = ed->ed_next will make ed_rm_list to point to ed->ed_next
>> and previously added ed by usb_kill_urb will be left unreferenced by
>> ed_rm_list. This causes usb_kill_urb() hang forever waiting for
>> finish_unlink to remove added ed from ed_rm_list.
>>
>> The main reason for hang in this race condtion is addition and removal
>> of ed from ed_rm_list in the beginning during usb_kill_urb and later
>> last* is modified in finish_unlinks().
>>
>> As suggested by Alan Stern, the solution for proper handling of
>> ohci->ed_rm_list is to remove ed from the ed_rm_list before finishing
>> any URBs. Then at the end, we can add ed back to the list if necessary.
>>
>> This properly handle the updated ohci->ed_rm_list in usb_kill_urb().
>>
>> Fixes:977dcfdc6031("USB:OHCI:don't lose track of EDs when a controller dies")
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> CC: <stable@vger.kernel.org>
>> Signed-off-by: Aman Deep <aman.deep@samsung.com>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> Changes in v6:
>> This is a resend of Aman Deep's v5 patch [0], which solved the hang we
>> hit [1]. (Thanks Aman :)
>>
>> The v5 has some format issues, so i slightly adjust the commit message.
>>
>> [0] https://www.spinics.net/lists/linux-usb/msg129010.html
>> [1] https://bugs.chromium.org/p/chromium/issues/detail?id=803749
>>
>>  drivers/usb/host/ohci-q.c | 17 ++++++++++-------
>>  1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
>> index b2ec8c399363..4ccb85a67bb3 100644
>> --- a/drivers/usb/host/ohci-q.c
>> +++ b/drivers/usb/host/ohci-q.c
>> @@ -1019,6 +1019,8 @@ static void finish_unlinks(struct ohci_hcd *ohci)
>>                  * have modified this list.  normally it's just prepending
>>                  * entries (which we'd ignore), but paranoia won't hurt.
>>                  */
>> +               *last = ed->ed_next;
>> +               ed->ed_next = NULL;
>>                 modified = 0;
>>
>>                 /* unlink urbs as requested, but rescan the list after
>> @@ -1077,21 +1079,22 @@ static void finish_unlinks(struct ohci_hcd *ohci)
>>                         goto rescan_this;
>>
>>                 /*
>> -                * If no TDs are queued, take ED off the ed_rm_list.
>> +                * If no TDs are queued, ED is now idle.
>>                  * Otherwise, if the HC is running, reschedule.
>> -                * If not, leave it on the list for further dequeues.
>> +                * If the HC isn't running, add ED back to the
>> +                * start of the list for later processing.
>>                  */
>>                 if (list_empty(&ed->td_list)) {
>> -                       *last = ed->ed_next;
>> -                       ed->ed_next = NULL;
>>                         ed->state = ED_IDLE;
>>                         list_del(&ed->in_use_list);
>>                 } else if (ohci->rh_state == OHCI_RH_RUNNING) {
>> -                       *last = ed->ed_next;
>> -                       ed->ed_next = NULL;
>>                         ed_schedule(ohci, ed);
>>                 } else {
>> -                       last = &ed->ed_next;
>> +                       ed->ed_next = ohci->ed_rm_list;
>> +                       ohci->ed_rm_list = ed;
>> +                       /* Don't loop on the same ED */
>> +                       if (last == &ohci->ed_rm_list)
>> +                               last = &ed->ed_next;
>>                 }
>>
>>                 if (modified)
>
> I am experiencing a USB function call hang from userspace with OCHI
> (full speed USB device) after updating from Linux 4.14.15 to 4.14.24
> and noticed this commit.
>
> Here is the Linux 4.14.24 kernel stack trace (extracted from SysRq+w
> and amended with addr2line):
> [<c05cbd64>] (__schedule) from [<c05cc148>] (schedule+0x50/0xb4)
> kernel/sched/core.c:2792
> [<c05cc148>] (schedule) from [<c042789c>]
> (usb_kill_urb.part.3+0x78/0xa8) include/asm-generic/preempt.h:59
> [<c042789c>] (usb_kill_urb.part.3) from [<c0433a3c>]
> (usbdev_ioctl+0x1288/0x1cf0) drivers/usb/core/urb.c:690
> [<c0433a3c>] (usbdev_ioctl) from [<c0217db8>]
> (do_vfs_ioctl+0x9c/0x8ec) drivers/usb/core/devio.c:1835
> [<c0217db8>] (do_vfs_ioctl) from [<c021863c>] (SyS_ioctl+0x34/0x5c)
> fs/ioctl.c:47
> [<c021863c>] (SyS_ioctl) from [<c0107820>] (ret_fast_syscall+0x0/0x54)
> include/linux/file.h:39
>
> Afterwards the kernel is unresponsive to disconnect/connect of the
> full speed USB device but I can connect/disconnect a high speed USB
> device to the same port and communicate to it without problem since it
> uses EHCI (OHCI is companion controller). If I try to connect the full
> speed USB device again it is still unresponsive. The userspace
> application is still hanging after all this.
>
> Could this commit be causing the issue?

There does seem to be something wrong with this commit. I did some
more testing with Linux 4.16.0-rc6 on sun7i-a20-olinuxino-lime.
I connected a sun7i-a20-pcduino3b running Linux 4.15.12 that has OTG
port with gadget zero kernel module (g_zero) loaded to the USB port
and did some testing with usbtest from tools/usb/testusb.c in kernel
repository.

I had to do the following change to avoid getting flooded with
"usbtest 1-1:3.0: unlink retry" kernel messages after test 11 of
testusb starts:
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -1473,7 +1473,7 @@ static int unlink1(struct usbtest_dev *dev, int
pipe, int
                size, int async)
                                 * resubmission, but since we're testing unlink
                                 * paths, we can't.
                                 */
-                           ERROR(dev, "unlink retry\n");
+                         /*ERROR(dev, "unlink retry\n");*/
                                continue;
                        case 0:
                        case -EINPROGRESS:

Here are the results.

# ./testusb -a
/dev/bus/usb/001/002 test 0,    0.006822 secs
/dev/bus/usb/001/002 test 1,    0.140112 secs
/dev/bus/usb/001/002 test 2,    0.381125 secs
/dev/bus/usb/001/002 test 3,    0.133564 secs
/dev/bus/usb/001/002 test 4,    0.385498 secs
/dev/bus/usb/001/002 test 5,    2.138259 secs
/dev/bus/usb/001/002 test 6,    1.755144 secs
/dev/bus/usb/001/002 test 7,    2.137387 secs
/dev/bus/usb/001/002 test 8,    1.752393 secs
/dev/bus/usb/001/002 test 9,    1.132559 secs
/dev/bus/usb/001/002 test 10,   3.698934 secs
/dev/bus/usb/001/002 test 11,   40.061114 secs

dmesg (processed through scripts/decode_stacktrace.sh from kernel repository):
[   21.573242] usbtest 1-1:3.0: TEST 0:  NOP
[   21.580315] usbtest 1-1:3.0: TEST 1:  write 1024 bytes 1000 times
[   21.732138] usbtest 1-1:3.0: TEST 2:  read 1024 bytes 1000 times
[   22.132133] usbtest 1-1:3.0: TEST 3:  write/1024 0..1024 bytes 1000 times
[   22.282137] usbtest 1-1:3.0: TEST 4:  read/1024 0..1024 bytes 1000 times
[   22.682131] usbtest 1-1:3.0: TEST 5:  write 1000 sglists 32 entries
of 1024 bytes
[   24.832138] usbtest 1-1:3.0: TEST 6:  read 1000 sglists 32 entries
of 1024 bytes
[   26.602135] usbtest 1-1:3.0: TEST 7:  write/1024 1000 sglists 32
entries 0..1024 bytes
[   28.752136] usbtest 1-1:3.0: TEST 8:  read/1024 1000 sglists 32
entries 0..1024 bytes
[   30.522139] usbtest 1-1:3.0: TEST 9:  ch9 (subset) control tests, 1000 times
[   31.654957] usbtest 1-1:3.0: TEST 10:  queue 32 control calls, 1000 times
[   35.354220] usbtest 1-1:3.0: TEST 11:  unlink 1000 reads of 1024
[   75.414099] usbtest 1-1:3.0: TEST 12:  unlink 1000 writes of 1024
[  128.026194] INFO: rcu_sched self-detected stall on CPU
[  128.031367]  0-....: (1 GPs behind) idle=faa/1/1073741826
softirq=2614/2621 fqs=1048
[  128.039182]   (t=2100 jiffies g=227 c=226 q=1961)
[  128.043887] NMI backtrace for cpu 0
[  128.047377] CPU: 0 PID: 262 Comm: testusb Tainted: G           O
 4.16.0-rc6 #1
[  128.054932] Hardware name: Allwinner sun7i (A20) Family
[  128.060181] (unwind_backtrace) from show_stack (arch/arm/kernel/traps.c:249)
[  128.067921] (show_stack) from dump_stack (lib/dump_stack.c:55)
[  128.075142] (dump_stack) from nmi_cpu_backtrace (lib/nmi_backtrace.c:103)
[  128.083141] (nmi_cpu_backtrace) from nmi_trigger_cpumask_backtrace
(lib/nmi_backtrace.c:62)
[  128.092704] (nmi_trigger_cpumask_backtrace) from
rcu_dump_cpu_stacks (kernel/rcu/tree.c:1373 (discriminator 2))
[  128.102351] (rcu_dump_cpu_stacks) from rcu_check_callbacks
(kernel/rcu/tree.c:1526 kernel/rcu/tree.c:1592 kernel/rcu/tree.c:3361
kernel/rcu/tree.c:3423 kernel/rcu/tree.c:2763)
[  128.111304] (rcu_check_callbacks) from update_process_times
(arch/arm/include/asm/thread_info.h:91
include/asm-generic/preempt.h:11 kernel/time/timer.c:1638)
[  128.120173] (update_process_times) from tick_sched_timer
(kernel/time/tick-sched.c:1199)
[  128.128777] (tick_sched_timer) from __hrtimer_run_queues
(kernel/time/hrtimer.c:1349 kernel/time/hrtimer.c:1411)
[  128.137553] (__hrtimer_run_queues) from hrtimer_interrupt
(kernel/time/hrtimer.c:1472)
[  128.146331] (hrtimer_interrupt) from arch_timer_handler_phys
(drivers/clocksource/arm_arch_timer.c:589
drivers/clocksource/arm_arch_timer.c:606)
[  128.155285] (arch_timer_handler_phys) from handle_percpu_devid_irq
(kernel/irq/chip.c:909)
[  128.164843] (handle_percpu_devid_irq) from generic_handle_irq
(kernel/irq/irqdesc.c:607)
[  128.173880] (generic_handle_irq) from __handle_domain_irq
(kernel/irq/irqdesc.c:646)
[  128.182574] (__handle_domain_irq) from gic_handle_irq
(arch/arm/include/asm/io.h:118 drivers/irqchip/irq-gic.c:360)
[  128.190920] (gic_handle_irq) from __irq_svc
(arch/arm/kernel/entry-armv.S:226)
[  128.198382] Exception stack(0xcda1fc88 to 0xcda1fcd0)
[  128.203431] fc80:                   c0a95bc8 a0060013 0000000a
0000aa75 cd83b480 a0060013
[  128.211598] fca0: cf7ee000 ffffff98 00000001 00000000 00000400
cec2b800 00000009 cda1fcd8
[  128.219763] fcc0: c045b328 c0622890 20060013 ffffffff
[  128.224818] (__irq_svc) from _raw_spin_unlock_irqrestore
(kernel/locking/spinlock.c:185)
[  128.233428] (_raw_spin_unlock_irqrestore) from usb_hcd_unlink_urb
(drivers/usb/core/hcd.c:1720)
[  128.242816] (usb_hcd_unlink_urb) from unlink1
(drivers/usb/core/hcd.c:864 drivers/usb/core/hcd.c:1684)
[  128.250555] (unlink1) from unlink_simple (drivers/usb/misc/usbtest.c:1510)
[  128.257774] (unlink_simple) from usbtest_do_ioctl
(drivers/usb/misc/usbtest.c:2360)
[  128.266033] (usbtest_do_ioctl) from usbtest_ioctl
(drivers/usb/misc/usbtest.c:2685)
[  128.274206] (usbtest_ioctl) from usbdev_ioctl
(drivers/usb/core/devio.c:2175 drivers/usb/core/devio.c:2197
drivers/usb/core/devio.c:2511 drivers/usb/core/devio.c:2555)
[  128.282200] (usbdev_ioctl) from do_vfs_ioctl (fs/ioctl.c:47 fs/ioctl.c:686)
[  128.289854] (do_vfs_ioctl) from SyS_ioctl (include/linux/file.h:39
fs/ioctl.c:702 fs/ioctl.c:692)
[  128.297159] (SyS_ioctl) from ret_fast_syscall
(arch/arm/kernel/entry-common.S:52)
[  128.304716] Exception stack(0xcda1ffa8 to 0xcda1fff0)
[  128.309763] ffa0:                   000119c4 00000000 00000003
c00c5512 bebbfb34 bebbfb34
[  128.317931] ffc0: 000119c4 00000000 000109b0 00000036 00000000
00000000 b6fb0fac bebbfb44
[  128.326096] ffe0: 00022034 bebbfb1c 00011020 b6ee073c

If I revert the commit, I can run "./testusb -a" to completion without
any issues with Linux 4.16.0-rc6 on sun7i-a20-olinuxino-lime.
I don't get a kernel stall detected when testing on x86_64 but I do
still get at least one "unlink retry" error message from kernel in
dmesg which can be reproduced using "./testusb -a" or more frequently
with "./testusb -a -t 11 -c 5000".

Regards,
Jonathan
