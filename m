Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5E4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA8021741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeLZJz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 04:55:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbeLZJz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 04:55:58 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1C00B8E3D130D;
        Wed, 26 Dec 2018 17:55:55 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 26 Dec 2018
 17:55:51 +0800
Subject: Re: [PATCH v2] f2fs: fix use-after-free issue when accessing
 sbi->stat_info
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1545803429-14340-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7f89b0c1-fc5d-8c83-0ecc-0b0943b7be69@huawei.com>
Date:   Wed, 26 Dec 2018 17:55:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1545803429-14340-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/26 13:50, Sahitya Tummala wrote:
> iput() on sbi->node_inode can update sbi->stat_info
> in the below context, if the f2fs_write_checkpoint()
> has failed with error.
> 
> f2fs_balance_fs_bg+0x1ac/0x1ec
> f2fs_write_node_pages+0x4c/0x260
> do_writepages+0x80/0xbc
> __writeback_single_inode+0xdc/0x4ac
> writeback_single_inode+0x9c/0x144
> write_inode_now+0xc4/0xec
> iput+0x194/0x22c
> f2fs_put_super+0x11c/0x1e8
> generic_shutdown_super+0x70/0xf4
> kill_block_super+0x2c/0x5c
> kill_f2fs_super+0x44/0x50
> deactivate_locked_super+0x60/0x8c
> deactivate_super+0x68/0x74
> cleanup_mnt+0x40/0x78
> 
> Fix this by moving f2fs_destroy_stats() further below iput() in
> both f2fs_put_super() and f2fs_fill_super() paths.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

It looks good to me now. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

