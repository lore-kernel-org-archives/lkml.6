Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0F1C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C351920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C351920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbeLMPZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:25:54 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:48160 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbeLMPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:25:54 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43FyDt24Fpz1qxJY;
        Thu, 13 Dec 2018 16:25:50 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43FyDt1PStz1qtfL;
        Thu, 13 Dec 2018 16:25:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id KDubXfsI4KoD; Thu, 13 Dec 2018 16:25:48 +0100 (CET)
X-Auth-Info: NzFAuzH8C7t+HfDuQ0xoc0td5AM4pZbwUefi7IB1iwM=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 13 Dec 2018 16:25:48 +0100 (CET)
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
 <b8525991-f539-a180-2e88-a70b29319413@denx.de>
 <20181213051154.57h2ddfcbrgh65gy@pburton-laptop>
From:   Marek Vasut <marex@denx.de>
Message-ID: <372cccd7-a175-2737-5af8-3072606c6b1c@denx.de>
Date:   Thu, 13 Dec 2018 15:51:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181213051154.57h2ddfcbrgh65gy@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2018 06:11 AM, Paul Burton wrote:
> Hi Marek,

Hi,

> On Thu, Dec 13, 2018 at 05:18:19AM +0100, Marek Vasut wrote:
>>>>> I wonder whether the issue may be the JZ4780 UART not automatically
>>>>> resetting the FIFOs when FCR[0] changes. This is a guess, but the manual
>>>>> doesn't explicitly say it'll happen & the programming example it gives
>>>>> says to explicitly clear the FIFOs using FCR[2:1]. Since this is what
>>>>> the kernel has been doing for at least the whole git era I wouldn't be
>>>>> surprised if other devices are bitten by the change as people start
>>>>> trying 4.20 on them.
>>>>
>>>> The patch you're complaining about is doing exactly that -- it sets
>>>> UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT in FCR , and then clears it.
>>>> Those two bits are exactly FCR[2:1]. It also explicitly does not touch
>>>> any other bits in FCR.
>>>
>>> No - your patch does that *only* if the FIFO enable bit is set, and
>>> presumes that clearing FIFOs is a no-op when they're disabled. I don't
>>> believe that's true on my system. I also believe that not touching the
>>> FIFO enable bit is problematic, since some callers clearly expect that
>>> to be cleared.
>>
>> Why would you disable FIFO to clear it ? This doesn't make sense to me,
>> the FIFO must be operational for it to be cleared. Moreover, it
>> contradicts your previous statement, "the programming example it gives
>> says to explicitly clear the FIFOs using FCR[2:1]" .
> 
> No, no, not at all... I'm saying that my theory is:
> 
>   - The JZ4780 requires that the FIFO be reset using FCR[2:1] in order
>     to not read garbage.

Which we do

>   - Prior to your patch serial8250_clear_fifos() did this,
>     unconditionally.

btw originally, this also cleared the UME bit. Could this be what made
the difference on the JZ4780 ?

Can you try this patch on the JZ4780 , just out of curiosity ?

diff --git a/drivers/tty/serial/8250/8250_port.c
b/drivers/tty/serial/8250/8250_port.c
index c39482b961110..3dce99f4c6802 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -553,7 +553,7 @@ static unsigned int serial_icr_read(struct
uart_8250_port *up, int offset)
 static void serial8250_clear_fifos(struct uart_8250_port *p)
 {
        unsigned char fcr;
-       unsigned char clr_mask = UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
+       unsigned char clr_mask = UART_FCR_CLEAR_RCVR |
UART_FCR_CLEAR_XMIT | BIT(4) /* UME */;

        if (p->capabilities & UART_CAP_FIFO) {

>   - After your patch serial8250_clear_fifos() only clears the FIFOs if
>     the FIFO is already enabled.

I'd suppose this is OK, since clearing a disabled FIFO makes no sense ?

>   - When called from serial8250_do_startup() during boot, the FIFO may
>     not be enabled - for example if the bootloader didn't use the FIFO,
>     or if the UART is used with 8250_early which zeroes FCR.

If it's not enabled, do you need to clear it ?

>   - Therefore after your patch the FIFO reset bits are never set if the
>     UART was used with 8250_early, or if it wasn't but the bootloader
>     didn't enable the FIFO.

Hence my question above, do you need to clear the FIFO even if it was
not enabled ?

> I suspect that you get away with that because according to the PC16550D
> documentation the FIFOs should reset when the FIFO enable bit changes,
> so when the FIFO is later enabled it gets reset. I suspect that in the
> JZ4780 this does not happen, and the FIFO contains garbage. Our previous
> behaviour (always set FCR[2:1] to reset the FIFO) has been around for a
> long time, so I would not be surprised to find other devices relying
> upon it.

It is well possible, but I'd like to understand what really happens
here, not just guess.

> I'm also saying that if the FIFOs are enabled during boot then your
> patch will leave them enabled after serial8250_do_startup() calls
> serial8250_clear_fifos(), which a comment in serial8250_do_startup()
> clearly states is not the expected behaviour:

In that case, that needs to be fixed. But serial8250_clear_fifos()
should only do what the name says -- clear FIFOs -- not disable them.

>> Clear the FIFO buffers and disable them.
>> (they will be reenabled in set_termios())
> 
> (From https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/8250/8250_port.c?h=v4.20-rc6#n2209)
> 
> And further, with your patch serial8250_do_shutdown() will leave the
> FIFO enabled which again does not match what comments suggest it expects
> ("Disable break condition and FIFOs").
> 
>> What exactly does your programming example for the JZ4780 say about the
>> FIFO clearing ? And does it work in that example ?
> 
> It says to set FCR[2:1] to reset the FIFO after enabling it, which as
> far as I can tell from the PC16550D documentation would not be necessary
> there because when you enable the FIFO it would automatically be reset.
> Linux did this until your patch.

Linux sets the FCR[2:1] if the FIFO is enabled even now.

>>>>> @@ -558,25 +558,26 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
>>>>>  	if (p->capabilities & UART_CAP_FIFO) {
>>>>>  		/*
>>>>>  		 * Make sure to avoid changing FCR[7:3] and ENABLE_FIFO bits.
>>>>> -		 * In case ENABLE_FIFO is not set, there is nothing to flush
>>>>> -		 * so just return. Furthermore, on certain implementations of
>>>>> -		 * the 8250 core, the FCR[7:3] bits may only be changed under
>>>>> -		 * specific conditions and changing them if those conditions
>>>>> -		 * are not met can have nasty side effects. One such core is
>>>>> -		 * the 8250-omap present in TI AM335x.
>>>>> +		 * On certain implementations of the 8250 core, the FCR[7:3]
>>>>> +		 * bits may only be changed under specific conditions and
>>>>> +		 * changing them if those conditions are not met can have nasty
>>>>> +		 * side effects. One such core is the 8250-omap present in TI
>>>>> +		 * AM335x.
>>>>>  		 */
>>>>>  		fcr = serial_in(p, UART_FCR);
>>>>> +		serial_out(p, UART_FCR, fcr | clr_mask);
>>>>> +		serial_out(p, UART_FCR, fcr & ~clr);
>>>>
>>>> Note that, if I understand the patch correctly, this will _not_ restore
>>>> the original (broken) behavior. The original behavior cleared the entire
>>>> FCR at the end, which cleared even bits that were not supposed to be
>>>> cleared .
>>>
>>> It will restore the original behaviour with regards to disabling the
>>> FIFOs, so long as callers that expect that use
>>> serial8250_clear_and_disable_fifos().
>>
>> Does your platform need the FIFO to be explicitly disabled for it to be
>> cleared, can you confirm that ? And if so, does this apply to other
>> platforms with 8250 UART or is this specific to JZ4780 implementation of
>> the UART block ?
>>
>> I just remembered U-Boot has this patch for JZ4780 UART [1], which
>> touches the FCR UME bit, so the FCR behavior on JZ4780 does differ from
>> the generic 8250 core. Could it be that this is what you're hitting ?
> 
> No - we already set the UME bit & this has all worked fine until your
> patch changed the FIFO reset behaviour.

The UME bit is in the FCR, serial8250_clear_fifos() originally cleared
it, cfr:
-               serial_out(p, UART_FCR, 0);
in f6aa5beb45be27968a4df90176ca36dfc4363d37 . So the code was originally
completely disabling the UART on JZ4780 .

-- 
Best regards,
Marek Vasut
