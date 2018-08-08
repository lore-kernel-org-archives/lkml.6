Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EADAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD42921AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIoSCbxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD42921AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbeHHXoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730151AbeHHXoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:44:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE53B2151B;
        Wed,  8 Aug 2018 21:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533763404;
        bh=G89x0EyaYm5MK8K1ZQH85655WZeIwIyROSNc+A6xLZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIoSCbxXDKOdf6kPrU5My23Mr/23YioF3qf1HGqRI2STbJDPInXg6a9MYrTvx9oM1
         hGieXVON7iTZzjNENiqF7N+1VkD6p+l4eaHehc9SEdoFVqjRBE+D2FmORYkd48Vdt5
         bKsn+wBdSurxSYQ+GJEwviCAsrCCgtblJFStVw94=
Date:   Wed, 8 Aug 2018 16:23:22 -0500
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
Message-ID: <20180808212322.GF49411@bhelgaas-glaptop.roam.corp.google.com>
References: <20180724110144.16442-1-jlee@suse.com>
 <20180806214807.GE30691@bhelgaas-glaptop.roam.corp.google.com>
 <20180808155318.GE13767@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808155318.GE13767@linux-l9pv.suse>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:53:18PM +0800, joeyli wrote:
> Hi Bjorn,
> 
> First, thanks for your review!
> 
> On Mon, Aug 06, 2018 at 04:48:07PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 24, 2018 at 07:01:44PM +0800, Lee, Chun-Yi wrote:
> > > I got a machine that the resource of firmware enabled IOAPIC conflicts
> > > with the resource of a children bus when the PCI host bus be hotplug.
> > > 
> > > [ 3182.243325] PCI host bridge to bus 0001:40
> > > [ 3182.243328] pci_bus 0001:40: root bus resource [io  0xc000-0xdfff window]
> > > [ 3182.243330] pci_bus 0001:40: root bus resource [mem 0xdc000000-0xebffffff window]
> > > [ 3182.243331] pci_bus 0001:40: root bus resource [mem 0x212400000000-0x2125ffffffff window]
> > > [ 3182.243334] pci_bus 0001:40: root bus resource [bus 40-7e]
> > > ...
> > > [ 3182.244737] pci 0001:40:05.4: [8086:6f2c] type 00 class 0x080020
> > > [ 3182.244746] pci 0001:40:05.4: reg 0x10: [mem 0xdc000000-0xdc000fff]
> > > ...
> > > [ 3182.246697] pci 0001:40:02.0: PCI bridge to [bus 41]
> > > [ 3182.246702] pci 0001:40:02.0:   bridge window [mem 0xdc000000-0xdc7fffff]
> > > ...
> > > pci 0001:40:05.4: can't claim BAR 0 [mem 0xdc000000-0xdc000fff]: address conflict with PCI Bus 0001:41 [mem 0xdc000000-0xdc7fffff]
> > > 
> > > The bus topology:
> > > 
> > >  +-[0001:40]-+-02.0-[41]--
> > >  |           +-03.0-[41]--
> > >  |           +-03.2-[41]--+-00.0  Intel Corporation I350 Gigabit Network Connection
> > >  |           |            +-00.1  Intel Corporation I350 Gigabit Network Connection
> > >  |           |            +-00.2  Intel Corporation I350 Gigabit Network Connection
> > >  |           |            \-00.3  Intel Corporation I350 Gigabit Network Connection
> > >  |           +-05.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Map/VTd_Misc/System Management
> > >  |           +-05.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO Hot Plug
> > >  |           +-05.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO RAS/Control Status/Global Errors
> > >  |           \-05.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D I/O APIC
> > > 
> > > This problem causes that the NIC behine the child bus was not available
> > > after PCI host bridge hotpluged.
> > > 
> > > Kernel does not want to change resource of firmware enabled IOAPIC, but
> > > the priority of children bus's resources are higher than any other devices.
> > > So this conflict can not be handled by the reassigning logic of kernel.
> 
> Sorry for my description is not clear. The "priority" is for resources
> clamining, not for the address decoding.
> 
> > I don't understand this paragraph.  AFAIK, if two devices on a bus
> > both decode the same address, as the IOAPIC and the bridge do here,
> > the only real "priority" in PCI would be subtractive decode.  But I
> > don't think that applies here since the bridge is using a positive
> > decode window.
> 
> Sorry for I didn't understand... How could you know the bridge doesn't
> apply subtractive decode?

A subtractive decode bridge forwards anything appearing on its primary
bus to its secondary bus.  In conventional PCI, it only does this if
no other agent on the primary bus asserts DEVSEL# (PCI r3.0, sec
3.6.1).  In PCIe, the primary "bus" is a link and there's only one
device on it, so a subtractive decode bridge could forward anything it
sees.  If the subtractive decode bridge is part of a multi-function
device, I assume that multi-function device would have to determine
internally whether the subtractive decode bridge or another function
should claim the transaction.

Either way, a subtractive decode bridge can forward anything that
appears on its primary bus, so a subtractive decode window effectively
contains everything the upstream bridge passes down.  In this case you
have:

  pci_bus 0001:40: root bus resource [mem 0xdc000000-0xebffffff window]
  pci_bus 0001:40: root bus resource [mem 0x212400000000-0x2125ffffffff window]
  pci 0001:40:02.0: PCI bridge to [bus 41]
  pci 0001:40:02.0:   bridge window [mem 0xdc000000-0xdc7fffff]

The 40:02.0 bridge could see [mem 0xdc000000-0xebffffff] or [mem
0x212400000000-0x2125ffffffff] on its primary bus, so if it were a
subtractive decode bridge, its "window" would contain both of those
regions, and we should label them as "(subtractive decode)" in the
dmesg log.

Since [mem 0xdc000000-0xdc7fffff] is only part of the first root bus
resource, I infer that it must be a positively decoded window.
"lspci -vv" would tell you for sure.

> > I would expect that a read to the [mem 0xdc000000-0xdc000fff] range
> > would potentially receive two read completions, which would cause an
> > Unexpected Completion error.
> 
> Thanks for your information. The I350 NIC doesn't work after hotplug.
> So it may causes by Unexpected Completion error as you mentioned.
>  
> > Maybe you mean that we don't want to change the IOAPIC resources, but
> > it's OK if we move the bridge window, so in that sense, the IOAPIC is
> > "higher priority" than the bridge window?  This is the reverse of what
> > your paragraph seems to say.
> 
> Yes, this is what I mean. Sorry for my paragraph causes confusing. 
> 
> The memory decoder bit in the command register of 0001:40:05.4 IOAPIC
> is raised by firmware after hotplug. So kernel treats it as a
> _firmware enabled_ IOAPIC. Because kernel don't want to change the IOAPIC
> resources, so my patch try to claim the IOAPIC resources before all
> bridges. It can workaround the hotplug problem on issue machine.
> 
> But, actually I am not sure that this hacking makes sense. And, I also
> don't know why the memory decoder bit is raised by firmware when hotplug.
> Maybe this is a firmware problem.

That's a good point.  It's fine for firmware to enable the IOAPIC
memory decode.  But the address conflict:

  [ 3906.092119] pci 0001:40:05.4: reg 0x10: [mem 0xdc000000-0xdc000fff]
  [ 3906.093898] pci 0001:40:02.0: PCI bridge to [bus 41]
  [ 3906.093902] pci 0001:40:02.0:   bridge window [mem 0xdc000000-0xdc7fffff]

is not so fine.  That looks like a firmware bug to me.  These devices
should power up with zeroes in their BARs, so the addresses must have
been assigned by firmware before it sent the ACPI hotplug notification
to Linux.

In principle, Linux *should* be able to recover from that by moving
the IOAPIC or the bridge window, but obviously we don't.

What are the chances of getting a firmware fix?  Has this firmware
already shipped to customers?

> > > This patch claims the resources of firmware enabled IOAPIC before
> > > children bus. Then kernel gets a chance to reassign the resources of
> > > children bus to avoid the conflict.
> > 
> > Can you open a report at https://bugzilla.kernel.org, attach the
> > before and after dmesg logs, and include the URL in the commit log?
> 
> OK, I have filed a bug on kernel bugzilla and also attached dmesg
> log:
> 	https://bugzilla.kernel.org/show_bug.cgi?id=200765

Thanks.  Please include this URL in the changelog if you post an
updated patch.

Bjorn
