Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4C8C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212E021773
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391866AbeLUUgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:36:07 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:58889 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732146AbeLUUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:36:07 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43M0l54Cvnz1qvwC;
        Fri, 21 Dec 2018 21:36:01 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43M0l50hjwz1qsJh;
        Fri, 21 Dec 2018 21:36:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id PpUddr77N0NU; Fri, 21 Dec 2018 21:35:59 +0100 (CET)
X-Auth-Info: T06MoJD12PDo90wuQYGN6QtiOuFp/1X2KFMzFVVBw+k=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 21 Dec 2018 21:35:59 +0100 (CET)
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
From:   Marek Vasut <marex@denx.de>
Message-ID: <78839e8c-0278-6060-0dd2-a84a19258a8a@denx.de>
Date:   Fri, 21 Dec 2018 21:08:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181216222815.4t4xhaiy6rvfaogq@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/2018 11:28 PM, Paul Burton wrote:
> Hi Marek,
> 
> On Sun, Dec 16, 2018 at 11:01:18PM +0100, Marek Vasut wrote:
>>>>> I did suggest an alternative approach which would rename
>>>>> serial8250_clear_fifos() and split it into 2 variants - one that
>>>>> disables FIFOs & one that does not, then use the latter in
>>>>> __do_stop_tx_rs485():
>>>>>
>>>>> https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-laptop/
>>>>>
>>>>> However I have no access to the OMAP3 hardware that Marek's patch was
>>>>> attempting to fix & have heard nothing back with regards to him testing
>>>>> that approach, so here's a simple revert that fixes the Ingenic JZ4780.
>>>>>
>>>>> I've marked for stable back to v4.10 presuming that this is how far the
>>>>> broken patch may be backported, given that this is where commit
>>>>> 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subsequent
>>>>> transmits to break") that it tried to fix was introduced.
>>>>
>>>> OK, I tested this on AM335x / OMAP3 and the system is again broken, so
>>>> that's a NAK.
>>>
>>> To be clear - what did you test? This revert or the patch linked to
>>> above?
>>>
>>> This revert would of course reintroduce your RS485 issue because it just
>>> undoes your change.
>>
>> The revert. Which of the two patches do you need me to test.
> 
> The one in the email I sent on Thursday 13th at 01:48:06 UTC, linked to
> at lore.kernel.org in the quote right above:
> 
> https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-laptop/
> 
> You replied with comments on the patch, you just never tested it or
> never told me if you did. The lack of response means I don't know
> whether that potential patch even still works for your system, hence the
> revert.

I shared the entire testcase, which now fails on AM335x due to this
revert. Is there any progress on a proper fix from your side which does
not break the AM335x ?

-- 
Best regards,
Marek Vasut
