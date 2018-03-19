Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754935AbeCSCgd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 22:36:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52843 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754531AbeCSCgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 22:36:31 -0400
Subject: Re: [PATCH] f2fs: Set GF_NOFS in read_cache_page_gfp while doing
 f2fs_quota_read
To: Ritesh Harjani <riteshh@codeaurora.org>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC: <stummala@codeaurora.org>
References: <1521206633-21378-1-git-send-email-riteshh@codeaurora.org>
 <1521206633-21378-2-git-send-email-riteshh@codeaurora.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <173fc1c2-bc17-2167-cfda-3217fff8789f@huawei.com>
Date: Mon, 19 Mar 2018 10:36:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1521206633-21378-2-git-send-email-riteshh@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/16 21:23, Ritesh Harjani wrote:
> Quota code itself is serializing the operations by taking mutex_lock.
> It seems a below deadlock can happen if GF_NOFS is not used in
> f2fs_quota_read
> 
> __switch_to+0x88
> __schedule+0x5b0
> schedule+0x78
> schedule_preempt_disabled+0x20
> __mutex_lock_slowpath+0xdc   		//mutex owner is itself
> mutex_lock+0x2c
> dquot_commit+0x30			//mutex_lock(&dqopt->dqio_mutex);
> dqput+0xe0
> __dquot_drop+0x80
> dquot_drop+0x48
> f2fs_evict_inode+0x218
> evict+0xa8
> dispose_list+0x3c
> prune_icache_sb+0x58
> super_cache_scan+0xf4
> do_shrink_slab+0x208
> shrink_slab.part.40+0xac
> shrink_zone+0x1b0
> do_try_to_free_pages+0x25c
> try_to_free_pages+0x164
> __alloc_pages_nodemask+0x534
> do_read_cache_page+0x6c
> read_cache_page+0x14
> f2fs_quota_read+0xa4
> read_blk+0x54
> find_tree_dqentry+0xe4
> find_tree_dqentry+0xb8
> find_tree_dqentry+0xb8
> find_tree_dqentry+0xb8
> qtree_read_dquot+0x68
> v2_read_dquot+0x24
> dquot_acquire+0x5c			// mutex_lock(&dqopt->dqio_mutex);
> dqget+0x238
> __dquot_initialize+0xd4
> dquot_initialize+0x10
> dquot_file_open+0x34
> f2fs_file_open+0x6c
> do_dentry_open+0x1e4
> vfs_open+0x6c
> path_openat+0xa20
> do_filp_open+0x4c
> do_sys_open+0x178
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
