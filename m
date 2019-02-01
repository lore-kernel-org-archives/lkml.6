Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B20BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E8C20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="q1hrSLXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfBAKgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:36:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42574 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbfBAKgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:36:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so2986437pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 02:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uhkom3iqnvItF0jZsi6m64NpW6tX682P39uKYJE45o8=;
        b=q1hrSLXuKrwKROlbfOHMv33A06fTfMbHFppGpbqSq07bcLbhYfvn0j6oHdZ+cm8wQc
         w1eQtXQU8ZoXkMKTQeqzvLzins9aegVLw6AJnfZ7kWSQWSMq4qPrSUSMCPyUInquXuIk
         j3lZZiQr89aLDE2rFeypxjG2UFz7I89MDy4qHkTUpCwtMA5B3AWu1Y9NjEjjDYDOanTI
         g0KZ9ssRvyM6G7mpPCs6SxF0Jx91z7Wfsr+JnzCHJPbQSyDvK0rvocYRsbx8NONDuHQS
         ll5RDoJGzT4e9lOSAn/Iqm20KLkTpCqx3CHIrxANHi6+ZNwVMKVdQOxbrmp1M10O5Z1Z
         7cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uhkom3iqnvItF0jZsi6m64NpW6tX682P39uKYJE45o8=;
        b=p0GD0Xv79wZJoy+bi9XuqR6Hyk/KF2Duy+CfVE/HuU0ASWdR42Y1A7GDqCdL0vguyR
         SQfh82v754bzpkA4NzzFub+6R4UauTWgiWQ2UZuiDQ/RPy7jvX93JX6K3cGqE3OQDBdU
         ejXulXKViRNbxzkT6t1L6xrMAJf8pNbIQLX+KP21LYhSYixJGX4WJjwy8TkcIlhw1lnL
         vuB8gnfCRL5NNUoVynFKneBHtTbLppiqyQyhYOcXDJwazLORFULfZ3fUOZX2tZZLFo7X
         tHgExn7X2Cd67PG0FCtsazemaDR1fKvWrPhBctgRdahZybp008yUvLK9j5bOKLFaYOwe
         qilQ==
X-Gm-Message-State: AHQUAuZvY0mCCCP+HsF0llpHlf1RC2iJKsGimbjfz9n3ZEukz0mNGA0E
        Ls4S2O8/TZ7fs6edZo8daHj7ww==
X-Google-Smtp-Source: AHgI3IYrL1R1AmK6Gdg73yLBACHTGZEavh6ZfUk2TMbQCrVxoJLAzpglHmGNWR7bWNmG/k/9TCS7GA==
X-Received: by 2002:a63:1a4b:: with SMTP id a11mr1738952pgm.254.1549017365028;
        Fri, 01 Feb 2019 02:36:05 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id w128sm11080401pfw.79.2019.02.01.02.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 02:36:04 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A72DA30A67B; Fri,  1 Feb 2019 13:36:00 +0300 (+03)
Date:   Fri, 1 Feb 2019 13:36:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        luto@amacapital.net, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V4 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20190201103600.uflrwzgwj2tadhey@kshutemo-mobl1>
References: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
 <20190201092240.GB31498@hirez.programming.kicks-ass.net>
 <20190201100358.GD31552@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201100358.GD31552@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:03:58AM +0100, Peter Zijlstra wrote:
> On Fri, Feb 01, 2019 at 10:22:40AM +0100, Peter Zijlstra wrote:
> 
> > +static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> >  {
> > +	pgd_t *pgd;
> > +	p4d_t *p4d;
> > +	pud_t *pud;
> > +	pmd_t *pmd;
> > +
> > +	pgd = pgd_offset(mm, addr);
> > +	if (pgd_none(*pgd))
> > +		return 0;
> > +
> > +	p4d = p4d_offset(pgd, addr);
> > +	if (p4d_none(*p4d))
> > +		return 0;
> > +
> > +	if (p4d_large(*p4d));
> > +		return 1ULL << P4D_SHIFT;
> > +
> > +	if (!p4d_present(*p4d))
> > +		return 0;
> > +
> > +	pud = pud_offset(p4d, addr);
> > +	if (pud_none(*pud))
> > +		return 0;
> > +
> > +	if (pud_large(*pud))
> > +		return 1ULL << PUD_SHIFT;
> 
> Will just mentioned a lovely feature where some archs have multi entry
> large pages.
> 
> Possible something like:
> 
> 	if (pud_large(*pud)) {
> 		struct page *page = pud_page(*pud);
> 		int order = PUD_SHIFT;
> 
> 		if (PageHuge(page)) {
> 			page = compound_head(page);
> 			order += compound_order(page);
> 		}
> 
> 		return 1ULL << order;
> 	}
> 
> works correctly.

For more fun: some compound pages can be mapped withe page table entries
not matching it's compound size, i.e. 2M pages mapped with PTE.

-- 
 Kirill A. Shutemov
