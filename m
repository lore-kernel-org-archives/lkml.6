Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B510C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1268220844
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y0z2NC55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1268220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeHIVoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbeHIVoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:44:46 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3531C21EF7;
        Thu,  9 Aug 2018 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533842313;
        bh=2oK23VnUlosCtJeNvW+VkfPdJLrgZyAlyQlcejLjHc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y0z2NC55e2p5SegVaREUbYmxwJ9VIfck5MDVBmeY6UTt/qQsarfk4OwKacewkIt6v
         Ye6C8EBwY2Hx3/fhWofS9t5epXgpB71d3i4GnDyX5cgHk6PyYRMRak+15g5lcldO56
         Il5Xr8cr0TQMQd7GFSwAvhLehvxCxU8cjWFjSSp8=
Date:   Thu, 9 Aug 2018 14:18:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Alex G." <mr.nuke.me@gmail.com>
Cc:     Alex_Gagniuc@Dellteam.com, bhelgaas@google.com,
        keith.busch@intel.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com,
        fred@fredlawl.com, poza@codeaurora.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
Message-ID: <20180809191832.GC113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <20180809141551.GH49411@bhelgaas-glaptop.roam.corp.google.com>
 <2cae6a5ac8324be18b8dcf3d7dfcc288@ausx13mps321.AMER.DELL.COM>
 <20180809182905.GA113140@bhelgaas-glaptop.roam.corp.google.com>
 <d235e71d-647f-00d1-8a21-2784b7939c25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d235e71d-647f-00d1-8a21-2784b7939c25@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 02:00:23PM -0500, Alex G. wrote:
> On 08/09/2018 01:29 PM, Bjorn Helgaas wrote:
> > On Thu, Aug 09, 2018 at 04:46:32PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> > > On 08/09/2018 09:16 AM, Bjorn Helgaas wrote:
> (snip_
> > > >     enable_ecrc_checking()
> > > >     disable_ecrc_checking()
> > > 
> > > I don't immediately see how this would affect FFS, but the bits are part
> > > of the AER capability structure. According to the FFS model, those would
> > > be owned by FW, and we'd have to avoid touching them.
> > 
> > Per ACPI v6.2, sec 18.3.2.4, the HEST may contain entries for Root
> > Ports that contain the FIRMWARE_FIRST flag as well as values the OS is
> > supposed to write to several AER capability registers.  It looks like
> > we currently ignore everything except the FIRMWARE_FIRST and GLOBAL
> > flags (ACPI_HEST_FIRMWARE_FIRST and ACPI_HEST_GLOBAL in Linux).
> > 
> > That seems like a pretty major screwup and more than I want to fix
> > right now.
> 
> The logic is not very clear, but I think it goes like this:
> For GLOBAL and FFS, disable native AER everywhere.
> When !GLOBAL and FFS, then only disable native AER for the root port
> described by the HEST entry.

I agree the code is convoluted, but that sounds right to me.

What I meant is that we ignore the values the HEST entry tells us
we're supposed to write to Device Control and the AER Uncorrectable
Error Mask, Uncorrectable Error Severity, Correctable Error Mask, and
AER Capabilities and Control.

> > > For practical considerations this is not an issue today. The ACPI error
> > > handling code currently crashes when it encounters any fatal error, so
> > > we wouldn't hit this in the FFS case.
> > 
> > I wasn't aware the firmware-first path was *that* broken.  Are there
> > problem reports for this?  Is this a regression?
> 
> It's been like this since, I believe, 3.10, and probably much earlier. All
> reports that I have seen of linux crashing on surprise hot-plug have been
> caused by the panic() call in the apei code. Dell BIOSes do an extreme
> amount of work to determine when it's safe to _not_ report errors to the OS,
> since all known OSes crash on this path.

Oh, is this the __ghes_panic() path?  If so, I'm going to turn away
and plead ignorance unless the PCI core is doing something wrong that
eventually results in that panic.
