Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C06C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887A8206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbeLPWB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 17:01:27 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:38436 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730860AbeLPWB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 17:01:27 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43Hysw06Nhz1r0Gm;
        Sun, 16 Dec 2018 23:01:24 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43Hysv6bn9z1qsZC;
        Sun, 16 Dec 2018 23:01:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id CFL1_clki3N4; Sun, 16 Dec 2018 23:01:22 +0100 (CET)
X-Auth-Info: 7/tF+Q5YzpxPXbvQsValM1HSKK9qBtjYYVo4W7puvpw=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 16 Dec 2018 23:01:22 +0100 (CET)
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <93a3c76b-f4ba-57ae-9d80-6e945b4f3181@denx.de>
 <20181216213901.hpll7wqzhqvfgkfy@pburton-laptop>
From:   Marek Vasut <marex@denx.de>
Message-ID: <28a1d4ae-493d-8bbc-46f7-ad41ca04d782@denx.de>
Date:   Sun, 16 Dec 2018 23:01:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181216213901.hpll7wqzhqvfgkfy@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/2018 10:39 PM, Paul Burton wrote:
> Hi Marek,

Hi,

> On Sun, Dec 16, 2018 at 10:08:48PM +0100, Marek Vasut wrote:
>>> I did suggest an alternative approach which would rename
>>> serial8250_clear_fifos() and split it into 2 variants - one that
>>> disables FIFOs & one that does not, then use the latter in
>>> __do_stop_tx_rs485():
>>>
>>> https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-laptop/
>>>
>>> However I have no access to the OMAP3 hardware that Marek's patch was
>>> attempting to fix & have heard nothing back with regards to him testing
>>> that approach, so here's a simple revert that fixes the Ingenic JZ4780.
>>>
>>> I've marked for stable back to v4.10 presuming that this is how far the
>>> broken patch may be backported, given that this is where commit
>>> 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subsequent
>>> transmits to break") that it tried to fix was introduced.
>>
>> OK, I tested this on AM335x / OMAP3 and the system is again broken, so
>> that's a NAK.
> 
> To be clear - what did you test? This revert or the patch linked to
> above?
> 
> This revert would of course reintroduce your RS485 issue because it just
> undoes your change.

The revert. Which of the two patches do you need me to test.

> Either way, commit f6aa5beb45be ("serial: 8250: Fix clearing FIFOs in
> RS485 mode again") breaks systems that worked before it so at this late
> stage in the 4.20 cycle a revert would make sense to me. If that breaks
> RS85 on OMAP3 then my question would be how much can anyone really care
> if nobody noticed since v4.10? And why should that lead to you breaking
> the JZ4780 which has been discovered before a stable kernel release
> includes the breakage?

There's always a .y release where this can be properly investigated and
solved, instead of breaking one platform or the other.

Then again, see the patch from Ezequiel that was just posted, I think it
might be a far better solution.

-- 
Best regards,
Marek Vasut
