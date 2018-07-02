Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F98C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321F4259E3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy8CO8Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321F4259E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeGBNQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbeGBNQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:16:47 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE07F2554C;
        Mon,  2 Jul 2018 13:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530537407;
        bh=EQtQ5zjO0PYyLcXBoFXZwtuz6izdEp0IvtpFf7Zzb1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cy8CO8VfYcW1s9aSjSkyRzWBRR2Hy3Dfz8pdfa6DIWycTNcwCMlhWJLB0nbk9cBhw
         sdCBXOTOYqYWIpluzdHCWRBwCHzxarZy6i/qJgcPImshccw4JGcjiSs0PW9dVVi5zf
         XGjjHeoqeZ8hJscl9Q2vuy9cIhK+iLURGpKlOBi8=
Date:   Mon, 2 Jul 2018 08:16:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex G <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] PCI/AER: Fix aerdrv loading with "pcie_ports=native"
 parameter
Message-ID: <20180702131645.GA15983@bhelgaas-glaptop.roam.corp.google.com>
References: <20180619195835.5423-1-mr.nuke.me@gmail.com>
 <20180630213140.GG9547@bhelgaas-glaptop.roam.corp.google.com>
 <fdc547c3-e4f7-4967-7216-9379e6d28139@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc547c3-e4f7-4967-7216-9379e6d28139@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 11:39:00PM -0500, Alex G wrote:
> On 06/30/2018 04:31 PM, Bjorn Helgaas wrote:
> > [+cc Borislav, linux-acpi, since this involves APEI/HEST]
> 
> Borislav is not the relevant maintainer here, since we're not contingent on
> APEI handling. I think Keith has a lot more experience with this part of the
> kernel.

Thanks for adding Keith.

> > On Tue, Jun 19, 2018 at 02:58:20PM -0500, Alexandru Gagniuc wrote:
> > > According to the documentation, "pcie_ports=native", linux should use
> > > native AER and DPC services. While that is true for the _OSC method
> > > parsing, this is not the only place that is checked. Should the HEST
> > > table list PCIe ports as firmware-first, linux will not use native
> > > services.
> > 
> > Nothing in ACPI-land looks at pcie_ports_native.  How should ACPI
> > things work in the "pcie_ports=native" case?  I guess we still have to
> > expect to receive error records from the firmware, because it may
> > certainly send us non-PCI errors (machine checks, etc) and maybe even
> > some PCI errors (even if the Linux AER driver claims AER interrupts,
> > we don't know what notification mechanisms the firmware may be using).
> 
> I think ACPI land shouldn't care about this. We care about it from the PCIe
> stand point at the interface with ACPI. FW might see a delta in the sense
> that we request control of some features via _OSC, which we otherwise would
> not do without pcie_ports=native.
> 
> > I guess best-case, we'll get ACPI error records for all non-PCI
> > things, and the Linux AER driver will see all the AER errors.
> 
> It might affect FW's ability to catch errors, but that's dependent on the
> root port implementation.
> 
> > Worst-case, I don't really know what to expect.  Duplicate reporting
> > of AER errors via firmware and Linux AER driver?  Some kind of
> > confusion about who acknowledges and clears them?
> 
> Once user enters pcie_ports=native, all bets are off: you broke the contract
> you have with the FW -- whether or not you have this patch.
> 
> > Out of curiosity, what is your use case for "pcie_ports=native"?
> > Presumably there's something that works better when using it, and
> > things work even *better* with this patch?
> 
> Corectness. It bothers me that actual behavior does not match the
> documentation:
> 
>  native  Use native PCIe services associated with PCIe ports
>                         unconditionally.
> 
> 
> > I know people do use it, because I often see it mentioned in forums
> > and bug reports, but I really don't expect it to work very well
> > because we're ignoring the usage model the firmware is designed
> > around.  My unproven suspicion is that most uses are in the black
> > magic category of "there's a bug here, and we don't know how to fix
> > it, but pcie_ports=native makes it work better".
> 
> There exist cases that firmware didn't consider. I would not call them
> "firmware bugs", but there are cases where the user understands the platform
> better than firmware.
> Example: on certain PCIe switches, a hardware PCIe error may bring the
> switch downstream ports into a state where they stop notifying hotplug
> events. Depending on the platform, firmware may or may not fix this
> condition, but "pcie_ports=native" enables DPC. DPC contains the error
> without the switch downstream port entering the weird error state in the
> first place.
> 
> All bets are off at this point.

If a user needs "pcie_ports=native", I claim that's a user experience
problem, and the underlying cause is a hardware, firmware, or OS
defect.

I have no doubt the situation you describe is real, but this doesn't
make any progress toward resolving the user experience problem.  In
fact, it propagates the folklore that using "pcie_ports=native" is an
appropriate final solution.  It's fine as a temporary workaround while
we figure out a better solution, but we need some mechanism for
analyzing the problem and eventually removing the need to use
"pcie_ports=native".

I have a minor comment on the patch, but I think it makes sense.  This
might be a good time to resurrect Prarit's "taint-on-pci-parameters"
patch.  If somebody uses "pcie_ports=native", I think it makes sense
to taint the kernel both because (1) we broke the contract with the
firmware and we don't really know what to expect, and (2) it's an
opportunity to encourage the user to raise a bug report.

Bjorn
