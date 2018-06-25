Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A1C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1096325FDB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1096325FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964848AbeFYRxR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:53:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:47759 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934849AbeFYRxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:53:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 09D56AE90;
        Mon, 25 Jun 2018 17:53:15 +0000 (UTC)
Date:   Mon, 25 Jun 2018 19:53:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>
Subject: Re: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
Message-ID: <20180625175225.GQ28965@dhcp22.suse.cz>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
 <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de>
 <1529938470.14039.134.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529938470.14039.134.camel@hpe.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-06-18 14:56:26, Kani Toshimitsu wrote:
> On Sun, 2018-06-24 at 15:19 +0200, Thomas Gleixner wrote:
> > On Wed, 16 May 2018, Toshi Kani wrote:
> > 
> > > This series fixes two issues in the x86 ioremap free page handlings
> > > for pud/pmd mappings.
> > > 
> > > Patch 01 fixes BUG_ON on x86-PAE reported by Joerg.  It disables
> > > the free page handling on x86-PAE.
> > > 
> > > Patch 02-03 fixes a possible issue with speculation which can cause
> > > stale page-directory cache.
> > >  - Patch 02 is from Chintan's v9 01/04 patch [1], which adds a new arg
> > >    'addr', with my merge change to patch 01.
> > >  - Patch 03 adds a TLB purge (INVLPG) to purge page-structure caches
> > >    that may be cached by speculation.  See the patch descriptions for
> > >    more detal.
> > 
> > Toshi, Joerg, Michal!
> 
> Hi Thomas,
> 
> Thanks for checking. I was about to ping as well.
> 
> > I'm failing to find a conclusion of this discussion. Can we finally make
> > some progress with that?
> 
> I have not heard from Joerg since I last replied to his comments to
> Patch 3/3 -- I did my best to explain that there was no issue in the
> single page allocation in pud_free_pmd_page().  From my perspective, the
>  v3 series is good to go.

Well, I admit that this not my area but I agree with Joerg that
allocating memory inside afunction that is supposed to free page table
is far from ideal. More so that the allocation is hardcoded GFP_KERNEL.
We already have this antipattern in functions to allocate page tables
and it has turned to be maintenance PITA longterm. So if there is a way
around that then I would strongly suggest finding a different solution.

Whether that is sufficient to ditch the whole series is not my call
though.
-- 
Michal Hocko
SUSE Labs
