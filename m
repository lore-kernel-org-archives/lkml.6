Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD4AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C41D222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g94KbMi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393844AbfBOK0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:26:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50883 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBOK0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:26:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so9324458wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TPakNccnVA+ErLN52vpjoOMm/RjQCb+NcwP5kRsJomU=;
        b=g94KbMi3fu4MiyCx0rUtk7uLGdh5fvf7hnRx8J9S3W1xZa4qi5D/KYkQakRw13SorM
         L1SdS+COFo9hFahpBojut/WU6/akn0whao+TNW18EfjJ++NheJvUC3bu90iqxN5ceStw
         qs/w9gupiFZG/vNuN8RbS9lb4RSfO5gbxlQgZvzFKq/SO2rRyLgQf72lYQwlKUpER1EA
         Y9mid0IoEpaQedZrpQtyHZsYpIP9/Ne3UstniGcIFeINtWHzlUhrYn2x6ceHXCev/e/e
         ZiniJ3tFycjA/7NdUYCsf2/P+LSTMuIEVBxejn001ayqX7n9L0GW48xwYxKG0AUxeBab
         ggXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TPakNccnVA+ErLN52vpjoOMm/RjQCb+NcwP5kRsJomU=;
        b=cWO+rBaZHXYphMZ51boAN16SrKmkf/jLsAvDubLEqo8zMXJ7YcarhXiGx4WZFdxhp9
         TH/XEdXVBRCuH3B8vvdH2lS1rvCm5X2J0lccS7ZEBdz6mJFE/uA2BE100gNbvZSpr0GA
         2nzq0cCE9Bw9eKvVm8m5zrwu2M43RV7Sx7DasawV5fnrrozbWvtDfn/JGDgq1YRCFc1P
         wZexuFAEgmSRE0yAZ7fCbeXdVcbFtRBeXEBgJrzAYn9+tstnyUdajofrlecUIsebHqIL
         FfGnPDuML4f+5TlFwLpYxguLq8E0FDot9CHD4B3g8JMjiKguh9gPpLx3qPWztHTIqnxd
         rV+A==
X-Gm-Message-State: AHQUAuadEh34sSooUjKFb3QMRrRfKcKYnIm3jQq2TLwLUFN6kPLHeY65
        3Btdt14Sri3g3TPoO0yZ0BIpHA==
X-Google-Smtp-Source: AHgI3IaNb4dsVFb4yQaeqIu9TZlrCbV2IOta4/U/DfSMJu3pYbSnBMZlZoigI3as5eTUKcwHUxCzkQ==
X-Received: by 2002:a1c:6505:: with SMTP id z5mr6350709wmb.7.1550226363408;
        Fri, 15 Feb 2019 02:26:03 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id e6sm6334041wrt.14.2019.02.15.02.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 02:26:02 -0800 (PST)
Subject: Re: [PATCH] nvmem: core: fix the return value check when calling the
 notifier chain
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
References: <20190214162349.22740-1-brgl@bgdev.pl>
 <e566b4ba-0f3e-052a-bf08-ad881cf7b7c0@linaro.org>
 <CAMRc=MdW47YspeOv+9U6h9Ps35S0As2yBVXPdiwJFXNg_hMZZg@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2ef927a7-0698-3d2f-797f-b9f742bce905@linaro.org>
Date:   Fri, 15 Feb 2019 10:26:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdW47YspeOv+9U6h9Ps35S0As2yBVXPdiwJFXNg_hMZZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/02/2019 09:41, Bartosz Golaszewski wrote:
>> rval will be masked with STOP MASK, so the above statement could be
>> false even if we have error.
>> So you should consider returning an errono which can be understood by user:
>>
>> may be something like this:
>>
>> if (rval & NOTIFY_STOP_MASK) {
>>          rval = notifier_to_errno(rval);
>>          goto err_remove_cells
>> }
>>
> Actually I'm now thinking we can remove this check at all - most users
> never check the return values of notifier chain calls. This function
> cannot fail in itself. What do you think?
Thats even better, I was about to suggest the same on the fact that we 
should allow nvmem provider to register to be successful irrespective of 
the notifier callback failures.

--srini
