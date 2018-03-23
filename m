Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-947063-1521799828-2-2517753171021281680
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521799827; b=FTUOlACA5fX1i47Q/guXLa7Giv6Y6DFFosHcOglfoRUDbWo
    uKcp5NcIYsQCUhJ7xaBPl7iywwonM9Xx/fyM/ahMr3aYJ8VkXdBCrQV5pfaq4iDP
    Zjsde+F8COGKcZqJxUCMfxvIveo7y+EBkXrsgfs1lfGeDcLaQI4hJL+koE+6CA0j
    OAIK3pPZR8GfTx3og+7S3qiPHYX0qb1z7vdFWOokKQ09jZLRvdBMbQFYlKsSfbcv
    Hg9WmPgmt6PUeMjsHfaqGE2FNlRkygR6I/GSYDyacLclgPyAVbrqlzI4c7I9Pnd6
    Z5j9gxpnmZqu+oeIQ060ol1GgpvQgweyOuPuS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521799827; bh=XQ8fvapTleJwgdy9GEW+1vct8E
    BU2Wjcmq7a7vVru/8=; b=nfJeL0imhArjJuei6W1WTWclhqu2/SgMAmlA6nkemY
    b9bHgsoFvHkAZxcsxX3K4vRckYQZX/qmj8Wy9SZTSBK4m0aeSN8JAYGPYHKMd52w
    JCIdA3KTP2OzFSZwEfInYPnUVNGd2ypWtNeK/Ia4qwdUPyc7+ZVxyuxkXMjRbUzs
    8ndO0QR7t+D96b2U6hH5Kn6GRTBao6hIJx1XzVbRu/pePlWNF0tbm06s+1gRMChw
    +VR91xLoh+JijTxbDDTox/s4geT9Dqhn0YgKW+sm3auWv6x3kScXO9lsw63ibLWp
    llR3ffKz/FyuoZsSaLrfRoaZ+gIBFU4GONzTM18oSpAA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932682AbeCWKKX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:10:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932681AbeCWKKT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jens Axboe <axboe@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 133/177] block/mq: Cure cpu hotplug lock inversion
Date: Fri, 23 Mar 2018 10:54:21 +0100
Message-Id: <20180323094211.086193872@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>


[ Upstream commit eabe06595d62cfa9278e2cd012df614bc68a7042 ]

By poking at /debug/sched_features I triggered the following splat:

 [] ======================================================
 [] WARNING: possible circular locking dependency detected
 [] 4.11.0-00873-g964c8b7-dirty #694 Not tainted
 [] ------------------------------------------------------
 [] bash/2109 is trying to acquire lock:
 []  (cpu_hotplug_lock.rw_sem){++++++}, at: [<ffffffff8120cb8b>] static_key_slow_dec+0x1b/0x50
 []
 [] but task is already holding lock:
 []  (&sb->s_type->i_mutex_key#4){+++++.}, at: [<ffffffff81140216>] sched_feat_write+0x86/0x170
 []
 [] which lock already depends on the new lock.
 []
 []
 [] the existing dependency chain (in reverse order) is:
 []
 [] -> #2 (&sb->s_type->i_mutex_key#4){+++++.}:
 []        lock_acquire+0x100/0x210
 []        down_write+0x28/0x60
 []        start_creating+0x5e/0xf0
 []        debugfs_create_dir+0x13/0x110
 []        blk_mq_debugfs_register+0x21/0x70
 []        blk_mq_register_dev+0x64/0xd0
 []        blk_register_queue+0x6a/0x170
 []        device_add_disk+0x22d/0x440
 []        loop_add+0x1f3/0x280
 []        loop_init+0x104/0x142
 []        do_one_initcall+0x43/0x180
 []        kernel_init_freeable+0x1de/0x266
 []        kernel_init+0xe/0x100
 []        ret_from_fork+0x31/0x40
 []
 [] -> #1 (all_q_mutex){+.+.+.}:
 []        lock_acquire+0x100/0x210
 []        __mutex_lock+0x6c/0x960
 []        mutex_lock_nested+0x1b/0x20
 []        blk_mq_init_allocated_queue+0x37c/0x4e0
 []        blk_mq_init_queue+0x3a/0x60
 []        loop_add+0xe5/0x280
 []        loop_init+0x104/0x142
 []        do_one_initcall+0x43/0x180
 []        kernel_init_freeable+0x1de/0x266
 []        kernel_init+0xe/0x100
 []        ret_from_fork+0x31/0x40

 []  *** DEADLOCK ***
 []
 [] 3 locks held by bash/2109:
 []  #0:  (sb_writers#11){.+.+.+}, at: [<ffffffff81292bcd>] vfs_write+0x17d/0x1a0
 []  #1:  (debugfs_srcu){......}, at: [<ffffffff8155a90d>] full_proxy_write+0x5d/0xd0
 []  #2:  (&sb->s_type->i_mutex_key#4){+++++.}, at: [<ffffffff81140216>] sched_feat_write+0x86/0x170
 []
 [] stack backtrace:
 [] CPU: 9 PID: 2109 Comm: bash Not tainted 4.11.0-00873-g964c8b7-dirty #694
 [] Hardware name: Intel Corporation S2600GZ/S2600GZ, BIOS SE5C600.86B.02.02.0002.122320131210 12/23/2013
 [] Call Trace:

 []  lock_acquire+0x100/0x210
 []  get_online_cpus+0x2a/0x90
 []  static_key_slow_dec+0x1b/0x50
 []  static_key_disable+0x20/0x30
 []  sched_feat_write+0x131/0x170
 []  full_proxy_write+0x97/0xd0
 []  __vfs_write+0x28/0x120
 []  vfs_write+0xb5/0x1a0
 []  SyS_write+0x49/0xa0
 []  entry_SYSCALL_64_fastpath+0x23/0xc2

This is because of the cpu hotplug lock rework. Break the chain at #1
by reversing the lock acquisition order. This way i_mutex_key#4 no
longer depends on cpu_hotplug_lock and things are good.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2014,15 +2014,15 @@ struct request_queue *blk_mq_init_alloca
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 
-	get_online_cpus();
 	mutex_lock(&all_q_mutex);
+	get_online_cpus();
 
 	list_add_tail(&q->all_q_node, &all_q_list);
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q, cpu_online_mask);
 
-	mutex_unlock(&all_q_mutex);
 	put_online_cpus();
+	mutex_unlock(&all_q_mutex);
 
 	return q;
 
