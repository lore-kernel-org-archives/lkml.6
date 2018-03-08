Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeCHUZd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:25:33 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46400 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCHUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:25:31 -0500
X-Google-Smtp-Source: AG47ELsm5lXbq24+e/l50nql70Da5i3mK9lhhoGEizVfA/MmZGnKgaugyYbyBb+LzZjGT6GEF4ylqA==
Subject: Re: [PATCH] net: phy: Move interrupt check from phy_check to
 phy_interrupt
To: Brad Mouring <brad.mouring@ni.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180307225042.2205-1-brad.mouring@ni.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <b3d649a6-5d36-ba9c-86c8-1d4eb7c6a05b@cogentembedded.com>
Date: Thu, 8 Mar 2018 23:25:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180307225042.2205-1-brad.mouring@ni.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2018 01:50 AM, Brad Mouring wrote:

> If multiple phys share the same interrupt (e.g. a multi-phy chip),
> the first device registered is the only one checked as phy_interrupt
> will always return IRQ_HANDLED if the first phydev is not halted.
> Move the interrupt check into phy_interrupt and, if it was not this
> phydev, return IRQ_NONE to allow other devices on this irq a chance
> to check if it was their interrupt.
> 
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> ---
>  drivers/net/phy/phy.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index e3e29c2b028b..ff1aa815568f 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -632,6 +632,12 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
>  	if (PHY_HALTED == phydev->state)
>  		return IRQ_NONE;		/* It can't be ours.  */
>  
> +	if (phy_interrupt_is_valid(phydev)) {
> +		if (phydev->drv->did_interrupt &&
> +			!phydev->drv->did_interrupt(phydev))

   Forgot to mention: DaveM prefers that continuation lines start under the 1st
column after ( on the broken up line. The way you did it this line blends with
the next one (they shouldn't).

> +			return IRQ_NONE;
> +	}
> +
>  	phy_change(phydev);
>  
>  	return IRQ_HANDLED;
[...]

MBR, Sergei
