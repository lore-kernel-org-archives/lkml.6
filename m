Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9979C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F912082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbeLPWMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 17:12:46 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:56752 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeLPWMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 17:12:46 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43Hz6z1WgLz1qxPv;
        Sun, 16 Dec 2018 23:12:42 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43Hz6y5wPDz1qqkw;
        Sun, 16 Dec 2018 23:12:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id NtzQMBRQDqFe; Sun, 16 Dec 2018 23:12:41 +0100 (CET)
X-Auth-Info: SuV4hhHjKXsIQAhuxtjZrRLxUwhb+gg08wM5UmNwOE4=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 16 Dec 2018 23:12:41 +0100 (CET)
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Paul Burton <paul.burton@mips.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <b629cc98-8c80-bcc2-e973-94e1795b883e@denx.de>
Date:   Sun, 16 Dec 2018 23:11:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/2018 10:52 PM, Ezequiel Garcia wrote:
> On Sun, 16 Dec 2018 at 18:45, Marek Vasut <marex@denx.de> wrote:
> [skips discussion]
>>
>>> Ultimately it's Greg's decision but it sounds like you're asking me to
>>> say it's OK to break the JZ4780 in a stable kernel with a patch that I
>>> think would be risky anyway, and I won't do that.
>>
>> I am saying this revert breaks AM335x, so this is a stalemate. I had a
>> discussion with Ezequiel (on CC) and he seems to have a different
>> smaller patch coming for this problem.
>>
> 
> Can you guys test this? Note that serial8250_do_startup has a comment
> stating clearly that it has the intention of disabling the FIFOs,
> so it seems this is the right thing to do.
> 
> Paul, this removes the garbage on my CI20 (rev.1)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index c39482b96111..fac19cbc51d1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2209,10 +2209,11 @@ int serial8250_do_startup(struct uart_port *port)
>         /*
>          * Clear the FIFO buffers and disable them.
>          * (they will be reenabled in set_termios())
>          */
>         serial8250_clear_fifos(up);
> +       serial_out(up, UART_FCR, 0);
> 
>         /*
>          * Clear the interrupt registers.
>          */
>         serial_port_in(port, UART_LSR);
> 
> 

On AM335x pocketbeagle
Tested-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut
