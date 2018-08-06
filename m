Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F352C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193CC219C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193CC219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeHFEty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:49:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10633 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbeHFEty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:49:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6C4D985EF3E90;
        Mon,  6 Aug 2018 10:42:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 10:42:54 +0800
Message-ID: <5B67B5B0.7040006@huawei.com>
Date:   Mon, 6 Aug 2018 10:42:56 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Nikolay Borisov <nborisov@suse.com>
CC:     <clm@fb.com>, <jbacik@fb.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] fs/btrfs/disk-io: Remove unneeded variable "err"
References: <1533481371-21349-1-git-send-email-zhongjiang@huawei.com> <1533481371-21349-2-git-send-email-zhongjiang@huawei.com> <b999d05d-1f94-5f31-8b43-20e6bf4ebc3d@suse.com>
In-Reply-To: <b999d05d-1f94-5f31-8b43-20e6bf4ebc3d@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/6 3:13, Nikolay Borisov wrote:
>
> On  5.08.2018 18:02, zhong jiang wrote:
>> The err is not used after initalization, So remove it and make
>> the function to be void function.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> The ret value of this function is not checked by the sole caller
> (btrfs_cleanup_one_transaction), however, this does not give you the
> right to use a bulk commit message. If you want your future
> contributions to be taken seriously please put actual effort in properly
> describing your changes.
 I am sorry for that. I will merge the series into a patch. I will repost.

 Thanks,
 zhong jiang
>
>> ---
>>  fs/btrfs/disk-io.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 468365d..34e4926 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -53,8 +53,8 @@
>>  static const struct extent_io_ops btree_extent_io_ops;
>>  static void end_workqueue_fn(struct btrfs_work *work);
>>  static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
>> -static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>> -				      struct btrfs_fs_info *fs_info);
>> +static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>> +				       struct btrfs_fs_info *fs_info);
>>  static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root);
>>  static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
>>  					struct extent_io_tree *dirty_pages,
>> @@ -4179,13 +4179,12 @@ static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
>>  	spin_unlock(&fs_info->ordered_root_lock);
>>  }
>>  
>> -static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>> -				      struct btrfs_fs_info *fs_info)
>> +static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>> +				       struct btrfs_fs_info *fs_info)
>>  {
>>  	struct rb_node *node;
>>  	struct btrfs_delayed_ref_root *delayed_refs;
>>  	struct btrfs_delayed_ref_node *ref;
>> -	int ret = 0;
>>  
>>  	delayed_refs = &trans->delayed_refs;
>>  
>> @@ -4193,7 +4192,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>>  	if (atomic_read(&delayed_refs->num_entries) == 0) {
>>  		spin_unlock(&delayed_refs->lock);
>>  		btrfs_info(fs_info, "delayed_refs has NO entry");
>> -		return ret;
>>  	}
>>  
>>  	while ((node = rb_first(&delayed_refs->href_root)) != NULL) {
>> @@ -4247,8 +4245,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>>  	}
>>  
>>  	spin_unlock(&delayed_refs->lock);
>> -
>> -	return ret;
>>  }
>>  
>>  static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
>>
>


