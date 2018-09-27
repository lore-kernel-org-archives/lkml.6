Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F62DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9742156E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9742156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeI0OHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:07:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbeI0OHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:07:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AA1E7572C01B4;
        Thu, 27 Sep 2018 15:50:06 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Thu, 27 Sep 2018
 15:50:06 +0800
Subject: Re: [f2fs-dev] [PATCH RESEND v2] Revert: "f2fs: check last page index
 in cached bio to decide submission"
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Chao Yu <chao@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180926144456.3167-1-chao@kernel.org>
 <20180927074058.GK22939@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <63809379-4844-d326-1a2c-44498b1fad1a@huawei.com>
Date:   Thu, 27 Sep 2018 15:50:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927074058.GK22939@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/27 15:40, Sahitya Tummala wrote:
> On Wed, Sep 26, 2018 at 10:44:56PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> There is one case that we can leave bio in f2fs, result in hanging
>> page writeback waiter.
>>
>> Thread A				Thread B
>> - f2fs_write_cache_pages
>>  - f2fs_submit_page_write
>>  page #0 cached in bio #0 of cold log
>>  - f2fs_submit_page_write
>>  page #1 cached in bio #1 of warm log
>> 					- f2fs_write_cache_pages
>> 					 - f2fs_submit_page_write
>> 					 bio is full, submit bio #1 contain page #1
>>  - f2fs_submit_merged_write_cond(, page #1)
>>  fail to submit bio #0 due to page #1 is not in any cached bios.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> - rebase to dev-test
>>  fs/f2fs/checkpoint.c |  2 +-
>>  fs/f2fs/data.c       | 38 +++++++++++++++++++-------------------
>>  fs/f2fs/f2fs.h       |  4 ++--
>>  fs/f2fs/node.c       | 12 ++++++------
>>  fs/f2fs/segment.c    | 11 +++++------
>>  5 files changed, 33 insertions(+), 34 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index d624d7983197..2f63b362ce63 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -280,7 +280,7 @@ static int __f2fs_write_meta_page(struct page *page,
>>  
>>  	if (wbc->for_reclaim)
>>  		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
>> -						0, page->index, META);
>> +							page, 0, META);
>>  
>>  	unlock_page(page);
>>  
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index be69b6ac6870..b03f9d163175 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -322,8 +322,8 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
>>  	io->bio = NULL;
>>  }
>>  
>> -static bool __has_merged_page(struct f2fs_bio_info *io,
>> -				struct inode *inode, nid_t ino, pgoff_t idx)
>> +static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
>> +						struct page *page, nid_t ino)
>>  {
>>  	struct bio_vec *bvec;
>>  	struct page *target;
>> @@ -332,7 +332,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
>>  	if (!io->bio)
>>  		return false;
>>  
>> -	if (!inode && !ino)
>> +	if (!inode && !page && !ino)
>>  		return true;
>>  
>>  	bio_for_each_segment_all(bvec, io->bio, i) {
>> @@ -342,11 +342,10 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
>>  		else
>>  			target = fscrypt_control_page(bvec->bv_page);
>>  
>> -		if (idx != target->index)
>> -			continue;
>> -
>>  		if (inode && inode == target->mapping->host)
>>  			return true;
>> +		if (page && page == target)
>> +			return true;
> 
> If both inode and page are passed, then I think it we should check for page first
> followed by inode checks. What do you think?

Yes, I've changed this and would like to check in latter tests.

But, it's strange, yesterday, I remember I've passed all tests, but when I
retest this patch at home, I got stuck and obviously there are compiler
warning... I guess I'm missing something yesterday.

Thanks,

> 
>>  		if (ino && ino == ino_of_node(target))
>>  			return true;
>>  	}
>> @@ -355,7 +354,8 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
>>  }
>>  
>>  static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
>> -				nid_t ino, pgoff_t idx, enum page_type type)
>> +						struct page *page, nid_t ino,
>> +						enum page_type type)
>>  {
>>  	enum page_type btype = PAGE_TYPE_OF_BIO(type);
>>  	enum temp_type temp;
>> @@ -366,7 +366,7 @@ static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
>>  		io = sbi->write_io[btype] + temp;
>>  
>>  		down_read(&io->io_rwsem);
>> -		ret = __has_merged_page(io, inode, ino, idx);
>> +		ret = __has_merged_page(io, inode, page, ino);
>>  		up_read(&io->io_rwsem);
>>  
>>  		/* TODO: use HOT temp only for meta pages now. */
>> @@ -397,12 +397,12 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
>>  }
>>  
>>  static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>> -				struct inode *inode, nid_t ino, pgoff_t idx,
>> -				enum page_type type, bool force)
>> +				struct inode *inode, struct page *page,
>> +				nid_t ino, enum page_type type, bool force)
>>  {
>>  	enum temp_type temp;
>>  
>> -	if (!force && !has_merged_page(sbi, inode, ino, idx, type))
>> +	if (!force && !has_merged_page(sbi, inode, page, ino, type))
>>  		return;
>>  
>>  	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
>> @@ -421,10 +421,10 @@ void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
>>  }
>>  
>>  void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
>> -				struct inode *inode, nid_t ino, pgoff_t idx,
>> -				enum page_type type)
>> +				struct inode *inode, struct page *page,
>> +				nid_t ino, enum page_type type)
>>  {
>> -	__submit_merged_write_cond(sbi, inode, ino, idx, type, false);
>> +	__submit_merged_write_cond(sbi, inode, page, ino, type, false);
>>  }
>>  
>>  void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi)
>> @@ -1962,7 +1962,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>>  		ClearPageUptodate(page);
>>  
>>  	if (wbc->for_reclaim) {
>> -		f2fs_submit_merged_write_cond(sbi, inode, 0, page->index, DATA);
>> +		f2fs_submit_merged_write_cond(sbi, inode, page, 0, DATA);
>>  		clear_inode_flag(inode, FI_HOT_DATA);
>>  		f2fs_remove_dirty_inode(inode);
>>  		submitted = NULL;
>> @@ -2020,10 +2020,10 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  	pgoff_t index;
>>  	pgoff_t end;		/* Inclusive */
>>  	pgoff_t done_index;
>> -	pgoff_t last_idx = ULONG_MAX;
>>  	int cycled;
>>  	int range_whole = 0;
>>  	int tag;
>> +	int nwritten = 0;
>>  
>>  	pagevec_init(&pvec);
>>  
>> @@ -2126,7 +2126,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  				done = 1;
>>  				break;
>>  			} else if (submitted) {
>> -				last_idx = page->index;
>> +				nwritten++;
>>  			}
>>  
>>  			if (--wbc->nr_to_write <= 0 &&
>> @@ -2148,9 +2148,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
>>  		mapping->writeback_index = done_index;
>>  
>> -	if (last_idx != ULONG_MAX)
>> +	if (nwritten)
>>  		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
>> -						0, last_idx, DATA);
>> +								NULL, 0, DATA);
>>  
>>  	return ret;
>>  }
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index dc9306e87a51..464545e40729 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3049,8 +3049,8 @@ int f2fs_init_post_read_processing(void);
>>  void f2fs_destroy_post_read_processing(void);
>>  void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
>>  void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
>> -				struct inode *inode, nid_t ino, pgoff_t idx,
>> -				enum page_type type);
>> +				struct inode *inode, struct page *page,
>> +				nid_t ino, enum page_type type);
>>  void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
>>  int f2fs_submit_page_bio(struct f2fs_io_info *fio);
>>  void f2fs_submit_page_write(struct f2fs_io_info *fio);
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index ea151e07790f..c47ca807e245 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1561,8 +1561,8 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>  	up_read(&sbi->node_write);
>>  
>>  	if (wbc->for_reclaim) {
>> -		f2fs_submit_merged_write_cond(sbi, page->mapping->host, 0,
>> -						page->index, NODE);
>> +		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
>> +						page, 0, NODE);
>>  		submitted = NULL;
>>  	}
>>  
>> @@ -1634,13 +1634,13 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>>  			unsigned int *seq_id)
>>  {
>>  	pgoff_t index;
>> -	pgoff_t last_idx = ULONG_MAX;
>>  	struct pagevec pvec;
>>  	int ret = 0;
>>  	struct page *last_page = NULL;
>>  	bool marked = false;
>>  	nid_t ino = inode->i_ino;
>>  	int nr_pages;
>> +	int nwritten = 0;
>>  
>>  	if (atomic) {
>>  		last_page = last_fsync_dnode(sbi, ino);
>> @@ -1718,7 +1718,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>>  				f2fs_put_page(last_page, 0);
>>  				break;
>>  			} else if (submitted) {
>> -				last_idx = page->index;
>> +				nwritten++;
>>  			}
>>  
>>  			if (page == last_page) {
>> @@ -1744,8 +1744,8 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>>  		goto retry;
>>  	}
>>  out:
>> -	if (last_idx != ULONG_MAX)
>> -		f2fs_submit_merged_write_cond(sbi, NULL, ino, last_idx, NODE);
>> +	if (nwritten)
>> +		f2fs_submit_merged_write_cond(sbi, NULL, NULL, ino, NODE);
>>  	return ret ? -EIO: 0;
>>  }
>>  
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 97a4fae75651..965ef524e2a2 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -371,7 +371,7 @@ static int __f2fs_commit_inmem_pages(struct inode *inode)
>>  		.io_type = FS_DATA_IO,
>>  	};
>>  	struct list_head revoke_list;
>> -	pgoff_t last_idx = ULONG_MAX;
>> +	bool submit_bio = false;
>>  	int err = 0;
>>  
>>  	INIT_LIST_HEAD(&revoke_list);
>> @@ -406,14 +406,14 @@ static int __f2fs_commit_inmem_pages(struct inode *inode)
>>  			}
>>  			/* record old blkaddr for revoking */
>>  			cur->old_addr = fio.old_blkaddr;
>> -			last_idx = page->index;
>> +			submit_bio = true;
>>  		}
>>  		unlock_page(page);
>>  		list_move_tail(&cur->list, &revoke_list);
>>  	}
>>  
>> -	if (last_idx != ULONG_MAX)
>> -		f2fs_submit_merged_write_cond(sbi, inode, 0, last_idx, DATA);
>> +	if (submit_bio)
>> +		f2fs_submit_merged_write_cond(sbi, inode, NULL, 0, DATA);
>>  
>>  	if (err) {
>>  		/*
>> @@ -3179,8 +3179,7 @@ void f2fs_wait_on_page_writeback(struct page *page,
>>  	if (PageWriteback(page)) {
>>  		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
>>  
>> -		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
>> -						0, page->index, type);
>> +		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, type);
>>  		if (ordered)
>>  			wait_on_page_writeback(page);
>>  		else
>> -- 
>> 2.18.0
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

