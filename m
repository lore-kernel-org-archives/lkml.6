Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD23C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6E620663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6E620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeKZSKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:10:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbeKZSKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:10:42 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3DA169FBC914C;
        Mon, 26 Nov 2018 15:17:25 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 26 Nov 2018
 15:17:23 +0800
Subject: Re: [PATCH v2] f2fs: fix sbi->extent_list corruption issue
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1543207640-31033-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d968cd81-ea64-3ae5-d5f4-13823aa8105a@huawei.com>
Date:   Mon, 26 Nov 2018 15:17:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543207640-31033-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/26 12:47, Sahitya Tummala wrote:
> When there is a failure in f2fs_fill_super() after/during
> the recovery of fsync'd nodes, it frees the current sbi and
> retries again. This time the mount is successful, but the files
> that got recovered before retry, still holds the extent tree,
> whose extent nodes list is corrupted since sbi and sbi->extent_list
> is freed up. The list_del corruption issue is observed when the
> file system is getting unmounted and when those recoverd files extent
> node is being freed up in the below context.
> 
> list_del corruption. prev->next should be fffffff1e1ef5480, but was (null)
> <...>
> kernel BUG at kernel/msm-4.14/lib/list_debug.c:53!
> task: fffffff1f46f2280 task.stack: ffffff8008068000
> lr : __list_del_entry_valid+0x94/0xb4
> pc : __list_del_entry_valid+0x94/0xb4
> <...>
> Call trace:
> __list_del_entry_valid+0x94/0xb4
> __release_extent_node+0xb0/0x114
> __free_extent_tree+0x58/0x7c
> f2fs_shrink_extent_tree+0xdc/0x3b0
> f2fs_leave_shrinker+0x28/0x7c
> f2fs_put_super+0xfc/0x1e0
> generic_shutdown_super+0x70/0xf4
> kill_block_super+0x2c/0x5c
> kill_f2fs_super+0x44/0x50
> deactivate_locked_super+0x60/0x8c
> deactivate_super+0x68/0x74
> cleanup_mnt+0x40/0x78
> __cleanup_mnt+0x1c/0x28
> task_work_run+0x48/0xd0
> do_notify_resume+0x678/0xe98
> work_pending+0x8/0x14
> 
> Fix this by cleaning up inodes, extent tree and nodes of those
> recovered files before freeing up sbi and before next retry.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Looks good to me now. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

