Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEFAC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C23120870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C23120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeLMAze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:55:34 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:59673 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLMAzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:55:33 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43FZwf6xWYz1qvTn;
        Thu, 13 Dec 2018 01:55:30 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43FZwf6JC5z1qstg;
        Thu, 13 Dec 2018 01:55:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id fp4Bp9Jo87Vz; Thu, 13 Dec 2018 01:55:29 +0100 (CET)
X-Auth-Info: AYmp2zLKuldguvLK+/XplJGm3BUSmbkjgN7BK5hRdO4=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 13 Dec 2018 01:55:29 +0100 (CET)
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
To:     Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
References: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
From:   Marek Vasut <marex@denx.de>
Message-ID: <cd3e2787-48e1-ce70-0fa7-94df6dc81794@denx.de>
Date:   Thu, 13 Dec 2018 01:55:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2018 01:41 AM, Paul Burton wrote:
> Hi Marek / Greg / all,
> 
> On Mon, Sep 03, 2018 at 12:44:52AM +0000, Marek Vasut wrote:
>> The 8250 FIFOs indeed need to be cleared after stopping transmission in
>> RS485 mode without SER_RS485_RX_DURING_TX flag set. But there are two
>> problems with the approach taken by the previous patch from Fixes tag.
>>
>> First, serial8250_clear_fifos() should clear fifos, but what it really
>> does is it enables the FIFOs unconditionally if present, clears them
>> and then sets the FCR register to zero, which effectively disables the
>> FIFOs. In case the FIFO is disabled, enabling it and clearing it makes
>> no sense and in fact can trigger misbehavior of the 8250 core. Moreover,
>> the FCR register may contain other FIFO configuration bits which may not
>> be writable unconditionally and writing them incorrectly can trigger
>> misbehavior of the 8250 core too. (ie. AM335x UART swallows the first
>> byte and retransmits the last byte twice because of this FCR write).
>>
>> Second, serial8250_clear_and_reinit_fifos() completely reloads the FCR,
>> but what really has to happen at the end of the RS485 transmission is
>> clearing of the FIFOs and nothing else.
>>
>> This patch repairs serial8250_clear_fifos() so that it really only
>> clears the FIFOs by operating on FCR[2:1] bits and leaves all the
>> other bits alone. It also undoes serial8250_clear_and_reinit_fifos()
>> from __do_stop_tx_rs485() as serial8250_clear_fifos() is sufficient.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Fixes: 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subsequent transmits to break")
>> Cc: Daniel Jedrychowski <avistel@gmail.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>> NOTE: I am not entirely certain this won't break some other hardware,
>>       esp. since there might be dependencies on the weird previous
>>       behavior of the serial8250_clear_fifos() somewhere.
> 
> This patch has broken the UART on my Ingenic JZ4780 based MIPS Creator
> Ci20 board. After this patch the system seems to detect garbage input
> that is recognized as SysRq triggers which spam the console & eventually
> reset the system.
> 
> One thing of note is that both serial8250_do_startup() &
> serial8250_do_shutdown() contain comments that explicitly state their
> expectation that the FIFOs will be disabled by serial8250_clear_fifos(),
> which is no longer true after this patch.
> 
> I found that restoring the old behaviour for serial8250_do_startup() is
> enough to make my system work again, but this is obviously a hack:
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index f776b3eafb96..8def02933d19 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2210,7 +2210,11 @@ int serial8250_do_startup(struct uart_port *port)
>  	 * Clear the FIFO buffers and disable them.
>  	 * (they will be reenabled in set_termios())
>  	 */
> -	serial8250_clear_fifos(up);
> +	if (up->capabilities & UART_CAP_FIFO) {
> +		serial_port_out(port, UART_FCR, UART_FCR_ENABLE_FIFO);
> +		serial8250_clear_fifos(up);
> +		serial_port_out(port, UART_FCR, 0);
> +	}
>  
>  	/*
>  	 * Clear the interrupt registers.
> 
> Any ideas? Given the mismatch between this patch & comments that clearly
> expect the old behaviour I think the __do_stop_tx_rs485() case probably
> needs something different to other callers.

The problem the original patch fixed was that too many bits were cleared
in the FCR on OMAP3/AM335x . If you have such a system (a beaglebone or
similar), you can come up with a solution which can accommodate both the
JZ4780 and AM335x. Can you take a look ? The datasheet for both should
be public too.

-- 
Best regards,
Marek Vasut
