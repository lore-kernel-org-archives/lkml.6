Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeBWOp2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:45:28 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41245 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBWOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:45:27 -0500
X-Google-Smtp-Source: AG47ELuaaaEUo8PpS900VoAfmpJvBARNk2AcvKM+HqywR3aYfR2ZkMyTegXxH+0xBsxLLg/xWLPCCQ==
Subject: Re: [PATCH 5/9] drm/xen-front: Implement handling of shared display
 buffers
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-6-git-send-email-andr2000@gmail.com>
 <11ce6c96-1739-435c-4b6f-c9f5d02a2905@oracle.com>
 <dea8aaa3-70e8-4532-1f5a-2e0f8f57abed@gmail.com>
 <36003bb4-6fc9-f8f9-2817-103bf0f543e9@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <bc441999-ec06-794e-99cb-20091c87ede2@gmail.com>
Date: Fri, 23 Feb 2018 16:45:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <36003bb4-6fc9-f8f9-2817-103bf0f543e9@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 04:36 PM, Boris Ostrovsky wrote:
> On 02/23/2018 02:53 AM, Oleksandr Andrushchenko wrote:
>> On 02/23/2018 02:25 AM, Boris Ostrovsky wrote:
>>> On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>>>>      static int __init xen_drv_init(void)
>>>>    {
>>>> +    /* At the moment we only support case with XEN_PAGE_SIZE ==
>>>> PAGE_SIZE */
>>>> +    BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
>>> Why BUILD_BUG_ON? This should simply not load if page sizes are
>>> different.
>>>
>>>    
>> This is a compile time check, so if kernel/Xen is configured
>> to use page size combination which is not supported by the
>> driver it will fail during compilation. This seems correct to me,
>> because you shouldn't even try to load the driver which
>> cannot handle different page sizes to not make any harm.
>
> This will prevent whole kernel from building. So, for example,
> randconfig builds will fail.
>
makes a lot of sense, thank you
will rework so I reject to load if the requirement is not met
>>>
>>>
>>>> +    ret = gnttab_map_refs(map_ops, NULL, buf->pages, buf->num_pages);
>>>> +    BUG_ON(ret);
>>> We should try not to BUG*(). There are a few in this patch (and possibly
>>> others) that I think can be avoided.
>>>
>> I will rework BUG_* for map/unmap code to handle errors,
>> but will still leave
>>      /* either pages or sgt, not both */
>>      BUG_ON(cfg->pages && cfg->sgt);
>> which is a real driver bug and must not happen
> Why not return an error?
>
> In fact, AFAICS you only call it in patch 9 where both of these can be
> tested, in which case something like -EINVAL would look reasonable.
ok, will remove BUG_ON as well
> -boris
