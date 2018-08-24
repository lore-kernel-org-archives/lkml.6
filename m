Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCD9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22BF2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3d9lPt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22BF2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeHXMf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:35:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40568 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbeHXMf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:35:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so6832851wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cmG/YfwL+3u6RMpwlA84kKKT4jjW7akdX2h3SHwrRTY=;
        b=J3d9lPt7jhAXrRMTYE+1cxbe0LMIFCpmpXZIIi9/ZrMr0T/c8Z/8Rkv6M9Ijhr5v4K
         ImqmMrT/hyiWl+RWjw+A8kJIklvL/7knRSTiu1/Rb1tX+3r0g4NoggC7/a+T4okDLMzJ
         zzXPM8R9NJ1MO6XklCWBTYSqrDqQdrxfusNAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cmG/YfwL+3u6RMpwlA84kKKT4jjW7akdX2h3SHwrRTY=;
        b=NKn/G6K2aC6HEo8qBA7TtNAVdrhSK3JD9iZXdRraRXCOYQp4U8Km1GoMxI4GPYeD1r
         Ir5Wxv6Yg3iTTq9pMHLKIKjbJc9OrN9uW3QqcOWEsJT1bG5okbq9aRf6s5vSnH6vsjnS
         iItzRsfUQPaTJ0DZRETRxg6L/5gORIxPXj3SfEjfAV7k7KmaAXSWLSK5qsl5VAueDB4L
         bbZmVsrpAcRqwZR+GHloDDt3IWewf/CDpxG4XWH4WxHGFCIdA1PtT9TQSkiNq4U+80oy
         2QjoaBmwKizisgttC1hypQaU7PsHTvlVE647MZw/qHAV/bFNxr+4F747Zqm1IWno4q3k
         42JA==
X-Gm-Message-State: APzg51AY2XOrjUuuSdRQvJHA32AA9zK/u7aUIn4ZTQ9kmY34UsOxLzaU
        oz9gwBZp+DSq7uvnCoqeol6d3g==
X-Google-Smtp-Source: ANB0VdbQyBrjNzKOj0khg7ZeeM0kp/MODkGRZSPZcJEvC15k/2yR1+/5dXWZ77soqq04uqXu8Xk4cw==
X-Received: by 2002:adf:ae01:: with SMTP id x1-v6mr594301wrc.45.1535101302960;
        Fri, 24 Aug 2018 02:01:42 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id e141-v6sm1505853wmd.32.2018.08.24.02.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 02:01:42 -0700 (PDT)
Subject: Re: [PATCH v6 2/4] venus: firmware: move load firmware in a separate
 function
To:     Alexandre Courbot <acourbot@chromium.org>, vgarodia@codeaurora.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
 <1535034528-11590-3-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MXydrrfbWOps-xV4eRzgN6n6pT45B2C=H5tuF2pZOesZQ@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <ee7f8db9-8624-9e08-7ea2-7ea99c0ad289@linaro.org>
Date:   Fri, 24 Aug 2018 12:01:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MXydrrfbWOps-xV4eRzgN6n6pT45B2C=H5tuF2pZOesZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 08/24/2018 10:39 AM, Alexandre Courbot wrote:
> On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>>
>> Separate firmware loading part into a new function.
>>
>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/core.c     |  4 +-
>>  drivers/media/platform/qcom/venus/firmware.c | 55 ++++++++++++++++++----------
>>  drivers/media/platform/qcom/venus/firmware.h |  2 +-
>>  3 files changed, 38 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
>> index bb6add9..75b9785 100644
>> --- a/drivers/media/platform/qcom/venus/core.c
>> +++ b/drivers/media/platform/qcom/venus/core.c
>> @@ -84,7 +84,7 @@ static void venus_sys_error_handler(struct work_struct *work)
>>
>>         pm_runtime_get_sync(core->dev);
>>
>> -       ret |= venus_boot(core->dev, core->res->fwname);
>> +       ret |= venus_boot(core);
>>
>>         ret |= hfi_core_resume(core, true);
>>
>> @@ -284,7 +284,7 @@ static int venus_probe(struct platform_device *pdev)
>>         if (ret < 0)
>>                 goto err_runtime_disable;
>>
>> -       ret = venus_boot(dev, core->res->fwname);
>> +       ret = venus_boot(core);
>>         if (ret)
>>                 goto err_runtime_disable;
>>
>> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
>> index a9d042e..34224eb 100644
>> --- a/drivers/media/platform/qcom/venus/firmware.c
>> +++ b/drivers/media/platform/qcom/venus/firmware.c
>> @@ -60,20 +60,18 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>>         return 0;
>>  }
>>
>> -int venus_boot(struct device *dev, const char *fwname)
>> +static int venus_load_fw(struct venus_core *core, const char *fwname,
>> +                        phys_addr_t *mem_phys, size_t *mem_size)
> 
> Following the remarks of the previous patch, you would have mem_phys
> and mem_size as members of venus_core (probably renamed as fw_mem_addr
> and fw_mem_size).
> 
>>  {
>>         const struct firmware *mdt;
>>         struct device_node *node;
>> -       phys_addr_t mem_phys;
>> +       struct device *dev;
>>         struct resource r;
>>         ssize_t fw_size;
>> -       size_t mem_size;
>>         void *mem_va;
>>         int ret;
>>
>> -       if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) || !qcom_scm_is_available())
>> -               return -EPROBE_DEFER;
> 
> !IS_ENABLED(CONFIG_QCOM_MDT_LOADER) is not a condition that can change
> at runtime, and returning -EPROBE_DEFER in that case seems erroneous
> to me. Instead, wouldn't it make more sense to make the driver depend
> on QCOM_MDT_LOADER?

That was made on purpose, for more info git show b8f9bdc151e4a

-- 
regards,
Stan
