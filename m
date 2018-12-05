Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E1AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A1D2082D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A1D2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeLEPuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:50:17 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24566 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727103AbeLEPuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:50:14 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB5FkmHQ001926;
        Wed, 5 Dec 2018 16:49:46 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2p53mb64tj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 05 Dec 2018 16:49:46 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D801F31;
        Wed,  5 Dec 2018 15:49:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE7CA518E;
        Wed,  5 Dec 2018 15:49:45 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.50) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 5 Dec
 2018 16:49:44 +0100
Subject: Re: [PATCH V2 1/2] mmc: mmci: send stop command if sbc error issue
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com>
 <1541583041-17461-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpLTEwrBagJrd98Zyrd_pwJa9Zkgsi+geZainQV+OgpOQ@mail.gmail.com>
 <CAPDyKFp06tiMVgKyKLLKKwGtDPkAKuGWo=NaS+j=3oWGq-UV_A@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <f35da2b3-6bd9-59c0-ca09-40c150eb1a9b@st.com>
Date:   Wed, 5 Dec 2018 16:49:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp06tiMVgKyKLLKKwGtDPkAKuGWo=NaS+j=3oWGq-UV_A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/18 3:23 PM, Ulf Hansson wrote:
> On Tue, 20 Nov 2018 at 10:42, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 7 November 2018 at 10:30, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> Refer to "4.15 set block count command" of sd specification:
>>> Host needs to issue CMD12 if any error is detected in
>>> the CMD18 and CMD25 operations.
>>>
>>> In sbc case, the data->stop is fill by framework.
>>>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>> ---
>>>   drivers/mmc/host/mmci.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>> index 82bab35..13fa640 100644
>>> --- a/drivers/mmc/host/mmci.c
>>> +++ b/drivers/mmc/host/mmci.c
>>> @@ -1190,11 +1190,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>>>                          /* The error clause is handled above, success! */
>>>                          data->bytes_xfered = data->blksz * data->blocks;
>>>
>>> -               if (!data->stop || host->mrq->sbc) {
>>> +               if (!data->stop || (host->mrq->sbc && !data->error))
>>>                          mmci_request_end(host, data->mrq);
>>> -               } else {
>>> +               else
>>>                          mmci_start_command(host, data->stop, 0);
>>
>> This looks correct to me!
>>
>> Although, just wanted to double check that you tested this for a case
>> where we have host->mrq->sbc set and got an error in data->error? I
>> guess it can be tricky, so I was thinking of manually trying to
>> instruct the code, to set an error in data->error, at some point to
>> trigger this code. That would at least give us some confidence that it
>> works as expected.
> 
> I did some manual tests to trigger the error path. As far as I can
> tell, it works as expected and I observes that the core is able to
> recover and re-send the request.
> 
> [...]
> 
> So, I have added my tested-by tag and applied this for next. Thanks!
> 
> In regards to patch2/2 I am awaiting your update.
> 
> Kind regards
> Uffe
> 
