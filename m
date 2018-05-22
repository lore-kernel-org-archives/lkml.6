Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeEVA4Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:56:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36496 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeEVA4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:56:22 -0400
X-Google-Smtp-Source: AB8JxZpNzZN1nijvYpUTKAOnq1H+dJ7K5bv4c+Bn4RArKXt0R/a3a7ItxfvK6aYzzv3IdinfN7SZor5FlX97PVG9FqM=
MIME-Version: 1.0
In-Reply-To: <20180521091626.GB14654@vkoul-mobl>
References: <CAJz5Opfqbj6waPrJ3gQsM50=StH_HHvsYySj7sqgeQcKtAVrHQ@mail.gmail.com>
 <eb17d6a7-a188-3ef4-2641-5fd588b16431@samsung.com> <CAJz5Opfd9zeEAShFtUNhW4yLfVykef=2QdWWzq88Dtddn4eymQ@mail.gmail.com>
 <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com> <20180515062144.GC13271@vkoul-mobl>
 <CAJz5Open++Dj=a4ty-JbnZBFoqbMQKU6qYumJKSRMRLp_3erSw@mail.gmail.com>
 <20180517041946.GQ13271@vkoul-mobl> <CAJz5Opfep+TL0k_3kG7uQc_nU-BdFy1wsD1jo1agwtSvw0JibQ@mail.gmail.com>
 <20180518040349.GB2932@vkoul-mobl> <CAJz5OpfSanwNS7Z=3FapR97XZzjWF_J23HqVouxVnPn2HwkKLw@mail.gmail.com>
 <20180521091626.GB14654@vkoul-mobl>
From: Frank Mori Hess <fmh6jj@gmail.com>
Date: Mon, 21 May 2018 20:56:20 -0400
Message-ID: <CAJz5OpdW7ZgX_K-+6H_mkHhzRf1_km8Usf306_HrnD7qCztdpw@mail.gmail.com>
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

On Mon, May 21, 2018 at 5:16 AM, Vinod Koul <vinod.koul@linaro.org> wrote:
>>
>> I understand the residue can't be read after terminate, that's why
>> reading the residue is step 2 in pause/residue/terminate.  My question
>> was whether the entire sequence pause/residue/terminate taken as a
>> whole can or cannot lose data.  Saying that individual steps can or
>> can't lose data is not enough, context is required.  The key point is
>> whether pause flushes in-flight data to its destination or not.  If it
>> does, and our residue is accurate, the terminate cannot cause data
>> loss.  If pause doesn't flush, an additional step of flush_sync as
>> Lars suggested is required.  So pause/flush_sync/residue/terminate
>> would be the safe sequence that cannot lose data.
>
> I wouldn't use cannot, shouldn't would be better here as it depends on HW and
> where all data has been buffered and if it can be flushed or not.
>
> Have you checked if pl330 supports such flushing?

It does not, at least in the context of pausing.  The dma-330 DMAEND
instruction flushes in-flight data to its destination, and there are
read/write barrier instructions also, but none of them can be injected
on the fly into a running dma thread.  DMAKILL can be, but it discards
in-flight data.  Currently, if an 8250 serial driver uses the pl330
for rx dma, the result is possible data loss/corruption.  If there was
a stronger pause capability, call it "cmd_sync_pause" which guaranteed
flushing of in-flight data to its destination and accurate residue
reading when paused, then the 8250 serial driver could check for
"cmd_sync_pause" and reject dma drivers that do not have that
capability.  pl330.c would not advertise cmd_sync_pause.  I don't know
if other dmaengine hardware would be able to support cmd_sync_pause or
not, I'm mostly just familiar with the pl330.  The ep93xx_dma.c driver
for example has a m2p_hw_synchronize function which seems to do a
flush.

-- 
Frank
