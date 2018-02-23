Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414828-2-2505010517393608733
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414827; b=c5CBw8iRtiP9yDwmSOGJjOhKlBPbBIUCY5dYF6xcSw7gOAw
    uIOLAsuXTkztDjoPBxuAG8q7H9m+cWSkWEc8tJ4OVPExZu0ImtDWW/5V6UsLMnUZ
    PdtZ7iybjzxuuHhEKS8tRZQ3wVmYmIOx5SWRo7UNel6w0TyCIMXKPS6i8wLRnWjl
    h25S6iR4VzAX0dtujG8bXteHLGZo0RBRhvqGlrpvafCA0x5kpUA29ceBxUGEKncp
    LrPsjWooHbqFekxKzWxRJp/WTlN6LHKONy61oZiVJQL/96miMiznth5WXOFlRzNE
    EWMZL7gDRV//r7sAxbGiB0jXHSLCZDSOGP2tqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414827; bh=cta2q0zqM7/uwpRsWopTkfj4Ob
    NzVWbeF9b3yfYeIJ0=; b=L2Hl7I3bQXAX1TEQhhuVmEWll3K6SsUwjR+0V+sHXE
    0vjF3iB0oaJKwS+Md/ZkoMjiff3ZBC+rTxqHw/9xcwbbd2J5k1E+ZhbEBpQMnoS2
    EfpYExSIHi0IUj9yG3XkUYfsicet2c9kq5IlX8M+O4amj00U66isk/NR7rvPj9Qp
    9nIVYnyYHZKt36JyNpLBzHPwfMg5A+Rcrxfk7g2Ep5a7pE5pSxsGjn6IU7TU9unz
    pxdWSqkW38rtPu9FOc+t8cpSsNbvpOIYSflpS58MkPhXGt8Ko0L0WkhOTYODIOvR
    8cyZBN5KEbabeMo1PMcvFO1Roi4D3/DvCnvnl/qC/LkA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932256AbeBWTkI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:40:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45316 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934543AbeBWSt3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        syzbot <syzkaller@googlegroups.com>,
        Glauber Costa <glauber@scylladb.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 012/159] mm,vmscan: Make unregister_shrinker() no-op if register_shrinker() failed.
Date: Fri, 23 Feb 2018 19:25:20 +0100
Message-Id: <20180223170744.683076587@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit bb422a738f6566f7439cd347d54e321e4fe92a9f upstream.

Syzbot caught an oops at unregister_shrinker() because combination of
commit 1d3d4437eae1bb29 ("vmscan: per-node deferred work") and fault
injection made register_shrinker() fail and the caller of
register_shrinker() did not check for failure.

----------
[  554.881422] FAULT_INJECTION: forcing a failure.
[  554.881422] name failslab, interval 1, probability 0, space 0, times 0
[  554.881438] CPU: 1 PID: 13231 Comm: syz-executor1 Not tainted 4.14.0-rc8+ #82
[  554.881443] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  554.881445] Call Trace:
[  554.881459]  dump_stack+0x194/0x257
[  554.881474]  ? arch_local_irq_restore+0x53/0x53
[  554.881486]  ? find_held_lock+0x35/0x1d0
[  554.881507]  should_fail+0x8c0/0xa40
[  554.881522]  ? fault_create_debugfs_attr+0x1f0/0x1f0
[  554.881537]  ? check_noncircular+0x20/0x20
[  554.881546]  ? find_next_zero_bit+0x2c/0x40
[  554.881560]  ? ida_get_new_above+0x421/0x9d0
[  554.881577]  ? find_held_lock+0x35/0x1d0
[  554.881594]  ? __lock_is_held+0xb6/0x140
[  554.881628]  ? check_same_owner+0x320/0x320
[  554.881634]  ? lock_downgrade+0x990/0x990
[  554.881649]  ? find_held_lock+0x35/0x1d0
[  554.881672]  should_failslab+0xec/0x120
[  554.881684]  __kmalloc+0x63/0x760
[  554.881692]  ? lock_downgrade+0x990/0x990
[  554.881712]  ? register_shrinker+0x10e/0x2d0
[  554.881721]  ? trace_event_raw_event_module_request+0x320/0x320
[  554.881737]  register_shrinker+0x10e/0x2d0
[  554.881747]  ? prepare_kswapd_sleep+0x1f0/0x1f0
[  554.881755]  ? _down_write_nest_lock+0x120/0x120
[  554.881765]  ? memcpy+0x45/0x50
[  554.881785]  sget_userns+0xbcd/0xe20
(...snipped...)
[  554.898693] kasan: CONFIG_KASAN_INLINE enabled
[  554.898724] kasan: GPF could be caused by NULL-ptr deref or user memory access
[  554.898732] general protection fault: 0000 [#1] SMP KASAN
[  554.898737] Dumping ftrace buffer:
[  554.898741]    (ftrace buffer empty)
[  554.898743] Modules linked in:
[  554.898752] CPU: 1 PID: 13231 Comm: syz-executor1 Not tainted 4.14.0-rc8+ #82
[  554.898755] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  554.898760] task: ffff8801d1dbe5c0 task.stack: ffff8801c9e38000
[  554.898772] RIP: 0010:__list_del_entry_valid+0x7e/0x150
[  554.898775] RSP: 0018:ffff8801c9e3f108 EFLAGS: 00010246
[  554.898780] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  554.898784] RDX: 0000000000000000 RSI: ffff8801c53c6f98 RDI: ffff8801c53c6fa0
[  554.898788] RBP: ffff8801c9e3f120 R08: 1ffff100393c7d55 R09: 0000000000000004
[  554.898791] R10: ffff8801c9e3ef70 R11: 0000000000000000 R12: 0000000000000000
[  554.898795] R13: dffffc0000000000 R14: 1ffff100393c7e45 R15: ffff8801c53c6f98
[  554.898800] FS:  0000000000000000(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
[  554.898804] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  554.898807] CR2: 00000000dbc23000 CR3: 00000001c7269000 CR4: 00000000001406e0
[  554.898813] DR0: 0000000020000000 DR1: 0000000020000000 DR2: 0000000000000000
[  554.898816] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
[  554.898818] Call Trace:
[  554.898828]  unregister_shrinker+0x79/0x300
[  554.898837]  ? perf_trace_mm_vmscan_writepage+0x750/0x750
[  554.898844]  ? down_write+0x87/0x120
[  554.898851]  ? deactivate_super+0x139/0x1b0
[  554.898857]  ? down_read+0x150/0x150
[  554.898864]  ? check_same_owner+0x320/0x320
[  554.898875]  deactivate_locked_super+0x64/0xd0
[  554.898883]  deactivate_super+0x141/0x1b0
----------

Since allowing register_shrinker() callers to call unregister_shrinker()
when register_shrinker() failed can simplify error recovery path, this
patch makes unregister_shrinker() no-op when register_shrinker() failed.
Also, reset shrinker->nr_deferred in case unregister_shrinker() was
by error called twice.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Aliaksei Karaliou <akaraliou.dev@gmail.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Glauber Costa <glauber@scylladb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmscan.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -297,10 +297,13 @@ EXPORT_SYMBOL(register_shrinker);
  */
 void unregister_shrinker(struct shrinker *shrinker)
 {
+	if (!shrinker->nr_deferred)
+		return;
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
 	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
 }
 EXPORT_SYMBOL(unregister_shrinker);
 
