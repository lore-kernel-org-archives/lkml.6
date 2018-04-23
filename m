Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbeDWGrM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:47:12 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:33050 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbeDWGrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:47:10 -0400
X-Google-Smtp-Source: AIpwx483FIWSaGvdrmf7JFF3OE2hAonBzJr6YC+E1Z2uE8124sRIkdnEZX6l8QxbVRczQ5QBovZXhyGXdl8edCMF9cU=
MIME-Version: 1.0
In-Reply-To: <1524239609.10138.47.camel@synopsys.com>
References: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
 <CAPDyKFqxZLtx_=0UU9NgBnW0Vmw=456q2FFbMBK4LKEaF-ua7A@mail.gmail.com> <1524239609.10138.47.camel@synopsys.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Apr 2018 08:47:09 +0200
Message-ID: <CAPDyKFpY7JsQukY=E2PRg=iVfmis4i1kvST+b2wtshNc5Jn+jw@mail.gmail.com>
Subject: Re: [RFC 0/2] dw_mmc: add multislot support
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 April 2018 at 17:53, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com> wrote:
> Hi Ulf,
>
> On Fri, 2018-04-20 at 09:35 +0200, Ulf Hansson wrote:
>> [...]
>>
>> >
>> > 2. Add missing stuff to support multislot mode in DesignWare MMC driver.
>> >  * Add missing slot switch to __dw_mci_start_request() function.
>> >  * Refactor set_ios function:
>> >    a) Calculate common clock which is
>> >       suitable for all slots instead of directly use clock value
>> >       provided by mmc core. We calculate common clock as the minimum
>> >       among each used slot clocks. This clock is calculated in
>> >       dw_mci_calc_common_clock() function which is called
>> >       from set_ios()
>> >    b) Disable clock only if no other slots are ON.
>> >    c) Setup clock directly in set_ios() only if no other slots
>> >       are ON. Otherwise adjust clock in __dw_mci_start_request()
>> >       function before slot switch.
>> >    d) Move timings and bus_width setup to separate funcions.
>> >  * Use timing field in each slot structure instead of common field in
>> >    host structure.
>> >  * Add locks to serialize access to registers.
>>
>> Sorry, but this is a hack to *try* to make multi-slot work and this
>> isn't sufficient. There were good reasons to why the earlier
>> non-working multi slot support was removed from dw_mmc.
>
> Previous multi slot implementation was removed as nobody used it and
> nobody tested it. There are lots of mistakes in previous implementation
> which are not related to request serialization
> like lack of slot switch / lack of adding slot id to CIU commands / ets...
> So obviously it was never tested and never used at real multi slot hardware.
>
>> Let me elaborate a bit for your understanding. The core uses a host
>> lock (mmc_claim|release_host()) to serialize operations and commands,
>> as to confirm to the SD/SDIO/(e)MMC specs. The above changes gives no
>> guarantees for this. To make that work, we would need a "mmc bus lock"
>> to be managed by the core.
>
> In current implementation data transfers and commands to different
> hosts (slots) are serialized internally in the dw_mmc driver. We have
> request queue and when .request() is called we add new request to the
> queue. We take new request from the queue only if the previous one
> has already finished.

That isn't sufficient. The core expects all calls to *any* of the host
ops to be serialized for one host. It does so to conform to the specs.

For example it may call:
 ->set_ios()
->request()
->set_ios()
->request()
->request()

>
> So although hosts (slots) have separate locks (mmc_claim|release_host())
> the requests to different slots are serialized by driver.
>
> Isn't that enough?

Sorry, but no.

> I'm not very familiar with SD/SDIO/(e)MMC specs so my assumptions might be wrong
> in that case please correct me.

Well, that kind of explains your simplistic approach.

I would suggest you to study the specs and the behavior of the mmc
core a bit more carefully, that should give you a better understanding
of the problems.

>
>> However, inventing a "mmc bus lock" would lead to other problems
>> related to I/O scheduling for upper layers - it simply breaks. For
>> example, I/O requests for one card/slot can then starve I/O requests
>> reaching another card/slot.
>>
>
> Nevertheless we had to deal somehow with existing hardware which
> has multislot dw mmc controller and both slots are used...
>
> This patch at least shouldn't break anything for current users (which use
> it in single slot mode)
>
> Moreover we tested this dual-slot implementation and don't catch any problems
> (probably yet) except bus performance decrease in dual-slot mode (which is
> quite expected).

Honestly, I don't think efforts of implementing this is worth it!

Even if we would be able to solve the problem from an mmc subsystem
point of view, we would still have the I/O scheduling problem to
address. To solve that, we would need to be able to configure upper
block layer code to run one scheduling instance over multiple block
devices...

Kind regards
Uffe
