Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeC0VTd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:19:33 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:44073 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeC0VTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:19:31 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Evgeniy.Didin@synopsys.com" <Evgeniy.Didin@synopsys.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: dma-mapping: clearing GFP_ZERO flag caused crashes of Ethernet
 on arc/hsdk board.
Thread-Topic: dma-mapping: clearing GFP_ZERO flag caused crashes of Ethernet
 on arc/hsdk board.
Thread-Index: AQHTxe7Y86AnIPeLoEWcNLwKgl2z76PkQKwAgAA0dwA=
Date: Tue, 27 Mar 2018 21:19:19 +0000
Message-ID: <1522185558.6917.7.camel@synopsys.com>
References: <1522170774.2593.9.camel@synopsys.com>
         <CAHp75VeZSsdR1=ZhOM6jseYCP3m0GyE=8EjJUxWosze9BBw9rQ@mail.gmail.com>
In-Reply-To: <CAHp75VeZSsdR1=ZhOM6jseYCP3m0GyE=8EjJUxWosze9BBw9rQ@mail.gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <64D7FDC862E9D24C95389F44BE802964@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2RLJdhw005946

Hi Andy,

On Tue, 2018-03-27 at 21:11 +0300, Andy Shevchenko wrote:
> On Tue, Mar 27, 2018 at 8:12 PM, Evgeniy Didin
> <Evgeniy.Didin@synopsys.com> wrote:
> > Hello,
> > 
> > After commit  57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in common code")  we noticed problems with Ethernet controller on one of our
> > platforms (namely ARC HSDK).
> > I
> > n particular we see that removal of __GFP_ZERO flag in function dma_alloc_attrs() was the culprit because in our implementation of arc_dma_alloc()
> > we only allocate zeroed pages if
> > that flag is explicitly set by the caller. Now with unconditional removal of that flag in dma_alloc_attrs() we allocate non-zeroed pages and that
> > seem to cause problems.
> > 
> > From
> > mentioned commit message I may conclude that architectural code is supposed to always allocate zeroed pages but I cannot find any requirement of
> > that in kernel's documentation.
> > Coul
> > d you please point me to that requirement if that exists at all, then we'll implement a fix in our arch code like that:
> 
> Can you elaborate what driver is in use?
> stmmac with dwmac-anarion?

It is indeed DW GMAC (AKA STMMAC) with built-in DMA.

> If so, this driver (w/o anarion parts, which I believe doesn't have
> anything to do with this) is widely used on other platforms.
> We have to see a lot of reports, though only one so far?
> 
> The logical question is why?

1. See that's another platform with ARC core so maybe in case of ARM
   DMA allocator already zeroes pages regardless provided flags -
   personally I didn't check that.

2. Even on HSDK we saw that only on attempt to run "iperf", even DHCP
   client works perfectly fine on that same platform so maybe others
   just don't see problems yet.

3. Who knows if RCs are being tested on other platforms with
   networking so maybe similar reports will start to appear once
   4.16 gets released.

-Alexey
