Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AH8x224ONfdXt5Jl9h89VoZZIQVD4GAguG1WVUcaPvK7PRfFm/VWrlkXh94QmpG5X2Y+bKokjYxt
ARC-Seal: i=1; a=rsa-sha256; t=1517571124; cv=none;
        d=google.com; s=arc-20160816;
        b=UYjoVY51GPDz8uJPccKikW694lMEMOmwZvroAl+plDB8KFRolPZLpKskW3J40okPee
         odztEhwpIEs8C42r3lZQx5Zn/miy9ijcpjBgBsyrL2IlHYvkadQstmq40PF7QUBI6o8u
         w14HkqApIV6ClR6wXktVUWC7TWQgshHQ5T3MXXWszQYUXA9XWbvzCusvrRzPMjb40Yfg
         MAC2XtQqdd1+piNHtmif6YP0XA7pvxrbBfFAKKbivhUo+4R1Fp8OOz4jrm4YaD3IJn8n
         7brHqclvaN4l0uNPmNKQw6ICGVhaQhZGqFeRco6+IjF+4FHVQ8i3dlHWUAOvCNUYzSa+
         JNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=LFUUGaLGp9IYxRm1zTzEwecTaiiWMuj+jCitTODZerQ=;
        b=iGQwB0piPvUlbhLIIljF1JfF/xANyKN83zvXdaHnQw9o7/lTJTGDmKxV/DUIgGSN3z
         kIZqiHRf6Er+rK0MmtPj+Gr9DCay9uUZeVKRou7Q5LkHg/QM/KhcXRQOboxxq0s3XRzn
         eKmheWsjDgzYD3zpAueWGL5VPDEKQ+46jHm/K7lSWDDhBOw5ZUixITRIMLRj+lBOMEqQ
         x1LsA5/tds0G/zqTlw5SMiXfDNzdSxHTFJTdpca/UMu3Kajgt+4oWGmOqcddBHWeMclw
         rYV7BhwxUQ5L1GFGt9to3a0oYiO+uh2szzq9h19QY993ojhrFYB2Hkol9K7m9XwAJ852
         kM0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu: Add the device_link between
 masters and smmu
To: Sricharan R <sricharan@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, alex.williamson@redhat.com,
 robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
 will.deacon@arm.com, iommu@lists.linux-foundation.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, sboyd@codeaurora.org
Cc: gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
 architt@codeaurora.org, linux-arm-msm@vger.kernel.org
References: <1516362223-22946-1-git-send-email-vivek.gautam@codeaurora.org>
 <1516362223-22946-5-git-send-email-vivek.gautam@codeaurora.org>
 <6b930150-cb81-b0a5-601c-16cb576c4341@arm.com>
 <b7887b45-774a-2515-4304-227037b9af1f@codeaurora.org>
 <7cc4caec-4264-db9d-3afa-e3d20d3edfa7@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8932e2f-75bb-ce30-ae68-1870477fad5f@arm.com>
Date: Fri, 2 Feb 2018 11:31:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7cc4caec-4264-db9d-3afa-e3d20d3edfa7@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590021073891800456?=
X-GMAIL-MSGID: =?utf-8?q?1591288659244251392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/18 05:40, Sricharan R wrote:
> Hi Robin/Vivek,
> 
> On 2/1/2018 2:23 PM, Vivek Gautam wrote:
>> Hi,
>>
>>
>> On 1/31/2018 6:39 PM, Robin Murphy wrote:
>>> On 19/01/18 11:43, Vivek Gautam wrote:
>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>
>>>> Finally add the device link between the master device and
>>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>>> master needs it. This is done from add_device callback which gets
>>>> called once when the master is added to the smmu.
>>>
>>> Don't we need to balance this with a device_link_del() in .remove_device (like exynos-iommu does)?
>>
>> Right. Will add device_link_del() call. Thanks for pointing out.
> 
>   The reason for not adding device_link_del from .remove_device was, the core device_del
>   which calls the .remove_device from notifier, calls device_links_purge before that.
>   That does the same thing as device_link_del. So by the time .remove_device is called,
>   device_links for that device is already cleaned up. Vivek, you may want to check once that
>   calling device_link_del from .remove_device has no effect, just to confirm once more.

There is at least one path in which .remove_device is not called via the 
notifier from device_del(), which is in the cleanup path of 
iommu_bus_init(). AFAICS any links created by .add_device during that 
process would be left dangling, because the device(s) would be live but 
otherwise disassociated from the IOMMU afterwards.

 From a maintenance perspective it's easier to have the call in its 
logical place even if it does nothing 99% of the time; that way we 
shouldn't have to keep an eye out for subtle changes in the power 
management code or driver core that might invalidate the device_del() 
reasoning above, and the power management guys shouldn't have to 
comprehend the internals of the IOMMU API to make sense of the 
unbalanced call if they ever want to change their API.

Thanks,
Robin.
