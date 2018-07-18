Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D91FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286322075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286322075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeGRMnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:43:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:49492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbeGRMnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:43:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8E1FADCA;
        Wed, 18 Jul 2018 12:05:31 +0000 (UTC)
Date:   Wed, 18 Jul 2018 14:05:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     pasha.tatashin@oracle.com, dalias@libc.org,
        Jan Kara <jack@suse.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        daniel.m.jordan@oracle.com, Ingo Molnar <mingo@redhat.com>,
        fenghua.yu@intel.com, Jerome Glisse <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/14] mm: Asynchronous + multithreaded memmap init
 for ZONE_DEVICE
Message-ID: <20180718120529.GY7193@dhcp22.suse.cz>
References: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAGM2rea9AwQGaf1JiV_SDDKTKyP_n+dG9Z20gtTZEkuZPFnXFQ@mail.gmail.com>
 <CAPcyv4jo91jKjwn-M7cOhG=6vJ3c-QCyp0W+T+CtmiKGyZP1ng@mail.gmail.com>
 <CAGM2reacO1HF91yH8OR5w5AdZwPgwfSFfjDNBsHbP66v1rEg=g@mail.gmail.com>
 <20180717155006.GL7193@dhcp22.suse.cz>
 <CAA9_cmez_vrjBYvcpXT_5ziQ2CqRFzPbEWMO2kdmjW0rWhkaCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA9_cmez_vrjBYvcpXT_5ziQ2CqRFzPbEWMO2kdmjW0rWhkaCA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-07-18 10:32:32, Dan Williams wrote:
> On Tue, Jul 17, 2018 at 8:50 AM Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > Is there any reason that this work has to target the next merge window?
> > The changelog is not really specific about that.
> 
> Same reason as any other change in this space, hardware availability
> continues to increase. These patches are a direct response to end user
> reports of unacceptable init latency with current kernels.

Do you have any reference please?

> > There no numbers or
> > anything that would make this sound as a high priority stuff.
> 
> >From the end of the cover letter:
> 
> "With this change an 8 socket system was observed to initialize pmem
> namespaces in ~4 seconds whereas it was previously taking ~4 minutes."

Well, yeah, it sounds like a nice to have thing to me. 4 minutes doesn't
sounds excesive for a single init time operation. Machines are booting
tens of minutes these days...

> My plan if this is merged would be to come back and refactor it with
> the deferred_init_memmap() implementation, my plan if this is not
> merged would be to come back and refactor it with the
> deferred_init_memmap() implementation.

Well, my experience tells me that "refactor later" is rarely done.
Especially when it is not critical thing to do. There are so many other
things to go in the way to put that into back burner... So unless this
is abslutely critical to have fixed in the upcoming merge window then I
would much rather see a (reasonably) good solution from the begining.
-- 
Michal Hocko
SUSE Labs
