Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB65FC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC5E205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC5E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeKAMY3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:24:29 -0400
Received: from smtp.h3c.com ([60.191.123.56]:21435 "EHLO h3cmg01-ex.h3c.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbeKAMY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 08:24:29 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Nov 2018 08:24:25 EDT
Received: from BJHUB02-EX.srv.huawei-3com.com (unknown [10.63.20.170]) by h3cmg01-ex.h3c.com with smtp
         id 7ac6_01e0_b675df94_e4f9_4095_b887_b176608f198e;
        Thu, 01 Nov 2018 11:12:06 +0800
Received: from H3CMLB12-EX.srv.huawei-3com.com ([fe80::10fe:abde:731b:fdde])
 by BJHUB02-EX.srv.huawei-3com.com ([::1]) with mapi id 14.03.0415.000; Thu, 1
 Nov 2018 11:11:58 +0800
From:   Changwei Ge <ge.changwei@h3c.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Larry Chen <lchen@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: Re: [Ocfs2-devel] [PATCH V2] ocfs2: fix dead lock caused by
 ocfs2_defrag_extent
Thread-Topic: [Ocfs2-devel] [PATCH V2] ocfs2: fix dead lock caused by
 ocfs2_defrag_extent
Thread-Index: AQHUcZCliDsYf2/a3U2eb5J9pSi3vQ==
Date:   Thu, 1 Nov 2018 03:11:57 +0000
Message-ID: <63ADC13FD55D6546B7DECE290D39E37301277DDF02@H3CMLB12-EX.srv.huawei-3com.com>
References: <20180902091455.23862-1-lchen@suse.com>
 <20181031142632.c523108bc137caa8cb1c6282@linux-foundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

I still have a few tiny comments for your patch, please refer to them.

On 2018/11/1 5:28, Andrew Morton wrote:
> 
> Folks, could we please review this patch for upstream inclusion?
> 
> Thanks.
> 
> 
> From: Larry Chen <lchen@suse.com>
> Subject: ocfs2: fix deadlock caused by ocfs2_defrag_extent
> 
> ocfs2_defrag_extent may fall into deadlock.
> 
> ocfs2_ioctl_move_extents
>    ocfs2_ioctl_move_extents
>      ocfs2_move_extents
>        ocfs2_defrag_extent
>          ocfs2_lock_allocators_move_extents
> 
>            ocfs2_reserve_clusters
>              inode_lock GLOBAL_BITMAP_SYSTEM_INODE
> 
> 	  __ocfs2_flush_truncate_log
>              inode_lock GLOBAL_BITMAP_SYSTEM_INODE
> 
> As backtrace shows above, ocfs2_reserve_clusters() will call inode_lock
> against the global bitmap if local allocator has not sufficient cluters.
> Once global bitmap could meet the demand, ocfs2_reserve_cluster will
> return success with global bitmap locked.
> 
> After ocfs2_reserve_cluster(), if truncate log is full,
> __ocfs2_flush_truncate_log() will definitely fall into deadlock because it
> needs to inode_lock global bitmap, which has already been locked.
> 
> To fix this bug, we could remove from ocfs2_lock_allocators_move_extents()
> the code which intends to lock global allocator, and put the removed code
> after __ocfs2_flush_truncate_log().
> 
> ocfs2_lock_allocators_move_extents() is refered by 2 places, one is here,
> the other does not need the data allocator context, which means this patch
> does not affect the caller so far.
> 
> [lchen@suse.com: rename ocfs2_lock_allocators_move_extents() to ocfs2_lock_meta_allocator_move_extents(), add some comments]
>    Link: https://urldefense.proofpoint.com/v2/url?u=http-3A__lkml.kernel.org_r_20180902091455.23862-2D1-2Dlchen-40suse.com&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=C7gAd4uDxlAvTdc0vmU6X8CMk6L2iDY8-HD0qT6Fo7Y&m=K8aRgOiMescamJW-IuHq-cW4mWedGQv2JTT-2KPy1RI&s=3fQHFtwgixirPeQ5Px4fRBnd_UcSx3rvSsLKLidwESo&e=
> Link: https://urldefense.proofpoint.com/v2/url?u=http-3A__lkml.kernel.org_r_20180827080121.31145-2D1-2Dlchen-40suse.com&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=C7gAd4uDxlAvTdc0vmU6X8CMk6L2iDY8-HD0qT6Fo7Y&m=K8aRgOiMescamJW-IuHq-cW4mWedGQv2JTT-2KPy1RI&s=PQOJREyeElsg_1IlINdSGefNqA6w_cUrI1ezdVxyi7o&e=
> Signed-off-by: Larry Chen <lchen@suse.com>
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Junxiao Bi <junxiao.bi@oracle.com>
> Cc: Joseph Qi <jiangqi903@gmail.com>
> Cc: Changwei Ge <ge.changwei@h3c.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   fs/ocfs2/move_extents.c |   40 +++++++++++++++++++++++---------------
>   1 file changed, 25 insertions(+), 15 deletions(-)
> 
> --- a/fs/ocfs2/move_extents.c~fix-dead-lock-caused-by-ocfs2_defrag_extent
> +++ a/fs/ocfs2/move_extents.c
> @@ -162,7 +162,7 @@ out:
>    * in some cases, we don't need to reserve clusters, just let data_ac
>    * be NULL.
>    */
> -static int ocfs2_lock_allocators_move_extents(struct inode *inode,
> +static int ocfs2_lock_meta_allocator_move_extents(struct inode *inode,
>   					struct ocfs2_extent_tree *et,
>   					u32 clusters_to_move,
>   					u32 extents_to_split,

After removing 'reserving clusters logic' out of this function, I suggest to also change the function header comments.
And I think there is no need for arguments _data_ac_ now.
Otherwise this patch looks sane to me.

Thanks,
Changwei

> @@ -192,13 +192,6 @@ static int ocfs2_lock_allocators_move_ex
>   		goto out;
>   	}
>   
> -	if (data_ac) {
> -		ret = ocfs2_reserve_clusters(osb, clusters_to_move, data_ac);
> -		if (ret) {
> -			mlog_errno(ret);
> -			goto out;
> -		}
> -	}
>   
>   	*credits += ocfs2_calc_extend_credits(osb->sb, et->et_root_el);
>   
> @@ -257,10 +250,11 @@ static int ocfs2_defrag_extent(struct oc
>   		}
>   	}
>   
> -	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, *len, 1,
> -						 &context->meta_ac,
> -						 &context->data_ac,
> -						 extra_blocks, &credits);
> +	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
> +						*len, 1,
> +						&context->meta_ac,
> +						&context->data_ac,
> +						extra_blocks, &credits);
>   	if (ret) {
>   		mlog_errno(ret);
>   		goto out;
> @@ -283,6 +277,21 @@ static int ocfs2_defrag_extent(struct oc
>   		}
>   	}
>   
> +	/*
> +	 * Make sure ocfs2_reserve_cluster is called after
> +	 * __ocfs2_flush_truncate_log, otherwise, dead lock may happen.
> +	 *
> +	 * If ocfs2_reserve_cluster is called
> +	 * before __ocfs2_flush_truncate_log, dead lock on global bitmap
> +	 * may happen.
> +	 *
> +	 */
> +	ret = ocfs2_reserve_clusters(osb, *len, &context->data_ac);
> +	if (ret) {
> +		mlog_errno(ret);
> +		goto out_unlock_mutex;
> +	}
> +
>   	handle = ocfs2_start_trans(osb, credits);
>   	if (IS_ERR(handle)) {
>   		ret = PTR_ERR(handle);
> @@ -600,9 +609,10 @@ static int ocfs2_move_extent(struct ocfs
>   		}
>   	}
>   
> -	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, len, 1,
> -						 &context->meta_ac,
> -						 NULL, extra_blocks, &credits);
> +	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
> +						len, 1,
> +						&context->meta_ac,
> +						NULL, extra_blocks, &credits);
>   	if (ret) {
>   		mlog_errno(ret);
>   		goto out;
> _
> 
> 
> _______________________________________________
> Ocfs2-devel mailing list
> Ocfs2-devel@oss.oracle.com
> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
> 
