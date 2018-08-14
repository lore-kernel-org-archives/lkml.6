Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4C0C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFAD21734
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFAD21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbeHNSRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:17:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45086 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbeHNSRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:17:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3DB680D;
        Tue, 14 Aug 2018 08:29:52 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 943A03F5D0;
        Tue, 14 Aug 2018 08:29:52 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 39CAD1AE015E; Tue, 14 Aug 2018 16:29:59 +0100 (BST)
Date:   Tue, 14 Aug 2018 16:29:59 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Greg Hackmann <ghackmann@google.com>
Cc:     Greg Hackmann <ghackmann@android.com>,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Steve Capper <steve.capper@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        CHANDAN VN <chandan.vn@samsung.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()
Message-ID: <20180814152958.GD567@arm.com>
References: <20180813193013.236362-1-ghackmann@google.com>
 <20180814104041.GB28664@arm.com>
 <eb90a28e-893c-e02e-a9c2-1d988f08cf3a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb90a28e-893c-e02e-a9c2-1d988f08cf3a@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 08:17:48AM -0700, Greg Hackmann wrote:
> On 08/14/2018 03:40 AM, Will Deacon wrote:
> > Hi Greg,
> > 
> > On Mon, Aug 13, 2018 at 12:30:11PM -0700, Greg Hackmann wrote:
> >> ARM64's pfn_valid() shifts away the upper PAGE_SHIFT bits of the input
> >> before seeing if the PFN is valid.  This leads to false positives when
> >> some of the upper bits are set, but the lower bits match a valid PFN.
> >>
> >> For example, the following userspace code looks up a bogus entry in
> >> /proc/kpageflags:
> >>
> >>     int pagemap = open("/proc/self/pagemap", O_RDONLY);
> >>     int pageflags = open("/proc/kpageflags", O_RDONLY);
> >>     uint64_t pfn, val;
> >>
> >>     lseek64(pagemap, [...], SEEK_SET);
> >>     read(pagemap, &pfn, sizeof(pfn));
> >>     if (pfn & (1UL << 63)) {        /* valid PFN */
> >>         pfn &= ((1UL << 55) - 1);   /* clear flag bits */
> >>         pfn |= (1UL << 55);
> >>         lseek64(pageflags, pfn * sizeof(uint64_t), SEEK_SET);
> >>         read(pageflags, &val, sizeof(val));
> >>     }
> >>
> >> On ARM64 this causes the userspace process to crash with SIGSEGV rather
> >> than reading (1 << KPF_NOPAGE).  kpageflags_read() treats the offset as
> >> valid, and stable_page_flags() will try to access an address between the
> >> user and kernel address ranges.
> >>
> >> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> >> ---
> >>  arch/arm64/mm/init.c | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > Thanks, this looks like a sensible fix to me. Do you think it warrants a
> > CC stable?
> > 
> > Will
> 
> Yes, I think so.  Should I resend with a "Fixes" field?

Could do, but I think this goes all the way back to day 1! Doesn't arch/arm/
also suffer from the same issue?

Will
