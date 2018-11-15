Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43009C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0941D21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0941D21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeKOSjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:39:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728519AbeKOSjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:39:36 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E0DB25AC123D0;
        Thu, 15 Nov 2018 16:32:24 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Thu, 15 Nov 2018
 16:32:22 +0800
Subject: Re: [PATCH] f2fs: add bio cache for IPU
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20181023083817.3466-1-yuchao0@huawei.com>
 <20181115075226.GA83610@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <944355f6-49d8-f579-aad6-53c54258e90b@huawei.com>
Date:   Thu, 15 Nov 2018 16:32:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181115075226.GA83610@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaeguek,

On 2018/11/15 15:52, Jaegeuk Kim wrote:
> Hi Chao,
> 
> I suspect this brings a system stuck by missing bio being flushed. Please check
> the changes.

Oh, let me check this patch.

Thanks,

> 
> Thanks,
> 
> On 10/23, Chao Yu wrote:
>> SQLite in Wal mode may trigger sequential IPU write in db-wal file, after
>> commit d1b3e72d5490 ("f2fs: submit bio of in-place-update pages"), we
>> lost the chance of merging page in inner managed bio cache, result in
>> submitting more small-sized IO.
>>
>> So let's add temporary bio in writepages() to cache mergeable write IO as
>> much as possible.
>>
>> Test case:
>> 1. xfs_io -f /mnt/f2fs/file -c "pwrite 0 65536" -c "fsync"
>> 2. xfs_io -f /mnt/f2fs/file -c "pwrite 0 65536" -c "fsync"
>>
>> Before:
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65544, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65552, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65560, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65568, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65576, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65584, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65592, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65600, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65608, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65616, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65624, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65632, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65640, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65648, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65656, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65664, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), NODE, sector = 57352, size = 4096
>>
>> After:
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65544, size = 65536
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), NODE, sector = 57368, size = 4096
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++--
>>  fs/f2fs/f2fs.h    |  3 +++
>>  fs/f2fs/segment.c |  5 ++++-
>>  3 files changed, 62 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 01b7f59523dc..0c8f18dc140d 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -491,6 +491,49 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>>  	return 0;
>>  }
>>  
>> +int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>> +{
>> +	struct bio *bio = *fio->bio;
>> +	struct page *page = fio->encrypted_page ?
>> +			fio->encrypted_page : fio->page;
>> +
>> +	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
>> +			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
>> +		return -EFAULT;
>> +
>> +	trace_f2fs_submit_page_bio(page, fio);
>> +	f2fs_trace_ios(fio, 0);
>> +
>> +	if (bio && (*fio->last_block + 1 != fio->new_blkaddr ||
>> +			!__same_bdev(fio->sbi, fio->new_blkaddr, bio))) {
>> +		__submit_bio(fio->sbi, bio, fio->type);
>> +		bio = NULL;
>> +	}
>> +alloc_new:
>> +	if (!bio) {
>> +		bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
>> +				BIO_MAX_PAGES, false, fio->type, fio->temp);
>> +		*fio->last_block = fio->new_blkaddr;
>> +		bio_set_op_attrs(bio, fio->op, fio->op_flags);
>> +	}
>> +
>> +	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
>> +		__submit_bio(fio->sbi, bio, fio->type);
>> +		bio = NULL;
>> +		goto alloc_new;
>> +	}
>> +
>> +	if (fio->io_wbc)
>> +		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
>> +
>> +	*fio->last_block = fio->new_blkaddr;
>> +
>> +	inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page));
>> +
>> +	*fio->bio = bio;
>> +	return 0;
>> +}
>> +
>>  void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>  {
>>  	struct f2fs_sb_info *sbi = fio->sbi;
>> @@ -1899,6 +1942,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>>  }
>>  
>>  static int __write_data_page(struct page *page, bool *submitted,
>> +				struct bio **bio,
>> +				sector_t *last_block,
>>  				struct writeback_control *wbc,
>>  				enum iostat_type io_type)
>>  {
>> @@ -1924,6 +1969,8 @@ static int __write_data_page(struct page *page, bool *submitted,
>>  		.need_lock = LOCK_RETRY,
>>  		.io_type = io_type,
>>  		.io_wbc = wbc,
>> +		.bio = bio,
>> +		.last_block = last_block,
>>  	};
>>  
>>  	trace_f2fs_writepage(page, DATA);
>> @@ -2051,7 +2098,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>>  static int f2fs_write_data_page(struct page *page,
>>  					struct writeback_control *wbc)
>>  {
>> -	return __write_data_page(page, NULL, wbc, FS_DATA_IO);
>> +	return __write_data_page(page, NULL, NULL, NULL, wbc, FS_DATA_IO);
>>  }
>>  
>>  /*
>> @@ -2067,6 +2114,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  	int done = 0;
>>  	struct pagevec pvec;
>>  	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
>> +	struct bio *bio = NULL;
>> +	sector_t last_block;
>>  	int nr_pages;
>>  	pgoff_t uninitialized_var(writeback_index);
>>  	pgoff_t index;
>> @@ -2154,7 +2203,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  			if (!clear_page_dirty_for_io(page))
>>  				goto continue_unlock;
>>  
>> -			ret = __write_data_page(page, &submitted, wbc, io_type);
>> +			ret = __write_data_page(page, &submitted, &bio,
>> +						&last_block, wbc, io_type);
>>  			if (unlikely(ret)) {
>>  				/*
>>  				 * keep nr_to_write, since vfs uses this to
>> @@ -2201,6 +2251,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  	if (nwritten)
>>  		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
>>  								NULL, 0, DATA);
>> +	/* submit cached bio of IPU write */
>> +	if (bio)
>> +		__submit_bio(sbi, bio, DATA);
>>  
>>  	return ret;
>>  }
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 8932276015f9..6af2a105529d 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1042,6 +1042,8 @@ struct f2fs_io_info {
>>  	bool retry;		/* need to reallocate block address */
>>  	enum iostat_type io_type;	/* io type */
>>  	struct writeback_control *io_wbc; /* writeback control */
>> +	struct bio **bio;		/* bio for ipu */
>> +	sector_t *last_block;		/* last block number in bio */
>>  	unsigned char version;		/* version of the node */
>>  };
>>  
>> @@ -3085,6 +3087,7 @@ void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
>>  				nid_t ino, enum page_type type);
>>  void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
>>  int f2fs_submit_page_bio(struct f2fs_io_info *fio);
>> +int f2fs_merge_page_bio(struct f2fs_io_info *fio);
>>  void f2fs_submit_page_write(struct f2fs_io_info *fio);
>>  struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
>>  			block_t blk_addr, struct bio *bio);
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 3aa2f00262b3..b51b182dd7f4 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3194,7 +3194,10 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
>>  
>>  	stat_inc_inplace_blocks(fio->sbi);
>>  
>> -	err = f2fs_submit_page_bio(fio);
>> +	if (fio->bio)
>> +		err = f2fs_merge_page_bio(fio);
>> +	else
>> +		err = f2fs_submit_page_bio(fio);
>>  	if (!err)
>>  		update_device_state(fio);
>>  
>> -- 
>> 2.18.0.rc1
> 
> .
> 

