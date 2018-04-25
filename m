Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755216AbeDYPJ6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:09:58 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:12572 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755206AbeDYPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:09:55 -0400
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="10901281"
Date: Wed, 25 Apr 2018 17:08:53 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: David Engraf <david.engraf@sysgo.com>
CC: <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: at91: Read all available bytes at once
Message-ID: <20180425150853.GU13305@rfolt0960.corp.atmel.com>
Mail-Followup-To: David Engraf <david.engraf@sysgo.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180418124055.21333-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180418124055.21333-1-david.engraf@sysgo.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Apr 18, 2018 at 02:40:55PM +0200, David Engraf wrote:
> With FIFO enabled it is possible to read multiple bytes
> at once in the interrupt handler as long as RXRDY is
> set. This may also reduce the number of interrupts.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> ---
>  drivers/i2c/busses/i2c-at91.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index bfd1fdff64a9..d01c2b2384bd 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -518,8 +518,12 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
>  	 * the RXRDY interrupt first in order to not keep garbage data in the
>  	 * Receive Holding Register for the next transfer.
>  	 */
> -	if (irqstatus & AT91_TWI_RXRDY)
> -		at91_twi_read_next_byte(dev);
> +	if (irqstatus & AT91_TWI_RXRDY) {
> +		/* read all available bytes at once when FIFO is used */
> +		do {
> +			at91_twi_read_next_byte(dev);
> +		} while (at91_twi_read(dev, AT91_TWI_SR) & AT91_TWI_RXRDY);

You can avoid this check by using the RXFL field to know the number of
data you can read. Did you try to use it? If yes, did you notice some issues?

Regards

Ludovic

> +	}
>  
>  	/*
>  	 * When a NACK condition is detected, the I2C controller sets the NACK,
> -- 
> 2.14.1
> 
