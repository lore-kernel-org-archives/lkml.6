Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F94C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C7620820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C7620820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408276AbeKWSvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:51:24 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48985 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732073AbeKWSvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:51:24 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gQ6VY-0005N0-4s; Fri, 23 Nov 2018 09:08:12 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gQ6VX-0008WU-BX; Fri, 23 Nov 2018 09:08:11 +0100
Date:   Fri, 23 Nov 2018 09:08:11 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, fabio.estevam@nxp.com,
        s.hauer@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] serial: imx: unprepare console clocks on remove
Message-ID: <20181123080811.nezdtq47fqd265kx@pengutronix.de>
References: <20181114174940.7865-1-stefan@agner.ch>
 <20181114174940.7865-2-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181114174940.7865-2-stefan@agner.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 06:49:39PM +0100, Stefan Agner wrote:
> Currently imx_uart_console_setup() prepares clocks which do not
> get unprepared anywhere. Check whether the console has been used
> by testing if index is set and unprepare clocks in this case.
> 
> This makes sure that clocks are properly unprepared after the
> console device has been unbound.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/tty/serial/imx.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 313c3b1900a8..757c91e5105a 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2085,7 +2085,7 @@ static struct console imx_uart_console = {
>  	.data		= &imx_uart_uart_driver,
>  };
>  
> -#define IMX_CONSOLE	&imx_uart_console
> +#define IMX_CONSOLE	(&imx_uart_console)
>  
>  #ifdef CONFIG_OF
>  static void imx_uart_console_early_putchar(struct uart_port *port, int ch)
> @@ -2378,8 +2378,17 @@ static int imx_uart_probe(struct platform_device *pdev)
>  static int imx_uart_remove(struct platform_device *pdev)
>  {
>  	struct imx_port *sport = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
> +
> +	if (IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE) && IMX_CONSOLE->index >= 0) {
> +		clk_unprepare(sport->clk_ipg);
> +		clk_unprepare(sport->clk_per);
> +		IMX_CONSOLE->index = -1;
> +	}
>  
> -	return uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
> +	return ret;

I doubt this is right. imx_uart_console_setup is called once, and
if the console is on (say) ttymxc0 you don't want to unprepare the
clocks if ttymxc3 gets unbound.

So I think this cleanup must go into imx_uart_exit().

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
