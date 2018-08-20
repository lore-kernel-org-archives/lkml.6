Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C91C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A45721722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A45721722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeHTRru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:47:50 -0400
Received: from muru.com ([72.249.23.125]:54216 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeHTRrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:47:49 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 35BA180AE;
        Mon, 20 Aug 2018 14:35:40 +0000 (UTC)
Date:   Mon, 20 Aug 2018 07:31:53 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh R <vigneshr@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: Re: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
Message-ID: <20180820143153.GD7523@atomide.com>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
 <454c277e-8a63-81cb-b341-a50f4e25cbea@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454c277e-8a63-81cb-b341-a50f4e25cbea@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [180808 06:35]:
> On Tuesday 05 June 2018 07:35 PM, Rob Herring wrote:
> > Really need 64-bit addresses and sizes? Use ranges to limit the
> > address space if possible.
> 
> We now have address-cells as <1>,
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am65.dtsi#n49
> 
> However each PCIe instance has 2 data regions and one of the regions
> (PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT1/PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT1 specified
> in the "MAIN Domain Memory Map" table of TRM http://www.ti.com/lit/pdf/spruid7)
> is above the 32bit region and requires 2 cells to specify the start address.
> This region is used to access MEM_SPACE of PCIe endpoint when operating in root
> complex mode and access memory of PCI root complex when operating in endpoint mode.
> 
> In order to describe this, should we change the address-cells back to <2> or do
> you suggest any other alternatives?

It's probably best to have the top level cbass interconnect use
#size-cells = <2> and then have it's child interconnects have
#size-cells = <1> if they don't need ranges above 4GB.

BTW, what's the difference between all these three similar PCIE
ranges?

PCIE0_CORE_CORE_DAT_SLV_PCIE_CORE 0x0005500000 0x0005600000 1 MB
PCIE1_CORE_CORE_DAT_SLV_PCIE_CORE 0x0005600000 0x0005700000 1 MB

PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT0 0x0010000000 0x0018000000 128 MB
PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT0 0x0018000000 0x0020000000 128 MB

PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT1 0x4000000000 0x4100000000 4 GB
PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT1 0x4100000000 0x4200000000 4 GB

Regards,

Tony
