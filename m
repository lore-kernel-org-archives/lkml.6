Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5861BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4D6206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfAHMOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:14:46 -0500
Received: from foss.arm.com ([217.140.101.70]:50010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbfAHMOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:14:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D0481596;
        Tue,  8 Jan 2019 04:14:45 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B61413F70D;
        Tue,  8 Jan 2019 04:14:43 -0800 (PST)
Date:   Tue, 8 Jan 2019 12:14:41 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] arm64: trap illegal translations in __virt_to_phys()
Message-ID: <20190108121440.GC29102@lakrids.cambridge.arm.com>
References: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
 <20190107150019.GC46743@lakrids.cambridge.arm.com>
 <1546917883.6754.8.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546917883.6754.8.camel@mtkswgap22>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 11:24:43AM +0800, Miles Chen wrote:
> On Mon, 2019-01-07 at 15:00 +0000, Mark Rutland wrote:
> > On Mon, Jan 07, 2019 at 07:21:20PM +0800, Miles Chen wrote:
> > > Current __virt_to_phys() only print warning messages for non-linear
> > > addresses. It's hard to catch all warnings by those messages.
> > 
> > Why? Are you seeing a large number of warnings somewhere?
> 
> Official kernel works fine. I saw some cases in our internal branch and
> we're fixing them.
> 
> > 
> > > So add a VIRTUAL_BUG_ON() to trap all non-linear and non-symbol
> > > addresses (e.g., stack addresses)
> > > 
> > > Tested by pass stack addresses and symbol addresses to __pa(). Result:
> > > stack addresses: kernel BUG()
> > 
> > Either:
> > 
> > * Stacks are vmap'd, and __is_lm_address(stack_addr) is false. We'll
> >   produce a WARNING() today (and return a junk physical address).
> > 
> > * Stacks are linear mapped, and cannot be distinguished from other
> >   linear mapped addresses. The physical address will be valid.
> > 
> > ... so I don't understand why you need to change this.
> 
> For the first case: for vmap'd stack, __pa() returns a junk
> physical address and it might be easier to debug this incorrect address
> translation by a BUG() call instead of monitoring the warning log.

I think that's an argument for upgrading the existing WARN() to a BUG(),
rather than adding a separate VIRTUAL_BUG_ON().

However, there are cases where the junk physical address is not used to
perform an access, and the WARN() is more helpful.

You can set panic_on_warn to get an immediate panic() when the WARN()
fires. Is there some reason that approach doesn't work for you?

Thanks,
Mark.
