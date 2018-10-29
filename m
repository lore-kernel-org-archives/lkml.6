Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1FCC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBE92084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBE92084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeJ2Xhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:37:36 -0400
Received: from foss.arm.com ([217.140.101.70]:41624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeJ2Xhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:37:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0D68341;
        Mon, 29 Oct 2018 07:48:38 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19C9F3F71D;
        Mon, 29 Oct 2018 07:48:36 -0700 (PDT)
Date:   Mon, 29 Oct 2018 14:48:34 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     John Garry <john.garry@huawei.com>, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
Message-ID: <20181029144833.GB1835@brain-police>
References: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
 <20181029112504.GF14127@arm.com>
 <925009c6-226d-213f-dbcb-68b772d80a18@huawei.com>
 <20181029121638.GB15446@arm.com>
 <839acfc7-6b3a-b7ac-2f4a-713960ece457@huawei.com>
 <17e3006a-7ecd-968e-7e67-ea7d08858ec3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17e3006a-7ecd-968e-7e67-ea7d08858ec3@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 06:15:42PM +0530, Anshuman Khandual wrote:
> On 10/29/2018 06:02 PM, John Garry wrote:
> > On 29/10/2018 12:16, Will Deacon wrote:
> >> On Mon, Oct 29, 2018 at 12:14:09PM +0000, John Garry wrote:
> >>> On 29/10/2018 11:25, Will Deacon wrote:
> >>>> On Fri, Oct 26, 2018 at 09:57:47PM +0800, John Garry wrote:
> >>>>> Currently it is acceptable to set the distance between 2 separate nodes to
> >>>>> LOCAL_DISTANCE.
> >>>>>
> >>>>> Reject this as it is invalid.
> >>>>>
> >>>>> This change avoids a crash reported in [1].
> >>>>>
> >>>>> [1] https://www.spinics.net/lists/arm-kernel/msg683304.html
> >>>>>
> >>>>> Signed-off-by: John Garry <john.garry@huawei.com>
> >>>>>
> >>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> >>>>> index 146c04c..6092e3d 100644
> >>>>> --- a/arch/arm64/mm/numa.c
> >>>>> +++ b/arch/arm64/mm/numa.c
> >>>>> @@ -335,7 +335,8 @@ void __init numa_set_distance(int from, int to, int distance)
> >>>>>     }
> >>>>>
> >>>>>     if ((u8)distance != distance ||
> >>>>> -        (from == to && distance != LOCAL_DISTANCE)) {
> >>>>> +        (from == to && distance != LOCAL_DISTANCE) ||
> >>>>> +        (from != to && distance == LOCAL_DISTANCE)) {
> >>>>
> >>>> The current code here is more-or-less lifted from the x86 implementation
> >>>> of numa_set_distance().
> >>>
> >>> Right, I did notice this. I didn't think that x86 folks would be so
> >>> concerned since they generally only use ACPI, and the ACPI code already
> >>> validates these distances in drivers/acpi/numa.c: slit_valid() [unlike OF
> >>> code].
> >>>
> >>>  I think we should either factor out the sanity check
> >>>> into a core helper or make the core code robust to these funny configurations.
> >>>
> >>> OK, so to me it would make sense to factor out a sanity check into a core
> >>> helper.
> >>
> >> That, or have the OF code perform the same validation that slit_valid() is
> >> doing for ACPI. I'm just trying to avoid other architectures running into
> >> this problem down the line.
> >>
> > 
> > Right, OF code should do this validation job if ACPI is doing it
> > (especially since the DT bindings actually specify the distance rules),
> > and not rely on the arch NUMA code to accept/reject numa_set_distance()
> > combinations.
> 
> I would say this particular condition checking still falls under arch NUMA init
> code sanity check like other basic tests what numa_set_distance() currently does
> already but it should not be a necessity for the OF driver to check these. It can
> choose to check but arch NUMA should check basic things like two different NUMA
> nodes should not have LOCAL_DISTANCE as distance like in this case.
> 
> 	(from == to && distance != LOCAL_DISTANCE) ||
> 		(from != to && distance == LOCAL_DISTANCE))
> 
> 
> > 
> > And, in addition to this, I'd say OF should disable NUMA if given an
> > invalid table (like ACPI does).
> 
> Taking a decision to disable NUMA should be with kernel (arch NUMA) once kernel
> starts booting. Platform should have sent right values, OF driver trying to
> adjust stuff what platform has sent with FDT once the kernel starts booting is
> not right. For example "Kernel NUMA wont like the distance factors lets clean
> then up before passing on to MM". Disabling NUMA is one such major decision which
> should be with arch NUMA code not with OF driver.

I don't fully understand what you're getting at here, but why would the
check posted by John be arch-specific? It's already done in the core code
for ACPI, so there's a discrepancy between ACPI and FDT that should be
resolved. I'd also argue that the subtleties of this check are actually
based on what the core code is willing to accept in terms of the NUMA
description, so it's also the best place to enforce it.

Will
