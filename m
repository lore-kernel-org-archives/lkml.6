Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DDFC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADAF24D9C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADAF24D9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeFXC5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 22:57:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:33549 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752048AbeFXC5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 22:57:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4CF01AB34;
        Sun, 24 Jun 2018 02:56:59 +0000 (UTC)
Date:   Sat, 23 Jun 2018 19:56:51 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     syzbot <syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, manfred@colorfullife.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        dave@stgolabs.net
Subject: ipc/msg: zalloc struct msg_queue when creating a new msq
Message-ID: <20180624025651.bvjlcfulbmycz5bf@linux-r8p5>
References: <000000000000e403b3056e76c786@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <000000000000e403b3056e76c786@google.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following splat was reported around the msg_queue structure
which can have uninitialized fields left over after newque().
Future syscalls which make use of the msq id (now valid) can thus
make KMSAN complain because not all fields are explicitly initialized
and we have the padding as well. This is internal to the kernel,
hence no bogus leaks.

==================================================================
BUG: KMSAN: uninit-value in do_msgrcv+0x509/0x1e30 ipc/msg.c:1048
CPU: 0 PID: 4528 Comm: syz-executor852 Not tainted 4.17.0-rc5+ #103
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x149/0x260 mm/kmsan/kmsan.c:1084
  __msan_warning_32+0x6e/0xc0 mm/kmsan/kmsan_instr.c:686
  do_msgrcv+0x509/0x1e30 ipc/msg.c:1048
  ksys_msgrcv ipc/msg.c:1184 [inline]
  __do_sys_msgrcv ipc/msg.c:1190 [inline]
  __se_sys_msgrcv ipc/msg.c:1187 [inline]
  __x64_sys_msgrcv+0x160/0x1b0 ipc/msg.c:1187
  do_syscall_64+0x152/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4459b9
RSP: 002b:00007f0d57662db8 EFLAGS: 00000297 ORIG_RAX: 0000000000000046
RAX: ffffffffffffffda RBX: 00000000006dac54 RCX: 00000000004459b9
RDX: 00000000000000d0 RSI: 0000000020000000 RDI: 0000000000260007
RBP: 00000000006dac50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000000
R13: 00007ffd5ab7e25f R14: 00007f0d576639c0 R15: 0000000000000006

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:279 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:189
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:315
  __kmalloc_node+0xe25/0x11f0 mm/slub.c:3865
  kmalloc_node include/linux/slab.h:554 [inline]
  kvmalloc_node+0x197/0x2f0 mm/util.c:421
  kvmalloc include/linux/mm.h:550 [inline]
  newque+0xb4/0x7d0 ipc/msg.c:139
  ipcget_new ipc/util.c:315 [inline]
  ipcget+0x27b/0xd90 ipc/util.c:653
  ksys_msgget ipc/msg.c:289 [inline]
  __do_sys_msgget ipc/msg.c:294 [inline]
  __se_sys_msgget ipc/msg.c:292 [inline]
  __x64_sys_msgget+0x14c/0x1d0 ipc/msg.c:292
  do_syscall_64+0x152/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
==================================================================

Fix this by simply zero init the whole structure, something that
sysvsems also do; this is safe as it's a nop, having no secondary
effect afaict.

Reported-by: syzbot <syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 62545ce19173..da81b374f9fd 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -136,7 +136,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	key_t key = params->key;
 	int msgflg = params->flg;
 
-	msq = kvmalloc(sizeof(*msq), GFP_KERNEL);
+	msq = kvzalloc(sizeof(*msq), GFP_KERNEL);
 	if (unlikely(!msq))
 		return -ENOMEM;
 
-- 
2.16.4

