Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF99C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14DD2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14DD2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeH3QAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:00:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:44420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727388AbeH3QAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:00:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3654AFEF;
        Thu, 30 Aug 2018 11:58:16 +0000 (UTC)
Date:   Thu, 30 Aug 2018 13:58:15 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/12] 
In-Reply-To: <20180828143603.4442-1-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1808301353170.18557@pobox.suse.cz>
References: <20180828143603.4442-1-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Petr Mladek wrote:

> livepatch: Atomic replace feature
> 
> The atomic replace allows to create cumulative patches. They
> are useful when you maintain many livepatches and want to remove
> one that is lower on the stack. In addition it is very useful when
> more patches touch the same function and there are dependencies
> between them.
> 
> This version does another big refactoring based on feedback against
> v11[*]. In particular, it removes the registration step, changes
> the API and handling of livepatch dependencies. The aim is
> to keep the number of possible variants on a sane level.
> It helps the keep the feature "easy" to use and maintain.
> 
> [*] https://lkml.kernel.org/r/20180323120028.31451-1-pmladek@suse.com

Hi,

I've started to review the patch set. Running selftests with lockdep 
enabled gives me...

======================================================
WARNING: possible circular locking dependency detected
4.17.0-rc1-klp_replace_v12-117114-gfedb3eba611d #218 Tainted: G              
K  
------------------------------------------------------
kworker/1:1/49 is trying to acquire lock:
00000000bb88dc17 (kn->count#186){++++}, at: kernfs_remove+0x23/0x40

but task is already holding lock:
0000000073632424 (klp_mutex){+.+.}, at: klp_transition_work_fn+0x17/0x40

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (klp_mutex){+.+.}:
       lock_acquire+0xd4/0x220
       __mutex_lock+0x75/0x920
       mutex_lock_nested+0x1b/0x20
       enabled_store+0x47/0x150
       kobj_attr_store+0x12/0x20
       sysfs_kf_write+0x4a/0x60
       kernfs_fop_write+0x123/0x1b0
       __vfs_write+0x2b/0x150
       vfs_write+0xc7/0x1c0
       ksys_write+0x49/0xa0
       __x64_sys_write+0x1a/0x20
       do_syscall_64+0x62/0x1b0
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (kn->count#186){++++}:
       __lock_acquire+0xe9d/0x1240
       lock_acquire+0xd4/0x220
       __kernfs_remove+0x23c/0x2c0
       kernfs_remove+0x23/0x40
       sysfs_remove_dir+0x51/0x60
       kobject_del+0x18/0x50
       kobject_cleanup+0x4b/0x180
       kobject_put+0x2a/0x50
       __klp_free_patch+0x5b/0x60
       klp_free_patch_nowait+0x12/0x30
       klp_try_complete_transition+0x13e/0x180
       klp_transition_work_fn+0x26/0x40
       process_one_work+0x1d8/0x5d0
       worker_thread+0x4d/0x3d0
       kthread+0x113/0x150
       ret_from_fork+0x3a/0x50

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(klp_mutex);
                               lock(kn->count#186);
                               lock(klp_mutex);
  lock(kn->count#186);

 *** DEADLOCK ***

3 locks held by kworker/1:1/49: #0: 00000000654f4e5a ((wq_completion)"events"){+.+.}, at: 
process_one_work+0x153/0x5d0 #1: 000000003c1dc846 ((klp_transition_work).work){+.+.}, at: 
process_one_work+0x153/0x5d0 #2: 0000000073632424 (klp_mutex){+.+.}, at: klp_transition_work_fn+0x17/0x40

stack backtrace:
CPU: 1 PID: 49 Comm: kworker/1:1 Tainted: G              K   
4.17.0-rc1-klp_replace_v12-117114-gfedb3eba611d #218
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
1.0.0-prebuilt.qemu-project.org 04/01/2014
Workqueue: events klp_transition_work_fn
Call Trace:
 dump_stack+0x81/0xb8
 print_circular_bug.isra.39+0x200/0x20e
 check_prev_add.constprop.47+0x725/0x740
 ? print_shortest_lock_dependencies+0x1c0/0x1c0
 __lock_acquire+0xe9d/0x1240
 lock_acquire+0xd4/0x220
 ? kernfs_remove+0x23/0x40
 __kernfs_remove+0x23c/0x2c0
 ? kernfs_remove+0x23/0x40
 kernfs_remove+0x23/0x40
 sysfs_remove_dir+0x51/0x60
 kobject_del+0x18/0x50
 kobject_cleanup+0x4b/0x180
 kobject_put+0x2a/0x50
 __klp_free_patch+0x5b/0x60
 klp_free_patch_nowait+0x12/0x30
 klp_try_complete_transition+0x13e/0x180
 klp_transition_work_fn+0x26/0x40
 process_one_work+0x1d8/0x5d0
 ? process_one_work+0x153/0x5d0
 worker_thread+0x4d/0x3d0
 ? trace_hardirqs_on+0xd/0x10
 kthread+0x113/0x150
 ? process_one_work+0x5d0/0x5d0
 ? kthread_delayed_work_timer_fn+0x90/0x90
 ? kthread_delayed_work_timer_fn+0x90/0x90
 ret_from_fork+0x3a/0x50


I think it could be related to registration removal and API changes. One 
thread writes to sysfs and wants to take klp_mutex there (CPU#1), the 
other holds klp_mutex in a transition period and calls klp_free_patch() 
to remove the sysfs infrastructure.

Regards,
Miroslav
