Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FECC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C9E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C9E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756606AbeFSJHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:07:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45546 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756178AbeFSJHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:07:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 089661435;
        Tue, 19 Jun 2018 02:07:11 -0700 (PDT)
Received: from [10.1.78.251] (unknown [10.1.78.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 719A63F25D;
        Tue, 19 Jun 2018 02:07:09 -0700 (PDT)
Subject: Re: [PATCH] serial: mps2-uart: Initialize early console
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1529384097-1631-1-git-send-email-linux@roeck-us.net>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <173551dd-3632-08a6-ec42-2ee416ccb9ad@arm.com>
Date:   Tue, 19 Jun 2018 10:07:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1529384097-1631-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 19/06/18 05:54, Guenter Roeck wrote:
> The early console code for mps2-uart assumes that the serial hardware is
> enabled for transmit when the system boots. However, this is not the case
> after reset. This results in a hang in mps2_early_putchar() if the serial
> transmitter is not enabled by a boot loader or ROM monitor.

I was under impression that for earlycon there is an assumption/requirement
that the serial port must already be setup and configured. For instance, I 
see such requirement for pl011. So it looks like boot code's fault not to
enable serial (for mps2 it needs to setup BAUDDIV as well).

I'm not against the patch per se, but I'd like to hear if my understanding of
earlycon requirements is correct or not.

Cheers
Vladimir

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/tty/serial/mps2-uart.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> index 9f8f63719126..0743a0551ce1 100644
> --- a/drivers/tty/serial/mps2-uart.c
> +++ b/drivers/tty/serial/mps2-uart.c
> @@ -448,6 +448,14 @@ static struct console mps2_uart_console = {
>  
>  #define MPS2_SERIAL_CONSOLE (&mps2_uart_console)
>  
> +static void mps2_early_init(struct uart_port *port)
> +{
> +	u8 control = readb(port->membase + UARTn_CTRL);
> +
> +	control |= UARTn_CTRL_TX_ENABLE;
> +	writeb(control, port->membase + UARTn_CTRL);
> +}
> +
>  static void mps2_early_putchar(struct uart_port *port, int ch)
>  {
>  	while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
> @@ -469,6 +477,7 @@ static int __init mps2_early_console_setup(struct earlycon_device *device,
>  	if (!device->port.membase)
>  		return -ENODEV;
>  
> +	mps2_early_init(&device->port);
>  	device->con->write = mps2_early_write;
>  
>  	return 0;
> 

