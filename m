Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98A7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A208421927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbeLVCYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 21:24:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49479 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbeLVCYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 21:24:52 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4FC0E28CF65D9;
        Sat, 22 Dec 2018 10:24:46 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Sat, 22 Dec 2018
 10:24:44 +0800
Subject: Re: [PATCH 1/1] f2fs: fix validation of the block count in
 sanity_check_raw_super
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20181221192820.26222-1-martin.blumenstingl@googlemail.com>
 <20181221192820.26222-2-martin.blumenstingl@googlemail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <093ddec0-1cbd-d5c4-2bbc-8cfb9eddd447@huawei.com>
Date:   Sat, 22 Dec 2018 10:24:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181221192820.26222-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/22 3:28, Martin Blumenstingl wrote:
> Treat "block_count" from struct f2fs_super_block as 64-bit little endian
> value in sanity_check_raw_super() because struct f2fs_super_block
> declares "block_count" as "__le64".
> 
> This fixes a bug where the superblock validation fails on big endian
> devices with the following error:
>   F2FS-fs (sda1): Wrong segment_count / block_count (61439 > 0)
>   F2FS-fs (sda1): Can't find valid F2FS filesystem in 1th superblock
>   F2FS-fs (sda1): Wrong segment_count / block_count (61439 > 0)
>   F2FS-fs (sda1): Can't find valid F2FS filesystem in 2th superblock
> As result of this the partition cannot be mounted.
> 
> With this patch applied the superblock validation works fine and the
> partition can be mounted again:
>   F2FS-fs (sda1): Mounted with checkpoint version = 7c84
> 
> My little endian x86-64 hardware was able to mount the partition without
> this fix.
> To confirm that mounting f2fs filesystems works on big endian machines
> again I tested this on a 32-bit MIPS big endian (lantiq) device.
> 
> Fixes: 0cfe75c5b01199 ("f2fs: enhance sanity_check_raw_super() to avoid potential overflows")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

