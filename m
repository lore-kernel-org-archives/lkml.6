Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 852496070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbeFFLC4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:02:56 -0400
Received: from mout01.posteo.de ([185.67.36.141]:35074 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752346AbeFFLCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:02:55 -0400
Subject: Re: [PATCH v5 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
To: Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, gregkh@linuxfoundation.org
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20180604165943.31381-1-radu.pirea@microchip.com>
 <20180604165943.31381-7-radu.pirea@microchip.com>
From: Richard Genoud <richard.genoud@gmail.com>
Message-ID: <91db9d80-d530-9a00-3b40-80e335869ff4@sorico.fr>
Date: Wed, 6 Jun 2018 13:02:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604165943.31381-7-radu.pirea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in the subject:
changed->change


On 04/06/2018 18:59, Radu Pirea wrote:
> This patch modifies the place where resources and device tree properties
> are searched.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  drivers/tty/serial/Kconfig        |  1 +
>  drivers/tty/serial/atmel_serial.c | 41 ++++++++++++++++++-------------
>  2 files changed, 25 insertions(+), 17 deletions(-)
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
> index df46a9e88c34..5c74e03396ef 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -193,8 +193,8 @@ static struct console atmel_console;
>  
>  #if defined(CONFIG_OF)
>  static const struct of_device_id atmel_serial_dt_ids[] = {
> -	{ .compatible = "atmel,at91rm9200-usart" },
> -	{ .compatible = "atmel,at91sam9260-usart" },
> +	{ .compatible = "atmel,at91rm9200-usart-serial" },
> +	{ .compatible = "atmel,at91sam9260-usart-serial" },
Sorry, I didn't catch that before, but we can drop "atmel,at91sam9260-usart-serial" don't we ?
Only "atmel,at91rm9200-usart-serial" is used in the MFD driver.

>  	{ /* sentinel */ }
>  };
>  #endif
> @@ -915,6 +915,7 @@ static void atmel_tx_dma(struct uart_port *port)
>  static int atmel_prepare_tx_dma(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	struct device *mfd_dev = port->dev->parent;
>  	dma_cap_mask_t		mask;
>  	struct dma_slave_config config;
>  	int ret, nent;
> @@ -922,7 +923,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	atmel_port->chan_tx = dma_request_slave_channel(port->dev, "tx");
> +	atmel_port->chan_tx = dma_request_slave_channel(mfd_dev, "tx");
>  	if (atmel_port->chan_tx == NULL)
>  		goto chan_err;
>  	dev_info(port->dev, "using %s for tx DMA transfers\n",
> @@ -1093,6 +1094,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
>  static int atmel_prepare_rx_dma(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	struct device *mfd_dev = port->dev->parent;
>  	struct dma_async_tx_descriptor *desc;
>  	dma_cap_mask_t		mask;
>  	struct dma_slave_config config;
> @@ -1104,7 +1106,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_CYCLIC, mask);
>  
> -	atmel_port->chan_rx = dma_request_slave_channel(port->dev, "rx");
> +	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
>  	if (atmel_port->chan_rx == NULL)
>  		goto chan_err;
>  	dev_info(port->dev, "using %s for rx DMA transfers\n",
> @@ -1631,7 +1633,7 @@ static void atmel_tasklet_tx_func(unsigned long data)
>  static void atmel_init_property(struct atmel_uart_port *atmel_port,
>  				struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = pdev->dev.parent->of_node;
I think this is not needed anymore (cf atmel_probe())

>  
>  	/* DMA/PDC usage specification */
>  	if (of_property_read_bool(np, "atmel,use-dma-rx")) {
> @@ -2222,8 +2224,8 @@ static const char *atmel_type(struct uart_port *port)
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
> @@ -2238,8 +2240,8 @@ static void atmel_release_port(struct uart_port *port)
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
> @@ -2341,27 +2343,28 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
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
> @@ -2652,11 +2655,13 @@ static int atmel_serial_resume(struct platform_device *pdev)
>  static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_port,
>  				     struct platform_device *pdev)
>  {
> +	struct device *dev = pdev->dev.parent;
> +
Ditto

>  	atmel_port->fifo_size = 0;
>  	atmel_port->rts_low = 0;
>  	atmel_port->rts_high = 0;
>  
> -	if (of_property_read_u32(pdev->dev.of_node,
> +	if (of_property_read_u32(dev->of_node,
Ditto
>  				 "atmel,fifo-size",
>  				 &atmel_port->fifo_size))
>  		return;
> @@ -2694,13 +2699,15 @@ static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_port,
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
> +	pdev->dev.of_node = np;
> +
As atmel_serial device's of_node is now the parent node, the changes
in atmel_init_property() and atmel_serial_probe_fifos() are not needed anymore.
And maybe add a comment to explain that this is part of a MFD and all
the attributes are in the parent node, so we're using the MFD device node
instead of this device node.

>  	ret = of_alias_get_id(np, "serial");
>  	if (ret < 0)
>  		/* port id not found in platform data nor device-tree aliases:
> @@ -2845,7 +2852,7 @@ static struct platform_driver atmel_serial_driver = {
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
