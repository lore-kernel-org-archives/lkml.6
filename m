Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90609C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B88F20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B88F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeLMES0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:18:26 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:40566 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMESZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:18:25 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43FgQj543dz1rYjc;
        Thu, 13 Dec 2018 05:18:21 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43FgQj4XMVz1qtdk;
        Thu, 13 Dec 2018 05:18:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Tzmgr0yzKrq3; Thu, 13 Dec 2018 05:18:19 +0100 (CET)
X-Auth-Info: CJIyQGXpzb4zFg51rCW4lyDoFZgNsrARY/TXhLD9ofE=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 13 Dec 2018 05:18:19 +0100 (CET)
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
To:     Paul Burton <paul.burton@mips.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
References: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
 <cd3e2787-48e1-ce70-0fa7-94df6dc81794@denx.de>
 <20181213014805.77u5dzydo23cm6fq@pburton-laptop>
 <117fda17-40e6-664b-2b8a-f1032610bf0b@denx.de>
 <20181213033301.febmn5qt3chn3vqb@pburton-laptop>
From:   Marek Vasut <marex@denx.de>
Message-ID: <b8525991-f539-a180-2e88-a70b29319413@denx.de>
Date:   Thu, 13 Dec 2018 05:18:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181213033301.febmn5qt3chn3vqb@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2018 04:33 AM, Paul Burton wrote:
> Hi Marek,

Hello Paul,

> On Thu, Dec 13, 2018 at 03:27:51AM +0100, Marek Vasut wrote:
>>> I wonder whether the issue may be the JZ4780 UART not automatically
>>> resetting the FIFOs when FCR[0] changes. This is a guess, but the manual
>>> doesn't explicitly say it'll happen & the programming example it gives
>>> says to explicitly clear the FIFOs using FCR[2:1]. Since this is what
>>> the kernel has been doing for at least the whole git era I wouldn't be
>>> surprised if other devices are bitten by the change as people start
>>> trying 4.20 on them.
>>
>> The patch you're complaining about is doing exactly that -- it sets
>> UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT in FCR , and then clears it.
>> Those two bits are exactly FCR[2:1]. It also explicitly does not touch
>> any other bits in FCR.
> 
> No - your patch does that *only* if the FIFO enable bit is set, and
> presumes that clearing FIFOs is a no-op when they're disabled. I don't
> believe that's true on my system. I also believe that not touching the
> FIFO enable bit is problematic, since some callers clearly expect that
> to be cleared.

Why would you disable FIFO to clear it ? This doesn't make sense to me,
the FIFO must be operational for it to be cleared. Moreover, it
contradicts your previous statement, "the programming example it gives
says to explicitly clear the FIFOs using FCR[2:1]" .

What exactly does your programming example for the JZ4780 say about the
FIFO clearing ? And does it work in that example ?

>>> @@ -558,25 +558,26 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
>>>  	if (p->capabilities & UART_CAP_FIFO) {
>>>  		/*
>>>  		 * Make sure to avoid changing FCR[7:3] and ENABLE_FIFO bits.
>>> -		 * In case ENABLE_FIFO is not set, there is nothing to flush
>>> -		 * so just return. Furthermore, on certain implementations of
>>> -		 * the 8250 core, the FCR[7:3] bits may only be changed under
>>> -		 * specific conditions and changing them if those conditions
>>> -		 * are not met can have nasty side effects. One such core is
>>> -		 * the 8250-omap present in TI AM335x.
>>> +		 * On certain implementations of the 8250 core, the FCR[7:3]
>>> +		 * bits may only be changed under specific conditions and
>>> +		 * changing them if those conditions are not met can have nasty
>>> +		 * side effects. One such core is the 8250-omap present in TI
>>> +		 * AM335x.
>>>  		 */
>>>  		fcr = serial_in(p, UART_FCR);
>>> +		serial_out(p, UART_FCR, fcr | clr_mask);
>>> +		serial_out(p, UART_FCR, fcr & ~clr);
>>
>> Note that, if I understand the patch correctly, this will _not_ restore
>> the original (broken) behavior. The original behavior cleared the entire
>> FCR at the end, which cleared even bits that were not supposed to be
>> cleared .
> 
> It will restore the original behaviour with regards to disabling the
> FIFOs, so long as callers that expect that use
> serial8250_clear_and_disable_fifos().

Does your platform need the FIFO to be explicitly disabled for it to be
cleared, can you confirm that ? And if so, does this apply to other
platforms with 8250 UART or is this specific to JZ4780 implementation of
the UART block ?

I just remembered U-Boot has this patch for JZ4780 UART [1], which
touches the FCR UME bit, so the FCR behavior on JZ4780 does differ from
the generic 8250 core. Could it be that this is what you're hitting ?

[1]
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=0b060eefd951fc111ecb77c7b1932b158e6a4f2c;hp=79fd9281880974f076c5b4b354b57faa6e0cc146

>> This patch will make things worse by retaining the clr_mask set in the
>> FCR, thus the FCR[2:1] will be set when you return from this function.
>> That cannot be right ?
> 
> You're mistaken - clr_mask (ie. the FIFO reset bits) get cleared again
> by the second call to serial_out(), I just did it without modifying the
> fcr variable - ie. we write the original fcr value again at the end, but
> with UART_FCR_ENABLE_FIFO cleared in the
> serial8250_clear_and_disable_fifos() case. It would probably be clearer
> with the clr argument renamed disable or something like that.

Uhh, OK, thanks for clarifying.

-- 
Best regards,
Marek Vasut
