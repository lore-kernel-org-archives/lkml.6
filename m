Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17C6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A74C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A74C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeICNkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:40:20 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:44416 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeICNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:40:20 -0400
Received: by mail-it0-f70.google.com with SMTP id b124-v6so206161itb.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 02:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1cHKbd2OxnjEoHY+DJxFLNBo0e3RcttHH7P4ro0yJmM=;
        b=DC/jFIOMA0kIsj0HyuHhZ640szfmaiKthmPemRdrt2iXWJ8bzgwbqsbaNoBK5xYEVT
         lx8mtUOtNrUXQe3tJ9nUVAktDCRtBYQ6M+/hh0UNezUvMWAM8N/03q19jwOkNvDu039H
         nGd8XrPwlOzeP4ai2kDq8x5GPGYMu/cdXUmXsvSfhaagSKA5EcZvO/cvWXc4wxnTKHRX
         4Ueq5UfkO30cKvv9zMdAmWdndtMo7iaaaBXA8mImCDOdTDPOrFw/hSRzFwxkGenlkFc5
         Yx6H1i1fyhNhTKO4RLx+jFCqMgkJ500ICtiq4U6JrGX3vTUPbqP2ZbUHzXCiTnqCo/dX
         uhLQ==
X-Gm-Message-State: APzg51BXHStMSaBpYnpPgITxzamR+bG6pRl4PCxM8yge0zGc0LISR+LW
        Vt/jmtx0uRlEf7ofXfOQDIqUd8K6Ws950lCPe934Xbe5pXs7
X-Google-Smtp-Source: ANB0VdYHTST9Zqv2rS0ARhwKSUr+bYkkR1ocyVf9nJA5BfKJhE4P7FIjLUVvbE5pZlcjoU5ztvlfAmKfzA2M8gM3xJCfZ9rNDqus
MIME-Version: 1.0
X-Received: by 2002:a6b:590e:: with SMTP id n14-v6mr11923100iob.70.1535966463770;
 Mon, 03 Sep 2018 02:21:03 -0700 (PDT)
Date:   Mon, 03 Sep 2018 02:21:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075c8d70574f40fbc@google.com>
Subject: KASAN: use-after-free Read in vhci_hub_control
From:   syzbot <syzbot+600b03e0cf1b73bb23c4@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=160cf55a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=600b03e0cf1b73bb23c4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1116710a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119be4ea400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+600b03e0cf1b73bb23c4@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
vhci_hcd: invalid port number 108
==================================================================
BUG: KASAN: use-after-free in vhci_hub_control+0x1b88/0x1bf0  
drivers/usb/usbip/vhci_hcd.c:441
Read of size 4 at addr ffff8801ce61f7bc by task syz-executor473/4680

CPU: 1 PID: 4680 Comm: syz-executor473 Not tainted 4.19.0-rc1+ #217
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
RIP: 0033:0x445cf9
Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff4cea17d8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000445cf9
RDX: 0000000020000000 RSI: 00000000c0185500 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000fb6880 R09: 0000000000000001
R10: 000000000000000f R11: 0000000000000213 R12: 0000000000403060
R13: 00000000004030f0 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea00073987c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 ffffffff07390101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ce61f680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801ce61f700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff8801ce61f780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                         ^
  ffff8801ce61f800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801ce61f880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
