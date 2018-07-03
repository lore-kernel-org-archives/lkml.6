Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F424C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C8924791
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C8924791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeGCVCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:02:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45510 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbeGCVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:02:23 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faSRE-0002qH-Bh; Tue, 03 Jul 2018 23:02:16 +0200
Date:   Tue, 3 Jul 2018 23:02:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
cc:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with
 addr
In-Reply-To: <1530287995.14039.361.camel@hpe.com>
Message-ID: <alpine.DEB.2.21.1807032301140.1816@nanos.tec.linutronix.de>
References: <20180627141348.21777-1-toshi.kani@hpe.com>  <20180627141348.21777-3-toshi.kani@hpe.com>  <20180627155632.GH30631@arm.com> <1530115885.14039.295.camel@hpe.com>  <20180629122358.GC17859@arm.com> <1530287995.14039.361.camel@hpe.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018, Kani, Toshi wrote:
> On Fri, 2018-06-29 at 13:23 +0100, Will Deacon wrote:
> > Hi Toshi, Thomas,
> > 
> > On Wed, Jun 27, 2018 at 04:13:22PM +0000, Kani, Toshi wrote:
> > > On Wed, 2018-06-27 at 16:56 +0100, Will Deacon wrote:
> > > > On Wed, Jun 27, 2018 at 08:13:47AM -0600, Toshi Kani wrote:
> > > > > From: Chintan Pandya <cpandya@codeaurora.org>
> > > > > 
> > > > > The following kernel panic was observed on ARM64 platform due to a stale
> > > > > TLB entry.
> > > > > 
> > > > >  1. ioremap with 4K size, a valid pte page table is set.
> > > > >  2. iounmap it, its pte entry is set to 0.
> > > > >  3. ioremap the same address with 2M size, update its pmd entry with
> > > > >     a new value.
> > > > >  4. CPU may hit an exception because the old pmd entry is still in TLB,
> > > > >     which leads to a kernel panic.
> > > > > 
> > > > > Commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
> > > > > table") has addressed this panic by falling to pte mappings in the above
> > > > > case on ARM64.
> > > > > 
> > > > > To support pmd mappings in all cases, TLB purge needs to be performed
> > > > > in this case on ARM64.
> > > > > 
> > > > > Add a new arg, 'addr', to pud_free_pmd_page() and pmd_free_pte_page()
> > > > > so that TLB purge can be added later in seprate patches.
> > > > 
> > > > So I acked v13 of Chintan's series posted here:
> > > > 
> > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582953.html
> > > > 
> > > > any chance this lot could all be merged together, please?
> > > 
> > > Chintan's patch 2/3 and 3/3 apply cleanly on top of my series. Can you
> > > please coordinate with Thomas on the logistics?
> > 
> > Sure. I guess having this series on a common branch that I can pull into
> > arm64 and apply Chintan's other patches on top would work.
> > 
> > How does that sound?
> 
> Should this go thru -mm tree then?
> 
> Andrew, Thomas, what do you think? 

I just pick it up and provide Will a branch to pull that lot from.

Thanks,

	tglx
