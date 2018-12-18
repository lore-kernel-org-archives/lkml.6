Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC050C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B6821841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeLRKdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:33:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbeLRKdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:33:43 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2BDD96712B359;
        Tue, 18 Dec 2018 18:33:40 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 18:33:37 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix missing unlock(sbi->gc_mutex)
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <stable@vger.kernel.org>
References: <20181218021530.78323-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8a552929-17cc-eb0b-f4e6-5a94a1735d83@huawei.com>
Date:   Tue, 18 Dec 2018 18:33:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181218021530.78323-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/18 10:15, Jaegeuk Kim wrote:
> This fixes missing unlock call.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b79677639108..2689a2cb56cc 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1462,6 +1462,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  
>  	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
>  		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
> +
> +		/* f2fs_gc guarantees unlock gc_mutex */

How about:

	while () {
		mutex_lock(&sbi->gc_mutex);
		err = f2fs_gc();
		if (err) {
			handle error cases..
		}
	}

Thanks,

> +		mutex_lock(&sbi->gc_mutex);
>  		if (err == -ENODATA)
>  			break;
>  		if (err && err != -EAGAIN) {
> 

