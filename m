Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeDFLZn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:25:43 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34375 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeDFLZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:25:11 -0400
X-Google-Smtp-Source: AIpwx4+xQA1b0rvcFj2ppR3xt12Nc55s6nWAU2O3Cr6zIbOylCC/upOqC63KI8BHr7+HiwnNUy4gnA==
Subject: Re: [PATCH 1/1] drm/xen-zcopy: Add Xen zero-copy helper DRM driver
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180329131931.29957-1-andr2000@gmail.com>
 <20180329131931.29957-2-andr2000@gmail.com>
 <20180403094734.GT3881@phenom.ffwll.local>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <1ef9290a-7564-007d-81c6-cf7db74252f3@gmail.com>
Date: Fri, 6 Apr 2018 14:25:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403094734.GT3881@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 12:47 PM, Daniel Vetter wrote:
> On Thu, Mar 29, 2018 at 04:19:31PM +0300, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> +static int to_refs_grant_foreign_access(struct xen_gem_object *xen_obj)
>> +{
>> +	grant_ref_t priv_gref_head;
>> +	int ret, j, cur_ref, num_pages;
>> +	struct sg_page_iter sg_iter;
>> +
>> +	ret = gnttab_alloc_grant_references(xen_obj->num_pages,
>> +			&priv_gref_head);
>> +	if (ret < 0) {
>> +		DRM_ERROR("Cannot allocate grant references\n");
>> +		return ret;
>> +	}
>> +
>> +	j = 0;
>> +	num_pages = xen_obj->num_pages;
>> +	for_each_sg_page(xen_obj->sgt->sgl, &sg_iter, xen_obj->sgt->nents, 0) {
>> +		struct page *page;
>> +
>> +		page = sg_page_iter_page(&sg_iter);
> Quick drive-by: You can't assume that an sgt is struct page backed.
Do you mean that someone could give me sgt which never
seen sg_assign_page for its entries?
What are the other use-cases for that to happen?
> And you probably want to check this at import/attach time.
The check you mean is to make sure that when I call
page = sg_page_iter_page(&sg_iter);
I have to make sure that I get a valid page?
> -Daniel
Thank you,
Oleksandr
