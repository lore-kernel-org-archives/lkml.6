Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeDFM3a (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:29:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3696 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752257AbeDFM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:29:28 -0400
From: Fabien DESSENNE <fabien.dessenne@st.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Ludovic BARRE <ludovic.barre@st.com>,
        "Devicetree List" <devicetree@vger.kernel.org>,
        "\", linux-arm-kernel\"@lists.infradead.org"
        <", linux-arm-kernel"@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2 2/2] mailbox: add STMicroelectronics STM32 IPCC driver
Thread-Topic: [PATCH v2 2/2] mailbox: add STMicroelectronics STM32 IPCC driver
Thread-Index: AQHTzMHdHpageEh13EG70mtSxYSG6qPziqSA
Date: Fri, 6 Apr 2018 12:29:02 +0000
Message-ID: <4a2170b7-e5e9-4f5c-8ff7-79e102a658c1@st.com>
References: <1520852307-26659-1-git-send-email-fabien.dessenne@st.com>
 <1520852307-26659-3-git-send-email-fabien.dessenne@st.com>
 <CABb+yY1x7J_oEgU-LR5jPYCoCoUHng84E+CibTxLzdtxhENTBw@mail.gmail.com>
In-Reply-To: <CABb+yY1x7J_oEgU-LR5jPYCoCoUHng84E+CibTxLzdtxhENTBw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <853A75F869AB854C902589DC856236A9@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-06_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w36CTaap008281

Hi


On 05/04/18 11:38, Jassi Brar wrote:
> On Mon, Mar 12, 2018 at 4:28 PM, Fabien Dessenne <fabien.dessenne@st.com> wrote:
> ....
>> +
>> +       /* irq */
>> +       for (i = 0; i < IPCC_IRQ_NUM; i++) {
>> +               ipcc->irqs[i] = of_irq_get_byname(dev->of_node, irq_name[i]);
>> +               if (ipcc->irqs[i] < 0) {
>> +                       dev_err(dev, "no IRQ specified %s\n", irq_name[i]);
>> +                       ret = ipcc->irqs[i];
>> +                       goto err_clk;
>> +               }
>> +
>> +               ret = devm_request_threaded_irq(dev, ipcc->irqs[i], NULL,
>> +                                               irq_thread[i], IRQF_ONESHOT,
>> +                                               dev_name(dev), ipcc);
>>
> In your interrupt handlers you don't do anything that could block.
> Threads only adds some delay to your message handling.
> So maybe use devm_request_irq() ?

The interrupt handlers call mbox_chan_received_data() / 
mbox_chan_txdone(), which call in turn client's rx_callback() / 
tx_done() / tx_prepare() which behavior may be unsafe. Hence, using a 
threaded irq here seems to be a good choice.


>
> .......
>> +
>> +static struct platform_driver stm32_ipcc_driver = {
>> +       .driver = {
>> +               .name = "stm32-ipcc",
>> +               .owner = THIS_MODULE,
>>
> No need of owner here these days.

OK, I will suppress it.

> And also maybe use readl/writel, instead of _relaxed.

The IPCC device is exclusively used on ARM. In ARM architecture, the 
ioremap on devices are strictly ordered and uncached.
In that case, using _relaxed avoids an unneeded cache flush, slightly 
improving performance.

>
> Cheers!
