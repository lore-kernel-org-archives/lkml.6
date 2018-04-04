Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeDDKTB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:19:01 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:45420 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeDDKS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:18:59 -0400
X-Google-Smtp-Source: AIpwx48aeLwNXxkXEQ/mp44Lb8pg89Ywy2gUsT3EEVmU9Kd5TQLpH5+xbjWNLDVY+VVXPPfzABFBfMiFS5PcAsPR7jA=
MIME-Version: 1.0
In-Reply-To: <87h8os3uwa.fsf@belgarion.home>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-3-robert.jarzmik@free.fr> <CAK8P3a3pSitVqfiF2LK0cMrAKLOeCWXXJBLeVc5f_Tg=vALkUA@mail.gmail.com>
 <87tvss48ti.fsf@belgarion.home> <CAK8P3a2FFVnPj4+VoQET3-Jz2DaYbc6UUJnX1fH5s8VumJZ7Og@mail.gmail.com>
 <87h8os3uwa.fsf@belgarion.home>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 4 Apr 2018 12:18:58 +0200
X-Google-Sender-Auth: -q4F-n0cowmTZLbpexKXzNW60hI
Message-ID: <CAK8P3a21xkp5KkNRpnxJH1bSZjyiyO=f7_9XyyqvGS3EC=GBWg@mail.gmail.com>
Subject: Re: [PATCH 02/15] ARM: pxa: add dma slave map
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 10:19 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> ... chop chop removing unneeded recipients ....
>
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> Ok, I looked at the driver in more detail now and found the scary parts.
>> So it's using the async DMA interface to do synchronous DMA in
>> interrupt context in order to transfer the rx data faster than an readsl()
>> would, correct?
> That's correct, at least for the smc91x.
>
>> It still feels odd to me that there is an entry in the slave map for
>> a device that does not have a request line. However, it also seems
>> that the entire code in those two drivers that deals with DMA is specific
>> to PXA anyway, so maybe it can be done differently: instead of
>> calling dma_request_slave_channel_compat() or dma_request_chan()
>> with a fake request line, how about calling dma_request_channel()
>> with an NULL filter function and data, and have the driver handle
>> the empty data case the same way as the rq=-1 case today?
> Okay, in this case :
>  - the channel priority cannot be passed anymore

Right, but it could just always use a static priority, right?

>  - and I don't see how this can work :
>    dma_request_channel()
>      __dma_request_channel()
>        find_candidate()
>          private_candidate(mask, device, fn, fn_param);
>            /* Here, fn == NULL and fn_param == NULL as per your proposal */
>
>    This function will find the first available dma channel, all right, but
>    no function will be called in pxa_dma driver, and therefore the last
>    requestor of the channel will be used, which is bad.

Can't you just reset those in pxad_free_chan_resources()?

       Arnd
