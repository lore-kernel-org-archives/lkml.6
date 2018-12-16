Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E43C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361B2206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbeLPVWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 16:22:30 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:38757 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeLPVW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 16:22:29 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43Hy0x46yBz1qvTy;
        Sun, 16 Dec 2018 22:22:25 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43Hy0x3Gf5z1qsb6;
        Sun, 16 Dec 2018 22:22:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id lUaMeyXTAIrz; Sun, 16 Dec 2018 22:22:23 +0100 (CET)
X-Auth-Info: ZSWsYNyN3SunfP6Lbf5IeClkoWAGN5i+mS7BHp/noOU=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 16 Dec 2018 22:22:23 +0100 (CET)
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
To:     Paul Burton <paul.burton@mips.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <93a3c76b-f4ba-57ae-9d80-6e945b4f3181@denx.de>
Date:   Sun, 16 Dec 2018 22:08:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181216200833.27928-1-paul.burton@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/2018 09:10 PM, Paul Burton wrote:
> Commit f6aa5beb45be ("serial: 8250: Fix clearing FIFOs in RS485 mode
> again") makes a change to FIFO clearing code which its commit message
> suggests was intended to be specific to use with RS485 mode, however:
> 
>  1) The change made does not just affect __do_stop_tx_rs485(), it also
>     affects other uses of serial8250_clear_fifos() including paths for
>     starting up, shutting down or auto-configuring a port regardless of
>     whether it's an RS485 port or not.
> 
>  2) It makes the assumption that resetting the FIFOs is a no-op when
>     FIFOs are disabled, and as such it checks for this case & explicitly
>     avoids setting the FIFO reset bits when the FIFO enable bit is
>     clear. A reading of the PC16550D manual would suggest that this is
>     OK since the FIFO should automatically be reset if it is later
>     enabled, but we support many 16550-compatible devices and have never
>     required this auto-reset behaviour for at least the whole git era.
>     Starting to rely on it now seems risky, offers no benefit, and
>     indeed breaks at least the Ingenic JZ4780's UARTs which reads
>     garbage when the RX FIFO is enabled if we don't explicitly reset it.
> 
>  3) By only resetting the FIFOs if they're enabled, the behaviour of
>     serial8250_do_startup() during boot now depends on what the value of
>     FCR is before the 8250 driver is probed. This in itself seems
>     questionable and leaves us with FCR=0 & no FIFO reset if the UART
>     was used by 8250_early, otherwise it depends upon what the
>     bootloader left behind.
> 
>  4) Although the naming of serial8250_clear_fifos() may be unclear, it
>     is clear that callers of it expect that it will disable FIFOs. Both
>     serial8250_do_startup() & serial8250_do_shutdown() contain comments
>     to that effect, and other callers explicitly re-enable the FIFOs
>     after calling serial8250_clear_fifos(). The premise of that patch
>     that disabling the FIFOs is incorrect therefore seems wrong.
> 
> For these reasons, this reverts commit f6aa5beb45be ("serial: 8250: Fix
> clearing FIFOs in RS485 mode again").
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Fixes: f6aa5beb45be ("serial: 8250: Fix clearing FIFOs in RS485 mode again").
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Jedrychowski <avistel@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: stable <stable@vger.kernel.org> # 4.10+
> ---
> I did suggest an alternative approach which would rename
> serial8250_clear_fifos() and split it into 2 variants - one that
> disables FIFOs & one that does not, then use the latter in
> __do_stop_tx_rs485():
> 
> https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-laptop/
> 
> However I have no access to the OMAP3 hardware that Marek's patch was
> attempting to fix & have heard nothing back with regards to him testing
> that approach, so here's a simple revert that fixes the Ingenic JZ4780.
> 
> I've marked for stable back to v4.10 presuming that this is how far the
> broken patch may be backported, given that this is where commit
> 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subsequent
> transmits to break") that it tried to fix was introduced.

OK, I tested this on AM335x / OMAP3 and the system is again broken, so
that's a NAK.

> ---
>  drivers/tty/serial/8250/8250_port.c | 29 +++++------------------------
>  1 file changed, 5 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index f776b3eafb96..3f779d25ec0c 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -552,30 +552,11 @@ static unsigned int serial_icr_read(struct uart_8250_port *up, int offset)
>   */
>  static void serial8250_clear_fifos(struct uart_8250_port *p)
>  {
> -	unsigned char fcr;
> -	unsigned char clr_mask = UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
> -
>  	if (p->capabilities & UART_CAP_FIFO) {
> -		/*
> -		 * Make sure to avoid changing FCR[7:3] and ENABLE_FIFO bits.
> -		 * In case ENABLE_FIFO is not set, there is nothing to flush
> -		 * so just return. Furthermore, on certain implementations of
> -		 * the 8250 core, the FCR[7:3] bits may only be changed under
> -		 * specific conditions and changing them if those conditions
> -		 * are not met can have nasty side effects. One such core is
> -		 * the 8250-omap present in TI AM335x.
> -		 */
> -		fcr = serial_in(p, UART_FCR);
> -
> -		/* FIFO is not enabled, there's nothing to clear. */
> -		if (!(fcr & UART_FCR_ENABLE_FIFO))
> -			return;
> -
> -		fcr |= clr_mask;
> -		serial_out(p, UART_FCR, fcr);
> -
> -		fcr &= ~clr_mask;
> -		serial_out(p, UART_FCR, fcr);
> +		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
> +		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
> +			       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
> +		serial_out(p, UART_FCR, 0);
>  	}
>  }
>  
> @@ -1467,7 +1448,7 @@ static void __do_stop_tx_rs485(struct uart_8250_port *p)
>  	 * Enable previously disabled RX interrupts.
>  	 */
>  	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> -		serial8250_clear_fifos(p);
> +		serial8250_clear_and_reinit_fifos(p);
>  
>  		p->ier |= UART_IER_RLSI | UART_IER_RDI;
>  		serial_port_out(&p->port, UART_IER, p->ier);
> 


-- 
Best regards,
Marek Vasut
