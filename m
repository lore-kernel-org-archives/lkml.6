Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A858C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 03:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AFE20882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 03:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESBdBIBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AFE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeG2EsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 00:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbeG2EsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 00:48:20 -0400
Received: from [192.168.0.101] (unknown [180.111.102.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCEE220882;
        Sun, 29 Jul 2018 03:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532834371;
        bh=VEfB/C+XyROfE16r1nyyMjldh4euFWTPY4STLHH7WFc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ESBdBIBqF3K5hjjbJ/M90GsZUPbCAGhfLNcvB1oD/s4qxMYWBYsXnJ95tm5HEzAKa
         bZAgCqzssdrrgZNq7iG2PMn4+Au3f/vMotk7ABe79fYk9UqIPE3i0Sg2NscftNi9I+
         +QhnzRwdq32615QbtaXyp2QdZBn7soufpc27XiSU=
Subject: Re: [PATCH 4/4] f2fs: fix to spread clear_cold_data()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Weichao Guo <guoweichao@huawei.com>
References: <20180727101516.41403-1-yuchao0@huawei.com>
 <20180727101516.41403-4-yuchao0@huawei.com>
 <20180729020013.GG83620@jaegeuk-macbookpro.roam.corp.google.com>
 <b7d39e79-dfb0-17c3-1eee-6afb969008a4@kernel.org>
 <20180729024456.GJ83620@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <2c48e483-25ea-1a13-d605-59ce939832d8@kernel.org>
Date:   Sun, 29 Jul 2018 11:19:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729024456.GJ83620@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/29 10:44, Jaegeuk Kim wrote:
> On 07/29, Chao Yu wrote:
>> On 2018/7/29 10:00, Jaegeuk Kim wrote:
>>> On 07/27, Chao Yu wrote:
>>>> We need to drop PG_checked flag on page as well when we clear PG_uptodate
>>>> flag, in order to avoid treating the page as GCing one later.
>>>
>>> What do you mean "treating the page as GCing one"?
>>
>> I mean if PG_checked flag in page is not cleared, allocator will make it goes
>> into cold area.
>>
>> static int __get_segment_type_6(struct f2fs_io_info *fio)
>> ...
>> 		if (is_cold_data(fio->page) || file_is_cold(inode))
>> 			return CURSEG_COLD_DATA;
> 
> This will come only when page is dirty. So, it'd better to clear this in
> f2fs_set_data_page_dirty()? set_cold_data() is called after set_page_dirty().

Looks fine, let me send v2.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/data.c    | 8 +++++++-
>>>>  fs/f2fs/dir.c     | 1 +
>>>>  fs/f2fs/segment.c | 4 +++-
>>>>  3 files changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index a29f3162b887..2817e2f4eb17 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -1768,6 +1768,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>>>>  	/* This page is already truncated */
>>>>  	if (fio->old_blkaddr == NULL_ADDR) {
>>>>  		ClearPageUptodate(page);
>>>> +		clear_cold_data(page);
>>>>  		goto out_writepage;
>>>>  	}
>>>>  got_it:
>>>> @@ -1943,8 +1944,10 @@ static int __write_data_page(struct page *page, bool *submitted,
>>>>  
>>>>  out:
>>>>  	inode_dec_dirty_pages(inode);
>>>> -	if (err)
>>>> +	if (err) {
>>>>  		ClearPageUptodate(page);
>>>> +		clear_cold_data(page);
>>>> +	}
>>>>  
>>>>  	if (wbc->for_reclaim) {
>>>>  		f2fs_submit_merged_write_cond(sbi, inode, 0, page->index, DATA);
>>>> @@ -2534,6 +2537,8 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
>>>>  		}
>>>>  	}
>>>>  
>>>> +	clear_cold_data(page);
>>>> +
>>>>  	/* This is atomic written page, keep Private */
>>>>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>>>>  		return f2fs_drop_inmem_page(inode, page);
>>>> @@ -2552,6 +2557,7 @@ int f2fs_release_page(struct page *page, gfp_t wait)
>>>>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>>>>  		return 0;
>>>>  
>>>> +	clear_cold_data(page);
>>>>  	set_page_private(page, 0);
>>>>  	ClearPagePrivate(page);
>>>>  	return 1;
>>>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>>>> index 7f955c4e86a4..1e4a4122eb0c 100644
>>>> --- a/fs/f2fs/dir.c
>>>> +++ b/fs/f2fs/dir.c
>>>> @@ -734,6 +734,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>>>>  		clear_page_dirty_for_io(page);
>>>>  		ClearPagePrivate(page);
>>>>  		ClearPageUptodate(page);
>>>> +		clear_cold_data(page);
>>>>  		inode_dec_dirty_pages(dir);
>>>>  		f2fs_remove_dirty_inode(dir);
>>>>  	}
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 58abbdc53561..4d83961745e6 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -267,8 +267,10 @@ static int __revoke_inmem_pages(struct inode *inode,
>>>>  		}
>>>>  next:
>>>>  		/* we don't need to invalidate this in the sccessful status */
>>>> -		if (drop || recover)
>>>> +		if (drop || recover) {
>>>>  			ClearPageUptodate(page);
>>>> +			clear_cold_data(page);
>>>> +		}
>>>>  		set_page_private(page, 0);
>>>>  		ClearPagePrivate(page);
>>>>  		f2fs_put_page(page, 1);
>>>> -- 
>>>> 2.18.0.rc1
