Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6CDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541A120859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391147AbfAPOKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:10:31 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2846 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390689AbfAPOKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:10:31 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0GE6W1r002001;
        Wed, 16 Jan 2019 15:10:11 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pybywmaaq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 16 Jan 2019 15:10:11 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 72AE634;
        Wed, 16 Jan 2019 14:10:10 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 028092D41;
        Wed, 16 Jan 2019 14:10:10 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.45) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 16 Jan
 2019 15:10:09 +0100
Subject: Re: [PATCH v2 2/3] mfd: syscon: Add optional clock support
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com>
 <CAK8P3a1MucNG86=bXwVVsasGBOLJ67kuRSpoeneF6M5aB6GmQA@mail.gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <9e0ee154-a399-9bff-3beb-adfd9d6c6fee@st.com>
Date:   Wed, 16 Jan 2019 15:10:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1MucNG86=bXwVVsasGBOLJ67kuRSpoeneF6M5aB6GmQA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 1:14 PM, Arnd Bergmann wrote:
> (sorry for the late reply, I just realized that I had never sent out the
> mail after Lee asked me for a review last year and I had drafted
> my reply).

Hi Arnd,

Many thanks for reviewing, no worries :-)

> 
> On Wed, Dec 12, 2018 at 9:48 AM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>>
>> Some system control registers need to be clocked, so the registers can
>> be accessed. Add an optional clock and attach it to regmap.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> This looks ok to me in principle, but I have one question: When we
> do a clk_get() and clk_prepare() as part of regmap_mmio_attach_clk(),
> does that change the behavior of syscon nodes that are otherwise
> unused?

I'm not sure I correctly understand this question. I don't think it will
change the behavior for "unused" nodes. These should remain unused with
this patch.

> 
> I think we have a bunch of devices that started out as a syscon but
> then we added a proper driver for them, which would handle the
> clocks explicitly. Is it guaranteed that this will keep working (including
> shutting down the clocks when they are unused) if we have two drivers
> that call clk_get() on the same device node?

I'd expect nothing wrong happens when two drivers call clk_get() for the
same clock.
Are there some case where two drivers are bind (e.g. syscon driver +
another driver) for the same piece of hardware ?

The clk_prepare() is part of regmap_mmio_attach_clk(). It's called once
upon registration via of_syscon_register(). There is currently no mean
to unregister, e.g. something like "of_syscon_unregister" and so do
clk_unprepare via regmap_mmio_detach_clk().

Then point is clk_enable()/clk_disable() calls will be used in
regmap_mmio_read() and regmap_mmio_write(). These calls are balanced.
Then clock framework should correctly disable/gate the clock when
unused, based on the enable count.

Is this answering your question?

Thanks again,
Best regards,
Fabrice
> 
>        Arnd
> 
