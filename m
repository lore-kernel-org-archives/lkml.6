Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EB3460555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeFFPog (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:44:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42280 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752669AbeFFPoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:44:34 -0400
Date: Wed, 6 Jun 2018 16:45:06 +0100
From: Will Deacon <will.deacon@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marek Vasut <marek.vasut@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] PCI: rcar: Add bus notifier so we can limit the DMA
 range
Message-ID: <20180606154505.GJ6631@arm.com>
References: <20180521220514.30256-1-marek.vasut+renesas@gmail.com>
 <CAK8P3a1PZ_MfgEcvWdUbN-eCcs5Xo38LQ54imLc4kNtSKO9Txw@mail.gmail.com>
 <c2897d82-fe33-52cd-5aa6-3bddb478cb9f@gmail.com>
 <20180604223048.GC30381@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604223048.GC30381@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 05:30:48PM -0500, Bjorn Helgaas wrote:
> [+cc ARM64 folks, linux-kernel]
> 
> The original patch under discussion is:
> https://lkml.kernel.org/r/20180521220514.30256-1-marek.vasut+renesas@gmail.com
> 
> On Tue, May 22, 2018 at 11:52:21AM +0200, Marek Vasut wrote:
> > On 05/22/2018 10:10 AM, Arnd Bergmann wrote:
> > > On Tue, May 22, 2018 at 12:05 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > >> From: Phil Edworthy <phil.edworthy@renesas.com>
> > >>
> > >> The PCIe DMA controller on RCar Gen2 and earlier is on 32bit bus,
> > >> so limit the DMA range to 32bit.
> > >>
> > >> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > >> Cc: Arnd Bergmann <arnd@arndb.de>
> > >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > >> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > >> Cc: Simon Horman <horms+renesas@verge.net.au>
> > >> Cc: Wolfram Sang <wsa@the-dreams.de>
> > >> Cc: linux-renesas-soc@vger.kernel.org
> > >> To: linux-pci@vger.kernel.org
> > >> ---
> > >> NOTE: I'm aware of https://patchwork.kernel.org/patch/9495895/ , but the
> > >>       discussion seems to have gone way off, so I'm sending this as a
> > >>       RFC. Any feedback on how to do this limiting properly would be nice.
> > > 
> > > Doing it in the driver is clearly not appropriate, we must do this in
> > > common code. If I remember correctly, it's specifically ARM64 that is
> > > broken here, it incorrectly allows setting a DMA mask to 64 bit
> > > when that is not available.
> > 
> > Yep, that's correct. ARM64 with devices mapping tremendous amounts of
> > memory. So did anything change since that discussion references in the NOTE?

Is it specifically arm64 that's broken here? If so, why and how do other
archs (e.g. riscv) handle this? I thought all of this behaviour was driven
by the DMA ops, and we're just using generic code for that afaict.

Will
