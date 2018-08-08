Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F0BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2189221766
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z56Aywdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2189221766
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeHHTmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbeHHTmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:42:53 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C07CC216F4;
        Wed,  8 Aug 2018 17:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533748934;
        bh=WbFLpkB48cWNNVo4a6UbymRHF8em7Fk2LnPG1R/+ya8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z56Aywdgc80wK8xLDOSSOwpj58RfC6lqkxt/jxtVGw0Szalv654+DCJbd3nCXZzz1
         8LDqb+273onexzn5S5LHp2fROgWqY/81F7aWtbzTiEn0NRjlBiVwH6DqFp8qt9ZOG1
         ALaDMZCfPI6Qb/Z41/afiMigpXxAdDbsrEUPgM/s=
Date:   Wed, 8 Aug 2018 12:22:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] arm64: PCI: Remove node-local allocations when
 initialising host controller
Message-ID: <20180808172211.GD49411@bhelgaas-glaptop.roam.corp.google.com>
References: <20180801173132.19739-1-punit.agrawal@arm.com>
 <38ad03ba-2658-98c8-1888-0aa3bfb59bd4@arm.com>
 <20180802143319.GA13512@red-moon>
 <CAErSpo5i7AAXq4vmfsH2WjheXpzzM1iaehdeM24eQZjzYY39Rg@mail.gmail.com>
 <87eff85364.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eff85364.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:44:03PM +0100, Punit Agrawal wrote:
> Bjorn Helgaas <bhelgaas@google.com> writes:
> > On Thu, Aug 2, 2018 at 9:33 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >> On Wed, Aug 01, 2018 at 02:38:51PM -0500, Jeremy Linton wrote:
> >>
> >> Jiang Liu does not work on the kernel anymore so we won't know
> >> anytime soon the reasoning behind commit 965cd0e4a5e5
> >>
> >> > On 08/01/2018 12:31 PM, Punit Agrawal wrote:
> >> > >Memory for host controller data structures is allocated local to the
> >> > >node to which the controller is associated with. This has been the
> >> > >behaviour since support for ACPI was added in
> >> > >commit 0cb0786bac15 ("ARM64: PCI: Support ACPI-based PCI host controller").
> >> >
> >> > Which was apparently influenced by:
> >> >
> >> > 965cd0e4a5e5 x86, PCI, ACPI: Use kmalloc_node() to optimize for performance
> >> >
> >> > Was there an actual use-case behind that change?
> >> >
> >> > I think this fixes the immediate boot problem, but if there is any
> >> > perf advantage it seems wise to keep it... Particularly since x86
> >> > seems to be doing the node sanitation in pci_acpi_root_get_node().
> >>
> >> I am struggling to see the perf advantage of allocating a struct
> >> that the PCI controller will never read/write from a NUMA node that
> >> is local to the PCI controller, happy to be corrected if there is
> >> a sound rationale behind that.
> >
> > If there is no reason to use kzalloc_node() here, we shouldn't use it.
> >
> > But we should use it (or not use it) consistently across arches.  I do
> > not believe there is an arch-specific reason to be different.
> > Currently, pci_acpi_scan_root() uses kzalloc_node() on x86 and arm64,
> > but kzalloc() on ia64.  They all ought to be the same.
> 
> From my understanding, arm64 use of kzalloc_node() was derived from the
> x86 version. Maybe somebody familiar with behaviour on x86 can provide
> input here.

If you want to remove use of kzalloc_node(), I'm fine with that as
long as you do it for x86 at the same time (maybe separate patches,
but at least in the same series).

I don't see any evidence in 965cd0e4a5e5 ("x86, PCI, ACPI: Use
kmalloc_node() to optimize for performance") that it actually improves
performance, so I'd be inclined to just use kzalloc().

Bjorn
