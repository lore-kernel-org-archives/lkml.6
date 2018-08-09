Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00EBC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6364E21A6D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6364E21A6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbeHIKz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:55:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50102 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbeHIKz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:55:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA13918A;
        Thu,  9 Aug 2018 01:31:43 -0700 (PDT)
Received: from localhost (e105922-lin.Emea.Arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E0E93F5D0;
        Thu,  9 Aug 2018 01:31:43 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH] arm64: PCI: Remove node-local allocations when initialising host controller
References: <20180801173132.19739-1-punit.agrawal@arm.com>
        <38ad03ba-2658-98c8-1888-0aa3bfb59bd4@arm.com>
        <20180802143319.GA13512@red-moon>
        <CAErSpo5i7AAXq4vmfsH2WjheXpzzM1iaehdeM24eQZjzYY39Rg@mail.gmail.com>
        <87eff85364.fsf@e105922-lin.cambridge.arm.com>
        <20180808172211.GD49411@bhelgaas-glaptop.roam.corp.google.com>
Date:   Thu, 09 Aug 2018 09:31:41 +0100
In-Reply-To: <20180808172211.GD49411@bhelgaas-glaptop.roam.corp.google.com>
        (Bjorn Helgaas's message of "Wed, 8 Aug 2018 12:22:11 -0500")
Message-ID: <871sb83pqq.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Wed, Aug 08, 2018 at 03:44:03PM +0100, Punit Agrawal wrote:
>> Bjorn Helgaas <bhelgaas@google.com> writes:
>> > On Thu, Aug 2, 2018 at 9:33 AM Lorenzo Pieralisi
>> > <lorenzo.pieralisi@arm.com> wrote:
>> >> On Wed, Aug 01, 2018 at 02:38:51PM -0500, Jeremy Linton wrote:
>> >>
>> >> Jiang Liu does not work on the kernel anymore so we won't know
>> >> anytime soon the reasoning behind commit 965cd0e4a5e5
>> >>
>> >> > On 08/01/2018 12:31 PM, Punit Agrawal wrote:
>> >> > >Memory for host controller data structures is allocated local to the
>> >> > >node to which the controller is associated with. This has been the
>> >> > >behaviour since support for ACPI was added in
>> >> > >commit 0cb0786bac15 ("ARM64: PCI: Support ACPI-based PCI host controller").
>> >> >
>> >> > Which was apparently influenced by:
>> >> >
>> >> > 965cd0e4a5e5 x86, PCI, ACPI: Use kmalloc_node() to optimize for performance
>> >> >
>> >> > Was there an actual use-case behind that change?
>> >> >
>> >> > I think this fixes the immediate boot problem, but if there is any
>> >> > perf advantage it seems wise to keep it... Particularly since x86
>> >> > seems to be doing the node sanitation in pci_acpi_root_get_node().
>> >>
>> >> I am struggling to see the perf advantage of allocating a struct
>> >> that the PCI controller will never read/write from a NUMA node that
>> >> is local to the PCI controller, happy to be corrected if there is
>> >> a sound rationale behind that.
>> >
>> > If there is no reason to use kzalloc_node() here, we shouldn't use it.
>> >
>> > But we should use it (or not use it) consistently across arches.  I do
>> > not believe there is an arch-specific reason to be different.
>> > Currently, pci_acpi_scan_root() uses kzalloc_node() on x86 and arm64,
>> > but kzalloc() on ia64.  They all ought to be the same.
>> 
>> From my understanding, arm64 use of kzalloc_node() was derived from the
>> x86 version. Maybe somebody familiar with behaviour on x86 can provide
>> input here.
>
> If you want to remove use of kzalloc_node(), I'm fine with that as
> long as you do it for x86 at the same time (maybe separate patches,
> but at least in the same series).
>
> I don't see any evidence in 965cd0e4a5e5 ("x86, PCI, ACPI: Use
> kmalloc_node() to optimize for performance") that it actually improves
> performance, so I'd be inclined to just use kzalloc().

Thanks for confirming.

I'm happy to add a patch updating x86 use of kzalloc_node() as
well. I'll post something once the merge window closes.

>
> Bjorn
