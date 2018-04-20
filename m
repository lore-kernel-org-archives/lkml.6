Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbeDTHfb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:35:31 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32893 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753597AbeDTHf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:35:29 -0400
X-Google-Smtp-Source: AIpwx48nQy1k0Rtg/ZXGMeuzSVEIxI27svTzF5kVZloONV/HN2XVm4wQT8j2/fGL0pSQsEr5h4KY2Dee4r0egVmvT98=
MIME-Version: 1.0
In-Reply-To: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
References: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 20 Apr 2018 09:35:28 +0200
Message-ID: <CAPDyKFqxZLtx_=0UU9NgBnW0Vmw=456q2FFbMBK4LKEaF-ua7A@mail.gmail.com>
Subject: Re: [RFC 0/2] dw_mmc: add multislot support
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>
> 2. Add missing stuff to support multislot mode in DesignWare MMC driver.
>  * Add missing slot switch to __dw_mci_start_request() function.
>  * Refactor set_ios function:
>    a) Calculate common clock which is
>       suitable for all slots instead of directly use clock value
>       provided by mmc core. We calculate common clock as the minimum
>       among each used slot clocks. This clock is calculated in
>       dw_mci_calc_common_clock() function which is called
>       from set_ios()
>    b) Disable clock only if no other slots are ON.
>    c) Setup clock directly in set_ios() only if no other slots
>       are ON. Otherwise adjust clock in __dw_mci_start_request()
>       function before slot switch.
>    d) Move timings and bus_width setup to separate funcions.
>  * Use timing field in each slot structure instead of common field in
>    host structure.
>  * Add locks to serialize access to registers.

Sorry, but this is a hack to *try* to make multi-slot work and this
isn't sufficient. There were good reasons to why the earlier
non-working multi slot support was removed from dw_mmc.

Let me elaborate a bit for your understanding. The core uses a host
lock (mmc_claim|release_host()) to serialize operations and commands,
as to confirm to the SD/SDIO/(e)MMC specs. The above changes gives no
guarantees for this. To make that work, we would need a "mmc bus lock"
to be managed by the core.

However, inventing a "mmc bus lock" would lead to other problems
related to I/O scheduling for upper layers - it simply breaks. For
example, I/O requests for one card/slot can then starve I/O requests
reaching another card/slot.

[...]

Kind regards
Uffe
