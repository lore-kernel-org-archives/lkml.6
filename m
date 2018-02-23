Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBWAY7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:24:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41586 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeBWAY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:24:58 -0500
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
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <11ce6c96-1739-435c-4b6f-c9f5d02a2905@oracle.com>
Date: Thu, 22 Feb 2018 19:25:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1519200222-20623-6-git-send-email-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8812 signatures=668677
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=588
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>  
>  static int __init xen_drv_init(void)
>  {
> +	/* At the moment we only support case with XEN_PAGE_SIZE == PAGE_SIZE */
> +	BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);


Why BUILD_BUG_ON? This should simply not load if page sizes are different.

 



> +	ret = gnttab_map_refs(map_ops, NULL, buf->pages, buf->num_pages);
> +	BUG_ON(ret);


We should try not to BUG*(). There are a few in this patch (and possibly
others) that I think can be avoided.





> +
> +static int alloc_storage(struct xen_drm_front_shbuf *buf)
> +{
> +	if (buf->sgt) {
> +		buf->pages = kvmalloc_array(buf->num_pages,
> +				sizeof(struct page *), GFP_KERNEL);
> +		if (!buf->pages)
> +			return -ENOMEM;
> +
> +		if (drm_prime_sg_to_page_addr_arrays(buf->sgt, buf->pages,
> +				NULL, buf->num_pages) < 0)
> +			return -EINVAL;
> +	}
> +
> +	buf->grefs = kcalloc(buf->num_grefs, sizeof(*buf->grefs), GFP_KERNEL);
> +	if (!buf->grefs)
> +		return -ENOMEM;
> +
> +	buf->directory = kcalloc(get_num_pages_dir(buf), PAGE_SIZE, GFP_KERNEL);
> +	if (!buf->directory)
> +		return -ENOMEM;

You need to clean up on errors.

-boris

> +
> +	return 0;
> +}
