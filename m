Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934055AbeB1TpO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:45:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38920 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932351AbeB1TpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:45:12 -0500
Subject: Re: [PATCH 8/9] drm/xen-front: Implement GEM operations
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-9-git-send-email-andr2000@gmail.com>
 <2f2c6fea-c0cb-e244-41f3-269db07986fc@oracle.com>
 <56c4a78b-356a-fb35-a97e-187581ae45ad@epam.com>
 <71ab9d03-dc07-f7f2-c9f8-463cc926e573@oracle.com>
 <a9f9d0e4-f504-6d78-40bd-d683fbfa288f@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <81d77b4c-db75-8830-06c9-6774c15a4c25@oracle.com>
Date: Wed, 28 Feb 2018 14:46:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a9f9d0e4-f504-6d78-40bd-d683fbfa288f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280240
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 01:52 AM, Oleksandr Andrushchenko wrote:
> On 02/27/2018 01:47 AM, Boris Ostrovsky wrote:
>> On 02/23/2018 10:35 AM, Oleksandr Andrushchenko wrote:
>>> On 02/23/2018 05:26 PM, Boris Ostrovsky wrote:
>>>> On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>>
>>>>> +        ret = gem_alloc_pages_array(xen_obj, size);
>>>>> +        if (ret < 0) {
>>>>> +            gem_free_pages_array(xen_obj);
>>>>> +            goto fail;
>>>>> +        }
>>>>> +
>>>>> +        ret = alloc_xenballooned_pages(xen_obj->num_pages,
>>>>> +                xen_obj->pages);
>>>> Why are you allocating balloon pages?
>>> in this use-case we map pages provided by the backend
>>> (yes, I know this can be a problem from both security
>>> POV and that DomU can die holding pages of Dom0 forever:
>>> but still it is a configuration option, so user decides
>>> if her use-case needs this and takes responsibility for
>>> such a decision).
>>
>> Perhaps I am missing something here but when you say "I know this can be
>> a problem from both security POV ..." then there is something wrong with
>> your solution.
> well, in this scenario there are actually 2 concerns:
> 1. If DomU dies the pages/grants from Dom0/DomD cannot be
> reclaimed back
> 2. Misbehaving guest may send too many requests to the
> backend exhausting grant references and memory of Dom0/DomD
> (this is the only concern from security POV). Please see [1]
>
> But, we are focusing on embedded use-cases,
> so those systems we use are not that "dynamic" with respect to 2).
> Namely: we have fixed number of domains and their functionality
> is well known, so we can do rather precise assumption on resource
> usage. This is why I try to warn on such a use-case and rely on
> the end user who understands the caveats


How will dom0/backend know whether or not to trust the front end (and
thus whether or not to provide provide pages to it)? Will there be
something in xenstore, for example, to indicate such trusted frontends?

-boris


>
> I'll probably add more precise description of this use-case
> clarifying what is that security POV, so there is no confusion
>
> Hope this explanation answers your questions
>> -boris
>>
>>> Please see description of the buffering modes in xen_drm_front.h
>>> specifically for backend allocated buffers:
>>>  
>>> *******************************************************************************
>>>
>>>   * 2. Buffers allocated by the backend
>>>  
>>> *******************************************************************************
>>>
>>>   *
>>>   * This mode of operation is run-time configured via guest domain
>>> configuration
>>>   * through XenStore entries.
>>>   *
>>>   * For systems which do not provide IOMMU support, but having specific
>>>   * requirements for display buffers it is possible to allocate such
>>> buffers
>>>   * at backend side and share those with the frontend.
>>>   * For example, if host domain is 1:1 mapped and has DRM/GPU hardware
>>> expecting
>>>   * physically contiguous memory, this allows implementing zero-copying
>>>   * use-cases.
>>>
>>>> -boris
>>>>
>>>>> +        if (ret < 0) {
>>>>> +            DRM_ERROR("Cannot allocate %zu ballooned pages: %d\n",
>>>>> +                    xen_obj->num_pages, ret);
>>>>> +            goto fail;
>>>>> +        }
>>>>> +
>>>>> +        return xen_obj;
>>>>> +    }
>>>>> +    /*
>>>>> +     * need to allocate backing pages now, so we can share those
>>>>> +     * with the backend
>>>>> +     */
>>>>> +    xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
>>>>> +    xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
>>>>> +    if (IS_ERR_OR_NULL(xen_obj->pages)) {
>>>>> +        ret = PTR_ERR(xen_obj->pages);
>>>>> +        xen_obj->pages = NULL;
>>>>> +        goto fail;
>>>>> +    }
>>>>> +
>>>>> +    return xen_obj;
>>>>> +
>>>>> +fail:
>>>>> +    DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
>>>>> +    return ERR_PTR(ret);
>>>>> +}
>>>>> +
>>>>>
> Thank you,
> Oleksandr
>
> [1]
> https://lists.xenproject.org/archives/html/xen-devel/2017-07/msg03100.html
>
