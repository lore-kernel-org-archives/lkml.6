Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73D9C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E0620882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3EMLFSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E0620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeGYLMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:12:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42895 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbeGYLMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:12:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so6803342wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 03:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3O2OKxjgBDx/xRVYJHzGFxkgx0Sj3AA23qzaa9sK0/I=;
        b=K3EMLFSu2WJWltm1ATudhNoJNhO36I6tp5LJSGc0yjf1hbz+9Jxw505msYIeuydU+7
         ywK85kt8B6dE7vt6t2Vz3+sbpT1jQr/2NxlYDtJUeU7fJEwetbVmn5Tka2Q6KbqNOu8H
         CFkh3EZUr7zgNoN3qiwaRjZqqqYcXUQYBfrJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3O2OKxjgBDx/xRVYJHzGFxkgx0Sj3AA23qzaa9sK0/I=;
        b=JrlO5iTHa1pjIoZ/CAAQCibJqAoWmgjtRi0YNcgI6mSnl42SzHQ6A3XhbJZv0wlglZ
         aJA6/zbgHSlRB/JVYkqp/56mIbCU24aJXavxFFFoWXXGy9svhV7d1cPdhlLj6FBWvxcp
         QiGkqk01R9lJdXR8ExYfHaUnVI0ulErw4LI2PyI4Y4eE0OGDtopPzPhZMN0VSm2GfXrf
         mzTBryzvgtrH1CDdgQsYwmx8qsUkpCbMcell2iHuOwNdgiJ8zO9xAAeJEBbHVMZ9SD1h
         DNxrxkoOgR8rGuD/b1Tj238Cgy2CBJHzGWlwq1KXHHFG2fH7p0V//NquVcGZQm5etTm3
         69Gg==
X-Gm-Message-State: AOUpUlEYAtn96WQJZ60FMsklZ4lmEDTA2Z68Q8ZEz6YsYCriEcSB3YeF
        qc2Q+YPAOlMQykVhb1Pz6JKnMz49/SQ=
X-Google-Smtp-Source: AAOMgpdkg1NVpKFEDAEnoKV3yurXyTfO5m5Ebmv+r0cEzZZYiOcGOm39Pw1a32dK+mWD5JhJaYgBzA==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr14663837wre.29.1532512892960;
        Wed, 25 Jul 2018 03:01:32 -0700 (PDT)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id a9-v6sm10174104wrp.55.2018.07.25.03.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 03:01:32 -0700 (PDT)
Subject: Re: [PATCH v3 18/35] media: camss: Add basic runtime PM support
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
 <1532343772-27382-19-git-send-email-todor.tomov@linaro.org>
 <20180724124916.iyanzu3nux35cudg@paasikivi.fi.intel.com>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <096a3fb4-01b8-3096-116f-8562cfb8b6b8@linaro.org>
Date:   Wed, 25 Jul 2018 13:01:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180724124916.iyanzu3nux35cudg@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Thank you for review.

On 24.07.2018 15:49, Sakari Ailus wrote:
> Hi Todor,
> 
> On Mon, Jul 23, 2018 at 02:02:35PM +0300, Todor Tomov wrote:
>> There is a PM domain for each of the VFE hardware modules. Add
>> support for basic runtime PM support to be able to control the
>> PM domains. When a PM domain needs to be powered on - a device
>> link is created. When a PM domain needs to be powered off -
>> its device link is removed. This allows separate and
>> independent control of the PM domains.
>>
>> Suspend/Resume is still not supported.
>>
>> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/camss/camss-csid.c   |  4 ++
>>  drivers/media/platform/qcom/camss/camss-csiphy.c |  5 ++
>>  drivers/media/platform/qcom/camss/camss-ispif.c  | 19 ++++++-
>>  drivers/media/platform/qcom/camss/camss-vfe.c    | 13 +++++
>>  drivers/media/platform/qcom/camss/camss.c        | 63 ++++++++++++++++++++++++
>>  drivers/media/platform/qcom/camss/camss.h        | 11 +++++
>>  6 files changed, 113 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
>> index 627ef44..ea2b0ba 100644
>> --- a/drivers/media/platform/qcom/camss/camss-csid.c
>> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/of.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/regulator/consumer.h>
>>  #include <media/media-entity.h>
>>  #include <media/v4l2-device.h>
>> @@ -316,6 +317,8 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
>>  	if (on) {
>>  		u32 hw_version;
>>  
>> +		pm_runtime_get_sync(dev);
>> +
>>  		ret = regulator_enable(csid->vdda);
> 
> Shouldn't the regulator be enabled in the runtime_resume callback instead?

Ideally - yes, but it becomes more complex (different pipelines are possible
and we have only one callback) so (at least for now) I have left it as it is
and stated in the commit message that suspend/resume is still not supported.

> 
>>  		if (ret < 0)
>>  			return ret;
> 
> Note that you'll need pm_runtime_put() in in error handling here. Perhaps
> elsewhere, too.

Yes, I'll add it here and on all other places.

> 
> Can powering on the device (i.e. pm_runtime_get_sync() call)  fail?

I'd really like to say that it cannot fail :) at least the callback is
empty for now and cannot fail, but the logic in pm_runtime_get_sync()
is not that simple and I'm really not sure. I'll add checks in the code
in case it fails.

> 
>> @@ -348,6 +351,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
>>  		disable_irq(csid->irq);
>>  		camss_disable_clocks(csid->nclocks, csid->clock);
>>  		ret = regulator_disable(csid->vdda);
>> +		pm_runtime_put_sync(dev);
>>  	}
>>  
>>  	return ret;
>> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
>> index 0383e94..2db78791 100644
>> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
>> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/of.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <media/media-entity.h>
>>  #include <media/v4l2-device.h>
>>  #include <media/v4l2-subdev.h>
>> @@ -240,6 +241,8 @@ static int csiphy_set_power(struct v4l2_subdev *sd, int on)
>>  		u8 hw_version;
>>  		int ret;
>>  
>> +		pm_runtime_get_sync(dev);
>> +
>>  		ret = csiphy_set_clock_rates(csiphy);
>>  		if (ret < 0)
>>  			return ret;
> 
> Like here.

Yes, I'll add it here too.

-- 
Best regards,
Todor Tomov
