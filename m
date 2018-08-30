Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E18EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A3620839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A3620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeH3Web (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:34:31 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:46757 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeH3Wea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:34:30 -0400
Received: by mail-io0-f199.google.com with SMTP id f4-v6so8437384ioh.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 11:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RBxTPeqDBsUv7SVujkXMiH0jEY9HW5SoFitojvicGps=;
        b=Wd//6ZTbBAWOscXmVY5tBcTNXWysa5WfmSidlUwpc5VTRrYSzC/LgdU9BkyaELi39y
         L1QscTQR0x41xs9WoWOBGws/qDYh7ecQs/9LQOpBewhApydAlqNYoaxVyO7jVYWI045M
         RJWdZGCeMHQ4lIgNu5fr4RlR3W/nmp9T9lBvHkNgd5XPlf569AN/Owrq34BAmSmfwyDY
         +CUeK92gIkb6eBN1kCAeh/ZeBUq/ZVFi1hdcD4eW5jiOQMQDldodZkFhqqYbSOG53IRl
         9twcl4LbQ21QuzuXXeeHIL+ulNcHNSvykkB6plBAKKC6v9cHDLLtD4FXYIWjoPfk6GbI
         +DNQ==
X-Gm-Message-State: APzg51B3rjCbUv3RPy0XPuHA4iLo8tQDOJmqrkvBVypzS7byiFG8Jqa7
        vzhZRpt062uprgnCluod7Hhz3G+wEWF0V5hX3IKiiBQr9VjA
X-Google-Smtp-Source: ANB0VdaBe2mTjk1k6RmuEObmtfKF9pqzrQfgmMdLYMmy5XG0fwbxulAI7xQI1+qIfDGx/q55e+q5a/fG4ILIWSoO/1aXU7eKVBiG
MIME-Version: 1.0
X-Received: by 2002:a02:601b:: with SMTP id i27-v6mr4327890jac.32.1535653863023;
 Thu, 30 Aug 2018 11:31:03 -0700 (PDT)
Date:   Thu, 30 Aug 2018 11:31:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000010a4d0574ab4743@google.com>
Subject: KMSAN: uninit-value in rds_bind
From:   syzbot <syzbot+915c9f99f3dbc4bd6cd1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2dca2cbde67a kmsan: fix build warnings with CONFIG_KMSAN=n
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=16db895a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=820d6393634b55e3
dashboard link: https://syzkaller.appspot.com/bug?extid=915c9f99f3dbc4bd6cd1
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1137bffe400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1521a7fe400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+915c9f99f3dbc4bd6cd1@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KMSAN: uninit-value in rds_bind+0x1f1/0x2360 net/rds/bind.c:174
CPU: 1 PID: 4497 Comm: syz-executor098 Not tainted 4.19.0-rc1+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x14b/0x190 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  rds_bind+0x1f1/0x2360 net/rds/bind.c:174
  __sys_bind+0x594/0x6f0 net/socket.c:1481
  __do_sys_bind net/socket.c:1492 [inline]
  __se_sys_bind net/socket.c:1490 [inline]
  __x64_sys_bind+0xd8/0x120 net/socket.c:1490
  do_syscall_64+0x15b/0x220 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440099
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffb43cf578 EFLAGS: 00000213 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440099
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401920
R13: 00000000004019b0 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----address@__sys_bind
Variable was created at:
  __sys_bind+0x6a/0x6f0 net/socket.c:1468
  __do_sys_bind net/socket.c:1492 [inline]
  __se_sys_bind net/socket.c:1490 [inline]
  __x64_sys_bind+0xd8/0x120 net/socket.c:1490
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
