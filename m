Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E926C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750D220870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfAVGKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:10:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVGKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:10:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BEB1811D6;
        Tue, 22 Jan 2019 06:10:47 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 569EC60922;
        Tue, 22 Jan 2019 06:10:40 +0000 (UTC)
Date:   Tue, 22 Jan 2019 14:10:37 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 02/24] mm: userfault: return VM_FAULT_RETRY on signals
Message-ID: <20190122061037.GA14907@xz-x1>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-3-peterx@redhat.com>
 <20190121154017.GA3711@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121154017.GA3711@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 22 Jan 2019 06:10:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:40:18AM -0500, Jerome Glisse wrote:
> On Mon, Jan 21, 2019 at 03:57:00PM +0800, Peter Xu wrote:
> > There was a special path in handle_userfault() in the past that we'll
> > return a VM_FAULT_NOPAGE when we detected non-fatal signals when waiting
> > for userfault handling.  We did that by reacquiring the mmap_sem before
> > returning.  However that brings a risk in that the vmas might have
> > changed when we retake the mmap_sem and even we could be holding an
> > invalid vma structure.  The problem was reported by syzbot.
> 
> This is confusing this should be a patch on its own ie changes to
> fs/userfaultfd.c where you remove that path.

Sure I will.

> 
> > 
> > This patch removes the special path and we'll return a VM_FAULT_RETRY
> > with the common path even if we have got such signals.  Then for all the
> > architectures that is passing in VM_FAULT_ALLOW_RETRY into
> > handle_mm_fault(), we check not only for SIGKILL but for all the rest of
> > userspace pending signals right after we returned from
> > handle_mm_fault().
> > 
> > The idea comes from the upstream discussion between Linus and Andrea:
> > 
> >   https://lkml.org/lkml/2017/10/30/560
> > 
> > (This patch contains a potential fix for a double-free of mmap_sem on
> >  ARC architecture; please see https://lkml.org/lkml/2018/11/1/723 for
> >  more information)
> 
> This patch should only be about changing the return to userspace rule.
> Before this patch the arch fault handler returned to userspace only
> for fatal signal, after this patch it returns to userspace for any
> signal.

Ok.  I'll make the first patch to do the signal changes, then the
second patch to remove the userfault path explicitly.

> 
> It would be a lot better to have a fix for arc as a separate patch so
> that we can focus on reviewing only one thing.

I just noticed that it was fixed just a few days ago in commit
4d447455e73b.  Then I'll just simply rebase to Linus master and use
the upstream fix, then I can drop this paragraph.

Thanks for the review!

-- 
Peter Xu
