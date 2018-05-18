Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeERS4o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:56:44 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39556 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeERS4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:56:40 -0400
X-Google-Smtp-Source: AB8JxZp5b8ftShUTr/jGWMDAqO8pCBkdlpU2wenF2xlnq4oYd3DDkizUxElwvTzvTRJsB7XzBOkpEyJC49oy2YqM4qA=
MIME-Version: 1.0
In-Reply-To: <20180518040349.GB2932@vkoul-mobl>
References: <CAJz5OpcGX_3u5POExdhnBbRu-T-m7KodGAvk50BOfZWKeH--kg@mail.gmail.com>
 <182f50b9-55b6-c9ce-07fb-718a1d22e9c8@samsung.com> <CAJz5Opfqbj6waPrJ3gQsM50=StH_HHvsYySj7sqgeQcKtAVrHQ@mail.gmail.com>
 <eb17d6a7-a188-3ef4-2641-5fd588b16431@samsung.com> <CAJz5Opfd9zeEAShFtUNhW4yLfVykef=2QdWWzq88Dtddn4eymQ@mail.gmail.com>
 <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com> <20180515062144.GC13271@vkoul-mobl>
 <CAJz5Open++Dj=a4ty-JbnZBFoqbMQKU6qYumJKSRMRLp_3erSw@mail.gmail.com>
 <20180517041946.GQ13271@vkoul-mobl> <CAJz5Opfep+TL0k_3kG7uQc_nU-BdFy1wsD1jo1agwtSvw0JibQ@mail.gmail.com>
 <20180518040349.GB2932@vkoul-mobl>
From: Frank Mori Hess <fmh6jj@gmail.com>
Date: Fri, 18 May 2018 14:56:39 -0400
Message-ID: <CAJz5OpfSanwNS7Z=3FapR97XZzjWF_J23HqVouxVnPn2HwkKLw@mail.gmail.com>
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Vinod <vkoul@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 12:03 AM, Vinod <vkoul@kernel.org> wrote:
>
> You are simply mixing things up!

It certainly feels like I'm mixed up.  If I have to resolve this, I'd
like to be a little less mixed up before I submit more patches which
are going to inevitably result in subtly broken code suddenly becoming
prominently and unignorably broken code.  Unfortunately I get the
impression I'm exhausting your patience to answer my questions, and
I've failed to fully communicate what the question is.


> On Pause we don't expect data loss, as user can
> resume the transfer. This means as you rightly guessed, the DMA HW should not drop
> any data, nor should SW.
>
> Now if you want to read residue at this point it is perfectly valid. But if you
> decide to terminate the channel (yes it is terminate_all API), we abort and don't
> have context to report back!

I understand the residue can't be read after terminate, that's why
reading the residue is step 2 in pause/residue/terminate.  My question
was whether the entire sequence pause/residue/terminate taken as a
whole can or cannot lose data.  Saying that individual steps can or
can't lose data is not enough, context is required.  The key point is
whether pause flushes in-flight data to its destination or not.  If it
does, and our residue is accurate, the terminate cannot cause data
loss.  If pause doesn't flush, an additional step of flush_sync as
Lars suggested is required.  So pause/flush_sync/residue/terminate
would be the safe sequence that cannot lose data.


> As Lars rightly pointed out, residue calculation are very tricky, DMA fifo may
> have data, some data may be in device FIFO, so residue is always from DMA point
> of view and may differ from device view (more or less depending upon direction)
>
> Now if you require to add more features for your usecase, please do feel free to
> send a patch. The framework can always be improved, we haven't solved world
> hunger yet!

World hunger?  I don't see how asking questions about a dma engine's
data integrity guarantees is either unreasonable or out of scope.

-- 
Frank
