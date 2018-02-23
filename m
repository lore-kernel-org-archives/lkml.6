Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeBWOfz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:35:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57448 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeBWOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:35:54 -0500
Subject: Re: [PATCH 5/9] drm/xen-front: Implement handling of shared display
 buffers
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-6-git-send-email-andr2000@gmail.com>
 <11ce6c96-1739-435c-4b6f-c9f5d02a2905@oracle.com>
 <dea8aaa3-70e8-4532-1f5a-2e0f8f57abed@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <36003bb4-6fc9-f8f9-2817-103bf0f543e9@oracle.com>
Date: Fri, 23 Feb 2018 09:36:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <dea8aaa3-70e8-4532-1f5a-2e0f8f57abed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8812 signatures=668677
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=710
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 02:53 AM, Oleksandr Andrushchenko wrote:
> On 02/23/2018 02:25 AM, Boris Ostrovsky wrote:
>> On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>>>     static int __init xen_drv_init(void)
>>>   {
>>> +    /* At the moment we only support case with XEN_PAGE_SIZE ==
>>> PAGE_SIZE */
>>> +    BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
>>
>> Why BUILD_BUG_ON? This should simply not load if page sizes are
>> different.
>>
>>   
> This is a compile time check, so if kernel/Xen is configured
> to use page size combination which is not supported by the
> driver it will fail during compilation. This seems correct to me,
> because you shouldn't even try to load the driver which
> cannot handle different page sizes to not make any harm.


This will prevent whole kernel from building. So, for example,
randconfig builds will fail.


>>
>>
>>
>>> +    ret = gnttab_map_refs(map_ops, NULL, buf->pages, buf->num_pages);
>>> +    BUG_ON(ret);
>>
>> We should try not to BUG*(). There are a few in this patch (and possibly
>> others) that I think can be avoided.
>>
> I will rework BUG_* for map/unmap code to handle errors,
> but will still leave
>     /* either pages or sgt, not both */
>     BUG_ON(cfg->pages && cfg->sgt);
> which is a real driver bug and must not happen

Why not return an error?

In fact, AFAICS you only call it in patch 9 where both of these can be
tested, in which case something like -EINVAL would look reasonable.

-boris
