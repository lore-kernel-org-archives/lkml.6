Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52976C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 00:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D6B219E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 00:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D6B219E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeHLCwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 22:52:03 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:48961 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeHLCwD (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Sat, 11 Aug 2018 22:52:03 -0400
Received: from linux-l9pv.suse (124-11-22-254.static.tfn.net.tw [124.11.22.254])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Sun, 12 Aug 2018 02:16:01 +0200
Date:   Sun, 12 Aug 2018 08:15:45 +0800
From:   joeyli <jlee@suse.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Claim the resources of firmware enabled IOAPIC
 before children bus
Message-ID: <20180812001413.GC3570@linux-l9pv.suse>
References: <20180724110144.16442-1-jlee@suse.com>
 <20180806214807.GE30691@bhelgaas-glaptop.roam.corp.google.com>
 <20180808155318.GE13767@linux-l9pv.suse>
 <20180808212322.GF49411@bhelgaas-glaptop.roam.corp.google.com>
 <20180810092501.GP13767@linux-l9pv.suse>
 <20180810135837.GI113140@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810135837.GI113140@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 08:58:37AM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 10, 2018 at 05:25:01PM +0800, joeyli wrote:
> > On Wed, Aug 08, 2018 at 04:23:22PM -0500, Bjorn Helgaas wrote:
> > ...
[...snip]
> > hm... I have another question that it may not relates to this issue. I
> > was tracing the code path of PCI hot-remove/hotplug. Base on spec, looks
> > that the RST# should be asserted when hot-remove. And the memory decode
> > bit must be set to zero after RST# be asserted. But I didn't see that
> > any kernel PCI/ACPI code set RST#. The only possible code to set RST# is
> > in POWER architecture. Do you know who assert the RST# when hot-remove?    
> 
> RST# is a conventional PCI signal (not a PCIe signal).  In any case, I
> would expect signals like that to be handled by hardware, not by
> software.  What section of the spec are you looking at?  I wouldn't

In PCI Hot-Plug Spec v1.1

2.2.1 Hot Removal
The Hot-Plug System Driver uses the Hot-Plug Controller to do the following:
a) Assert RST# to the slot and isolate the slot from the rest of the bus, in
   either order.
b) Power down the slot.
c) Change the optional slot-state indicator, as defined in Section 3.1.1, to show
   that the slot is off.

In the above description, it said that "Hot-Plug System Driver" should done
the job. So I was think that kernel driver must asserts RST#, but I didn't
find that in kernel code.

Then, in PCI Local Bus spec v2.2, it mentions:

Table 6-1: Command Register Bits
Bit Location            Description
0                       ...State after RST# is 0.
1                       ...State after RST# is 0.

So, after hot-remove the RST# must be asserted and the IO/memory
decode bit should also be set to zero.

I was tracing the kerenl hot-remove code for RST# because I
want to make sure that kernel didn't change the RST# state from
firmware.

> expect any requirements for doing things to a device when the device
> is being hot-removed, since the device may already be inaccessible,
> e.g., physically unreachable.

I see! It makes sense.

But I still confused about the "Hot-Plug System Driver" wording in
PCI Hot-Plug Spec. The "Hot-Plug System Driver " means a kernel
driver?

> 
> On a hot-*add*, there would of course be requirements about how the
> device powers up and comes out of reset.  For native drivers like
> pciehp/shpcpd/etc, there are often ways for software to control power
> to the slot, e.g., the "Power Controller Control" bit in the PCIe Slot
> Control register.
> 
> For ACPI-mediated hotplug (as in your situation), the actual hardware
> details are handled by the firmware and all the OS sees are things
> like ACPI Notify events and it uses methods like _STA and other things
> mentioned in ACPI v6.2, sec 6.3.
> 
> > > What are the chances of getting a firmware fix?  Has this firmware
> > > already shipped to customers?
> > 
> > The good news is that the machine has not shipped yet. As I know
> > that manufacturer is also finding the root cause for why firmware
> > enabled memory decode bit and also set the wrong addresses.
> 
> I don't think it's necessarily a problem that firmware enables the
> IOAPIC.  This is ACPI-mediated hotplug and it looks like it adds CPUs,
> memory, and I/O.  I wouldn't be surprised if the firmware has to make
> the IOAPIC operational to make some parts of the hot-add work.
> 
> The address conflict is the real problem.

Thanks for your explanation. It's really useful to me.

Thanks a lot!
Joey Lee
