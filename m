Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA5BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008EA2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008EA2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeHaOMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:12:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42381 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727559AbeHaOMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:12:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C343DBDA00CEC;
        Fri, 31 Aug 2018 18:06:07 +0800 (CST)
Received: from [127.0.0.1] (10.74.184.86) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Fri, 31 Aug 2018
 18:06:01 +0800
Subject: Re: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
To:     John Garry <john.garry@huawei.com>,
        James Morse <james.morse@arm.com>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <5eab89c6-c063-cbc2-4d02-459faf87698a@arm.com>
 <6cc3c5e2-3827-a89c-e37b-09728a34f21f@huawei.com>
CC:     Zhengqiang <zhengqiang10@huawei.com>,
        Fan Wu <wufan@codeaurora.org>, <mchehab@kernel.org>,
        <bp@alien8.de>, <baicar.tyler@gmail.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>
From:   tanxiaofei <tanxiaofei@huawei.com>
Message-ID: <5B891308.40407@huawei.com>
Date:   Fri, 31 Aug 2018 18:06:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <6cc3c5e2-3827-a89c-e37b-09728a34f21f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.184.86]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/31 0:50, John Garry wrote:
> On 30/08/2018 17:34, James Morse wrote:
> 
> Hi James,
> 
> Zhengqiang no longer works on this topic, so I have cc'ed some more guys who should be able to help.
> 
> John
> 
>> Hi Zhengqiang,
>>
>> On 29/08/18 19:33, Fan Wu wrote:
>>> The current ghes_edac driver does not update per-dimm error
>>> counters when reporting memory errors, because there is no
>>> platform-independent way to find DIMMs based on the error
>>> information provided by firmware. This patch offers a solution
>>> for platforms whose firmwares provide valid module handles
>>> (SMBIOS type 17) in error records. In this case ghes_edac will
>>> use the module handles to locate DIMMs and thus makes per-dimm
>>> error reporting possible.
>>
>> Does your platform set CPER_MEM_VALID_MODULE_HANDLE in GHES Memory errors? If
>> so, any chance you could test this patch on your platform? [0]
>> (original patch: https://lore.kernel.org/patchwork/patch/978928/)
>>

Hi James,

Our platform do not set CPER_MEM_VALID_MODULE_HANDLE in GHES Memory errors.

Thanks,
tanxiaofei

>> Thanks,
>>
>> James
>>
>> [0] https://marc.info/?l=linux-edac&m=152603960002324
>>
>>
>>> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
>>> index 473aeec..db527f0 100644
>>> --- a/drivers/edac/ghes_edac.c
>>> +++ b/drivers/edac/ghes_edac.c
>>> @@ -81,6 +81,26 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>>>          (*num_dimm)++;
>>>  }
>>>
>>> +static int ghes_edac_dimm_index(u16 handle)
>>> +{
>>> +    struct mem_ctl_info *mci;
>>> +    int i;
>>> +
>>> +    if (!ghes_pvt)
>>> +        return -1;
>>> +
>>> +    mci = ghes_pvt->mci;
>>> +
>>> +    if (!mci)
>>> +        return -1;
>>> +
>>> +    for (i = 0; i < mci->tot_dimms; i++) {
>>> +        if (mci->dimms[i]->smbios_handle == handle)
>>> +            return i;
>>> +    }
>>> +    return -1;
>>> +}
>>> +
>>>  static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>>>  {
>>>      struct ghes_edac_dimm_fill *dimm_fill = arg;
>>> @@ -177,6 +197,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>>>                  entry->total_width, entry->data_width);
>>>          }
>>>
>>> +        dimm->smbios_handle = entry->handle;
>>> +
>>>          dimm_fill->count++;
>>>      }
>>>  }
>>> @@ -327,12 +349,20 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>>>          p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
>>>      if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
>>>          const char *bank = NULL, *device = NULL;
>>> +        int index = -1;
>>> +
>>>          dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
>>> +        p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
>>> +                 mem_err->mem_dev_handle);
>>>          if (bank != NULL && device != NULL)
>>>              p += sprintf(p, "DIMM location:%s %s ", bank, device);
>>> -        else
>>> -            p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
>>> -                     mem_err->mem_dev_handle);
>>> +
>>> +        index = ghes_edac_dimm_index(mem_err->mem_dev_handle);
>>> +        if (index >= 0) {
>>> +            e->top_layer = index;
>>> +            e->enable_per_layer_report = true;
>>> +        }
>>> +
>>>      }
>>>      if (p > e->location)
>>>          *(p - 1) = '\0';
>>> diff --git a/include/linux/edac.h b/include/linux/edac.h
>>> index bffb978..a45ce1f 100644
>>> --- a/include/linux/edac.h
>>> +++ b/include/linux/edac.h
>>> @@ -451,6 +451,8 @@ struct dimm_info {
>>>      u32 nr_pages;            /* number of pages on this dimm */
>>>
>>>      unsigned csrow, cschannel;    /* Points to the old API data */
>>> +
>>> +    u16 smbios_handle;              /* Handle for SMBIOS type 17 */
>>>  };
>>>
>>>  /**
>>>
>>
>>
>> .
>>
> 
> 
> 
> .
> 

-- 
best wishes
 谭小飞

