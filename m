Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeDJBrj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:47:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7163 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751568AbeDJBri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:47:38 -0400
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't use GFP_ZERO for page caches
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180409190012.21552-1-jaegeuk@kernel.org>
 <20180409204244.GA25905@jaegeuk-macbookpro.roam.corp.google.com>
 <20180410013545.GA45603@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <2885add2-9a91-d9e0-ea42-c3950639fa46@huawei.com>
Date: Tue, 10 Apr 2018 09:47:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180410013545.GA45603@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/10 9:35, Jaegeuk Kim wrote:
> On 04/09, Jaegeuk Kim wrote:
>> Change log from v1:
>>  - don't memset for recovered page
>>
>> Related to https://lkml.org/lkml/2018/4/8/661
>>
>> Sometimes, we need to write meta data to new allocated block address,
>> then we will allocate a zeroed page in inner inode's address space, and
>> fill partial data in it, and leave other place with zero value which means
>> some fields are initial status.
>>
>> There are two inner inodes (meta inode and node inode) setting __GFP_ZERO,
>> I have just checked them, for both of them, we can avoid using __GFP_ZERO,
>> and do initialization by ourselves to avoid unneeded/redundant zeroing
>> from mm.
> 
> Okay, it seems we're missing some more places to reset the memory, since
> I'm still getting a panic. :(

Alright, let me recheck this patch... ;)

Thanks,

> 
> Thanks,
> 
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>  fs/f2fs/inode.c | 4 ++--
>>  fs/f2fs/node.c  | 3 ++-
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index 417c9dcd0269..87535bf63421 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -320,10 +320,10 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>>  make_now:
>>  	if (ino == F2FS_NODE_INO(sbi)) {
>>  		inode->i_mapping->a_ops = &f2fs_node_aops;
>> -		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
>> +		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
>>  	} else if (ino == F2FS_META_INO(sbi)) {
>>  		inode->i_mapping->a_ops = &f2fs_meta_aops;
>> -		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
>> +		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
>>  	} else if (S_ISREG(inode->i_mode)) {
>>  		inode->i_op = &f2fs_file_inode_operations;
>>  		inode->i_fop = &f2fs_file_operations;
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 9a99243054ba..5a4469093e43 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1096,7 +1096,8 @@ struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs)
>>  	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
>>  
>>  	f2fs_wait_on_page_writeback(page, NODE, true);
>> -	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
>> +	memset(F2FS_NODE(page), 0, PAGE_SIZE);
>> +	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, false);
>>  	set_cold_node(page, S_ISDIR(dn->inode->i_mode));
>>  	if (!PageUptodate(page))
>>  		SetPageUptodate(page);
>> -- 
>> 2.15.0.531.g2ccb3012c9-goog
>>
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 
