Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91101C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A00420837
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A00420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933961AbeGDIOA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:14:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:60278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933756AbeGDINt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:13:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21939ACC5;
        Wed,  4 Jul 2018 08:13:48 +0000 (UTC)
Date:   Wed, 4 Jul 2018 10:13:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 4/5] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-ID: <20180704081347.GG22503@dhcp22.suse.cz>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
 <20180629183501.9e30c26135f11853245c56c7@linux-foundation.org>
 <084aeccb-2c54-2299-8bf0-29a10cc0186e@linux.alibaba.com>
 <20180629201547.5322cfc4b52d19a0443daec2@linux-foundation.org>
 <20180702140502.GZ19043@dhcp22.suse.cz>
 <20180702134845.c4f536dead5374b443e24270@linux-foundation.org>
 <20180703060921.GA16767@dhcp22.suse.cz>
 <658e4c7b-d426-11ab-ef9a-018579cbf756@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658e4c7b-d426-11ab-ef9a-018579cbf756@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-07-18 11:22:17, Yang Shi wrote:
> 
> 
> On 7/2/18 11:09 PM, Michal Hocko wrote:
> > On Mon 02-07-18 13:48:45, Andrew Morton wrote:
> > > On Mon, 2 Jul 2018 16:05:02 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> > > 
> > > > On Fri 29-06-18 20:15:47, Andrew Morton wrote:
> > > > [...]
> > > > > Would one of your earlier designs have addressed all usecases?  I
> > > > > expect the dumb unmap-a-little-bit-at-a-time approach would have?
> > > > It has been already pointed out that this will not work.
> > > I said "one of".  There were others.
> > Well, I was aware only about two potential solutions. Either do the
> > heavy lifting under the shared lock and do the rest with the exlusive
> > one and this, drop the lock per parts. Maybe I have missed others?
> > 
> > > > You simply
> > > > cannot drop the mmap_sem during unmap because another thread could
> > > > change the address space under your feet. So you need some form of
> > > > VM_DEAD and handle concurrent and conflicting address space operations.
> > > Unclear that this is a problem.  If a thread does an unmap of a range
> > > of virtual address space, there's no guarantee that upon return some
> > > other thread has not already mapped new stuff into that address range.
> > > So what's changed?
> > Well, consider the following scenario:
> > Thread A = calling mmap(NULL, sizeA)
> > Thread B = calling munmap(addr, sizeB)
> > 
> > They do not use any external synchronization and rely on the atomic
> > munmap. Thread B only munmaps range that it knows belongs to it (e.g.
> > called mmap in the past). It should be clear that ThreadA should not
> > get an address from the addr, sizeB range, right? In the most simple case
> > it will not happen. But let's say that the addr, sizeB range has
> > unmapped holes for what ever reasons. Now anytime munmap drops the
> > exclusive lock after handling one VMA, Thread A might find its sizeA
> > range and use it. ThreadB then might remove this new range as soon as it
> > gets its exclusive lock again.
> 
> I'm a little bit confused here. If ThreadB already has unmapped that range,
> then ThreadA uses it. It sounds not like a problem since ThreadB should just
> go ahead to handle the next range when it gets its exclusive lock again,
> right? I don't think of why ThreadB would re-visit that range to remove it.

Not if the new range overlap with the follow up range that ThreadB does.
Example

B: munmap [XXXXX]    [XXXXXX] [XXXXXXXXXX]
B: breaks the lock after processing the first vma.
A: mmap [XXXXXXXXXXXX]
B: munmap retakes the lock and revalidate from the last vm_end because
   the old vma->vm_next might be gone
B:               [XXX][XXXXX] [XXXXXXXXXX]

so you munmap part of the range. Sure you can plan some tricks and skip
over vmas that do not start above your last vma->vm_end or something
like that but I expect there are other can of worms hidden there.
-- 
Michal Hocko
SUSE Labs
