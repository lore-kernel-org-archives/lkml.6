Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4B4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549952168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvrBvvOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549952168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeHXMbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:31:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38167 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeHXMbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:31:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so891571wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 01:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D31WSED4rLHFwWsEwfBBfCULhVmUX1cp69t3tvz3U6Q=;
        b=TvrBvvOdLKOuJyTf4l+DFUNnjnIaySd931plb3xEcCoqpmeVYMPkphy23FwhuuZYt4
         XrRY6OsaZ3mlTEUwF+uXtKM2y+s5iw9/XpgXOHmw8i1OmY95LGkr+MYoLuLEh/3+T+qT
         3o1mVEJokh+6KZnIEOBkJaoQwtzHblzckbK1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D31WSED4rLHFwWsEwfBBfCULhVmUX1cp69t3tvz3U6Q=;
        b=A7iVtQa6ykFmnUQq1Ohb9t6O5w6zfy0lkSSpozEwy4Rg4FEcECYTdIh/Fs0ohnjtXa
         HoWPU4Ysd2mcAg+rozAwW3fcQf4xkPk3gQcFoPDeB9XGKo9ZoBSJPfCm8vclEy2NflDT
         jznJ+sNBmYyXQzj9W/ZiRdG4Ed+8QSKtvxV122jfG4V3BiFUny9tYtbhCYckB8RgHqZz
         4FS8eSi2Gx6TqpAhq5xUVNMhffIWq7PdelmRGwst2PJOGvwtCjkt+3VhD0/hFckrpSsn
         zPbX7gmMDl5REIOntP4rR/0noNFa9opVSyW1Qr91iHPq89BjeevlpufD7rBYNsLKFIPH
         nGEA==
X-Gm-Message-State: APzg51BS+U1KrBhp6DPNn0Rzq3K6FK0ZucqN0sb4sE6jejm015113cfK
        MbybV8LiNm0dKwDCrbZWtWuNBA==
X-Google-Smtp-Source: ANB0VdZ2xjIoiXOEMCgMZNnH/IwEc3CynztsuLLQ2PlJtgi0NkUREFA7C/lLXE8IAtq3QkGcUCRzZw==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr829546wmd.77.1535101075650;
        Fri, 24 Aug 2018 01:57:55 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id c3-v6sm8574391wrm.56.2018.08.24.01.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 01:57:55 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] venus: firmware: add routine to reset ARM9
To:     Alexandre Courbot <acourbot@chromium.org>, vgarodia@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
 <1535034528-11590-2-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MUZawT84Wcrhi+MEyn+zSCWOpn_iOZMMudZz+_Urixsrw@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <51cc9d6b-0483-76a6-d413-3f5cc63f3f56@linaro.org>
Date:   Fri, 24 Aug 2018 11:57:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MUZawT84Wcrhi+MEyn+zSCWOpn_iOZMMudZz+_Urixsrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 08/24/2018 10:38 AM, Alexandre Courbot wrote:
> On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>>
>> Add routine to reset the ARM9 and brings it out of reset. Also
>> abstract the Venus CPU state handling with a new function. This
>> is in preparation to add PIL functionality in venus driver.
>>
>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/core.h         |  2 ++
>>  drivers/media/platform/qcom/venus/firmware.c     | 33 ++++++++++++++++++++++++
>>  drivers/media/platform/qcom/venus/firmware.h     | 11 ++++++++
>>  drivers/media/platform/qcom/venus/hfi_venus.c    | 13 +++-------
>>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  7 +++++
>>  5 files changed, 57 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 2f02365..dfd5c10 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -98,6 +98,7 @@ struct venus_caps {
>>   * @dev:               convenience struct device pointer
>>   * @dev_dec:   convenience struct device pointer for decoder device
>>   * @dev_enc:   convenience struct device pointer for encoder device
>> + * @no_tz:     a flag that suggests presence of trustzone
>>   * @lock:      a lock for this strucure
>>   * @instances: a list_head of all instances
>>   * @insts_count:       num of instances
>> @@ -129,6 +130,7 @@ struct venus_core {
>>         struct device *dev;
>>         struct device *dev_dec;
>>         struct device *dev_enc;
>> +       bool no_tz;
>>         struct mutex lock;
>>         struct list_head instances;
>>         atomic_t insts_count;
>> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
>> index c4a5778..a9d042e 100644
>> --- a/drivers/media/platform/qcom/venus/firmware.c
>> +++ b/drivers/media/platform/qcom/venus/firmware.c
>> @@ -22,10 +22,43 @@
>>  #include <linux/sizes.h>
>>  #include <linux/soc/qcom/mdt_loader.h>
>>
>> +#include "core.h"
>>  #include "firmware.h"
>> +#include "hfi_venus_io.h"
>>
>>  #define VENUS_PAS_ID                   9
>>  #define VENUS_FW_MEM_SIZE              (6 * SZ_1M)
> 
> This is making a strong assumption about the size of the FW memory
> region, which in practice is not always true (I had to reduce it to
> 5MB). How about having this as a member of venus_core, which is

Why you reduced to 5MB? Is there an issue with 6MB or you don't want to
waste reserved memory?

> initialized in venus_load_fw() from the actual size of the memory
> region? You could do this as an extra patch that comes before this
> one.
> 

The size is 6MB by historical reasons and they are no more valid, so I
think we could safely decrease to 5MB. I could prepare a patch for that.

-- 
regards,
Stan
