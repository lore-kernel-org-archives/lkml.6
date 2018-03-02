Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423238AbeCBIv6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:51:58 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53521 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1423193AbeCBIvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:51:49 -0500
Subject: Re: [PATCH V2 0/5] mmc: add stm32 sdmmc controller
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpfPAaLRZLqpyi6RwC1-=7Ao=u+OmEfHaYBABzd_-BKAw@mail.gmail.com>
 <8f328063-610f-a2e8-5f29-d3f0019384f2@st.com>
 <CAPDyKFqFWcZnWoUdnfRtj9WA1+ooNCXKfZ94Ddq4j849CH2QOQ@mail.gmail.com>
From: Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <cbdd31d8-dbea-4ea3-01ba-443daeb51775@st.com>
Date: Fri, 2 Mar 2018 09:51:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqFWcZnWoUdnfRtj9WA1+ooNCXKfZ94Ddq4j849CH2QOQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2018 11:44 AM, Ulf Hansson wrote:
> On 1 March 2018 at 10:57, Ludovic BARRE <ludovic.barre@st.com> wrote:
>> Hi Ulf
>>
>> On 03/01/2018 10:06 AM, Ulf Hansson wrote:
>>>
>>> Hi Ludovic,
>>>
>>> On 28 February 2018 at 16:47, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>>
>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> This patch serie adds support of stm32 SDMMC controller.
>>>> stm32h7 is the first SoC to use stm32 SDMMC controller
>>>> (previous SoC had pl180 controller).
>>>
>>>
>>> I am a not convinced this isn't a new improved variant of the pl180.
>>> According to register layout and the code you submitted in patch2,
>>> there are great similarities to pl180 and the mmci driver.
>>
>>
>> In fact, ST designers which created stm32-sdmmc hardware block from scratch
>> are the same which have done the modifications on pl180 variant (stm32
>> legacy f4, f7).
>> So some registers or bits name seem identical (or strongly inspirited) but
>> the engine and features are different.
> 
> Well, in that case, I assume the driver would also need work
> differently, but when looking at the code in patch2 this doesn't seem
> to be the case.
> 

I understand why you push to avoid drivers multiplication. But I'm
scared to squash 2 different hardware block which are their own roadmap
in the same drivers. I fear that it complicates the features management 
and maintenance of this driver.

there are some difference:
-the stm32-sdmmc use an internal dma (stm32-sdmmc is master on the bus), 
-idma alignment constraint.
-idma transfer mode single buffer, double buffer... (future evolution)
-need a command to stop transmission for data state machine
-same bit naming could have offset, mask width or set in different register.
=> I will try to synthesis register difference in a document
-voltage switch sequence
-delay block: calibration, tunning (sdr104)
-reset line required
-the same feature have not the same impact, example ddr mode
stm32:no bypass clk, activated in clk register
pl180: clkreg_neg_edge_enable, activated in datactrl register,
...

stm32-sdmmc is just at begining of its life cycle. Each revision of this 
block increases the difference with pl180. Today, I've just push the 
minimal driver to start a request, but I've not yet send all features of 
this revision like sdio, sdr104 support. After this revision there 
already are 2 other revisions in the pipe (at short term).

I am Out of Office with limited access to my e-mail till 2018 march 12th
I'll try to think about it on ski slope. euh, in fact no just ski and 
enjoy ;-)

BR
Ludo

>>
>> You could find the datasheet of STM32H7x3 on:
>> http://www.st.com/content/ccc/resource/technical/document/reference_manual/group0/c9/a3/76/fa/55/46/45/fa/DM00314099/files/DM00314099.pdf/jcr:content/translations/en.DM00314099.pdf
>>
>> Chapters: 55 Secure digital input/output MultiMediaCard interface
>> (SDMMC)
> 
> Thanks for sharing this. However this confirms my view, it looks
> exactly as a new improved mmci variant. :-)
> 
>>
>> This hardware block has own roadmap and some features are already in the
>> pipe for next SoC.
> 
> That's fine. I don't have a problem extending the mmci driver, even
> several times, as to cope with new revisions.
> 
>>
>> For code design: like I also worked on pl180 in the past :-)
>> my code is inspirited of this driver.
> 
> Right, that may explain things a bit.
> 
> However, besides a re-name of the registers, I really think that the
> code execution, dealing with IRQs etc, is very similar to the mmci
> driver. Isn't it?
> 
> So, I think it's at least worth to give it a go with the mmci driver
> first, to see if we can get it to work.
> 
> I guess you understand why I am pushing!? This is about maintenance -
> and I really want to avoid having a yet another driver to maintain,
> unless we can extend an existing one.
> 
> [...]
> 
> Kind regards
> Uffe
> 
