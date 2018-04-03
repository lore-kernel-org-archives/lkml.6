Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeDCUTo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 16:19:44 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:38278 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDCUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 16:19:43 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Tue, 03 Apr 2018 22:19:41 +0200
X-ME-IP: 37.171.40.252
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 02/15] ARM: pxa: add dma slave map
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
        <20180402142656.26815-3-robert.jarzmik@free.fr>
        <CAK8P3a3pSitVqfiF2LK0cMrAKLOeCWXXJBLeVc5f_Tg=vALkUA@mail.gmail.com>
        <87tvss48ti.fsf@belgarion.home>
        <CAK8P3a2FFVnPj4+VoQET3-Jz2DaYbc6UUJnX1fH5s8VumJZ7Og@mail.gmail.com>
X-URL: http://belgarath.falguerolles.org/
Date: Tue, 03 Apr 2018 22:19:33 +0200
In-Reply-To: <CAK8P3a2FFVnPj4+VoQET3-Jz2DaYbc6UUJnX1fH5s8VumJZ7Og@mail.gmail.com>
        (Arnd Bergmann's message of "Tue, 3 Apr 2018 17:39:08 +0200")
Message-ID: <87h8os3uwa.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... chop chop removing unneeded recipients ....

Arnd Bergmann <arnd@arndb.de> writes:

> Ok, I looked at the driver in more detail now and found the scary parts.
> So it's using the async DMA interface to do synchronous DMA in
> interrupt context in order to transfer the rx data faster than an readsl()
> would, correct?
That's correct, at least for the smc91x.

> It still feels odd to me that there is an entry in the slave map for
> a device that does not have a request line. However, it also seems
> that the entire code in those two drivers that deals with DMA is specific
> to PXA anyway, so maybe it can be done differently: instead of
> calling dma_request_slave_channel_compat() or dma_request_chan()
> with a fake request line, how about calling dma_request_channel()
> with an NULL filter function and data, and have the driver handle
> the empty data case the same way as the rq=-1 case today?
Okay, in this case :
 - the channel priority cannot be passed anymore
 - and I don't see how this can work :
   dma_request_channel()
     __dma_request_channel()
       find_candidate()
         private_candidate(mask, device, fn, fn_param);
           /* Here, fn == NULL and fn_param == NULL as per your proposal */

   This function will find the first available dma channel, all right, but
   no function will be called in pxa_dma driver, and therefore the last
   requestor of the channel will be used, which is bad.

>> If you think it's worth it, what is the driving benefit behind ?
> It seems a bit cleaner to only register the tables for the dma lines that
> are actually present on a given chip.
Okay, let's do this.

Cheers.

-- 
Robert
