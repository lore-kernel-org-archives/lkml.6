Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754815AbeDYO40 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:56:26 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:54846 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754683AbeDYO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:56:11 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [RFC 0/2] dw_mmc: add multislot support
Thread-Topic: [RFC 0/2] dw_mmc: add multislot support
Thread-Index: AQHT1kU9JRWyVBt9pU2N/kM9u9RtRKQJJjwAgACLJYCABB5agIADm9GA
Date: Wed, 25 Apr 2018 13:53:38 +0000
Message-ID: <1524664417.18209.16.camel@synopsys.com>
References: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
         <CAPDyKFqxZLtx_=0UU9NgBnW0Vmw=456q2FFbMBK4LKEaF-ua7A@mail.gmail.com>
         <1524239609.10138.47.camel@synopsys.com>
         <CAPDyKFpY7JsQukY=E2PRg=iVfmis4i1kvST+b2wtshNc5Jn+jw@mail.gmail.com>
In-Reply-To: <CAPDyKFpY7JsQukY=E2PRg=iVfmis4i1kvST+b2wtshNc5Jn+jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.59]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD76B6655B65824D93BE5774FD60A5FB@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3PEuV5Q006849

On Mon, 2018-04-23 at 08:47 +0200, Ulf Hansson wrote:
> On 20 April 2018 at 17:53, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com> wrote:
> > Hi Ulf,
> > 
> > On Fri, 2018-04-20 at 09:35 +0200, Ulf Hansson wrote:
> > > [...]
> > > 
> > > > 
> > > > 2. Add missing stuff to support multislot mode in DesignWare MMC driver.
> > > >  * Add missing slot switch to __dw_mci_start_request() function.
> > > >  * Refactor set_ios function:
> > > >    a) Calculate common clock which is
> > > >       suitable for all slots instead of directly use clock value
> > > >       provided by mmc core. We calculate common clock as the minimum
> > > >       among each used slot clocks. This clock is calculated in
> > > >       dw_mci_calc_common_clock() function which is called
> > > >       from set_ios()
> > > >    b) Disable clock only if no other slots are ON.
> > > >    c) Setup clock directly in set_ios() only if no other slots
> > > >       are ON. Otherwise adjust clock in __dw_mci_start_request()
> > > >       function before slot switch.
> > > >    d) Move timings and bus_width setup to separate funcions.
> > > >  * Use timing field in each slot structure instead of common field in
> > > >    host structure.
> > > >  * Add locks to serialize access to registers.
> > > 
> > > Sorry, but this is a hack to *try* to make multi-slot work and this
> > > isn't sufficient. There were good reasons to why the earlier
> > > non-working multi slot support was removed from dw_mmc.
> > 
> > Previous multi slot implementation was removed as nobody used it and
> > nobody tested it. There are lots of mistakes in previous implementation
> > which are not related to request serialization
> > like lack of slot switch / lack of adding slot id to CIU commands / ets...
> > So obviously it was never tested and never used at real multi slot hardware.
> > 
> > > Let me elaborate a bit for your understanding. The core uses a host
> > > lock (mmc_claim|release_host()) to serialize operations and commands,
> > > as to confirm to the SD/SDIO/(e)MMC specs. The above changes gives no
> > > guarantees for this. To make that work, we would need a "mmc bus lock"
> > > to be managed by the core.
> > 
> > In current implementation data transfers and commands to different
> > hosts (slots) are serialized internally in the dw_mmc driver. We have
> > request queue and when .request() is called we add new request to the
> > queue. We take new request from the queue only if the previous one
> > has already finished.
> 
> That isn't sufficient. The core expects all calls to *any* of the host
> ops to be serialized for one host. It does so to conform to the specs.
> 
> For example it may call:
>  ->set_ios()
> ->request()
> ->set_ios()
> ->request()
> ->request()
> 

A bit remark for better understanding:

All card settings change are serialized too. These settings are applied
after slot switch before execution of new request for this slot.

So situations like calling any host_0 ops while another host (host_1) is active
are handled by current code.

This is example of simultaneous ops calls for both slots:

host (slot) 0    | host (slot) 1
-----------------------------------
h0->set_ios()    |    h1->set_ios()
h0->request()    |    h1->request()
h0->set_ios()    |    h1->set_ios()
h0->request()    |    h1->request()
h0->request()    |
h0->request()    |
h0->request()    |

How it will be serialized in the mmc driver:

h0->set_ios()   // h0 settings save
h1->set_ios()   // h1 settings save
h0->request()   // apply settings for h0 and do request
------ slot switch to h1 ------
h1->request()   // apply settings for h1 and do request
h0->set_ios()   // h0 settings save
h1->set_ios()   // h1 settings save
------ slot switch to h0 ------
h0->request()   // apply settings for h0 and do request
------ slot switch to h1 ------
h1->request()   // apply settings for h1 and do request
------ slot switch to h0 ------
h0->request()   // do request (no new settings to apply)
h0->request()   // do request (no new settings to apply)
h0->request()   // do request (no new settings to apply)

-- 
 Eugeniy Paltsev
