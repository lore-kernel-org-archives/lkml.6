Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35665C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19AD20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19AD20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbeHAKzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:55:11 -0400
Received: from foss.arm.com ([217.140.101.70]:37958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387658AbeHAKzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:55:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3D1418A;
        Wed,  1 Aug 2018 02:10:25 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4F423F5B3;
        Wed,  1 Aug 2018 02:10:25 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id DC8F01AE3096; Wed,  1 Aug 2018 10:10:27 +0100 (BST)
Date:   Wed, 1 Aug 2018 10:10:27 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alex Bounine <alex.bou9@gmail.com>
Cc:     Alexei Colin <acolin@isi.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        John Paul Walters <jwalters@isi.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
Message-ID: <20180801091027.GC14438@arm.com>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu>
 <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
 <f2723578-f39d-27ac-b376-0f06905caa67@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2723578-f39d-27ac-b376-0f06905caa67@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 04:29:56PM -0400, Alex Bounine wrote:
> On 2018-07-31 08:54 AM, Alex Bounine wrote:
> >On 2018-07-31 04:41 AM, Will Deacon wrote:
> >>On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
> >>>Platforms with a PCI bus will be offered the RapidIO menu since they may
> >>>be want support for a RapidIO PCI device. Platforms without a PCI bus
> >>>that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> >>>in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> >>>
> >>>Tested that kernel builds for arm64 with RapidIO subsystem and
> >>>switch drivers enabled, also that the modules load successfully
> >>>on a custom Aarch64 Qemu model.
> >>>
> >>>Cc: Andrew Morton <akpm@linux-foundation.org>
> >>>Cc: Russell King <linux@armlinux.org.uk>
> >>>Cc: John Paul Walters <jwalters@isi.edu>
> >>>Cc: linux-arm-kernel@lists.infradead.org
> >>>Cc: linux-kernel@vger.kernel.org,
> >>>Signed-off-by: Alexei Colin <acolin@isi.edu>
> >>>---
> >>>  arch/arm64/Kconfig | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>
> >>Thanks, this looks much cleaner than before:
> >>
> >>Acked-by: Will Deacon <will.deacon@arm.com>
> >>
> >>The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
> >>unconditionally in the arm64 Kconfig. Does selecting only that option
> >>actually pull in new code to the build?
> >>
> >HAS_RAPIDIO option is intended for SOCs that have built in SRIO
> >controllers, like TI KeyStoneII or FPGAs. Because RapidIO subsystem core
> >is required during RapidIO port driver initialization, having separate
> >option allows us to control available build options for RapidIO core and
> >port driver (bool vs. tristate) and disable module option if port driver
> >is configured as built-in.
> 
> I am thinking about where HAS_RAPIDIO option can be set for arm64 branch.
> Having it set globally is too broad. For example we have Xilinx Zinq US
> board with SRIO IP on it. Having it globally in arm64 branch - bad. Probably
> having it set in drivers/soc/... is the best place.

Why is selecting HAS_RAPIDIO globally a bad thing to do? The way these
normally work is, if some subsystem requires arch support, then there's
an ARCH_HAS_xxxx option which the architecture selects when it implements
that support. Once you've enabled that, then that allows other sub-options
to be selected, such as specific drivers or what-not. Look at the Kconfig
files under drivers/soc/ -- you don't see anybody selecting ARCH_HAS_*
options.

Now, if HAS_RAPIDIO alone is pulling in a whole load of code to the build,
then it sounds like a misnomer.

Confused.

Will
