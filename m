Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184361-2-12411292642843424631
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184360; b=LkCRXRov/bHC7ODvH7BJDys74ZxqJ9uIb9m7DerKIoJ7x8y
    ZSNcoXC5tT+hs3bXwmTO4dJDt3Oj/i8RN3Ss+2VP25fqn47WUNEITN+W5wxZI1eS
    Gf6cBFK8GdlGclY+G9z/nr3JbNr1EKFYlrAT2J1Is3wHld/6O144OxfIS8zybfSw
    0TJGsMc/YgVy96U8zqVVl/26RgeVu/5kR4xKTRnB1Hpbt939GskE42gWB++d1XCk
    +/ErAsdr3IF0Hpeu2H8f1/D8oxxGpOJRV8cwewkONb7FO2ZkQPdvRju1G3VkHRAy
    No3IOuwtjlz1yFkgxjQ1DyXSCCixv7o2TBaUi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184360; bh=AcCVOeRL6DpypudWVZgxObrNmE
    7VXCVV1uJ4VCsuyAQ=; b=X5AZgsOGC/IiNLYHaLeSxxNNSDYQG6yC6ZEbOP/MBd
    /q/61KsaX3p2LpjYy1VC17u4Boz73MlDw5AewguwhO1MNUIWMGF8kZ9m6H+sBsZW
    0GHUE7H6aN7hHlf+XqRKDOOjDZ856mBRol0wp9OTp1S9vR1IfDYeDa6L2ghPEOc3
    p7rQoWIhgUvFWjCgCb11M3f4xSk58D78N3umcVa/wjkQZH2rH1vh0XoOW/9L5VPY
    ZRa1KWxlCQpsZ/OudVldmQMYiGy2Ttn5ZHz0ifx8gWcJWU2fGFnnFl1i5UtvEEb6
    Z3anyYXyBDmfiRWZ5NvqGyxqpl40vKdyInmKzAKaaotg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeBINwX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:52:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932158AbeBINqI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:46:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot
        <bot+eceb3204562c41a438fa1f2335e0fe4f6886d669@syzkaller.appspotmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 01/23] ip6mr: fix stale iterator
Date: Fri,  9 Feb 2018 14:39:59 +0100
Message-Id: <20180209133938.453880766@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


[ Upstream commit 4adfa79fc254efb7b0eb3cd58f62c2c3f805f1ba ]

When we dump the ip6mr mfc entries via proc, we initialize an iterator
with the table to dump but we don't clear the cache pointer which might
be initialized from a prior read on the same descriptor that ended. This
can result in lock imbalance (an unnecessary unlock) leading to other
crashes and hangs. Clear the cache pointer like ipmr does to fix the issue.
Thanks for the reliable reproducer.

Here's syzbot's trace:
 WARNING: bad unlock balance detected!
 4.15.0-rc3+ #128 Not tainted
 syzkaller971460/3195 is trying to release lock (mrt_lock) at:
 [<000000006898068d>] ipmr_mfc_seq_stop+0xe1/0x130 net/ipv6/ip6mr.c:553
 but there are no more locks to release!

 other info that might help us debug this:
 1 lock held by syzkaller971460/3195:
  #0:  (&p->lock){+.+.}, at: [<00000000744a6565>] seq_read+0xd5/0x13d0
 fs/seq_file.c:165

 stack backtrace:
 CPU: 1 PID: 3195 Comm: syzkaller971460 Not tainted 4.15.0-rc3+ #128
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
 Google 01/01/2011
 Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x257 lib/dump_stack.c:53
  print_unlock_imbalance_bug+0x12f/0x140 kernel/locking/lockdep.c:3561
  __lock_release kernel/locking/lockdep.c:3775 [inline]
  lock_release+0x5f9/0xda0 kernel/locking/lockdep.c:4023
  __raw_read_unlock include/linux/rwlock_api_smp.h:225 [inline]
  _raw_read_unlock+0x1a/0x30 kernel/locking/spinlock.c:255
  ipmr_mfc_seq_stop+0xe1/0x130 net/ipv6/ip6mr.c:553
  traverse+0x3bc/0xa00 fs/seq_file.c:135
  seq_read+0x96a/0x13d0 fs/seq_file.c:189
  proc_reg_read+0xef/0x170 fs/proc/inode.c:217
  do_loop_readv_writev fs/read_write.c:673 [inline]
  do_iter_read+0x3db/0x5b0 fs/read_write.c:897
  compat_readv+0x1bf/0x270 fs/read_write.c:1140
  do_compat_preadv64+0xdc/0x100 fs/read_write.c:1189
  C_SYSC_preadv fs/read_write.c:1209 [inline]
  compat_SyS_preadv+0x3b/0x50 fs/read_write.c:1203
  do_syscall_32_irqs_on arch/x86/entry/common.c:327 [inline]
  do_fast_syscall_32+0x3ee/0xf9d arch/x86/entry/common.c:389
  entry_SYSENTER_compat+0x51/0x60 arch/x86/entry/entry_64_compat.S:125
 RIP: 0023:0xf7f73c79
 RSP: 002b:00000000e574a15c EFLAGS: 00000292 ORIG_RAX: 000000000000014d
 RAX: ffffffffffffffda RBX: 000000000000000f RCX: 0000000020a3afb0
 RDX: 0000000000000001 RSI: 0000000000000067 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 BUG: sleeping function called from invalid context at lib/usercopy.c:25
 in_atomic(): 1, irqs_disabled(): 0, pid: 3195, name: syzkaller971460
 INFO: lockdep is turned off.
 CPU: 1 PID: 3195 Comm: syzkaller971460 Not tainted 4.15.0-rc3+ #128
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
 Google 01/01/2011
 Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x257 lib/dump_stack.c:53
  ___might_sleep+0x2b2/0x470 kernel/sched/core.c:6060
  __might_sleep+0x95/0x190 kernel/sched/core.c:6013
  __might_fault+0xab/0x1d0 mm/memory.c:4525
  _copy_to_user+0x2c/0xc0 lib/usercopy.c:25
  copy_to_user include/linux/uaccess.h:155 [inline]
  seq_read+0xcb4/0x13d0 fs/seq_file.c:279
  proc_reg_read+0xef/0x170 fs/proc/inode.c:217
  do_loop_readv_writev fs/read_write.c:673 [inline]
  do_iter_read+0x3db/0x5b0 fs/read_write.c:897
  compat_readv+0x1bf/0x270 fs/read_write.c:1140
  do_compat_preadv64+0xdc/0x100 fs/read_write.c:1189
  C_SYSC_preadv fs/read_write.c:1209 [inline]
  compat_SyS_preadv+0x3b/0x50 fs/read_write.c:1203
  do_syscall_32_irqs_on arch/x86/entry/common.c:327 [inline]
  do_fast_syscall_32+0x3ee/0xf9d arch/x86/entry/common.c:389
  entry_SYSENTER_compat+0x51/0x60 arch/x86/entry/entry_64_compat.S:125
 RIP: 0023:0xf7f73c79
 RSP: 002b:00000000e574a15c EFLAGS: 00000292 ORIG_RAX: 000000000000014d
 RAX: ffffffffffffffda RBX: 000000000000000f RCX: 0000000020a3afb0
 RDX: 0000000000000001 RSI: 0000000000000067 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 WARNING: CPU: 1 PID: 3195 at lib/usercopy.c:26 _copy_to_user+0xb5/0xc0
 lib/usercopy.c:26

Reported-by: syzbot <bot+eceb3204562c41a438fa1f2335e0fe4f6886d669@syzkaller.appspotmail.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6mr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -495,6 +495,7 @@ static void *ipmr_mfc_seq_start(struct s
 		return ERR_PTR(-ENOENT);
 
 	it->mrt = mrt;
+	it->cache = NULL;
 	return *pos ? ipmr_mfc_seq_idx(net, seq->private, *pos - 1)
 		: SEQ_START_TOKEN;
 }
