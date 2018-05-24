Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968221AbeEXRng (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:43:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37757 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966744AbeEXRnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:43:35 -0400
Date: Thu, 24 May 2018 19:43:25 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: imx: disable UCR4_OREN on shutdown
Message-ID: <20180524174325.ym5k7uhco3ylslaa@pengutronix.de>
References: <20180524173024.20936-1-sebastian.reichel@collabora.co.uk>
 <20180524173024.20936-3-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524173024.20936-3-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 07:30:24PM +0200, Sebastian Reichel wrote:
> UCR4_OREN is (depending on the configuration) enabled in startup,
> but is never disabled. Fix this by disabling it in shutdown.
> 
> Reported-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/tty/serial/imx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index a0fc0327c8a5..31e1df8a8d29 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1422,7 +1422,7 @@ static void imx_uart_shutdown(struct uart_port *port)
>  {
>  	struct imx_port *sport = (struct imx_port *)port;
>  	unsigned long flags;
> -	u32 ucr1, ucr2;
> +	u32 ucr1, ucr2, ucr4;
>  
>  	if (sport->dma_is_enabled) {
>  		dmaengine_terminate_sync(sport->dma_chan_tx);
> @@ -1452,6 +1452,10 @@ static void imx_uart_shutdown(struct uart_port *port)
>  	ucr2 = imx_uart_readl(sport, UCR2);
>  	ucr2 &= ~(UCR2_TXEN | UCR2_ATEN);
>  	imx_uart_writel(sport, ucr2, UCR2);
> +
> +	ucr4 = imx_uart_readl(sport, UCR4);
> +	ucr4 &= ~UCR4_OREN;
> +	imx_uart_writel(sport, ucr4, UCR4);

Not sure this is necessary, but I assume it cannot hurt either, so

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
