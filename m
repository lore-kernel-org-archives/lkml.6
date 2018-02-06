Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeBFMvE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:51:04 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:59696 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeBFMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:50:57 -0500
X-Auth-Info: 7eNfrCcgV2ihtbi+D1LkRXO82JJck1OnTf5hAJ+34tY=
Subject: Re: [PATCH 1/2] net, can, ifi: fix "write buffer full" error
To: Heiko Schocher <hs@denx.de>, linux-can@vger.kernel.org
Cc: Markus Marb <markus@marb.org>, netdev@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>
References: <20180206120235.15167-1-hs@denx.de>
From: Marek Vasut <marex@denx.de>
Message-ID: <93198cab-7eeb-b4b6-bc0b-279c93da32cd@denx.de>
Date: Tue, 6 Feb 2018 13:48:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206120235.15167-1-hs@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2018 01:02 PM, Heiko Schocher wrote:
> the driver reads in the ISR first the IRQpending register,
> and clears after that in a write *all* bits in it.
> 
> It could happen that the isr register raise bits between
> this 2 register accesses, which leads in lost bits ...
> 
> In case it clears "TX message sent successfully", the driver
> never sends any Tx data, and buffers to userspace run over.
> 
> Fixed this:
> clear only the bits in the IRQpending register, the
> driver had read.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
> 
>  drivers/net/can/ifi_canfd/ifi_canfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
> index 2772d05ff11c..05feb8177936 100644
> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
> @@ -607,7 +607,7 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
>  		return IRQ_NONE;
>  
>  	/* Clear all pending interrupts but ErrWarn */
> -	writel(clr_irq_mask, priv->base + IFI_CANFD_INTERRUPT);
> +	writel(isr & clr_irq_mask, priv->base + IFI_CANFD_INTERRUPT);
>  
>  	/* RX IRQ or bus warning, start NAPI */
>  	if (isr & rx_irq_mask) {
> 


-- 
Best regards,
Marek Vasut
