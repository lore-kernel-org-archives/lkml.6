Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeEQRWe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:22:34 -0400
Received: from www381.your-server.de ([78.46.137.84]:42291 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeEQRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:22:31 -0400
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Frank Mori Hess <fmh6jj@gmail.com>, Vinod Koul <vinod.koul@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
References: <2484918.HKVQc3yJkt@bear>
 <53b13d76-16a1-0e0a-09e1-c917e5d49326@samsung.com>
 <CAJz5OpcGX_3u5POExdhnBbRu-T-m7KodGAvk50BOfZWKeH--kg@mail.gmail.com>
 <182f50b9-55b6-c9ce-07fb-718a1d22e9c8@samsung.com>
 <CAJz5Opfqbj6waPrJ3gQsM50=StH_HHvsYySj7sqgeQcKtAVrHQ@mail.gmail.com>
 <eb17d6a7-a188-3ef4-2641-5fd588b16431@samsung.com>
 <CAJz5Opfd9zeEAShFtUNhW4yLfVykef=2QdWWzq88Dtddn4eymQ@mail.gmail.com>
 <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com>
 <20180515062144.GC13271@vkoul-mobl>
 <CAJz5Open++Dj=a4ty-JbnZBFoqbMQKU6qYumJKSRMRLp_3erSw@mail.gmail.com>
 <20180517041946.GQ13271@vkoul-mobl>
 <CAJz5Opfep+TL0k_3kG7uQc_nU-BdFy1wsD1jo1agwtSvw0JibQ@mail.gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b232b906-9359-bea1-447f-2c1341cc19d5@metafoo.de>
Date: Thu, 17 May 2018 19:22:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJz5Opfep+TL0k_3kG7uQc_nU-BdFy1wsD1jo1agwtSvw0JibQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 06:20 PM, Frank Mori Hess wrote:
> Sorry to keep coming back to this, but I'm experiencing a bit of
> incredulity that you are saying what you seem to be saying.  You seem
> to be saying dmaengine provides no way to permanently stop a transfer
> safely other than transferring the full number of bytes initially
> requested.  So the proper resolution is the 8250 serial driver needs
> to remove rx dma support, because they are just trying to do something
> that is not supported.

The problem is not so much on the software side but even more so on the
hardware side. Not all hardware even supports aborting a transfer with no
data loss because there is no precise measurement of how much data has been
transferred. The residue that is reported is always the lower bound, this
much has been transferred but it might actually have been more.

And even if hardware supports precise residue reporting there often is no
synchronization mechanism to ensure that there is no pending data anywhere
in the pipeline. This doesn't even have to be inside the DMA's buffers, the
DMA might have send the data to the peripheral but it has not arrived at the
peripheral side.

If the peripheral has a memory mapped FIFO there will typically be some
confirmation that the data was received, but with a dedicated DMA bus
between the DMA controller and the peripheral that is often not the case.
And for the first case the DMA controller also needs to actually expose the
information how many acknowledgements it has received.

Because there are basically two different resides, residue one is how much
data has been read from/written to memory and the other is how much data has
been read from/written to the peripheral. Any differences between the two
will account for in flight data.

What I'd recommend is to add a flush_sync() operation to the DMA interface.
This function would wait until all in flight data transfers have been
completed. That makes it safe to call terminate() without the risk of
loosing data and also allow accurate residue reporting.

Although I'd expect that there is fair risk that implementations will not
get flush_sync() 100% correct because it requires in-depth knowledge about
the internal behavior of the DMA which is often not documented.
