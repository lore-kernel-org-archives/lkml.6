Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeDEJif (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:38:35 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51870 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeDEJid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:38:33 -0400
X-Google-Smtp-Source: AIpwx4+xRsJhS0v7zIn55s/OV35N28SV3l6qW5kcMu8waNVdCCz1ig6V9Wuur4DlO0fgYPUhl6PimV8j6Hx6krivyrQ=
MIME-Version: 1.0
In-Reply-To: <1520852307-26659-3-git-send-email-fabien.dessenne@st.com>
References: <1520852307-26659-1-git-send-email-fabien.dessenne@st.com> <1520852307-26659-3-git-send-email-fabien.dessenne@st.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 5 Apr 2018 15:08:31 +0530
Message-ID: <CABb+yY1x7J_oEgU-LR5jPYCoCoUHng84E+CibTxLzdtxhENTBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mailbox: add STMicroelectronics STM32 IPCC driver
To: Fabien Dessenne <fabien.dessenne@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream"
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 4:28 PM, Fabien Dessenne <fabien.dessenne@st.com> wrote:
....
> +
> +       /* irq */
> +       for (i = 0; i < IPCC_IRQ_NUM; i++) {
> +               ipcc->irqs[i] = of_irq_get_byname(dev->of_node, irq_name[i]);
> +               if (ipcc->irqs[i] < 0) {
> +                       dev_err(dev, "no IRQ specified %s\n", irq_name[i]);
> +                       ret = ipcc->irqs[i];
> +                       goto err_clk;
> +               }
> +
> +               ret = devm_request_threaded_irq(dev, ipcc->irqs[i], NULL,
> +                                               irq_thread[i], IRQF_ONESHOT,
> +                                               dev_name(dev), ipcc);
>
In your interrupt handlers you don't do anything that could block.
Threads only adds some delay to your message handling.
So maybe use devm_request_irq() ?

.......
> +
> +static struct platform_driver stm32_ipcc_driver = {
> +       .driver = {
> +               .name = "stm32-ipcc",
> +               .owner = THIS_MODULE,
>
No need of owner here these days.
And also maybe use readl/writel, instead of _relaxed.

Cheers!
