Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeDFM42 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:56:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55893 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeDFM40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:56:26 -0400
X-Google-Smtp-Source: AIpwx48eLELi2czOGxmJP8HDHWCyaAeoBv65GksSEJGXKpnfMrGL/Z4Lstt+MvqWGAhcb+4XQUsRZrnxBtPX/pW/aDQ=
MIME-Version: 1.0
In-Reply-To: <4a2170b7-e5e9-4f5c-8ff7-79e102a658c1@st.com>
References: <1520852307-26659-1-git-send-email-fabien.dessenne@st.com>
 <1520852307-26659-3-git-send-email-fabien.dessenne@st.com>
 <CABb+yY1x7J_oEgU-LR5jPYCoCoUHng84E+CibTxLzdtxhENTBw@mail.gmail.com> <4a2170b7-e5e9-4f5c-8ff7-79e102a658c1@st.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Fri, 6 Apr 2018 18:26:24 +0530
Message-ID: <CABb+yY182+7xMbGCurzqxyoGFCRZn4_xKr3AvTQ2c+KyR1vx_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mailbox: add STMicroelectronics STM32 IPCC driver
To: Fabien DESSENNE <fabien.dessenne@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        ", linux-arm-kernel@lists.infradead.org"
        <", linux-arm-kernel"@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 5:59 PM, Fabien DESSENNE <fabien.dessenne@st.com> wrote:
> Hi
>
>
> On 05/04/18 11:38, Jassi Brar wrote:
>> On Mon, Mar 12, 2018 at 4:28 PM, Fabien Dessenne <fabien.dessenne@st.com> wrote:
>> ....
>>> +
>>> +       /* irq */
>>> +       for (i = 0; i < IPCC_IRQ_NUM; i++) {
>>> +               ipcc->irqs[i] = of_irq_get_byname(dev->of_node, irq_name[i]);
>>> +               if (ipcc->irqs[i] < 0) {
>>> +                       dev_err(dev, "no IRQ specified %s\n", irq_name[i]);
>>> +                       ret = ipcc->irqs[i];
>>> +                       goto err_clk;
>>> +               }
>>> +
>>> +               ret = devm_request_threaded_irq(dev, ipcc->irqs[i], NULL,
>>> +                                               irq_thread[i], IRQF_ONESHOT,
>>> +                                               dev_name(dev), ipcc);
>>>
>> In your interrupt handlers you don't do anything that could block.
>> Threads only adds some delay to your message handling.
>> So maybe use devm_request_irq() ?
>
> The interrupt handlers call mbox_chan_received_data() /
> mbox_chan_txdone(), which call in turn client's rx_callback() /
> tx_done() / tx_prepare() which behavior may be unsafe. Hence, using a
> threaded irq here seems to be a good choice.
>
rx_callback() is supposed to be atomic. So was tx_done() but some
platforms needed preparing for the message to be sent. Your client is
not going to be used by other platforms or even over other
controllers, so if your prepare is NULL/atomic, you should assume
tx_done to be atomic and not lose performace. If time comes to fix it,
we'll move prepare() out of the atomic path.


>> .......
>>> +
>>> +static struct platform_driver stm32_ipcc_driver = {
>>> +       .driver = {
>>> +               .name = "stm32-ipcc",
>>> +               .owner = THIS_MODULE,
>>>
>> No need of owner here these days.
>
> OK, I will suppress it.
>
>> And also maybe use readl/writel, instead of _relaxed.
>
> The IPCC device is exclusively used on ARM. In ARM architecture, the
> ioremap on devices are strictly ordered and uncached.
> In that case, using _relaxed avoids an unneeded cache flush, slightly
> improving performance.
>
Its not the portability, but that the impact is negligible in favor of
_relaxed() version when all you do is just program some registers and
not heavy duty i/o. But I am ok either way.  You'd gain far more
performance handling irqs in non-threaded manner :)

Cheers!
