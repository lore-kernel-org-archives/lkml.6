Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E36EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF9F20675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392028AbfBMUDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:03:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfBMUDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:03:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76DA6C0669DD;
        Wed, 13 Feb 2019 20:03:34 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 570CB5D6B3;
        Wed, 13 Feb 2019 20:03:31 +0000 (UTC)
Date:   Wed, 13 Feb 2019 13:03:30 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, akpm@linux-foundation.org,
        dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com,
        atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru,
        peterz@infradead.org
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190213130330.76ef1987@w520.home>
In-Reply-To: <20190213002650.kav7xc4r2xs5f3ef@ca-dmjordan1.us.oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
        <20190211224437.25267-2-daniel.m.jordan@oracle.com>
        <20190211225620.GO24692@ziepe.ca>
        <20190211231152.qflff6g2asmkb6hr@ca-dmjordan1.us.oracle.com>
        <20190212114110.17bc8a14@w520.home>
        <20190213002650.kav7xc4r2xs5f3ef@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 13 Feb 2019 20:03:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 19:26:50 -0500
Daniel Jordan <daniel.m.jordan@oracle.com> wrote:

> On Tue, Feb 12, 2019 at 11:41:10AM -0700, Alex Williamson wrote:
> > Daniel Jordan <daniel.m.jordan@oracle.com> wrote:  
> > > On Mon, Feb 11, 2019 at 03:56:20PM -0700, Jason Gunthorpe wrote:  
> > > > I haven't looked at this super closely, but how does this stuff work?
> > > > 
> > > > do_mlock doesn't touch pinned_vm, and this doesn't touch locked_vm...
> > > > 
> > > > Shouldn't all this be 'if (locked_vm + pinned_vm < RLIMIT_MEMLOCK)' ?
> > > >
> > > > Otherwise MEMLOCK is really doubled..    
> > > 
> > > So this has been a problem for some time, but it's not as easy as adding them
> > > together, see [1][2] for a start.
> > > 
> > > The locked_vm/pinned_vm issue definitely needs fixing, but all this series is
> > > trying to do is account to the right counter.  
> 
> Thanks for taking a look, Alex.
> 
> > This still makes me nervous because we have userspace dependencies on
> > setting process locked memory.  
> 
> Could you please expand on this?  Trying to get more context.

VFIO is a userspace driver interface and the pinned/locked page
accounting we're doing here is trying to prevent a user from exceeding
their locked memory limits.  Thus a VM management tool or unprivileged
userspace driver needs to have appropriate locked memory limits
configured for their use case.  Currently we do not have a unified
accounting scheme, so if a page is mlock'd by the user and also mapped
through VFIO for DMA, it's accounted twice, these both increment
locked_vm and userspace needs to manage that.  If pinned memory
and locked memory are now two separate buckets and we're only comparing
one of them against the locked memory limit, then it seems we have
effectively doubled the user's locked memory for this use case, as
Jason questioned.  The user could mlock one page and DMA map another,
they're both "locked", but now they only take one slot in each bucket.

If we continue forward with using a separate bucket here, userspace
could infer that accounting is unified and lower the user's locked
memory limit, or exploit the gap that their effective limit might
actually exceed system memory.  In the former case, if we do eventually
correct to compare the total of the combined buckets against the user's
locked memory limits, we'll break users that have adapted their locked
memory limits to meet the apparent needs.  In the latter case, the
inconsistent accounting is potentially an attack vector.

> > There's a user visible difference if we
> > account for them in the same bucket vs separate.  Perhaps we're
> > counting in the wrong bucket now, but if we "fix" that and userspace
> > adapts, how do we ever go back to accounting both mlocked and pinned
> > memory combined against rlimit?  Thanks,  
> 
> PeterZ posted an RFC that addresses this point[1].  It kept pinned_vm and
> locked_vm accounting separate, but allowed the two to be added safely to be
> compared against RLIMIT_MEMLOCK.

Unless I'm incorrect in the concerns above, I don't see how we can
convert vfio before this occurs.
 
> Anyway, until some solution is agreed on, are there objections to converting
> locked_vm to an atomic, to avoid user-visible changes, instead of switching
> locked_vm users to pinned_vm?

Seems that as long as we have separate buckets that are compared
individually to rlimit that we've got problems, it's just a matter of
where they're exposed based on which bucket is used for which
interface.  Thanks,

Alex
