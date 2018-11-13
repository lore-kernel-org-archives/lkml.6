Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A839C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00915223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00915223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeKMNMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 08:12:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15090 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbeKMNMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 08:12:42 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 081E4E6FAECF7;
        Tue, 13 Nov 2018 11:16:33 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Tue, 13 Nov 2018
 11:16:25 +0800
From:   Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: avoid GC causing encrypted file corrupted
To:     Chao Yu <chao@kernel.org>, Yunlong Song <yunlong.song@huawei.com>,
        <jaegeuk@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
 <19e63fa7-1a48-c1de-eef5-cde242e8300d@kernel.org>
Message-ID: <5c3d6053-e03a-8c61-0a07-07d0090ba349@huawei.com>
Date:   Tue, 13 Nov 2018 11:16:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <19e63fa7-1a48-c1de-eef5-cde242e8300d@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

On 2018/9/18 21:21, Chao Yu wrote:
> On 2018/9/18 20:39, Yunlong Song wrote:
>> The encrypted file may be corrupted by GC in following case:
>>
>> Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
>> Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
>> segment 2,
>>
>> Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |
>>
>> Before page 1 is written back and if segment 2 become a victim, then
>> page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,
>> during the GC process of Time 2, f2fs should wait for page 1 written back
>> before reading it, or move_data_block will read a garbage block from
>> blkaddr B since page is not written back to blkaddr B yet.
>>
>> Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
>> ra_data_block to read encrypted block, but it forgets to add
>> f2fs_wait_on_page_writeback to avoid racing between GC and flush.
>>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

I've reviewed this patch, could you add missing tag in the patch located in
dev-test branch?

Thanks,

> 
> Thanks,
> 
> .
> 

