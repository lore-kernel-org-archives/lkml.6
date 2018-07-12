Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA36C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D50820C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D50820C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbeGLJcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:32:46 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:41658 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeGLJcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:32:45 -0400
Received: by mail-io0-f197.google.com with SMTP id p12-v6so10409591iog.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 02:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pijR9j6tpjH/GtlRlEUgbpO0zh43sg15vIRLA9szaiA=;
        b=BbNdlOuoZOrADyGCx1MerL76yjbBpDBgN9tXFilflnqHN8iefGfxOhjQQyi9MItVyT
         abXN6UIO0E9nPsImzgvJkLx/rs/qk/z3oKRNtm7V5+kfVjlEpgbyMKRSRSXZdQoyqYlS
         Ktp7qiqRY3U2fephLxNL4bESNI0g2z1DHW3Nx9rK6gH3+9o7OIE450g/uNX+qDcDpT5b
         kMe3u+7vOA/rP5y7mn9QjI3bubOH+CHOkLmJ5YkcB41P2jVlk8RU04B5Ky7ZR7akTtp2
         ryDd25NgbHlLZU5AkDx5a7ezbHREuJzD9nx4LArJ1DKvzy38YXA77WG9Bmei2RBgI5M+
         xYgg==
X-Gm-Message-State: AOUpUlGu68snBf1Ef6U4QocPCJX+gK333Fgc6donP49VRsGRi9eOy/Kf
        YEpRxZhrL/kjDWFQKR07+35t6QUWXDWG0btNlPOQ8ln5i1uT
X-Google-Smtp-Source: AAOMgpfusS09dgtIjfJMRCqaqw07fb3JFUN1lo/1XeYkQPlSp4hENGCEMvl+yR02G4EXljUNipgdvw3kCoX0sn+hH1stFXyYAx0J
MIME-Version: 1.0
X-Received: by 2002:a6b:e413:: with SMTP id u19-v6mr573848iog.119.1531387441566;
 Thu, 12 Jul 2018 02:24:01 -0700 (PDT)
Date:   Thu, 12 Jul 2018 02:24:01 -0700
In-Reply-To: <000000000000c541110570a978a4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077da4b0570c9eccc@google.com>
Subject: Re: KMSAN: uninit-value in p9_client_rpc
From:   syzbot <syzbot+4de40388f584432bf004@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    b64f7ec04e12 kmsan: implement kmsan_memmove_shadow() and k..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=12f6791c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93d57043084eee38
dashboard link: https://syzkaller.appspot.com/bug?extid=4de40388f584432bf004
compiler:       clang version 7.0.0 (trunk 334104)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=147c36dc400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e87044400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4de40388f584432bf004@syzkaller.appspotmail.com

FS-Cache: O-key=[10] '34323934373135343132'
FS-Cache: N-cookie c=(____ptrval____) [p=(____ptrval____) fl=2 nc=0 na=1]
FS-Cache: N-cookie d=(____ptrval____) n=(____ptrval____)
FS-Cache: N-key=[10] '34323934373135343132'
==================================================================
BUG: KMSAN: uninit-value in p9_client_rpc+0x194c/0x1dc0 net/9p/client.c:818
CPU: 1 PID: 4620 Comm: syz-executor262 Not tainted 4.18.0-rc4+ #24
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1e0 lib/dump_stack.c:113
  kmsan_report+0x195/0x2c0 mm/kmsan/kmsan.c:1092
  __msan_warning_32+0x7d/0xe0 mm/kmsan/kmsan_instr.c:640
  p9_client_rpc+0x194c/0x1dc0 net/9p/client.c:818
  p9_client_attach+0x35b/0xc30 net/9p/client.c:1147
  v9fs_session_init+0x24b9/0x2970 fs/9p/v9fs.c:449
  v9fs_mount+0x107/0x11b0 fs/9p/vfs_super.c:135
  mount_fs+0x29b/0x780 fs/super.c:1277
  vfs_kern_mount+0x222/0x990 fs/namespace.c:1037
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0xd30/0x5310 fs/namespace.c:2848
  ksys_mount+0x32e/0x3d0 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0x157/0x1c0 fs/namespace.c:3075
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x445f79
Code: e8 cc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b 0d fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffb83104da8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006dbc3c RCX: 0000000000445f79
RDX: 0000000020000180 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 00000000006dbc38 R08: 00000000200001c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0030656c69662f2e
R13: 64663d736e617274 R14: 7974697275636573 R15: 0000000000000001

Local variable description: ----ecode.i@p9_client_rpc
Variable was created at:
  p9_client_rpc+0x183/0x1dc0 net/9p/client.c:750
  p9_client_attach+0x35b/0xc30 net/9p/client.c:1147
==================================================================

