Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BfStCko2GVvNXAAAmS7hNA
	; Thu, 07 Jun 2018 13:42:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 180EA608BA; Thu,  7 Jun 2018 13:42:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6C0F3601B4;
	Thu,  7 Jun 2018 13:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C0F3601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbeFGNmb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:42:31 -0400
Received: from mout01.posteo.de ([185.67.36.141]:54064 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753342AbeFGNm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:42:29 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout01.posteo.de (Postfix) with ESMTPS id 5F45920ED8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 15:42:27 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 411mtk3tBtz9rxp;
        Thu,  7 Jun 2018 15:42:22 +0200 (CEST)
Subject: Re: [PATCH v6 6/6] tty/serial: atmel: change the driver to work under
 at91-usart mfd
To: Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, gregkh@linuxfoundation.org
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20180607110020.20565-1-radu.pirea@microchip.com>
 <20180607110020.20565-7-radu.pirea@microchip.com>
From: Richard Genoud <richard.genoud@gmail.com>
Message-ID: <42c20ca1-6d27-71c2-83cf-2e5f113e8dc9@sorico.fr>
Date: Thu, 7 Jun 2018 15:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607110020.20565-7-radu.pirea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 13:00, Radu Pirea wrote:
> This patch modifies the place where resources and device tree properties
> are searched.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  drivers/tty/serial/Kconfig        |  1 +
>  drivers/tty/serial/atmel_serial.c | 42 ++++++++++++++++++++-----------
>  2 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 3682fd3e960c..25e55332f8b1 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -119,6 +119,7 @@ config SERIAL_ATMEL
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	select SERIAL_CORE
>  	select SERIAL_MCTRL_GPIO if GPIOLIB
> +	select MFD_AT91_USART
>  	help
>  	  This enables the driver for the on-chip UARTs of the Atmel
>  	  AT91 processors.
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index df46a9e88c34..5ef8a6a6fe17 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -193,8 +193,7 @@ static struct console atmel_console;
>  
>  #if defined(CONFIG_OF)
>  static const struct of_device_id atmel_serial_dt_ids[] = {
> -	{ .compatible = "atmel,at91rm9200-usart" },
> -	{ .compatible = "atmel,at91sam9260-usart" },
> +	{ .compatible = "atmel,at91rm9200-usart-serial" },
>  	{ /* sentinel */ }
>  };
>  #endif
> @@ -915,6 +914,7 @@ static void atmel_tx_dma(struct uart_port *port)
>  static int atmel_prepare_tx_dma(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	struct device *mfd_dev = port->dev->parent;
>  	dma_cap_mask_t		mask;
>  	struct dma_slave_config config;
>  	int ret, nent;
> @@ -922,7 +922,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	atmel_port->chan_tx = dma_request_slave_channel(port->dev, "tx");
> +	atmel_port->chan_tx = dma_request_slave_channel(mfd_dev, "tx");
>  	if (atmel_port->chan_tx == NULL)
>  		goto chan_err;
>  	dev_info(port->dev, "using %s for tx DMA transfers\n",
> @@ -1093,6 +1093,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
>  static int atmel_prepare_rx_dma(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	struct device *mfd_dev = port->dev->parent;
>  	struct dma_async_tx_descriptor *desc;
>  	dma_cap_mask_t		mask;
>  	struct dma_slave_config config;
> @@ -1104,7 +1105,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_CYCLIC, mask);
>  
> -	atmel_port->chan_rx = dma_request_slave_channel(port->dev, "rx");
> +	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
>  	if (atmel_port->chan_rx == NULL)
>  		goto chan_err;
>  	dev_info(port->dev, "using %s for rx DMA transfers\n",
> @@ -2222,8 +2223,8 @@ static const char *atmel_type(struct uart_port *port)
>   */
>  static void atmel_release_port(struct uart_port *port)
>  {
> -	struct platform_device *pdev = to_platform_device(port->dev);
> -	int size = pdev->resource[0].end - pdev->resource[0].start + 1;
> +	struct platform_device *mpdev = to_platform_device(port->dev->parent);
> +	int size = resource_size(mpdev->resource);
>  
>  	release_mem_region(port->mapbase, size);
>  
> @@ -2238,8 +2239,8 @@ static void atmel_release_port(struct uart_port *port)
>   */
>  static int atmel_request_port(struct uart_port *port)
>  {
> -	struct platform_device *pdev = to_platform_device(port->dev);
> -	int size = pdev->resource[0].end - pdev->resource[0].start + 1;
> +	struct platform_device *mpdev = to_platform_device(port->dev->parent);
> +	int size = resource_size(mpdev->resource);
>  
>  	if (!request_mem_region(port->mapbase, size, "atmel_serial"))
>  		return -EBUSY;
> @@ -2341,27 +2342,28 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
>  {
>  	int ret;
>  	struct uart_port *port = &atmel_port->uart;
> +	struct platform_device *mpdev = to_platform_device(pdev->dev.parent);
>  
>  	atmel_init_property(atmel_port, pdev);
>  	atmel_set_ops(port);
>  
> -	uart_get_rs485_mode(&pdev->dev, &port->rs485);
> +	uart_get_rs485_mode(&mpdev->dev, &port->rs485);
>  
>  	port->iotype		= UPIO_MEM;
>  	port->flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
>  	port->ops		= &atmel_pops;
>  	port->fifosize		= 1;
>  	port->dev		= &pdev->dev;
> -	port->mapbase	= pdev->resource[0].start;
> -	port->irq	= pdev->resource[1].start;
> +	port->mapbase		= mpdev->resource[0].start;
> +	port->irq		= mpdev->resource[1].start;
>  	port->rs485_config	= atmel_config_rs485;
> -	port->membase	= NULL;
> +	port->membase		= NULL;
>  
>  	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
>  
>  	/* for console, the clock could already be configured */
>  	if (!atmel_port->clk) {
> -		atmel_port->clk = clk_get(&pdev->dev, "usart");
> +		atmel_port->clk = clk_get(&mpdev->dev, "usart");
>  		if (IS_ERR(atmel_port->clk)) {
>  			ret = PTR_ERR(atmel_port->clk);
>  			atmel_port->clk = NULL;
> @@ -2694,13 +2696,22 @@ static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_port,
>  static int atmel_serial_probe(struct platform_device *pdev)
>  {
>  	struct atmel_uart_port *atmel_port;
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = pdev->dev.parent->of_node;
>  	void *data;
>  	int ret = -ENODEV;
>  	bool rs485_enabled;
>  
>  	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
>  
> +	/*
> +	 * In device tree is no node with "atmel,at91rm9200-usart-serial"
I think you meant :
In device tree *there* is no...

With that,
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> +	 * as compatible string. This driver is probed by at91-usart mfd driver
> +	 * which is just a wrapper over the atmel_serial driver and
> +	 * spi-at91-usart driver. All attributes needed by this driver are
> +	 * found in of_node of parent.
> +	 */
> +	pdev->dev.of_node = np;
> +
>  	ret = of_alias_get_id(np, "serial");
>  	if (ret < 0)
>  		/* port id not found in platform data nor device-tree aliases:
> @@ -2835,6 +2846,7 @@ static int atmel_serial_remove(struct platform_device *pdev)
>  
>  	clk_put(atmel_port->clk);
>  	atmel_port->clk = NULL;
> +	pdev->dev.of_node = NULL;
>  
>  	return ret;
>  }
> @@ -2845,7 +2857,7 @@ static struct platform_driver atmel_serial_driver = {
>  	.suspend	= atmel_serial_suspend,
>  	.resume		= atmel_serial_resume,
>  	.driver		= {
> -		.name			= "atmel_usart",
> +		.name			= "atmel_usart_serial",
>  		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
>  	},
>  };
> 

Thanks !

Richard.
