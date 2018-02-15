Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425627AbeBOQLr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:11:47 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.95]:36484 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1424433AbeBOQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:11:44 -0500
Subject: Re: [PATCH] drm/amdgpu_gem: fix error handling path in
 amdgpu_gem_va_update_vm
To: christian.koenig@amd.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180215052000.GA25691@embeddedgus>
 <b3638ffe-b29f-b30b-4a2c-ccc50f7562b0@gmail.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <fcd63cde-c593-32d5-5b7a-0ffd0a602bb3@embeddedor.com>
Date: Thu, 15 Feb 2018 10:11:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b3638ffe-b29f-b30b-4a2c-ccc50f7562b0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1emM8L-003tqB-Vn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.4.238]:45682
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/15/2018 06:32 AM, Christian König wrote:
> Am 15.02.2018 um 06:20 schrieb Gustavo A. R. Silva:
>> Currently, if amdgpu_vm_bo_update() fails, the returned error
>> is being ignored.
>>
>> Fix this by properly checking _r_ after calling amdgpu_vm_bo_update.
>> Also, remove redundant code just before label _error_.
>>
>> Addresses-Coverity-ID: 1464280 ("Unused value")
>> Fixes: 0abc6878fc2d ("drm/amdgpu: update VM PDs after the PTs")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 

Thanks, Christian
--
Gustavo

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index e48b4ec..db85fc0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -523,12 +523,13 @@ static void amdgpu_gem_va_update_vm(struct 
>> amdgpu_device *adev,
>>           goto error;
>>       if (operation == AMDGPU_VA_OP_MAP ||
>> -        operation == AMDGPU_VA_OP_REPLACE)
>> +        operation == AMDGPU_VA_OP_REPLACE) {
>>           r = amdgpu_vm_bo_update(adev, bo_va, false);
>> +        if (r)
>> +            goto error;
>> +    }
>>       r = amdgpu_vm_update_directories(adev, vm);
>> -    if (r)
>> -        goto error;
>>   error:
>>       if (r && r != -ERESTARTSYS)
> 
