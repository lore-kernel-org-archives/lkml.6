Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C00C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4F321570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzEl5dva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4F321570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeI0PMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:12:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37212 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbeI0PMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:12:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id y26-v6so4503070wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eUk0z8ZdckYYa4kt9vBmH2ukEWjJziVzYyyHiKkuZHM=;
        b=FzEl5dvaZFVtaEhwfyNofb8gmhzCHmQ8maXcZl689342bQrbrsRlAGrp8OWukSY6AG
         z2zCGdv35PuxfhmizQrWPRwqArfcV/9q2ETWULjZKThBfm4RSwZi2NYdCxJWkifJiDfq
         kLWT8jF+oXS4vDhR7vv83BFhN3yHuKjiZdEH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eUk0z8ZdckYYa4kt9vBmH2ukEWjJziVzYyyHiKkuZHM=;
        b=YBmxnqDopdOiEY9YRFZ5NW6GGrYTWhjJnDDWAsnl+fOHkFrNDELEbkWiUc3ef/sKmr
         EaQ0McLQITPEkesSmFsvacV+a1LkI52ZT/ifHWsWrOGr0fy3AjGsZ0U3brmxL1KvmUdr
         w3ofu8TbYPmJVFAs0Fsrt7lOUTg5wlVc6CAB+CuB3evz5RdYJrLPQRpTmdElyeAdLdSB
         xqaul+pdMdh1YwSklTrLUxXvpvq1GDjHs+5nGT9HMsoiG6S5MEIByzaM/F9NtQSMm8L3
         qzwCriDdzARCQwQYHMmQmaOsHWxUTwcMtEK7Bn2B8VYOb5HijHO5UjKH/gto8YstRH7B
         ytvw==
X-Gm-Message-State: ABuFfoglHjbuirvvSrNF+8uQHwYqHITHnXmlNkO7I3c2eLnp1pP5R1t3
        cTIerQ4FFh8u4czFKLaKn3iY0Q==
X-Google-Smtp-Source: ACcGV62uIw4LMv7aadBeE82LC01HqtAu+CJfi9MPqM2AxRsdxKW3DqvfSljnZ1xcHrWMswXNQNr1jw==
X-Received: by 2002:a1c:848c:: with SMTP id g134-v6mr4433714wmd.129.1538038506928;
        Thu, 27 Sep 2018 01:55:06 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id t14-v6sm1331954wmi.35.2018.09.27.01.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:55:06 -0700 (PDT)
Subject: Re: [PATCH V2 03/27] mmc: mmci: convert dma_setup callback to return
 an int
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-4-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqnN0gg9WsbNPQcodqUXJmFEzMM+ST36s6oEZ2OPoONug@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <55622e1c-190f-6903-ab04-16089264f277@linaro.org>
Date:   Thu, 27 Sep 2018 09:55:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqnN0gg9WsbNPQcodqUXJmFEzMM+ST36s6oEZ2OPoONug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for looping me!

On 24/09/18 15:28, Ulf Hansson wrote:
>>   /* Initialize the dml hardware connected to SD Card controller */
>> -static void qcom_dma_setup(struct mmci_host *host)
>> +static int qcom_dma_setup(struct mmci_host *host)
>>   {
>>          u32 config;
>>          void __iomem *base;
>> @@ -131,7 +131,7 @@ static void qcom_dma_setup(struct mmci_host *host)
>>
>>          if (producer_id < 0 || consumer_id < 0) {
>>                  host->variant->qcom_dml = false;
> It seems like the existing code is an attempt to fallback to use pio
> mode. However, I doubt it works as is.

If I remember it correctly, Yes, that was the intent. we should still be 
able to use the pio mode if the dma setup fails.

I believe pio mode should work, Last time when I tried (3-4 years back) 
it did work!

> 
>> -               return;
>> +               return -EINVAL;
> My point is, if you return an error code here, it means that the error
> code becomes propagated and ->probe() will fail.
That would be very bad!, We should report it and may be just continue 
with pio mode.

> 
> Ideally, we should be able fall back to pio mode when dma doesn't
> work. I have looped in Srinivas who implemented the qcom dml support,
> let's see if he can explains the intent with the code.
> 
> I also volunteer to help out running some tests on the 410c platform,
I think you meant IFC6410.. DB410c uses sdhci.


--srini
> however allow me a day or two to do that.
> 
