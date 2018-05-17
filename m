Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeEQETv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 00:19:51 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36051 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeEQETt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 00:19:49 -0400
X-Google-Smtp-Source: AB8JxZrDwSmnQJn+ueXxVdrKXTrbXAnGq0c2LTdDAVcb0Y7jWGGp6TfMdaTerlb/s8Q1mB+Q64FabA==
Date: Thu, 17 May 2018 09:49:46 +0530
From: Vinod Koul <vinod.koul@linaro.org>
To: Frank Mori Hess <fmh6jj@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
Message-ID: <20180517041946.GQ13271@vkoul-mobl>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJz5Open++Dj=a4ty-JbnZBFoqbMQKU6qYumJKSRMRLp_3erSw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-05-18, 11:50, Frank Mori Hess wrote:
> On Tue, May 15, 2018 at 2:21 AM, Vinod <vkoul@kernel.org> wrote:
> >
> > For Pause/resume data loss is _not_ expected.
> >
> >> > and some of the 8250 drivers like 8250_dw.c set a maxburst > 1.  If it
> >> > can't count on the pause/residue/terminate working without data loss
> >> > then it is just broken.  As is the 8250_omap.c driver.  Is the
> >> > description of dmaengine_pause in the documentation of "This pauses
> >> > activity on the DMA channel without data loss" to be interpreted as
> >> > "as long as you resume afterwards"?
> >>
> >> I assume that this requirement is for both - resuming and terminating.
> >
> > Terminate is abort, data loss may happen here.
> 
> Wait, are you saying if you do
> 
> dma pause

no data loss
> read residue

here as well
> dma terminate

Oh yes, we aborted...
> 
> then it is acceptable for there to be data loss, because it can be
> blamed on the terminate?  In that case the usage of dmaengine in all
> the 8250 serial drivers is broken.  Every time there is a break in the
> incoming rx data, the 8250 driver does pause/residue/terminate which
> could potentially cause data from the incoming data stream to be
> dropped.

As I said terminate is abort. It cleans up the channel and is supposed to
used for cleanup not for stopping. See Documentation:

- device_terminate_all

  - Aborts all the pending and ongoing transfers on the channel

  - For aborted transfers the complete callback should not be called

  - Can be called from atomic context or from within a complete
    callback of a descriptor. Must not sleep. Drivers must be able
    to handle this correctly.

  - Termination may be asynchronous. The driver does not have to
    wait until the currently active transfer has completely stopped.
    See device_synchronize.

Thanks
-- 
~Vinod
