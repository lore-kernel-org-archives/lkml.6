Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BCEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501C9206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501C9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409660AbeKWWUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:20:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:56090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394331AbeKWWUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:20:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9F63ACFA;
        Fri, 23 Nov 2018 11:36:49 +0000 (UTC)
Date:   Fri, 23 Nov 2018 12:36:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
Message-ID: <20181123113648.6fieltetklnoex6v@pathway.suse.cz>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
 <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
 <20181122020422.GA3441@jagdpanzerIV>
 <20181122160250.lxyfzsybfwskrh54@pathway.suse.cz>
 <fd006ace-f339-34c2-d87f-51f145ac8364@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd006ace-f339-34c2-d87f-51f145ac8364@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-11-22 15:29:35, Waiman Long wrote:
> On 11/22/2018 11:02 AM, Petr Mladek wrote:
> > Anyway, I wonder what was the primary motivation for this patch.
> > Was it the system hang? Or was it lockdep report about nesting
> > two terminal locks: db->lock, pool_lock with logbuf_lock?
> 
> The primary motivation was to make sure that printk() won't be called
> while holding either db->lock or pool_lock in the debugobjects code. In
> the determination of which locks can be made terminal, I focused on
> local spinlocks that won't cause boundary to an unrelated subsystem as
> it will greatly complicate the analysis.

Then please mention this as the real reason in the commit message.

The reason that printk might take too long in IRQ context does
not explain why we need the patch. printk() is called in IRQ
context in many other locations. I do not see why this place
should be special. The delay is the price for the chance to
see the problem.


> I didn't realize that it fixed a hang problem that I was seeing until I
> did bisection to find out that it was caused by the patch that cause the
> debugobjects splat in the first place a few days ago. I was comparing
> the performance status of the pre and post patched kernel. The pre-patch
> kernel failed to boot in the one of my test systems, but the
> post-patched kernel could. I narrowed it down to this patch as the fix
> for the hang problem.

The hang is a mystery. My guess is that there is a race somewhere.
The patch might have reduced the race window but it probably did
not fix the race itself.

Best Regards,
Petr
