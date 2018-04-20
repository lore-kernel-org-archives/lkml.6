Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755896AbeDTPxg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:53:36 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:35538 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755664AbeDTPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:53:34 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>
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
Thread-Index: AQHT1kU9JRWyVBt9pU2N/kM9u9RtRKQJJjwAgACLJYA=
Date: Fri, 20 Apr 2018 15:53:30 +0000
Message-ID: <1524239609.10138.47.camel@synopsys.com>
References: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
         <CAPDyKFqxZLtx_=0UU9NgBnW0Vmw=456q2FFbMBK4LKEaF-ua7A@mail.gmail.com>
In-Reply-To: <CAPDyKFqxZLtx_=0UU9NgBnW0Vmw=456q2FFbMBK4LKEaF-ua7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.53]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E79426BD2A16D41A85A936916640BBD@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KFrfuX003749

Hi Ulf,

On Fri, 2018-04-20 at 09:35 +0200, Ulf Hansson wrote:
> [...]
> 
> > 
> > 2. Add missing stuff to support multislot mode in DesignWare MMC driver.
> >  * Add missing slot switch to __dw_mci_start_request() function.
> >  * Refactor set_ios function:
> >    a) Calculate common clock which is
> >       suitable for all slots instead of directly use clock value
> >       provided by mmc core. We calculate common clock as the minimum
> >       among each used slot clocks. This clock is calculated in
> >       dw_mci_calc_common_clock() function which is called
> >       from set_ios()
> >    b) Disable clock only if no other slots are ON.
> >    c) Setup clock directly in set_ios() only if no other slots
> >       are ON. Otherwise adjust clock in __dw_mci_start_request()
> >       function before slot switch.
> >    d) Move timings and bus_width setup to separate funcions.
> >  * Use timing field in each slot structure instead of common field in
> >    host structure.
> >  * Add locks to serialize access to registers.
> 
> Sorry, but this is a hack to *try* to make multi-slot work and this
> isn't sufficient. There were good reasons to why the earlier
> non-working multi slot support was removed from dw_mmc.

Previous multi slot implementation was removed as nobody used it and
nobody tested it. There are lots of mistakes in previous implementation
which are not related to request serialization
like lack of slot switch / lack of adding slot id to CIU commands / ets...
So obviously it was never tested and never used at real multi slot hardware.

> Let me elaborate a bit for your understanding. The core uses a host
> lock (mmc_claim|release_host()) to serialize operations and commands,
> as to confirm to the SD/SDIO/(e)MMC specs. The above changes gives no
> guarantees for this. To make that work, we would need a "mmc bus lock"
> to be managed by the core.

In current implementation data transfers and commands to different
hosts (slots) are serialized internally in the dw_mmc driver. We have
request queue and when .request() is called we add new request to the
queue. We take new request from the queue only if the previous one
has already finished.

So although hosts (slots) have separate locks (mmc_claim|release_host())
the requests to different slots are serialized by driver.

Isn't that enough?
I'm not very familiar with SD/SDIO/(e)MMC specs so my assumptions might be wrong
in that case please correct me.

> However, inventing a "mmc bus lock" would lead to other problems
> related to I/O scheduling for upper layers - it simply breaks. For
> example, I/O requests for one card/slot can then starve I/O requests
> reaching another card/slot.
> 

Nevertheless we had to deal somehow with existing hardware which
has multislot dw mmc controller and both slots are used...

This patch at least shouldn't break anything for current users (which use
it in single slot mode)

Moreover we tested this dual-slot implementation and don't catch any problems
(probably yet) except bus performance decrease in dual-slot mode (which is
quite expected).

> 
> Kind regards
> Uffe
-- 
 Eugeniy Paltsev
