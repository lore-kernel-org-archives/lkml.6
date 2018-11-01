Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F6AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3592081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3592081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeKARdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:33:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53030 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbeKARdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:33:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A0DE80D;
        Thu,  1 Nov 2018 01:31:24 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866623F557;
        Thu,  1 Nov 2018 01:31:23 -0700 (PDT)
Date:   Thu, 1 Nov 2018 09:31:21 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v8 1/9] KVM: arm/arm64: Ensure only THP is candidate for
 adjustment
Message-ID: <20181101083121.GG12057@e113682-lin.lund.arm.com>
References: <20181001155443.23032-1-punit.agrawal@arm.com>
 <20181001155443.23032-2-punit.agrawal@arm.com>
 <20181031143646.GE12057@e113682-lin.lund.arm.com>
 <87h8h2rwwr.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8h2rwwr.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 02:52:20PM +0000, Punit Agrawal wrote:
> Christoffer Dall <christoffer.dall@arm.com> writes:
> 
> > On Mon, Oct 01, 2018 at 04:54:35PM +0100, Punit Agrawal wrote:
> >> PageTransCompoundMap() returns true for hugetlbfs and THP
> >> hugepages. This behaviour incorrectly leads to stage 2 faults for
> >> unsupported hugepage sizes (e.g., 64K hugepage with 4K pages) to be
> >> treated as THP faults.
> >> 
> >> Tighten the check to filter out hugetlbfs pages. This also leads to
> >> consistently mapping all unsupported hugepage sizes as PTE level
> >> entries at stage 2.
> >> 
> >> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> >> Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
> >> Cc: Christoffer Dall <christoffer.dall@arm.com>
> >> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >> Cc: stable@vger.kernel.org # v4.13+
> >
> >
> > Hmm, this function is only actually called from user_mem_abort() if we
> > have (!hugetlb), so I'm not sure the cc stable here was actually
> > warranted, nor that this patch is strictly necessary.
> >
> > It doesn't hurt, and makes the code potentially more robust for the
> > future though.
> >
> > Am I missing something?
> 
> !hugetlb is only true for hugepage sizes supported at stage 2. The
> function also got called for unsupported hugepage size at stage 2, e.g.,
> 64k hugepage with 4k page size, which then ended up doing the wrong
> thing.
> 
> Hope that adds some context. I should've added this to the commit log.
> 

To be fair you did say that this was for unsupported hugepage sizes.

Thanks for the explanation.


    Christoffer
