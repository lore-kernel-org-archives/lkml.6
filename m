Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755762AbeDZMa6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:30:58 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:57173 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeDZMaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:30:55 -0400
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="13311564"
Date: Thu, 26 Apr 2018 14:30:09 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: David Engraf <david.engraf@sysgo.com>
CC: <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] i2c: at91: Read all available bytes at once
Message-ID: <20180426123009.GZ13305@rfolt0960.corp.atmel.com>
Mail-Followup-To: David Engraf <david.engraf@sysgo.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180426082558.GX13305@rfolt0960.corp.atmel.com>
 <20180426095314.12758-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180426095314.12758-1-david.engraf@sysgo.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 11:53:14AM +0200, David Engraf wrote:
> With FIFO enabled it is possible to read multiple bytes
> at once in the interrupt handler as long as RXRDY is
> set. This may also reduce the number of interrupts.
> 
> This patch polls RXRDY and reads all available bytes at
> once.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks a lot David.

Regards

Ludovic

> ---
>  drivers/i2c/busses/i2c-at91.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index bfd1fdff64a9..9caee5b79eac 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -518,8 +518,16 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
>  	 * the RXRDY interrupt first in order to not keep garbage data in the
>  	 * Receive Holding Register for the next transfer.
>  	 */
> -	if (irqstatus & AT91_TWI_RXRDY)
> -		at91_twi_read_next_byte(dev);
> +	if (irqstatus & AT91_TWI_RXRDY) {
> +		/*
> +		 * Read all available bytes at once by polling RXRDY usable w/ and w/o
> +		 * FIFO. With FIFO enabled we could also read RXFL and avoid polling
> +		 * RXRDY.
> +		 */
> +		do {
> +			at91_twi_read_next_byte(dev);
> +		} while (at91_twi_read(dev, AT91_TWI_SR) & AT91_TWI_RXRDY);
> +	}
>  
>  	/*
>  	 * When a NACK condition is detected, the I2C controller sets the NACK,
> -- 
> 2.14.1
> 
