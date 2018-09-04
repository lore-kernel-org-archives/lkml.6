Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC105C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8482082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8482082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIDXS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:18:26 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:56675 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeIDXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:18:26 -0400
Received: by mail-io0-f199.google.com with SMTP id o18-v6so4379662ioh.23
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=w0pHGgY2WHRM8tiYVAc7yJxH9qDSalKDFnPfaAUA67g=;
        b=nN6CHF0y90nBTJP/nZy7YcsjaIo4QnWMZgEnaxUv19Tmx62uSuuBLmE6X1oqgAgoal
         k+Zk9Ab3knp1jmmhpqfejJfXom4aolcNQOdHSbWLDn76O1MYrcfBDW4a0H2IEAiOwlp7
         KG82QQakcneuHusVMvsuNolfrQXAiA4f0N2hT0vtxV84qYIcoI45cG9BboPo3ROmAdOs
         FN69bYL2nOqWUApVB8dbj7WjDonbBXs1RlO/h6ASuzrgjMARSoOIDYnkp0Qe4RXkhIJO
         VGqj3qPL4XorwQaqvS/DkEeMHzvkugfsl9EY1bRd8wpCIv1sipnah3vz9LcejJtc8lXB
         cxUw==
X-Gm-Message-State: APzg51CZlno6chchNojNMrYwYatJlrw/O4DmRplhxZTZ5yrBSwSwIOU1
        GVCQ7zknhKCjyHxdBUXo8vd5uGUo2X1EsabRU3B9gsdwGTvE
X-Google-Smtp-Source: ANB0VdYoj18zRM7OWX6w6ilAD99u/BiV0Ck4je7yVoV9H2KbSoS/uC/mrWLSIne/DOnyJKpslerWFNOqG3NQhj0gFL23GkAQTtIU
MIME-Version: 1.0
X-Received: by 2002:a6b:9346:: with SMTP id v67-v6mr15477258iod.111.1536087122389;
 Tue, 04 Sep 2018 11:52:02 -0700 (PDT)
Date:   Tue, 04 Sep 2018 11:52:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004643360575102706@google.com>
Subject: KASAN: slab-out-of-bounds Read in vhci_hub_control
From:   syzbot <syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    420f51f4ab6b Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126a6f0e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=bccc1fe10b70fadc78d0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121caa46400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ed8ab6400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
vhci_hcd: invalid port number 132
==================================================================
BUG: KASAN: slab-out-of-bounds in vhci_hub_control+0x1b88/0x1bf0  
drivers/usb/usbip/vhci_hcd.c:441
Read of size 4 at addr ffff8801ce615ebc by task syz-executor741/4647

CPU: 1 PID: 4647 Comm: syz-executor741 Not tainted 4.19.0-rc1+ #217
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  vhci_hub_control+0x1b88/0x1bf0 drivers/usb/usbip/vhci_hcd.c:441
  rh_call_control drivers/usb/core/hcd.c:679 [inline]
  rh_urb_enqueue drivers/usb/core/hcd.c:838 [inline]
  usb_hcd_submit_urb+0x184a/0x2160 drivers/usb/core/hcd.c:1651
  usb_submit_urb+0x895/0x14d0 drivers/usb/core/urb.c:570
  usb_start_wait_urb+0x140/0x360 drivers/usb/core/message.c:57
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x332/0x4e0 drivers/usb/core/message.c:152
  proc_control+0x99b/0xef0 drivers/usb/core/devio.c:1106
  usbdev_do_ioctl+0x1eb4/0x3b30 drivers/usb/core/devio.c:2394
  usbdev_ioctl+0x25/0x30 drivers/usb/core/devio.c:2551
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x449329
Code: e8 ac b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8653ff9da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dac28 RCX: 0000000000449329
RDX: 0000000020000100 RSI: 00000000c0185500 RDI: 0000000000000003
RBP: 00000000006dac20 R08: 00000000006dac2c R09: 0000000000000000
R10: 00007f8653ffa700 R11: 0000000000000246 R12: 00000000006dac2c
R13: 2330302f6273752f R14: 7375622f7665642f R15: 00000000006dad2c

Allocated by task 1:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x730 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  usb_set_configuration+0x10e9/0x19f0 drivers/usb/core/message.c:1834
  generic_probe+0xb6/0x110 drivers/usb/core/generic.c:174
  usb_probe_device+0xaf/0x110 drivers/usb/core/driver.c:266
  really_probe+0x5be/0x850 drivers/base/dd.c:500
  driver_probe_device+0x108/0x210 drivers/base/dd.c:662
  __device_attach_driver+0x25a/0x2d0 drivers/base/dd.c:758
  bus_for_each_drv+0x16b/0x1f0 drivers/base/bus.c:461
  __device_attach+0x2a1/0x430 drivers/base/dd.c:815
  device_initial_probe+0x1a/0x20 drivers/base/dd.c:862
  bus_probe_device+0x1fb/0x2a0 drivers/base/bus.c:521
  device_add+0x93e/0x17b0 drivers/base/core.c:1927
  usb_new_device+0x8ac/0x12b0 drivers/usb/core/hub.c:2485
  register_root_hub drivers/usb/core/hcd.c:1105 [inline]
  usb_add_hcd+0xb1f/0x1910 drivers/usb/core/hcd.c:2882
  vhci_hcd_probe+0xfb/0x240 drivers/usb/usbip/vhci_hcd.c:1316
  platform_drv_probe+0x96/0x160 drivers/base/platform.c:579
  really_probe+0x5be/0x850 drivers/base/dd.c:500
  driver_probe_device+0x108/0x210 drivers/base/dd.c:662
  __device_attach_driver+0x25a/0x2d0 drivers/base/dd.c:758
  bus_for_each_drv+0x16b/0x1f0 drivers/base/bus.c:461
  __device_attach+0x2a1/0x430 drivers/base/dd.c:815
  device_initial_probe+0x1a/0x20 drivers/base/dd.c:862
  bus_probe_device+0x1fb/0x2a0 drivers/base/bus.c:521
  device_add+0x93e/0x17b0 drivers/base/core.c:1927
  platform_device_add+0x36e/0x6f0 drivers/base/platform.c:417
  vhci_hcd_init+0x386/0x4e0 drivers/usb/usbip/vhci_hcd.c:1500
  do_one_initcall+0x127/0x838 init/main.c:885
  do_initcall_level init/main.c:953 [inline]
  do_initcalls init/main.c:961 [inline]
  do_basic_setup init/main.c:979 [inline]
  kernel_init_freeable+0x4bb/0x5ae init/main.c:1144
  kernel_init+0x11/0x1b3 init/main.c:1063
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8801ce615300
  which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 956 bytes to the right of
  2048-byte region [ffff8801ce615300, ffff8801ce615b00)
The buggy address belongs to the page:
page:ffffea0007398500 count:1 mapcount:0 mapping:ffff8801dac00c40 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0007397988 ffffea0007398788 ffff8801dac00c40
raw: 0000000000000000 ffff8801ce614200 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ce615d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801ce615e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801ce615e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                         ^
  ffff8801ce615f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801ce615f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
