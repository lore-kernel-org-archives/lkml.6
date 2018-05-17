Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeEQFAl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 01:00:41 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:47094 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeEQFAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 01:00:38 -0400
X-Google-Smtp-Source: AB8JxZrejMqy9RabrKmbVpJKpZQy56mQHsfofVjkSnwDiIGQKhbjqTbPHR53z2WLX8lNu5swtKv7OgV87+duS+FRFJ4=
MIME-Version: 1.0
In-Reply-To: <CAFCwf119c0vsR8uxqHZu6h12tWhaW6mh9pDYqGPriC60s-+h6Q@mail.gmail.com>
References: <20180516165326.47e96000@canb.auug.org.au> <CAFCwf119c0vsR8uxqHZu6h12tWhaW6mh9pDYqGPriC60s-+h6Q@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 17 May 2018 15:00:36 +1000
Message-ID: <CAPM=9tyj60nGzA0R8iCPONWL1OXRFi-n5=5rhGu501ZVQy4kEQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm tree
To: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've applied this locally for now so I can continue arm64 builds :-)

Dave.

On 16 May 2018 at 18:09, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> On Wed, May 16, 2018 at 9:53 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> After merging the drm tree, today's linux-next build (powerpc
>> allyesconfig) failed like this:
>>
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c: In function 'init_user_pages':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:632:3: error: implicit declaration of function 'release_pages'; did you mean 'release_task'? [-Werror=implicit-function-declaration]
>>    release_pages(mem->user_pages, bo->tbo.ttm->num_pages);
>>    ^~~~~~~~~~~~~
>>    release_task
>>
>> Caused by commit
>>
>>   5ae0283e831a ("drm/amdgpu: Add userptr support for KFD")
>>
>> I have applied the following patch for today:
>>
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Wed, 16 May 2018 16:43:34 +1000
>> Subject: [PATCH] drm/amdgpu: include pagemap.h for release_pages()
>>
>> Fixes: 5ae0283e831a ("drm/amdgpu: Add userptr support for KFD"
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Oded Gabbay <oded.gabbay@gmail.com>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 72ab2b1ffe75..ff8fd75f7ca5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -23,6 +23,7 @@
>>  #define pr_fmt(fmt) "kfd2kgd: " fmt
>>
>>  #include <linux/list.h>
>> +#include <linux/pagemap.h>
>>  #include <linux/sched/mm.h>
>>  #include <drm/drmP.h>
>>  #include "amdgpu_object.h"
>> --
>> 2.17.0
>>
>> --
>> Cheers,
>> Stephen Rothwell
>
> Thanks Stephen,
>
> I'll add it to amdkfd-next and send it to Dave with other fixes.
>
> Oded
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
