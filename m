Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C2EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D641720831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D641720831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbeKTMLv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:11:51 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:6476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbeKTMLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:11:51 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id CF78685E2ABC6;
        Tue, 20 Nov 2018 09:45:10 +0800 (CST)
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.210]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0415.000;
 Tue, 20 Nov 2018 09:45:11 +0800
From:   "liujian (CE)" <liujian56@huawei.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] driver: input: fix UBSAN warning in
 input_defuzz_abs_event
Thread-Topic: [PATCH] driver: input: fix UBSAN warning in
 input_defuzz_abs_event
Thread-Index: AQHUcl6QOAr1kFrZeEqKa/vqHakFIqVMFqGAgAsgHHA=
Date:   Tue, 20 Nov 2018 01:45:10 +0000
Message-ID: <4F88C5DDA1E80143B232E89585ACE27D024F8FC9@DGGEMM528-MBX.china.huawei.com>
References: <1541166531-248528-1-git-send-email-liujian56@huawei.com>
 <20181112194853.GH192687@dtor-ws>
In-Reply-To: <20181112194853.GH192687@dtor-ws>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.97.126]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Best Regards,
liujian

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Tuesday, November 13, 2018 3:49 AM
> To: liujian (CE) <liujian56@huawei.com>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] driver: input: fix UBSAN warning in
> input_defuzz_abs_event
> 
> Hi,
> 
> On Fri, Nov 02, 2018 at 09:48:51PM +0800, liujian wrote:
> > syzkaller triggered a UBCAN warning:
> >
> > [  196.188950] UBSAN: Undefined behaviour in
> > drivers/input/input.c:62:23 [  196.188958] signed integer overflow:
> > [  196.188964] -2147483647 - 104 cannot be represented in type 'int [2]'
> > [  196.188973] CPU: 7 PID: 4763 Comm: syz-executor Not tainted
> > 4.19.0-514.55.6.9.x86_64+ #7 [  196.188977] Hardware name: Bochs
> > Bochs, BIOS Bochs 01/01/2011 [  196.188979] Call Trace:
> > [  196.189001]  dump_stack+0x91/0xeb
> > [  196.189014]  ubsan_epilogue+0x9/0x7c [  196.189020]
> > handle_overflow+0x1d7/0x22c [  196.189028]  ?
> > __ubsan_handle_negate_overflow+0x18f/0x18f
> > [  196.189038]  ? __mutex_lock+0x213/0x13f0 [  196.189053]  ?
> > drop_futex_key_refs+0xa0/0xa0 [  196.189070]  ?
> > __might_fault+0xef/0x1b0 [  196.189096]
> > input_handle_event+0xe1b/0x1290 [  196.189108]
> > input_inject_event+0x1d7/0x27e [  196.189119]
> evdev_write+0x2cf/0x3f0
> > [  196.189129]  ? evdev_pass_values+0xd40/0xd40 [  196.189157]  ?
> > mark_held_locks+0x160/0x160 [  196.189171]  ?
> __vfs_write+0xe0/0x6c0 [
> > 196.189175]  ? evdev_pass_values+0xd40/0xd40 [  196.189179]
> > __vfs_write+0xe0/0x6c0 [  196.189186]  ? kernel_read+0x130/0x130 [
> > 196.189204]  ? _cond_resched+0x15/0x30 [  196.189214]  ?
> > __inode_security_revalidate+0xb8/0xe0
> > [  196.189222]  ? selinux_file_permission+0x354/0x430
> > [  196.189233]  vfs_write+0x160/0x440
> > [  196.189242]  ksys_write+0xc1/0x190
> > [  196.189248]  ? __ia32_sys_read+0xb0/0xb0 [  196.189259]  ?
> > trace_hardirqs_on_thunk+0x1a/0x1c [  196.189267]  ?
> > do_syscall_64+0x22/0x4a0 [  196.189276]  do_syscall_64+0xa5/0x4a0 [
> > 196.189287]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [  196.189293] RIP: 0033:0x44e7c9
> > [  196.189299] Code: fc ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f
> > 00
> >
> > the syzkaller reproduce script(but can't reproduce it every time):
> >
> > r0 = syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00',
> > 0x2,
> > 0x1)
> > write$binfmt_elf64(r0, &(0x7f0000000240)={{0x7f, 0x45, 0x4c, 0x46,
> > 0x40, 0x2, 0x2, 0xffffffff, 0xffffffffffff374c, 0x3, 0x0, 0x80000001,
> > 0x103, 0x40, 0x22e, 0x26, 0x1, 0x38, 0x2, 0xa23, 0x1, 0x2},
> > [{0x6474e557, 0x5, 0x6, 0x2, 0x9, 0x9, 0x6c3, 0x1ff}], "", [[], [],
> > [], []]}, 0x478) ioctl$EVIOCGSW(0xffffffffffffffff, 0x8040451b,
> > &(0x7f0000000040)=""/7)
> > syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2,
> > 0x1)
> > r1 = syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00',
> > 0x2,
> > 0x1)
> > openat$smack_task_current(0xffffffffffffff9c,
> > &(0x7f0000000040)='/proc/self/attr/current\x00', 0x2, 0x0)
> > ioctl$EVIOCSABS0(r1, 0x401845c0, &(0x7f0000000000)={0x4, 0x10000,
> 0x4,
> > 0xd1, 0x81, 0x3})
> > eventfd(0x1ff)
> > syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2,
> > 0x200)
> > syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2,
> > 0x1) syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00',
> > 0x2, 0x1)
> > syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2,
> > 0x1) syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00',
> > 0x2, 0x1)
> >
> > Typecast int to long to fix the issue.
> 
> Does this fix 32-bit platforms where long equals int? BTW, I'd prefer if we did
> not have to do 64 bit arithmetic on 32 bit arches here, if possible.
Hi Dmitry,
Thanks for your review,  we can typecast it to long long?  but if do not 64 bit arithmetic on 32-bit platforms, how about this?
We can not care about the overflow of addition/subtraction, but we should care about the return value.?

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3304aaa..954244f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -59,14 +59,17 @@ static inline int is_event_supported(unsigned int code,
 static int input_defuzz_abs_event(int value, int old_val, int fuzz)
 {
        if (fuzz) {
-               if (value > old_val - fuzz / 2 && value < old_val + fuzz / 2)
+               if (value > (long)((unsigned long)old_val - (unsigned long)fuzz / 2) &&
+                               value < (long)((unsigned long)old_val + (unsigned long)fuzz / 2))
                        return old_val;

-               if (value > old_val - fuzz && value < old_val + fuzz)
-                       return (old_val * 3 + value) / 4;
+               if (value > (long)((unsigned long)old_val - (unsigned long)fuzz) &&
+                               value < (long)((unsigned long)old_val + (unsigned long)fuzz))
+                       return ((long long)old_val * 3 + value) / 4;

-               if (value > old_val - fuzz * 2 && value < old_val + fuzz * 2)
-                       return (old_val + value) / 2;
+               if (value > (long)((unsigned long)old_val - (unsigned long)fuzz * 2) &&
+                               value < (long)((unsigned long)old_val + (unsigned long)fuzz * 2))
+                       return ((long long)old_val + value) / 2;
        }

        return value;


> Thanks.
> 
> --
> Dmitry
