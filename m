Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E43ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0DA208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0DA208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbeGPHor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:44:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9623 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728129AbeGPHor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:44:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 32BC4DBA53EE2;
        Mon, 16 Jul 2018 15:18:37 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.382.0; Mon, 16 Jul 2018
 15:18:36 +0800
Subject: Re: [PATCH] f2fs: avoid potential deadlock in f2fs_sbi_store
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180715011017.11237-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8694e965-8da9-29ed-fa3e-c85957194363@huawei.com>
Date:   Mon, 16 Jul 2018 15:18:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180715011017.11237-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/15 9:10, Jaegeuk Kim wrote:
> [  155.018460] ======================================================
> [  155.021431] WARNING: possible circular locking dependency detected
> [  155.024339] 4.18.0-rc3+ #5 Tainted: G           OE
> [  155.026879] ------------------------------------------------------
> [  155.029783] umount/2901 is trying to acquire lock:
> [  155.032187] 00000000c4282f1f (kn->count#130){++++}, at: kernfs_remove+0x1f/0x30
> [  155.035439]
> [  155.035439] but task is already holding lock:
> [  155.038892] 0000000056e4307b (&type->s_umount_key#41){++++}, at: deactivate_super+0x33/0x50
> [  155.042602]
> [  155.042602] which lock already depends on the new lock.
> [  155.042602]
> [  155.047465]
> [  155.047465] the existing dependency chain (in reverse order) is:
> [  155.051354]
> [  155.051354] -> #1 (&type->s_umount_key#41){++++}:
> [  155.054768]        f2fs_sbi_store+0x61/0x460 [f2fs]
> [  155.057083]        kernfs_fop_write+0x113/0x1a0
> [  155.059277]        __vfs_write+0x36/0x180
> [  155.061250]        vfs_write+0xbe/0x1b0
> [  155.063179]        ksys_write+0x55/0xc0
> [  155.065068]        do_syscall_64+0x60/0x1b0
> [  155.067071]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  155.069529]
> [  155.069529] -> #0 (kn->count#130){++++}:
> [  155.072421]        __kernfs_remove+0x26f/0x2e0
> [  155.074452]        kernfs_remove+0x1f/0x30
> [  155.076342]        kobject_del.part.5+0xe/0x40
> [  155.078354]        f2fs_put_super+0x12d/0x290 [f2fs]
> [  155.080500]        generic_shutdown_super+0x6c/0x110
> [  155.082655]        kill_block_super+0x21/0x50
> [  155.084634]        kill_f2fs_super+0x9c/0xc0 [f2fs]
> [  155.086726]        deactivate_locked_super+0x3f/0x70
> [  155.088826]        cleanup_mnt+0x3b/0x70
> [  155.090584]        task_work_run+0x93/0xc0
> [  155.092367]        exit_to_usermode_loop+0xf0/0x100
> [  155.094466]        do_syscall_64+0x162/0x1b0
> [  155.096312]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  155.098603]
> [  155.098603] other info that might help us debug this:
> [  155.098603]
> [  155.102418]  Possible unsafe locking scenario:
> [  155.102418]
> [  155.105134]        CPU0                    CPU1
> [  155.107037]        ----                    ----
> [  155.108910]   lock(&type->s_umount_key#41);
> [  155.110674]                                lock(kn->count#130);
> [  155.113010]                                lock(&type->s_umount_key#41);
> [  155.115608]   lock(kn->count#130);
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

