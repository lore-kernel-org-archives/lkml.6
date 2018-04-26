Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeDZTu4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:50:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50043 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeDZTuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:50:55 -0400
Date: Thu, 26 Apr 2018 21:50:51 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Marc Zyngier <marc.zyngier@arm.com>
cc: Jason Cooper <jason@lakedaemon.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] genirq/msi: Limit level-triggered MSI to platform
 devices
In-Reply-To: <20180423103440.26592-3-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.21.1804262148420.1596@nanos.tec.linutronix.de>
References: <20180423103440.26592-1-marc.zyngier@arm.com> <20180423103440.26592-3-marc.zyngier@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018, Marc Zyngier wrote:

> Nobody would be insane enough to try and use level triggered
> MSIs on PCI, but let's make sure it doesn't happen. Also,
> let's mandate that the irqchip backing the platform MSI domain
> is providing an irq_set_type method (or the whole thing would
> be a bit useless).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/base/platform-msi.c | 3 +++
>  drivers/pci/msi.c           | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 8e22073aeeed..3b9694a6beaa 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -101,6 +101,9 @@ static void platform_msi_update_chip_ops(struct msi_domain_info *info)
>  		chip->irq_set_affinity = msi_domain_set_affinity;
>  	if (!chip->irq_write_msi_msg)
>  		chip->irq_write_msi_msg = platform_msi_write_msg;
> +	if (WARN_ON((info->flags & MSI_FLAG_LEVEL_CAPABLE) &&
> +		    !chip->irq_set_type))

Shouldn't we just require something like IRQCHIP_SUPPORTS_MSI_LEVEL or such
in chip->flags being set instead?

Thanks,

	tglx
