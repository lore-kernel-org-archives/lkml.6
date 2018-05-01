Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755171AbeEAO4O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:56:14 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43839 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeEAO4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:56:13 -0400
X-Google-Smtp-Source: AB8JxZrra/Z1mjo/9G0a+DM08P7PIzp/2clzefDeVCFf0bn1O4P980lDm/pFiUsOxmIo3e0iQKlKJQ==
Date: Tue, 1 May 2018 09:56:11 -0500
From: Rob Herring <robh@kernel.org>
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/11] irqchip: stm32: add stm32mp1 support with
 hierarchy domain
Message-ID: <20180501145611.GA6842@rob-hp-laptop>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
 <1524759514-12392-8-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524759514-12392-8-git-send-email-ludovic.Barre@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 06:18:30PM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> Exti controller has been differently integrated on stm32mp1 SoC.
> A parent irq has only one external interrupt. A hierachy domain could
> be used. Handlers are call by parent, each parent interrupt could be
> masked and unmasked according to the needs.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../interrupt-controller/st,stm32-exti.txt         |   3 +
>  drivers/irqchip/irq-stm32-exti.c                   | 322 +++++++++++++++++++++
>  2 files changed, 325 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
> index edf03f0..136bd61 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
> @@ -5,11 +5,14 @@ Required properties:
>  - compatible: Should be:
>      "st,stm32-exti"
>      "st,stm32h7-exti"
> +    "st,stm32mp1-exti"
>  - reg: Specifies base physical address and size of the registers
>  - interrupt-controller: Indentifies the node as an interrupt controller
>  - #interrupt-cells: Specifies the number of cells to encode an interrupt
>    specifier, shall be 2
>  - interrupts: interrupts references to primary interrupt controller
> +  (only needed for exti controller with multiple exti under
> +  same parent interrupt: st,stm32-exti and st,stm32h7-exti")
>  
>  Example:
>  
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index b38c655..ebf7146 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c

[...]

> +static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
> +	{ .exti = 1, .irq_parent = 7 },
> +	{ .exti = 2, .irq_parent = 8 },
> +	{ .exti = 3, .irq_parent = 9 },
> +	{ .exti = 4, .irq_parent = 10 },
> +	{ .exti = 5, .irq_parent = 23 },
> +	{ .exti = 6, .irq_parent = 64 },
> +	{ .exti = 7, .irq_parent = 65 },
> +	{ .exti = 8, .irq_parent = 66 },
> +	{ .exti = 9, .irq_parent = 67 },
> +	{ .exti = 10, .irq_parent = 40 },
> +	{ .exti = 11, .irq_parent = 42 },
> +	{ .exti = 12, .irq_parent = 76 },
> +	{ .exti = 13, .irq_parent = 77 },
> +	{ .exti = 14, .irq_parent = 121 },
> +	{ .exti = 15, .irq_parent = 127 },
> +	{ .exti = 16, .irq_parent = 1 },
> +	{ .exti = 65, .irq_parent = 144 },
> +	{ .exti = 68, .irq_parent = 143 },
> +	{ .exti = 73, .irq_parent = 129 },
> +};

You can use an interrupt-map property rather than put this into the 
driver.
