Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19487C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC89A20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfAIBf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:35:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:30801 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729067AbfAIBfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:35:25 -0500
X-UUID: 6270caafbefa46bdafaf1b4758890335-20190109
X-UUID: 6270caafbefa46bdafaf1b4758890335-20190109
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 346372565; Wed, 09 Jan 2019 09:35:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 09:35:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 9 Jan
 2019 09:35:17 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Jan 2019 09:35:17 +0800
Message-ID: <1546997717.20937.3.camel@mtkswgap22>
Subject: Re: [PATCH] arm64: trap illegal translations in __virt_to_phys()
From:   Miles Chen <miles.chen@mediatek.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 9 Jan 2019 09:35:17 +0800
In-Reply-To: <20190108121440.GC29102@lakrids.cambridge.arm.com>
References: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
         <20190107150019.GC46743@lakrids.cambridge.arm.com>
         <1546917883.6754.8.camel@mtkswgap22>
         <20190108121440.GC29102@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
X-TM-SNTS-SMTP: A3E3E476657A8AEA9A3F13BDF29E0B0E7871C13BB2A5D93DBCA9E749BAB92D162000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 12:14 +0000, Mark Rutland wrote:
> On Tue, Jan 08, 2019 at 11:24:43AM +0800, Miles Chen wrote:
> > On Mon, 2019-01-07 at 15:00 +0000, Mark Rutland wrote:
> > > On Mon, Jan 07, 2019 at 07:21:20PM +0800, Miles Chen wrote:
> > > > Current __virt_to_phys() only print warning messages for non-linear
> > > > addresses. It's hard to catch all warnings by those messages.
> > > 
> > > Why? Are you seeing a large number of warnings somewhere?
> > 
> > Official kernel works fine. I saw some cases in our internal branch and
> > we're fixing them.
> > 
> > > 
> > > > So add a VIRTUAL_BUG_ON() to trap all non-linear and non-symbol
> > > > addresses (e.g., stack addresses)
> > > > 
> > > > Tested by pass stack addresses and symbol addresses to __pa(). Result:
> > > > stack addresses: kernel BUG()
> > > 
> > > Either:
> > > 
> > > * Stacks are vmap'd, and __is_lm_address(stack_addr) is false. We'll
> > >   produce a WARNING() today (and return a junk physical address).
> > > 
> > > * Stacks are linear mapped, and cannot be distinguished from other
> > >   linear mapped addresses. The physical address will be valid.
> > > 
> > > ... so I don't understand why you need to change this.
> > 
> > For the first case: for vmap'd stack, __pa() returns a junk
> > physical address and it might be easier to debug this incorrect address
> > translation by a BUG() call instead of monitoring the warning log.
> 
> I think that's an argument for upgrading the existing WARN() to a BUG(),
> rather than adding a separate VIRTUAL_BUG_ON().
> 
> However, there are cases where the junk physical address is not used to
> perform an access, and the WARN() is more helpful.

got it.

> 
> You can set panic_on_warn to get an immediate panic() when the WARN()
> fires. Is there some reason that approach doesn't work for you?

panic_on_warn works fine. thanks for your comment.


cheers,
Miles

> 
> Thanks,
> Mark.


