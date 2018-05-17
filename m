Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeEQQUM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:20:12 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40363 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeEQQUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:20:09 -0400
X-Google-Smtp-Source: AB8JxZqC2r4JpLip9lqRmUF6LIUJ312XiCtuogPTfBnXhOpGhX2isgLsHgLhN77S7mtXzt4jQ+hRsoVExzu7OG7ueno=
MIME-Version: 1.0
In-Reply-To: <20180517041946.GQ13271@vkoul-mobl>
References: <2484918.HKVQc3yJkt@bear> <53b13d76-16a1-0e0a-09e1-c917e5d49326@samsung.com>
 <CAJz5OpcGX_3u5POExdhnBbRu-T-m7KodGAvk50BOfZWKeH--kg@mail.gmail.com>
 <182f50b9-55b6-c9ce-07fb-718a1d22e9c8@samsung.com> <CAJz5Opfqbj6waPrJ3gQsM50=StH_HHvsYySj7sqgeQcKtAVrHQ@mail.gmail.com>
 <eb17d6a7-a188-3ef4-2641-5fd588b16431@samsung.com> <CAJz5Opfd9zeEAShFtUNhW4yLfVykef=2QdWWzq88Dtddn4eymQ@mail.gmail.com>
 <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com> <20180515062144.GC13271@vkoul-mobl>
 <CAJz5Open++Dj=a4ty-JbnZBFoqbMQKU6qYumJKSRMRLp_3erSw@mail.gmail.com> <20180517041946.GQ13271@vkoul-mobl>
From: Frank Mori Hess <fmh6jj@gmail.com>
Date: Thu, 17 May 2018 12:20:07 -0400
Message-ID: <CAJz5Opfep+TL0k_3kG7uQc_nU-BdFy1wsD1jo1agwtSvw0JibQ@mail.gmail.com>
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Vinod Koul <vinod.koul@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to keep coming back to this, but I'm experiencing a bit of
incredulity that you are saying what you seem to be saying.  You seem
to be saying dmaengine provides no way to permanently stop a transfer
safely other than transferring the full number of bytes initially
requested.  So the proper resolution is the 8250 serial driver needs
to remove rx dma support, because they are just trying to do something
that is not supported.

On Thu, May 17, 2018 at 12:19 AM, Vinod Koul <vinod.koul@linaro.org> wrote:
>> > Terminate is abort, data loss may happen here.
>>
>> Wait, are you saying if you do
>>
>> dma pause
>
> no data loss
>> read residue
>
> here as well
>> dma terminate
>
> Oh yes, we aborted...
>>

I see two ways of interpreting what you are saying. First, from the
point of view of the user of the dmaengine api.  From this point of
view it is impossible for data loss to occur during pause or reading
the residue, so saying they cause no data loss during
pause/residue/terminate is meaningless.  This is because the user
can't confirm any data loss until after they have read the residue and
the transfer is terminated, since optimistically the data may still be
available if only the user would resume and allow the transfer to
continue.

Second there is the interpretation I want to believe.  This is "no
data loss on pause" means that after the pause, no data has been
discarded by the dma controller hardware, in fact all the data it has
read before being paused has been fully transferred to its
destination.  Reading the residue while paused gives you an accurate,
up-to-date state of the paused transfer.  Then finally, although in
general dma terminate causes data loss, it does not in this case since
we terminated while we were paused and read the up-to-date residue.
This is the interpretation implicit in the 8250 serial driver.
