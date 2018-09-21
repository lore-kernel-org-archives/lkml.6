Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDB2ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342AC2156E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342AC2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391558AbeIVDEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:04:43 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36906 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVDEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:04:43 -0400
Received: by mail-io1-f72.google.com with SMTP id r18-v6so13066861ioj.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 14:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mIbj1X5SQUe//pKqwCFZ/nr+38r/pnlovlfHKpR5zkQ=;
        b=hpWQiP2AuZOmwf3WuUAMh0JBLAn0LYHKuwStw0PVsk7Tv49yHHMUD00gmDrFzBHIMd
         HLLTwbur9aEbVnm8DarSSEOlf07Qe7vXTOp5BuaZaQUUvCNDCHc+TlgsXE5mP5jWQKy1
         g0Q9bzuNuvYndQ9wYyYrOh3cUcgxVy1zENIHzOlabYUSfLGBQ+ysrM12E0JOtGwGMoCB
         CMA7fq2L5xXJiQJDtp+zqoBaQI/ZbUhHeXFkDmmWq2fIYI3oHUGmBEKv7B1Fw4IhOdx+
         C9HiBmO/BhN8l25M5NaA+wsmRK+hFMNiQaRj0peDZDKBDPY0DOGhVTBmXXPXYbLTqfhf
         J0wQ==
X-Gm-Message-State: ABuFfoha74u+Ug/H1SLd4CR+ByWtQAJZzjZovQwv/NCJ2jBnaEXgk3F+
        aFxjlW7KjUO38g4jGk+rKRxF8waxje3vFD4MrdR4B6gzaEz6
X-Google-Smtp-Source: ACcGV62jwg5XM10bM5v4imCjYd3211oMviRHx0NyGTDRTxFlP+DePWK0quB+ayn+EttzSK65ZWygVFjtb9UhS1Ie+eUU2EkL7k67
MIME-Version: 1.0
X-Received: by 2002:a6b:3b43:: with SMTP id i64-v6mr6643887ioa.61.1537564443145;
 Fri, 21 Sep 2018 14:14:03 -0700 (PDT)
Date:   Fri, 21 Sep 2018 14:14:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073fc7d0576681ebe@google.com>
Subject: KMSAN: uninit-value in memcmp (2)
From:   syzbot <syzbot+d3402c47f680ff24b29c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sunlw.fnst@cn.fujitsu.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    74ee2200b89f kmsan: bump .config.example to v4.17-rc3
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=11bcd7e7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ca1e57bafa8ab1f
dashboard link: https://syzkaller.appspot.com/bug?extid=d3402c47f680ff24b29c
compiler:       clang version 7.0.0 (trunk 329391)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102533c7800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156dab5b800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d3402c47f680ff24b29c@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KMSAN: uninit-value in memcmp+0x119/0x180 lib/string.c:861
CPU: 0 PID: 38 Comm: kworker/0:1 Not tainted 4.17.0-rc3+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
  memcmp+0x119/0x180 lib/string.c:861
  __hw_addr_add_ex net/core/dev_addr_lists.c:61 [inline]
  __dev_mc_add+0x1fc/0x900 net/core/dev_addr_lists.c:670
  dev_mc_add+0x6d/0x80 net/core/dev_addr_lists.c:687
  igmp6_group_added+0x2db/0xa00 net/ipv6/mcast.c:662
  ipv6_dev_mc_inc+0xe9e/0x1130 net/ipv6/mcast.c:914
  addrconf_join_solict net/ipv6/addrconf.c:2103 [inline]
  addrconf_dad_begin net/ipv6/addrconf.c:3853 [inline]
  addrconf_dad_work+0x462/0x2a20 net/ipv6/addrconf.c:3979
  process_one_work+0x12c6/0x1f60 kernel/workqueue.c:2145
  worker_thread+0x113c/0x24f0 kernel/workqueue.c:2279
  kthread+0x539/0x720 kernel/kthread.c:239
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:412

Local variable description: ----buf@igmp6_group_added
Variable was created at:
  igmp6_group_added+0x4a/0xa00 net/ipv6/mcast.c:650
  ipv6_dev_mc_inc+0xe9e/0x1130 net/ipv6/mcast.c:914
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
