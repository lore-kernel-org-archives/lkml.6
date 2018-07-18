Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8764BECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409A22075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409A22075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbeGRViR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:38:17 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53838 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRViR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:38:17 -0400
Received: from [2620:10d:c091:200::3:15a3] (helo=[IPv6:2620:10d:c0a3:10fb:4c:7ee9:b6e2:d1d5])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fftWo-0001UX-Ok; Wed, 18 Jul 2018 16:58:30 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
From:   Rik van Riel <riel@surriel.com>
In-Reply-To: <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
Date:   Wed, 18 Jul 2018 16:58:28 -0400
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com>
References: <20180716190337.26133-1-riel@surriel.com>
 <20180716190337.26133-5-riel@surriel.com>
 <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 17, 2018, at 4:04 PM, Andy Lutomirski <luto@kernel.org> wrote:
> 
> 
> I think you've introduced a minor-ish performance regression due to
> changing the old (admittedly terribly documented) control flow a bit.
> Before, if real_prev == next, we would skip:
> 
> load_mm_cr4(next);
> switch_ldt(real_prev, next);
> 
> Now we don't any more.  I think you should reinstate that
> optimization.  It's probably as simple as wrapping them in an if
> (real_priv != next) with a comment like /* Remote changes that would
> require a cr4 or ldt reload will unconditionally send an IPI even to
> lazy CPUs.  So, if we aren't changing our mm, we don't need to refresh
> cr4 or the ldt */

Looks like switch_ldt already skips reloading the LDT when prev equals
next, or when they simply have the same LDT values:

        if (unlikely((unsigned long)prev->context.ldt |
                     (unsigned long)next->context.ldt))
                load_mm_ldt(next);

It appears that the cr4 bits have a similar optimization:

static inline void cr4_set_bits(unsigned long mask)
{
        unsigned long cr4, flags;

        local_irq_save(flags);
        cr4 = this_cpu_read(cpu_tlbstate.cr4);
        if ((cr4 | mask) != cr4)
                __cr4_set(cr4 | mask);
        local_irq_restore(flags);
}

> 
> Hmm.  load_mm_cr4() should bypass itself when mm == &init_mm.  Want to
> fix that part or should I?
> 
Looks like there might not be anything to do here, after all.

On to the lazy TLB mm_struct refcounting stuff :)

