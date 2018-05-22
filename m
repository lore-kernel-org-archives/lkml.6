Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeEVPwo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:52:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38284 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbeEVPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:52:42 -0400
X-Google-Smtp-Source: AB8JxZpdnFL3Ia7dqqqGxL+29jz4YUC0zHUKWnlbgygNaq6bvEIsd7fg5yGcZ3GFyJZD5XSGD9n0qA==
Subject: Re: [PATCH 4/4] media: venus: add PIL support
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Vikash Garodia <vgarodia@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org, andy.gross@linaro.org, bjorn.andersson@linaro.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        acourbot@google.com
References: <1526556740-25494-1-git-send-email-vgarodia@codeaurora.org>
 <1526556740-25494-5-git-send-email-vgarodia@codeaurora.org>
 <3822394c-b304-15c3-c978-ee39589308eb@linaro.org>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <65b3d26a-8180-c051-1d34-44d49dca34ca@linaro.org>
Date: Tue, 22 May 2018 18:52:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3822394c-b304-15c3-c978-ee39589308eb@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/22/2018 04:02 PM, Stanimir Varbanov wrote:
> Hi Vikash,
> 
> On 05/17/2018 02:32 PM, Vikash Garodia wrote:
>> This adds support to load the video firmware
>> and bring ARM9 out of reset. This is useful
>> for platforms which does not have trustzone
>> to reset the ARM9.
>>
>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>> ---
>>  .../devicetree/bindings/media/qcom,venus.txt       |   8 +-
>>  drivers/media/platform/qcom/venus/core.c           |  67 +++++++--
>>  drivers/media/platform/qcom/venus/core.h           |   6 +
>>  drivers/media/platform/qcom/venus/firmware.c       | 163 +++++++++++++++++----
>>  drivers/media/platform/qcom/venus/firmware.h       |  10 +-
>>  5 files changed, 217 insertions(+), 37 deletions(-)
>>

<snip>

>>  
>> -int venus_shutdown(struct device *dev)
>> +int venus_boot_noTZ(struct venus_core *core, phys_addr_t mem_phys,
>> +							size_t mem_size)
>>  {
>> -	return qcom_scm_pas_shutdown(VENUS_PAS_ID);
>> +	struct iommu_domain *iommu;
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	if (!core->fw.dev)
>> +		return -EPROBE_DEFER;
>> +
>> +	dev = core->fw.dev;
>> +
>> +	iommu = iommu_domain_alloc(&platform_bus_type);
>> +	if (!iommu) {
>> +		dev_err(dev, "Failed to allocate iommu domain\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	iommu->geometry.aperture_start = 0x0;
>> +	iommu->geometry.aperture_end = VENUS_FW_MEM_SIZE;
> 
> The same comment for geometry params as for venus_probe is valid here.

Infact aperture_end will be overwritten by arm-smmu driver in the next
call to iommu_attach_device(), and by chance geometry.force_aperture
will become true.

I wonder is that geometry params are supposed to be used by drivers or
by iommu drivers?

> 
>> +
>> +	ret = iommu_attach_device(iommu, dev);
>> +	if (ret) {
>> +		dev_err(dev, "could not attach device\n");
>> +		goto err_attach;
>> +	}
>> +
>> +	ret = iommu_map(iommu, core->fw.iova, mem_phys, mem_size,
>> +			IOMMU_READ|IOMMU_WRITE|IOMMU_PRIV);
> 
> iova is not initialized and is zero, maybe we don't need that variable
> in the venus_firmware structure?
> 
>> +	if (ret) {
>> +		dev_err(dev, "could not map video firmware region\n");
>> +		goto err_map;
>> +	}
>> +	core->fw.iommu_domain = iommu;
>> +	venus_reset_hw(core);
>> +
>> +	return 0;
>> +
>> +err_map:
>> +	iommu_detach_device(iommu, dev);
>> +err_attach:
>> +	iommu_domain_free(iommu);
>> +	return ret;
>>  }
>> +

<snip>

-- 
regards,
Stan
