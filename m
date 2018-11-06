Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C42C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E5E2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E5E2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeKFM0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:26:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbeKFM0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:26:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 778CA58A5C;
        Tue,  6 Nov 2018 03:03:52 +0000 (UTC)
Received: from xz-x1 (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F058116D5B;
        Tue,  6 Nov 2018 03:03:48 +0000 (UTC)
Date:   Tue, 6 Nov 2018 11:03:46 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH RFC] mm: arc: fix potential double realease of mmap_sem
Message-ID: <20181106030346.GI7804@xz-x1>
References: <20181101032354.19351-1-peterx@redhat.com>
 <C2D7FE5348E1B147BCA15975FBA23075013A590E5E@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075013A590E5E@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 06 Nov 2018 03:03:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 12:48:31AM +0000, Vineet Gupta wrote:
> On 10/31/18 8:24 PM, Peter Xu wrote:
> > In do_page_fault() of ARC we have:
> >
> >         ...
> > 	fault = handle_mm_fault(vma, address, flags);
> >
> >         /* If Pagefault was interrupted by SIGKILL, exit page fault "early" */
> >         if (unlikely(fatal_signal_pending(current))) {
> >                 if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY))
> >                         up_read(&mm->mmap_sem);     <---------------- [1]
> >                 if (user_mode(regs))
> >                         return;
> >         }
> >         ...
> > 	if (likely(!(fault & VM_FAULT_ERROR))) {
> >                 ...
> > 		return;
> > 	}
> >
> > 	if (fault & VM_FAULT_OOM)
> > 		goto out_of_memory;                <----------------- [2]
> > 	else if (fault & VM_FAULT_SIGSEGV)
> > 		goto bad_area;                     <----------------- [3]
> > 	else if (fault & VM_FAULT_SIGBUS)
> > 		goto do_sigbus;                    <----------------- [4]
> >
> > Logically it's possible that we might try to release the mmap_sem twice
> > by having a scenario like:
> >
> >         - task received SIGKILL,
> >         - task handled kernel mode page fault,
> >         - handle_mm_fault() returned with one of VM_FAULT_ERROR,
> >
> > Then we'll go into path [1] to release the mmap_sem, however we won't
> > return immediately since user_mode(regs) check will fail (a kernel page
> > fault).  Then we might go into either [2]-[4] and either of them will
> > try to release the mmap_sem again.
> >
> > To fix this, we only release the mmap_sem at [1] when we're sure we'll
> > quit immediately (after we checked with user_mode(regs)).
> 
> Hmm, do_page_fault() needs a serious makeover. There's a known problem in the area
> you touched (with test case) where we fail to relinquish the mmap_sem for which
> Alexey had provided a fix. But I'm going to redo this part now and CC you folks
> for review. OK ?

Fine with me.  Thanks,

-- 
Peter Xu
