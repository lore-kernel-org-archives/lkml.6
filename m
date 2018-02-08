Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBHQaR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:30:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750961AbeBHQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:30:15 -0500
Date: Thu, 8 Feb 2018 18:30:07 +0200
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 1/2] zsmalloc: introduce zs_huge_object() function
References: <20180207092919.19696-1-sergey.senozhatsky@gmail.com>
 <20180207092919.19696-2-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207092919.19696-2-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18020816-0008-0000-0000-000004CAD583
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020816-0009-0000-0000-00001E5E8A1D
Message-Id: <20180208163006.GB17354@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080191
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 06:29:18PM +0900, Sergey Senozhatsky wrote:
> Not every object can be share its zspage with other objects, e.g.
> when the object is as big as zspage or nearly as big a zspage.
> For such objects zsmalloc has a so called huge class - every object
> which belongs to huge class consumes the entire zspage (which
> consists of a physical page). On x86_64, PAGE_SHIFT 12 box, the
> first non-huge class size is 3264, so starting down from size 3264,
> objects can share page(-s) and thus minimize memory wastage.
> 
> ZRAM, however, has its own statically defined watermark for huge
> objects - "3 * PAGE_SIZE / 4 = 3072", and forcibly stores every
> object larger than this watermark (3072) as a PAGE_SIZE object,
> in other words, to a huge class, while zsmalloc can keep some of
> those objects in non-huge classes. This results in increased
> memory consumption.
> 
> zsmalloc knows better if the object is huge or not. Introduce
> zs_huge_object() function which tells if the given object can be
> stored in one of non-huge classes or not. This will let us to drop
> ZRAM's huge object watermark and fully rely on zsmalloc when we
> decide if the object is huge.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  include/linux/zsmalloc.h |  2 ++
>  mm/zsmalloc.c            | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index 57a8e98f2708..9a1baf673cc1 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -47,6 +47,8 @@ void zs_destroy_pool(struct zs_pool *pool);
>  unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags);
>  void zs_free(struct zs_pool *pool, unsigned long obj);
> 
> +bool zs_huge_object(size_t sz);
> +
>  void *zs_map_object(struct zs_pool *pool, unsigned long handle,
>  			enum zs_mapmode mm);
>  void zs_unmap_object(struct zs_pool *pool, unsigned long handle);
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index c3013505c305..b3e295a806be 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -192,6 +192,7 @@ static struct vfsmount *zsmalloc_mnt;
>   * (see: fix_fullness_group())
>   */
>  static const int fullness_threshold_frac = 4;
> +static size_t zs_huge_class_size;
> 
>  struct size_class {
>  	spinlock_t lock;
> @@ -1417,6 +1418,19 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
>  }
>  EXPORT_SYMBOL_GPL(zs_unmap_object);
> 
> +/*
> + * Check if the object's size falls into huge_class area. We must take
> + * ZS_HANDLE_SIZE into account and test the actual size we are going to
> + * use up. zs_malloc() unconditionally adds handle size before it performs
> + * size_class lookup, so we may endup in a huge class yet zs_huge_object()
> + * returned 'false'.
> + */

Can you please reformat this comment as kernel-doc?

> +bool zs_huge_object(size_t sz)
> +{
> +	return sz + ZS_HANDLE_SIZE >= zs_huge_class_size;
> +}
> +EXPORT_SYMBOL_GPL(zs_huge_object);
> +
>  static unsigned long obj_malloc(struct size_class *class,
>  				struct zspage *zspage, unsigned long handle)
>  {
> @@ -2404,6 +2418,9 @@ struct zs_pool *zs_create_pool(const char *name)
>  			INIT_LIST_HEAD(&class->fullness_list[fullness]);
> 
>  		prev_class = class;
> +		if (pages_per_zspage == 1 && objs_per_zspage == 1
> +				&& !zs_huge_class_size)
> +			zs_huge_class_size = size;
>  	}
> 
>  	/* debug only, don't abort if it fails */
> -- 
> 2.16.1
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 

-- 
Sincerely yours,
Mike.
