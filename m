Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6954EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424D82190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404525AbfBMRqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:46:19 -0500
Received: from foss.arm.com ([217.140.101.70]:58176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbfBMRqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:46:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCBFFA78;
        Wed, 13 Feb 2019 09:46:18 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 522783F675;
        Wed, 13 Feb 2019 09:46:17 -0800 (PST)
Date:   Wed, 13 Feb 2019 17:46:08 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrew.murray@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 1/2] asm-generic/io: Pass result on inX() accessor to
 __io_par()
Message-ID: <20190213174608.GA29100@fuggles.cambridge.arm.com>
References: <20190211174544.4302-1-will.deacon@arm.com>
 <20190211174544.4302-2-will.deacon@arm.com>
 <CAK8P3a1gmJTt+jdTbdSYZ0z43qodxf+co757K1-Hq1mj4fCqQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1gmJTt+jdTbdSYZ0z43qodxf+co757K1-Hq1mj4fCqQA@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:55:17PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 11, 2019 at 6:45 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > The inX() I/O accessors must enforce ordering against subsequent calls
> > to the delay() routines, so that a read-back from a device can be used
> > to postpone a subsequent write to the same device.
> >
> > On some architectures, including arm64, this ordering can only be
> > achieved by creating a dependency on the value returned by the inX()
> > operation, so we need to pass the value we read to the __io_par()
> > macro in this case.
> >
> > Reported-by: Andrew Murray <andrew.murray@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  include/asm-generic/io.h | 8 ++++----
> 
> For changing the asm-generic file in the arm64 tree,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks, Arnd.

> For all I can see, this should not conflict with the usage of the
> same macros on RISC-V, though it does make add a significant
> difference, so I'd like to see an Ack from the RISC-V folks as
> well (added to Cc), or possibly a change to arch/riscv/include/asm/io.h
> to do a corresponding change.

There's already a comment in that header which says that the accesses are
ordered wrt timer reads, so I don't think anything needs to change there.
For consistency with the macro arguments, I could augment their __io_par to
take the read value as an unused argument, if that's what you mean?

Will
