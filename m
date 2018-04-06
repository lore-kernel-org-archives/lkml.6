Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeDFQUs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:20:48 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52017 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeDFQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:20:46 -0400
X-Google-Smtp-Source: AIpwx49y059EamuqiKOlTM95kEhV3/6A6/WLfmjM9ijjvpGQjxNlBigLMwrCbJxQsWuNF/IizYRtHwz27lN24nhbe9k=
MIME-Version: 1.0
In-Reply-To: <f9a45a6e-5b3c-ddd0-e465-cfcad6ece818@st.com>
References: <1520852307-26659-1-git-send-email-fabien.dessenne@st.com>
 <1520852307-26659-3-git-send-email-fabien.dessenne@st.com>
 <CABb+yY1x7J_oEgU-LR5jPYCoCoUHng84E+CibTxLzdtxhENTBw@mail.gmail.com>
 <4a2170b7-e5e9-4f5c-8ff7-79e102a658c1@st.com> <CABb+yY182+7xMbGCurzqxyoGFCRZn4_xKr3AvTQ2c+KyR1vx_w@mail.gmail.com>
 <f9a45a6e-5b3c-ddd0-e465-cfcad6ece818@st.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Fri, 6 Apr 2018 21:50:44 +0530
Message-ID: <CABb+yY2Dd2Gr_-+4RaJarq3tve8tgzVqcoJw+MGT=+Vy56PwLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mailbox: add STMicroelectronics STM32 IPCC driver
To: Fabien DESSENNE <fabien.dessenne@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org"
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 8:35 PM, Fabien DESSENNE <fabien.dessenne@st.com> wrote:
>
> On 06/04/18 14:56, Jassi Brar wrote:
>> On Fri, Apr 6, 2018 at 5:59 PM, Fabien DESSENNE <fabien.dessenne@st.com> wrote:
>>> Hi
>>>
>>>
>>> On 05/04/18 11:38, Jassi Brar wrote:
>>>> On Mon, Mar 12, 2018 at 4:28 PM, Fabien Dessenne <fabien.dessenne@st.com> wrote:
>>>> ....
>>>>> +
>>>>> +       /* irq */
>>>>> +       for (i = 0; i < IPCC_IRQ_NUM; i++) {
>>>>> +               ipcc->irqs[i] = of_irq_get_byname(dev->of_node, irq_name[i]);
>>>>> +               if (ipcc->irqs[i] < 0) {
>>>>> +                       dev_err(dev, "no IRQ specified %s\n", irq_name[i]);
>>>>> +                       ret = ipcc->irqs[i];
>>>>> +                       goto err_clk;
>>>>> +               }
>>>>> +
>>>>> +               ret = devm_request_threaded_irq(dev, ipcc->irqs[i], NULL,
>>>>> +                                               irq_thread[i], IRQF_ONESHOT,
>>>>> +                                               dev_name(dev), ipcc);
>>>>>
>>>> In your interrupt handlers you don't do anything that could block.
>>>> Threads only adds some delay to your message handling.
>>>> So maybe use devm_request_irq() ?
>>> The interrupt handlers call mbox_chan_received_data() /
>>> mbox_chan_txdone(), which call in turn client's rx_callback() /
>>> tx_done() / tx_prepare() which behavior may be unsafe. Hence, using a
>>> threaded irq here seems to be a good choice.
>>>
>> rx_callback() is supposed to be atomic.
>
> I am worried with this atomic part (and honestly I did not note that the
> callbacks were expected to be)
>
> In my case, remoteproc->virtio->rpmsg is the mailbox client defining the
> rx_callback.
> If I follow your suggestion, I shall make this rx_callback Atomic in
> remoteproc (or in virtio or rpmsg). And this does not seem to be so
> simple (add a worker in the middle of somewhere?). Bjorn, feel free to
> comment this part.
>
> An alternate implementation consists in using a threaded IRQ for the
> mailbox interrupt.
> This option is not only simple, but also ensures to split bottom & half
> parts at the irq level which is IMHO a general good practice.
>
> I can see that some mailbox clients implement callbacks that are NOT
> atomic and I suspect this is the reason why some mailbox drivers use
> threaded_irq (rockchip mailbox splits the bottom & half parts).
>
> Would it be acceptable to consider the "atomic client callback" as a
> non-strict rule ?
>
Of course you can traverse atomic path from sleepable context (but not
vice-versa).
Please send in the final revision.

Thanks.
