Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A28C43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4B52087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="G8cCCh5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4B52087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJJGYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:24:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41790 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeJJGYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:24:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id m77-v6so1600051pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FewfyTptfb0s5WSxMs5n7Qg+lzyT+gQ20EJBgZ1FVkE=;
        b=G8cCCh5hWze45vvuvbeGbJa0fUcjUbW4JHg6w2ONchlbArSZM3b5Y/PYE5fXdeZCSi
         m5gNwXFfzh6JW1yUcM+d60p90DFzazhjzuGJzuVQ2leGDgKJ0mKTDwbqnnalDQjBw4QZ
         yqC0Pi5H9Jc/6U+C3f7/UAZPoA10Ae3cCbjsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FewfyTptfb0s5WSxMs5n7Qg+lzyT+gQ20EJBgZ1FVkE=;
        b=G9OPuOMTvWsh8RvyIKALjdMcN+ez19XK9Ha77h9Tf4gqaQbbJLjZgWacHC9G0TrCPh
         bhHO75m3GVuelMVHl/WSWkPyrW6fVE6GSFHn0GrisSwqCYgu0EpZvAQqNA/QiQBccwWY
         OD6RvbG7GkrhOtObtt0MZiiHXDACtwPtz2u632Cl9vorkUU/SO8Uhauv5bt/pFEa9xQB
         I2+lEfDiLwx+6BeID18TPqBsuLD65RtcMXi3XogelwDqnlmeOYF6hpUnU1Y6CyJFIFSF
         3g3S7vUmymiqOIZOcPFgmiUSWNAMkMlSAmlRSD1mw/CMKRKtHiYeYbrqnEXWHh2ZBLwR
         0tOw==
X-Gm-Message-State: ABuFfogIEXl2+F9Uh5bGGTIPMduAX5qVaIYlMvVHgID3SFgXmaI1i78v
        elZ4fERKsyRDToOUPbUSUN9Hbw==
X-Google-Smtp-Source: ACcGV610O/umbdEui0oxJe1FrFJaCK6us22JP7fSqfu5sYi9HqXMd9xU1FMV7ApHvN4eEkV/QWOedA==
X-Received: by 2002:a63:a012:: with SMTP id r18-v6mr28021289pge.282.1539126290226;
        Tue, 09 Oct 2018 16:04:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id h19-v6sm34439934pfk.71.2018.10.09.16.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 16:04:48 -0700 (PDT)
Date:   Tue, 9 Oct 2018 16:04:47 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, minchan@google.com, hughd@google.com,
        lokeshgidra@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
Message-ID: <20181009230447.GA17911@joelaf.mtv.corp.google.com>
References: <20181009201400.168705-1-joel@joelfernandes.org>
 <20181009220222.26nzajhpsbt7syvv@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009220222.26nzajhpsbt7syvv@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:02:22AM +0300, Kirill A. Shutemov wrote:
> On Tue, Oct 09, 2018 at 01:14:00PM -0700, Joel Fernandes (Google) wrote:
> > Android needs to mremap large regions of memory during memory management
> > related operations. The mremap system call can be really slow if THP is
> > not enabled. The bottleneck is move_page_tables, which is copying each
> > pte at a time, and can be really slow across a large map. Turning on THP
> > may not be a viable option, and is not for us. This patch speeds up the
> > performance for non-THP system by copying at the PMD level when possible.
> > 
> > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > 
> > Before:
> > Total mremap time for 1GB data: 242321014 nanoseconds.
> > Total mremap time for 1GB data: 196842467 nanoseconds.
> > Total mremap time for 1GB data: 167051162 nanoseconds.
> > 
> > After:
> > Total mremap time for 1GB data: 385781 nanoseconds.
> > Total mremap time for 1GB data: 388959 nanoseconds.
> > Total mremap time for 1GB data: 402813 nanoseconds.
> > 
> > Incase THP is enabled, the optimization is skipped. I also flush the
> > tlb every time we do this optimization since I couldn't find a way to
> > determine if the low-level PTEs are dirty. It is seen that the cost of
> > doing so is not much compared the improvement, on both x86-64 and arm64.
> 
> Okay. That's interesting.
> 
> It makes me wounder why do we pass virtual address to pte_alloc() (and
> pte_alloc_one() inside).
> 
> If an arch has real requirement to tight a page table to a virtual address
> than the optimization cannot be used as it is. Per-arch should be fine
> for this case, I guess.
> 
> If nobody uses the address we should just drop the argument as a
> preparation to the patch.

I couldn't find any use of the address. But I am wondering why you feel
passing the address is something that can't be done with the optimization.
The pte_alloc only happens if the optimization is not triggered.

Also the clean up of the argument that you're proposing is a bit out of scope
of this patch but yeah we could clean it up in a separate patch if needed. I
don't feel too strongly about that. It seems cosmetic and in the future if
the address that's passed in is needed, then the architecture can use it.

> Anyway, I think the optimization requires some groundwork before it can be
> accepted. At least some explanation why it is safe to move page table from
> one spot in virtual address space to another.

So I did go through several scenarios and its fine to my eyes. I tested
it too and couldn't find any issue. Could you describe your concern a bit
more? The mm->mmap_sem lock is held through out the mremap. Further we are
acquiring needed rmap locks if needed and the ptl locks of the old new
page-table pages. And this same path is already copying pmds for hugepages.

thanks,

 - Joel




