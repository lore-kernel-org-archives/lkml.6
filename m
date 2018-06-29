Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B2DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DD027EDF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DD027EDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965750AbeF2MXX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:23:23 -0400
Received: from foss.arm.com ([217.140.101.70]:33398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965328AbeF2MXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:23:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FD9C80D;
        Fri, 29 Jun 2018 05:23:21 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E58533F266;
        Fri, 29 Jun 2018 05:23:20 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 549D81AE540D; Fri, 29 Jun 2018 13:23:59 +0100 (BST)
Date:   Fri, 29 Jun 2018 13:23:59 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with addr
Message-ID: <20180629122358.GC17859@arm.com>
References: <20180627141348.21777-1-toshi.kani@hpe.com>
 <20180627141348.21777-3-toshi.kani@hpe.com>
 <20180627155632.GH30631@arm.com>
 <1530115885.14039.295.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530115885.14039.295.camel@hpe.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Toshi, Thomas,

On Wed, Jun 27, 2018 at 04:13:22PM +0000, Kani, Toshi wrote:
> On Wed, 2018-06-27 at 16:56 +0100, Will Deacon wrote:
> > On Wed, Jun 27, 2018 at 08:13:47AM -0600, Toshi Kani wrote:
> > > From: Chintan Pandya <cpandya@codeaurora.org>
> > > 
> > > The following kernel panic was observed on ARM64 platform due to a stale
> > > TLB entry.
> > > 
> > >  1. ioremap with 4K size, a valid pte page table is set.
> > >  2. iounmap it, its pte entry is set to 0.
> > >  3. ioremap the same address with 2M size, update its pmd entry with
> > >     a new value.
> > >  4. CPU may hit an exception because the old pmd entry is still in TLB,
> > >     which leads to a kernel panic.
> > > 
> > > Commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
> > > table") has addressed this panic by falling to pte mappings in the above
> > > case on ARM64.
> > > 
> > > To support pmd mappings in all cases, TLB purge needs to be performed
> > > in this case on ARM64.
> > > 
> > > Add a new arg, 'addr', to pud_free_pmd_page() and pmd_free_pte_page()
> > > so that TLB purge can be added later in seprate patches.
> > 
> > So I acked v13 of Chintan's series posted here:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582953.html
> > 
> > any chance this lot could all be merged together, please?
> 
> Chintan's patch 2/3 and 3/3 apply cleanly on top of my series. Can you
> please coordinate with Thomas on the logistics?

Sure. I guess having this series on a common branch that I can pull into
arm64 and apply Chintan's other patches on top would work.

How does that sound?

Will
