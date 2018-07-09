Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E32C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAA62089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOcGiyI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAA62089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeGIOyW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932910AbeGIOyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:54:21 -0400
Received: from [192.168.0.101] (unknown [49.77.238.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEE1720875;
        Mon,  9 Jul 2018 14:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531148060;
        bh=osypUKyO/u/lwBI0RgyX0XuaHtYml72BM4N1idY89n0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=DOcGiyI4hmfkFiNu0JTLpMBBlxpaSTxmciYCbdh/vJLNoq3/xwZIn7xKwhk0RG0y1
         siXOFGbpQ83DkeuKveEUDSJ7CSF62rnXlA2h+i7U+67T6hcqgNCTXfF2bJekB2F864
         sp6LoJ+7MtWSBm3407Saf6v76JOo8PWyTH/mJ/HU=
Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: should check the type of end_io
 after pullback by fscrypto
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-4-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <d09dbae7-8073-1df6-e7ab-a0241c4023ff@kernel.org>
Date:   Mon, 9 Jul 2018 22:54:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180706210903.77887-4-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/7 5:09, Jaegeuk Kim wrote:
> This fixes to get the page type after pullback by fscrypto, since the original
> page is bounce page but we should need to get control page which is what we
> originally submitted.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c3f9b9baf140..9a0fcec53d0e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -152,7 +152,6 @@ static void f2fs_write_end_io(struct bio *bio)
>  
>  	bio_for_each_segment_all(bvec, bio, i) {
>  		struct page *page = bvec->bv_page;
> -		enum count_type type = WB_DATA_TYPE(page);
>  
>  		if (IS_DUMMY_WRITTEN_PAGE(page)) {
>  			set_page_private(page, (unsigned long)NULL);
> @@ -169,14 +168,14 @@ static void f2fs_write_end_io(struct bio *bio)
>  
>  		if (unlikely(bio->bi_status)) {
>  			mapping_set_error(page->mapping, -EIO);
> -			if (type == F2FS_WB_CP_DATA)
> +			if (WB_DATA_TYPE(page) == F2FS_WB_CP_DATA)
>  				f2fs_stop_checkpoint(sbi, true);
>  		}
>  
>  		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
>  					page->index != nid_of_node(page));
>  
> -		dec_page_count(sbi, type);
> +		dec_page_count(sbi, WB_DATA_TYPE(page));

But we account F2FS_WB_CP_DATA/F2FS_WB_DATA type page based bounce page instead
of original page.

	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;

	/* set submitted = true as a return value */
	fio->submitted = true;

	inc_page_count(sbi, WB_DATA_TYPE(bio_page));

Because for encrypted page of regular inode, we should account it with
F2FS_WB_DATA type:

static bool __is_cp_guaranteed(struct page *page)
{
....
	if (!mapping)   <---bounce page's mapping is NULL
		return false;
}

So we will get F2FS_WB_DATA type from __is_cp_guaranteed below:

enum count_type type = WB_DATA_TYPE(page);

Is there any problem?

Thanks

>  		clear_cold_data(page);
>  		end_page_writeback(page);
>  	}
> 
