Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeB0Gwh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 01:52:37 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40460 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeB0Gwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 01:52:36 -0500
X-Google-Smtp-Source: AG47ELsmKRrQZDQGi5w7s8tZ7HXa3sU9snIzt0KnvCkKD3mkk7Kylix+U0TmI7pSg4JxwN8BJtIk0g==
Subject: Re: [PATCH 8/9] drm/xen-front: Implement GEM operations
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <a9f9d0e4-f504-6d78-40bd-d683fbfa288f@gmail.com>
Date: Tue, 27 Feb 2018 08:52:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <71ab9d03-dc07-f7f2-c9f8-463cc926e573@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 01:47 AM, Boris Ostrovsky wrote:
> On 02/23/2018 10:35 AM, Oleksandr Andrushchenko wrote:
>> On 02/23/2018 05:26 PM, Boris Ostrovsky wrote:
>>> On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>>>> +static struct xen_gem_object *gem_create(struct drm_device *dev,
>>>> size_t size)
>>>> +{
>>>> +    struct xen_drm_front_drm_info *drm_info = dev->dev_private;
>>>> +    struct xen_gem_object *xen_obj;
>>>> +    int ret;
>>>> +
>>>> +    size = round_up(size, PAGE_SIZE);
>>>> +    xen_obj = gem_create_obj(dev, size);
>>>> +    if (IS_ERR_OR_NULL(xen_obj))
>>>> +        return xen_obj;
>>>> +
>>>> +    if (drm_info->cfg->be_alloc) {
>>>> +        /*
>>>> +         * backend will allocate space for this buffer, so
>>>> +         * only allocate array of pointers to pages
>>>> +         */
>>>> +        xen_obj->be_alloc = true;
>>> If be_alloc is a flag (which I am not sure about) --- should it be set
>>> to true *after* you've successfully allocated your things?
>> this is a configuration option telling about the way
>> the buffer gets allocated: either by the frontend or
>> backend (be_alloc -> buffer allocated by the backend)
>
> I can see how drm_info->cfg->be_alloc might be a configuration option
> but xen_obj->be_alloc is set here and that's not how configuration
> options typically behave.
you are right, I will put be_alloc down the code and will slightly
rework error handling for this function
>
>>>> +        ret = gem_alloc_pages_array(xen_obj, size);
>>>> +        if (ret < 0) {
>>>> +            gem_free_pages_array(xen_obj);
>>>> +            goto fail;
>>>> +        }
>>>> +
>>>> +        ret = alloc_xenballooned_pages(xen_obj->num_pages,
>>>> +                xen_obj->pages);
>>> Why are you allocating balloon pages?
>> in this use-case we map pages provided by the backend
>> (yes, I know this can be a problem from both security
>> POV and that DomU can die holding pages of Dom0 forever:
>> but still it is a configuration option, so user decides
>> if her use-case needs this and takes responsibility for
>> such a decision).
>
> Perhaps I am missing something here but when you say "I know this can be
> a problem from both security POV ..." then there is something wrong with
> your solution.
well, in this scenario there are actually 2 concerns:
1. If DomU dies the pages/grants from Dom0/DomD cannot be
reclaimed back
2. Misbehaving guest may send too many requests to the
backend exhausting grant references and memory of Dom0/DomD
(this is the only concern from security POV). Please see [1]

But, we are focusing on embedded use-cases,
so those systems we use are not that "dynamic" with respect to 2).
Namely: we have fixed number of domains and their functionality
is well known, so we can do rather precise assumption on resource
usage. This is why I try to warn on such a use-case and rely on
the end user who understands the caveats

I'll probably add more precise description of this use-case
clarifying what is that security POV, so there is no confusion

Hope this explanation answers your questions
> -boris
>
>> Please see description of the buffering modes in xen_drm_front.h
>> specifically for backend allocated buffers:
>>   *******************************************************************************
>>
>>   * 2. Buffers allocated by the backend
>>   *******************************************************************************
>>
>>   *
>>   * This mode of operation is run-time configured via guest domain
>> configuration
>>   * through XenStore entries.
>>   *
>>   * For systems which do not provide IOMMU support, but having specific
>>   * requirements for display buffers it is possible to allocate such
>> buffers
>>   * at backend side and share those with the frontend.
>>   * For example, if host domain is 1:1 mapped and has DRM/GPU hardware
>> expecting
>>   * physically contiguous memory, this allows implementing zero-copying
>>   * use-cases.
>>
>>> -boris
>>>
>>>> +        if (ret < 0) {
>>>> +            DRM_ERROR("Cannot allocate %zu ballooned pages: %d\n",
>>>> +                    xen_obj->num_pages, ret);
>>>> +            goto fail;
>>>> +        }
>>>> +
>>>> +        return xen_obj;
>>>> +    }
>>>> +    /*
>>>> +     * need to allocate backing pages now, so we can share those
>>>> +     * with the backend
>>>> +     */
>>>> +    xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
>>>> +    xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
>>>> +    if (IS_ERR_OR_NULL(xen_obj->pages)) {
>>>> +        ret = PTR_ERR(xen_obj->pages);
>>>> +        xen_obj->pages = NULL;
>>>> +        goto fail;
>>>> +    }
>>>> +
>>>> +    return xen_obj;
>>>> +
>>>> +fail:
>>>> +    DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
>>>> +    return ERR_PTR(ret);
>>>> +}
>>>> +
>>>>
Thank you,
Oleksandr

[1] 
https://lists.xenproject.org/archives/html/xen-devel/2017-07/msg03100.html
