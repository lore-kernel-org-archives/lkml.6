Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D9FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D0620844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D0620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbeGXRP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:15:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53866 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388364AbeGXRPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:15:25 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6OFwprD019548;
        Tue, 24 Jul 2018 18:07:51 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kbt9x7ddk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 24 Jul 2018 18:07:51 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3FCF331;
        Tue, 24 Jul 2018 16:07:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 18DBDA825;
        Tue, 24 Jul 2018 16:07:50 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 24 Jul
 2018 18:07:49 +0200
Subject: Re: [PATCH 1/2] pinctrl: stm32: fix bank io port number
To:     Rob Herring <robh@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@st.com>
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
 <1531745857-5561-2-git-send-email-alexandre.torgue@st.com>
 <20180720163515.GA16515@rob-hp-laptop>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <ed56c8d3-f354-d311-8407-66268bcdf7a6@st.com>
Date:   Tue, 24 Jul 2018 18:07:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180720163515.GA16515@rob-hp-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On 07/20/2018 06:35 PM, Rob Herring wrote:
> On Mon, Jul 16, 2018 at 02:57:36PM +0200, Alexandre Torgue wrote:
>> In case the exti line is not in line with the bank number (that is the case
>> when there is an hole between two banks, for example GPIOK and then GPIOZ),
>> use "st,bank-ioport" DT property to get the right exti line.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>> index 9a06e1f..60c678a 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>> @@ -55,6 +55,8 @@ Optional properties:
>>      NOTE: If "gpio-ranges" is used for a gpio controller, all gpio-controller
>>      have to use a "gpio-ranges" entry.
>>      More details in Documentation/devicetree/bindings/gpio/gpio.txt.
>> + - st,bank-ioport: should correspond to the EXTI IOport selection (EXTI line
>> +   used to select GPIOs as interrupts).
> 
> ioport sounds like something else. Perhaps '-exti-line'?

IOport is actually what is described in our datasheet. I could change it 
to -exti-line but I would prefer to match with the datasheet.

Regards
Alex
> 
>>   
>>   Example 1:
>>   #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
