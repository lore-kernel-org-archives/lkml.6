Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C956C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311B120835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311B120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeJKUPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:15:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:52428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727846AbeJKUPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:15:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0992CADE6;
        Thu, 11 Oct 2018 12:48:29 +0000 (UTC)
Date:   Thu, 11 Oct 2018 14:48:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/12]
Message-ID: <20181011124828.bc2reaplfisvergs@pathway.suse.cz>
References: <20180828143603.4442-1-pmladek@suse.com>
 <alpine.LSU.2.21.1808301353170.18557@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1808301353170.18557@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-08-30 13:58:15, Miroslav Benes wrote:
> On Tue, 28 Aug 2018, Petr Mladek wrote:
> 
> > livepatch: Atomic replace feature
> > 
> > The atomic replace allows to create cumulative patches. They
> > are useful when you maintain many livepatches and want to remove
> > one that is lower on the stack. In addition it is very useful when
> > more patches touch the same function and there are dependencies
> > between them.
> > 
> > This version does another big refactoring based on feedback against
> > v11[*]. In particular, it removes the registration step, changes
> > the API and handling of livepatch dependencies. The aim is
> > to keep the number of possible variants on a sane level.
> > It helps the keep the feature "easy" to use and maintain.
> > 
> > [*] https://lkml.kernel.org/r/20180323120028.31451-1-pmladek@suse.com
> 
> Hi,
> 
> I've started to review the patch set. Running selftests with lockdep 
> enabled gives me...
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.17.0-rc1-klp_replace_v12-117114-gfedb3eba611d #218 Tainted: G              
> K  
> ------------------------------------------------------
> kworker/1:1/49 is trying to acquire lock:
> 00000000bb88dc17 (kn->count#186){++++}, at: kernfs_remove+0x23/0x40
> 
> but task is already holding lock:
> 0000000073632424 (klp_mutex){+.+.}, at: klp_transition_work_fn+0x17/0x40
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (klp_mutex){+.+.}:
>        lock_acquire+0xd4/0x220
>        __mutex_lock+0x75/0x920
>        mutex_lock_nested+0x1b/0x20
>        enabled_store+0x47/0x150
>        kobj_attr_store+0x12/0x20
>        sysfs_kf_write+0x4a/0x60
>        kernfs_fop_write+0x123/0x1b0
>        __vfs_write+0x2b/0x150
>        vfs_write+0xc7/0x1c0
>        ksys_write+0x49/0xa0
>        __x64_sys_write+0x1a/0x20
>        do_syscall_64+0x62/0x1b0
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #0 (kn->count#186){++++}:
>        __lock_acquire+0xe9d/0x1240
>        lock_acquire+0xd4/0x220
>        __kernfs_remove+0x23c/0x2c0
>        kernfs_remove+0x23/0x40
>        sysfs_remove_dir+0x51/0x60
>        kobject_del+0x18/0x50
>        kobject_cleanup+0x4b/0x180
>        kobject_put+0x2a/0x50
>        __klp_free_patch+0x5b/0x60
>        klp_free_patch_nowait+0x12/0x30
>        klp_try_complete_transition+0x13e/0x180
>        klp_transition_work_fn+0x26/0x40
>        process_one_work+0x1d8/0x5d0
>        worker_thread+0x4d/0x3d0
>        kthread+0x113/0x150
>        ret_from_fork+0x3a/0x50
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(klp_mutex);
>                                lock(kn->count#186);
>                                lock(klp_mutex);
>   lock(kn->count#186);

Sigh, I overestimated the power of kobjects. I thought that this
must have been a false positive but it was not.

1. kernfs_fop_write() ignores kobj->kref. It takes care only
   of its own reference count, see kernfs_get_active().

2. kobj_put() takes care only of kobj->kref. The following
   code is called when the reference count reaches zero:

   + kobj_put()
     + kref_put()
       + kobject_release()
         + kobject_cleanup()
           + kobject_del()
	     + sysfs_remove_dir()
	       + kernfs_remove()
	         + __kernfs_remove().
		   + kernfs_drain()

    , where kernfs_drain() waits until all opened files
    are closed.

Now, we call kobj_put() under klp_mutex() when the sysfs
interface still exists. Files can be opened for
writing. As a result:

   + enabled_store() might wait for klp_mutex

   + kernfs_drain() would wait for enabled_store()
     with klp_mutex() taken.


I have reproduced this with some extra sleeps.

I am going to work on another solution.

Best Regards,
Petr
