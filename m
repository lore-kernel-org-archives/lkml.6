Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16566C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AFB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AFB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeIKQsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:48:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:57126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbeIKQs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:48:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 043BCAD7D;
        Tue, 11 Sep 2018 11:49:29 +0000 (UTC)
Date:   Tue, 11 Sep 2018 13:49:27 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Meelis Roos <mroos@linux.ee>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 32-bit PTI with THP = userspace corruption
Message-ID: <20180911114927.gikd3uf3otxn2ekq@suse.de>
References: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee>
 <20180830205527.dmemjwxfbwvkdzk2@suse.de>
 <alpine.LRH.2.21.1808310711380.17865@math.ut.ee>
 <20180831070722.wnulbbmillxkw7ke@suse.de>
 <alpine.DEB.2.21.1809081223450.1402@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809081223450.1402@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[
  Andrea, maybe you can have a quick look here too, please? Maybe I am
  overlooking a simple way to fix the issue. Problem description is
  below.
]

On Sat, Sep 08, 2018 at 12:24:10PM +0200, Thomas Gleixner wrote:
> > I'll try to reproduce and work on a fix.
> 
> Any progress on this?

Yes, but slower than I hoped because an infection sent me to bed for a
couple of days :/

So I can reproduce the issue, and the core problem is that with 32-bit
legacy paging the PGD level is also the huge-page level. This means that
we have two huge PTEs for every mapping and also two places where we
have to look for A/D bits. The problem now is that the kernel only looks
at the huge PTE in the kernel page-table when it evaluates A/D bits.
This causes data corruption when it misses an A/D bit.

I had a look into the THP and the HugeTLBfs code, and that is not
really easy to fix there. As I can see it now, there are a few options
to fix that, but most of them are ugly:

	1) Use Software A/D bits for 2-level legacy paging (ugly because
	   we need separate PAGE_* macros for that paging mode then)

	2) Update all the places in THP and HugeTLBfs code that
	   evaluate A/D bits to take both PTEs into account (ugly too
	   for obvious reasons)

	3) Disable THP and HugeTLBfs on 2-level paging kernels when PTI
	   is enabled (ugly because it breaks userspace expectations)

	4) Disable PTI support on 2-level paging by making it dependent
	   on CONFIG_X86_PAE. This is, imho, the least ugly option
	   because the machines that do not support PAE are most likely
	   too old to be affected my Meltdown anyway. We might also
	   consider switching i386_defconfig to PAE?

I am not a THP or HugeTLBfs expert and maybe I am overlooking a simpler
way to fix this issue. But as it stands now I am in favour for option
number 4.

Any other thoughts?

Thanks,

	Joerg
