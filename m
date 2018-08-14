Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A95C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB3721729
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zO2jWW5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB3721729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeHNQqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbeHNQqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:46:02 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB018214C3;
        Tue, 14 Aug 2018 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534255125;
        bh=vmGpebWWGcdygtkfwxtYgfCpkmm1u7z9WAzJb5/UMpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zO2jWW5PnTP6cW45J4oPpy+3sYpIxiRgYsaIezWLDMTVv22P5u+bzpVZM/LG/dIXd
         tSB83I83NFxZCdMqVNnMFohZNRPr3TyHRH5FzV57MX9eDTCzuM0RrlLAcDzIhPO7B6
         mRSK2kFr3wDpCXGSBQzrtuHS8ZaJXF9kWtqvkM2Q=
Date:   Tue, 14 Aug 2018 08:58:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        linux-pci@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: sb_edac.c lacks PCI domain support?
Message-ID: <20180814135843.GA149076@bhelgaas-glaptop.roam.corp.google.com>
References: <20180808200747.GA219159@bhelgaas-glaptop.roam.corp.google.com>
 <3908561D78D1C84285E8C5FCA982C28F7D3A370D@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D3A370D@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Mizuma-san, linux-pci]

On Wed, Aug 08, 2018 at 08:18:03PM +0000, Luck, Tony wrote:
> > I think sb_edac.c (and probably other EDAC stuff) lacks PCI domain
> > support
> 
> There's a patch queued to fix this.
> 
>   https://marc.info/?l=linux-edac&m=153256485215534&w=2

That's excellent, thank you!

i7core_edac.c also looks suspicious because it manages things based on
"socket", which is computed from a PCI bus number, and doesn't
reference the PCI domain at all:

  bus = pdev->bus->number;
  socket = last_bus - bus;
  alloc_i7core_dev(socket, ...);

> > It looks like 88ae80aa609c ("EDAC, skx_edac: Handle systems with
> > segmented PCI busses") fixes a similar problem; maybe that should
> > be applied elsewhere in EDAC as well?
> >
> > Why doesn't EDAC use the standard pci_register_driver() interface?
> > That would avoid issues like this.  It would also avoid the potential
> > conflict of another driver operating on the device at the same time.
> 
> EDAC drivers get information to translate system physical addresses
> to DIMM addresses from a whole bundle of different PCIe devices config
> space.  Connections between different parts of the translation algorithm
> depend on finding the devices that belong to the same memory controller
> by matching up bus numbers (actually <segment,busnumber> tuples as
> we are now finding).
> 
> Can pci_register_driver() cope with this odd usage?

pci_register_driver() can bind a driver to as many devices as desired.
It would be up to the driver to keep track of all its devices and
match them up by <segment,busnumber>.  But I think the drivers keep
track of all that already.

The biggest problem would probably be the fact that it couldn't depend
on being bound to devices in any given order.  It might have to check
to see whether it has found all the devices it expects, or maybe
become a little resilient to having errors reported when it doesn't
have all the information it needs to decode them.

Bjorn
