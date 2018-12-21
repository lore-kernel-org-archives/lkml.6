Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47446C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC7721928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392077AbeLUWEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:04:09 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:55389 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389028AbeLUWEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:04:08 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43M2hj0P2Vz1qvvS;
        Fri, 21 Dec 2018 23:04:04 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43M2hh53Jpz1qsJj;
        Fri, 21 Dec 2018 23:04:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id TW0calHYHzgz; Fri, 21 Dec 2018 23:04:02 +0100 (CET)
X-Auth-Info: 8kXpQnXbBqkg9AavCCyVVMpz6zvX6738fl/Ue0ZH83s=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 21 Dec 2018 23:04:02 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <93a3c76b-f4ba-57ae-9d80-6e945b4f3181@denx.de>
 <20181216213901.hpll7wqzhqvfgkfy@pburton-laptop>
 <28a1d4ae-493d-8bbc-46f7-ad41ca04d782@denx.de>
 <20181216222815.4t4xhaiy6rvfaogq@pburton-laptop>
 <78839e8c-0278-6060-0dd2-a84a19258a8a@denx.de>
 <20181221210818.g3kbv7bnr577dane@pburton-laptop>
Message-ID: <0266be47-75c8-6a1b-dfec-129c5b7bbf8f@denx.de>
Date:   Fri, 21 Dec 2018 23:02:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181221210818.g3kbv7bnr577dane@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/2018 10:08 PM, Paul Burton wrote:
> Hi Marek,
> 
> On Fri, Dec 21, 2018 at 09:08:28PM +0100, Marek Vasut wrote:
>> On 12/16/2018 11:28 PM, Paul Burton wrote:
>>> On Sun, Dec 16, 2018 at 11:01:18PM +0100, Marek Vasut wrote:
>>>>>>> I did suggest an alternative approach which would rename
>>>>>>> serial8250_clear_fifos() and split it into 2 variants - one that
>>>>>>> disables FIFOs & one that does not, then use the latter in
>>>>>>> __do_stop_tx_rs485():
>>>>>>>
>>>>>>> https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-laptop/
>>>>>>>
>>>>>>> However I have no access to the OMAP3 hardware that Marek's patch was
>>>>>>> attempting to fix & have heard nothing back with regards to him testing
>>>>>>> that approach, so here's a simple revert that fixes the Ingenic JZ4780.
>>>>>>>
>>>>>>> I've marked for stable back to v4.10 presuming that this is how far the
>>>>>>> broken patch may be backported, given that this is where commit
>>>>>>> 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subsequent
>>>>>>> transmits to break") that it tried to fix was introduced.
>>>>>>
>>>>>> OK, I tested this on AM335x / OMAP3 and the system is again broken, so
>>>>>> that's a NAK.
>>>>>
>>>>> To be clear - what did you test? This revert or the patch linked to
>>>>> above?
>>>>>
>>>>> This revert would of course reintroduce your RS485 issue because it just
>>>>> undoes your change.
>>>>
>>>> The revert. Which of the two patches do you need me to test.
>>>
>>> The one in the email I sent on Thursday 13th at 01:48:06 UTC, linked to
>>> at lore.kernel.org in the quote right above:
>>>
>>> https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-laptop/
>>>
>>> You replied with comments on the patch, you just never tested it or
>>> never told me if you did. The lack of response means I don't know
>>> whether that potential patch even still works for your system, hence the
>>> revert.
>>
>> I shared the entire testcase, which now fails on AM335x due to this
>> revert. Is there any progress on a proper fix from your side which does
>> not break the AM335x ?
> 
> No.
> 
> Let's be clear - I didn't break your AM335x system, your broken patch
> says that Daniel did with a commit applied back in v4.10. As such I
> don't consider it my responsibility to fix your problem at all, I don't
> have any access to the hardware anyway & I won't be buying hardware to
> fix a bug for you.
> 
> Despite all that I did write a patch which I expect would have solved
> the problem for both of us, which is linked *twice* in the quoted emails
> above & which as far as I can tell you *still* have not tested. I can
> only surmise that you're trying deliberately to be annoying at this
> point.
> 
> If you want to try the patch I already wrote, and confirm whether it
> actually works for you, then let's talk. Otherwise we're done here.

Understood. However I did test your patch, but it was generating
spurious IRQs and overruns (ttyS ttyS2: 91 input overrun(s)) on the
AM335x, so that's not a proper solution.

I even brought the CI20 V2 I have back to life (yes, I bought one). The
patch Ezequiel posted did fix the problem on the CI20, and did not break
the AM335x, so I'd prefer if it was revisited instead of a heavy-handed
revert.

And I'd prefer to keep this thread alive, since I am still convinced
that the FIFO handling code is wrong. Moreover, considering the UME bit
on JZ4780 in FCR, the original code should confuse the UART on the
JZ4780 too, although this might be hidden by some other surrounding code
specific to the 8250 core on the JZ4780.

I am also on mipslinux IRC channel, in case you want to discuss this.

-- 
Best regards,
Marek Vasut
