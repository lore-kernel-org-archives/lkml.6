Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEFBC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA54217B7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/dAvLES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA54217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbeHMV2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730225AbeHMV2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:28:45 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39ABD2175A;
        Mon, 13 Aug 2018 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534185919;
        bh=+Illrr5jh/iRRSNwV6qRhodjs5SaQKGxdOQMPOy8Dc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/dAvLESRgH1t1o0YcUFXFsDIKNGeMoy+ymIDSDqWfW7p+gJnRLHgT7F2rVVNtlJX
         bK7jsvn+ZG9Wof6Ix+fK7v83gKZ5R6z3Iwj6kZLxW4xkN7Y+b9ZaotNSARnHzTJe7r
         aeqD5+TgliAajAdHk5YneZ4Ly0kZVUpIR+2Ox1XA=
Date:   Mon, 13 Aug 2018 13:45:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     joeyli <jlee@suse.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Claim the resources of firmware enabled IOAPIC
 before children bus
Message-ID: <20180813184516.GL113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180724110144.16442-1-jlee@suse.com>
 <20180806214807.GE30691@bhelgaas-glaptop.roam.corp.google.com>
 <20180808155318.GE13767@linux-l9pv.suse>
 <20180808212322.GF49411@bhelgaas-glaptop.roam.corp.google.com>
 <20180810092501.GP13767@linux-l9pv.suse>
 <20180810135837.GI113140@bhelgaas-glaptop.roam.corp.google.com>
 <20180812001413.GC3570@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812001413.GC3570@linux-l9pv.suse>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 08:15:45AM +0800, joeyli wrote:
> On Fri, Aug 10, 2018 at 08:58:37AM -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 10, 2018 at 05:25:01PM +0800, joeyli wrote:
> > > On Wed, Aug 08, 2018 at 04:23:22PM -0500, Bjorn Helgaas wrote:
> > > ...
> [...snip]
> > > hm... I have another question that it may not relates to this issue. I
> > > was tracing the code path of PCI hot-remove/hotplug. Base on spec, looks
> > > that the RST# should be asserted when hot-remove. And the memory decode
> > > bit must be set to zero after RST# be asserted. But I didn't see that
> > > any kernel PCI/ACPI code set RST#. The only possible code to set RST# is
> > > in POWER architecture. Do you know who assert the RST# when hot-remove?    
> > 
> > RST# is a conventional PCI signal (not a PCIe signal).  In any case, I
> > would expect signals like that to be handled by hardware, not by
> > software.  What section of the spec are you looking at?  I wouldn't
> 
> In PCI Hot-Plug Spec v1.1
> 
> 2.2.1 Hot Removal
> The Hot-Plug System Driver uses the Hot-Plug Controller to do the following:
> a) Assert RST# to the slot and isolate the slot from the rest of the bus, in
>    either order.
> b) Power down the slot.
> c) Change the optional slot-state indicator, as defined in Section 3.1.1, to show
>    that the slot is off.
> 
> In the above description, it said that "Hot-Plug System Driver" should done
> the job. So I was think that kernel driver must asserts RST#, but I didn't
> find that in kernel code.

I don't think there's much in that spec that's still relevant unless
you are using conventional PCI.  Most current hardware would be using
PCIe, and the PCIe spec itself covers hotplug (PCIe r4.0, sec 6.7).

Prior to PCIe, hotplug wasn't directly included in the PCI spec, and
there were several varieties of hotplug controllers (SHPC, Compaq
hotplug controller, IBM hotplug controller, CompactPCI, etc.)

The PCI Hot-Plug spec covers the high-level model but doesn't have the
details of any of these controllers.  There is a separate spec for the
SHPC ("PCI Standard Hot-Plug Controller and Subsystem Specification",
r1.0, June 20, 2001), which does talk about requirements for RST#.
But even there I don't see a way for software to directly control
RST#; it looks like software programs the Slot Control Logic, which in
turn manages RST# based on commands from the software and hardware
inputs like presence detect.

> Then, in PCI Local Bus spec v2.2, it mentions:
> 
> Table 6-1: Command Register Bits
> Bit Location            Description
> 0                       ...State after RST# is 0.
> 1                       ...State after RST# is 0.
> 
> So, after hot-remove the RST# must be asserted and the IO/memory
> decode bit should also be set to zero.
> 
> I was tracing the kerenl hot-remove code for RST# because I
> want to make sure that kernel didn't change the RST# state from
> firmware.
> ...

> But I still confused about the "Hot-Plug System Driver" wording in
> PCI Hot-Plug Spec. The "Hot-Plug System Driver " means a kernel
> driver?

I would interpret "Hot-Plug System Driver" to refer to one of the
kernel PCI hotplug drivers (pciehp, shpcpd, cpqphp, ibmphp, etc.)

Bjorn
