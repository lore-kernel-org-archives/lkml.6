Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B076FC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6BA223A6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6BA223A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbeHJEEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:04:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725724AbeHJEEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:04:08 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7CD12C90EF310;
        Fri, 10 Aug 2018 09:36:31 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Fri, 10 Aug 2018
 09:36:30 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid fi->i_gc_rwsem[WRITE] lock in
 f2fs_gc
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180730013242.15647-1-jaegeuk@kernel.org>
 <20180804222954.GB35077@jaegeuk-macbookpro.roam.corp.google.com>
 <20180805163450.GB55836@jaegeuk-macbookpro.roam.corp.google.com>
 <16d7f719-268f-99f4-c5b2-fc893b557f11@huawei.com>
 <20180809195917.GA27087@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b09cdcf8-f8cd-98b6-54c1-82b2fb0f8b81@huawei.com>
Date:   Fri, 10 Aug 2018 09:36:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809195917.GA27087@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/10 3:59, Jaegeuk Kim wrote:
> Yup, how about this?
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index d816c328f02b..cb510fb36523 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1052,6 +1052,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  		.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
>  	};
>  	unsigned long long last_skipped = sbi->skipped_atomic_files[FG_GC];
> +	unsigned long long first_skipped;
>  	unsigned int skipped_round = 0, round = 0;
>  
>  	trace_f2fs_gc_begin(sbi->sb, sync, background,
> @@ -1064,8 +1065,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  				prefree_segments(sbi));
>  
>  	cpc.reason = __get_cp_reason(sbi);
> -	sbi->skipped_gc_rwsem = 0;
>  gc_more:
> +	sbi->skipped_gc_rwsem = 0;
> +	first_skipped = last_skipped;
> +
>  	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
>  		ret = -EINVAL;
>  		goto stop;
> @@ -1126,8 +1129,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  			goto gc_more;
>  		}
>  
> -		if (sbi->skipped_atomic_files[FG_GC] == last_skipped &&
> -				sbi->skipped_atomic_files[FG_GC] >
> +		if (first_skipped < last_skipped &&
> +				(last_skipped - first_skipped) >

IMO, it would be better to judge the condition with skipped number in all round
of FGGC instead of last round, since number in last round may not very accurate.

Thoughts?

Thanks,

>  						sbi->skipped_gc_rwsem) {
>  			f2fs_drop_inmem_pages_all(sbi, true);
>  			segno = NULL_SEGNO;
> 
> .
> 

