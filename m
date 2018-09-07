Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D466C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4390D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4390D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeIGUpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:45:35 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:56518 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbeIGUpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:45:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 0D1224193D;
        Fri,  7 Sep 2018 16:03:59 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yt-sB-2_xY1O; Fri,  7 Sep 2018 16:03:59 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id A43DE4193A;
        Fri,  7 Sep 2018 16:03:45 +0000 (UTC)
Subject: Re: WARNING: ODEBUG bug in vudc_probe
To:     Dmitry Vyukov <dvyukov@google.com>, valentina.manea.m@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, khlebnikov@yandex-team.ru,
        paolo.valente@linaro.org, axboe@kernel.dk
References: <CACT4Y+Ywimrr3_oD2r=u0-Sz-PFXL2tpXA4q0odKDMM_Tvw0AA@mail.gmail.com>
From:   Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>
Message-ID: <8e8f8ac1-8b72-a21c-f504-74a5ce12b625@kernel.org>
Date:   Fri, 7 Sep 2018 10:03:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Ywimrr3_oD2r=u0-Sz-PFXL2tpXA4q0odKDMM_Tvw0AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 09/07/2018 04:54 AM, Dmitry Vyukov wrote:
> Hi,
> 
> I am getting the following error while booting kernel on upstream
> commit a49a9dcce802b3651013f659813df1361d306172, config is attached.
> Seems there is some kind of resource leak.
> 
> Thanks

Odd. This commit has nothing to do with vudc. I am adding developers
that are associated with this commit to the thread.

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 58c6efa9f9a9..9fe5952d117d 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -275,9 +275,9 @@ static void bfqg_and_blkg_get(struct bfq_group *bfqg)

 void bfqg_and_blkg_put(struct bfq_group *bfqg)
 {
-       bfqg_put(bfqg);
-
        blkg_put(bfqg_to_blkg(bfqg));
+
+       bfqg_put(bfqg);
 }

 /* @stats = 0 */
-- 

> 
> ------------[ cut here ]------------
> ODEBUG: free active (active state 0) object type: timer_list hint:
> delayed_work_timer_fn+0x0/0x6e kernel/workqueue.c:4923
> WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:329
> debug_print_object+0x164/0x17c lib/debugobjects.c:326
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc2-00205-ga49a9dcce802 #6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1a5/0x28b lib/dump_stack.c:113
>  panic+0x239/0x4e8 kernel/panic.c:184
>  __warn+0x16f/0x1c5 kernel/panic.c:536
>  report_bug+0x163/0x1c9 lib/bug.c:186
>  fixup_bug+0x43/0x7c arch/x86/kernel/traps.c:178
>  do_error_trap+0xee/0x2ac arch/x86/kernel/traps.c:296
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
> RIP: 0010:debug_print_object+0x164/0x17c lib/debugobjects.c:326
> Code: 3c 02 00 74 05 e8 06 12 cc fe 48 8b 14 dd 60 9c c8 86 4d 89 e9
> 49 89 e8 44 89 f1 4c 89 e6 48 c7 c7 a0 90 c8 86 e8 5e a7 7a fe <0f> 0b
> 5b ff 05 b1 92 45 06 5d 41 5c 41 5d 41 5e c3 ff 05 a3 92 45
> RSP: 0000:ffff88006bbaf510 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffff88006bba2900
> RDX: 000000616bba2900 RSI: ffffffff8148ef03 RDI: ffffed000d775e76
> RBP: ffffffff868e66a0 R08: fffffbfff0ff8ff1 R09: 0000000000000001
> R10: ffff88006bba2900 R11: fffffbfff0ff8ff0 R12: ffffffff86c89580
> R13: ffffffff813c4247 R14: 0000000000000000 R15: ffff88006a131208
>  __debug_check_no_obj_freed lib/debugobjects.c:786 [inline]
>  debug_check_no_obj_freed+0x176/0x2a1 lib/debugobjects.c:818
>  slab_free_hook mm/slub.c:1368 [inline]
>  slab_free_freelist_hook+0x8a/0xed mm/slub.c:1398
>  slab_free mm/slub.c:2953 [inline]
>  kfree+0x187/0x222 mm/slub.c:3906

I am a bit stumped. The memory vudc is trying to free is valid. I am
looking into this more. Please send me the full dmesg.

>  vudc_probe+0x9d9/0xa24 drivers/usb/usbip/vudc_dev.c:633
>  platform_drv_probe+0xdd/0x181 drivers/base/platform.c:579
>  really_probe+0x590/0xb2a drivers/base/dd.c:500
>  driver_probe_device+0x2a8/0x313 drivers/base/dd.c:662
>  __device_attach_driver+0x220/0x27b drivers/base/dd.c:758
>  bus_for_each_drv+0x177/0x1b8 drivers/base/bus.c:461
>  __device_attach+0x203/0x36d drivers/base/dd.c:815
>  bus_probe_device+0xc8/0x22d drivers/base/bus.c:521
>  device_add+0x5b6/0x1273 drivers/base/core.c:1927
>  platform_device_add+0x53a/0x68d drivers/base/platform.c:417
>  init+0x13e/0x3c4 arch/x86/crypto/blowfish_glue.c:444
>  do_one_initcall+0x2d8/0x63f init/main.c:885
>  do_initcall_level init/main.c:953 [inline]
>  do_initcalls init/main.c:961 [inline]
>  do_basic_setup init/main.c:979 [inline]
>  kernel_init_freeable+0x4bb/0x5ac init/main.c:1144
>  kernel_init+0x11/0x1b6 init/main.c:1063
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
> 

thanks,
-- Shuah
