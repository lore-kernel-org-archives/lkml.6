Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB718C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41292084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbeLPUdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 15:33:17 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:57784 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbeLPUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 15:33:16 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43Hww81vvJz1qx96;
        Sun, 16 Dec 2018 21:33:12 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43Hww8192mz1qsZQ;
        Sun, 16 Dec 2018 21:33:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id AYa6thiwyWgJ; Sun, 16 Dec 2018 21:33:10 +0100 (CET)
X-Auth-Info: yaOdvTUCrt+hQr4sz1xTUa37B7MsjCS97HCky7vH1nM=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 16 Dec 2018 21:33:10 +0100 (CET)
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
Message-ID: <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
Date:   Sun, 16 Dec 2018 21:32:19 +0100
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
I am unable to test it on such a short notice as I'm currently ill, so I
cannot tell if your change breaks the OMAP3/AM335x boards or not. Given
that there are very few CI20 boards in use, I'd like to ask you for some
extra time to investigate this on the OMAP3 too.

btw what strikes me as curious is that this patch emerged shortly after
Ezequiel re-posted the CI20 U-Boot patches after an year-long hiatus, is
it somehow related ?

-- 
Best regards,
Marek Vasut
