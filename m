Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE080ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CD620852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CD620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbeGXDpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:45:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388284AbeGXDpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:45:24 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1BAD84173CB18;
        Tue, 24 Jul 2018 10:41:11 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.382.0; Tue, 24 Jul 2018
 10:40:26 +0800
Subject: Re: [PATCH v3] f2fs: issue discard align to section in LFS mode
To:     Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1531836275-94933-1-git-send-email-yunlong.song@huawei.com>
 <1532005095-111878-1-git-send-email-yunlong.song@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <bec2c80d-13ca-e6be-f73a-ee8c6e9f6462@huawei.com>
Date:   Tue, 24 Jul 2018 10:40:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532005095-111878-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/19 20:58, Yunlong Song wrote:
> For the case when sbi->segs_per_sec > 1 with lfs mode, take
> section:segment = 5 for example, if the section prefree_map is
> ...previous section | current section (1 1 0 1 1) | next section...,
> then the start = x, end = x + 1, after start = start_segno +
> sbi->segs_per_sec, start = x + 5, then it will skip x + 3 and x + 4, but
> their bitmap is still set, which will cause duplicated
> f2fs_issue_discard of this same section in the next write_checkpoint:
> 
> round 1: section bitmap : 1 1 1 1 1, all valid, prefree_map: 0 0 0 0 0
> then rm data block NO.2, block NO.2 becomes invalid, prefree_map: 0 0 1 0 0
> write_checkpoint: section bitmap: 1 1 0 1 1, prefree_map: 0 0 0 0 0,
> prefree of NO.2 is cleared, and no discard issued
> 
> round 2: rm data block NO.0, NO.1, NO.3, NO.4
> all invalid, but prefree bit of NO.2 is set and cleared in round 1, then
> prefree_map: 1 1 0 1 1
> write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1, no
> valid blocks of this section, so discard issued, but this time prefree
> bit of NO.3 and NO.4 is skipped due to start = start_segno + sbi->segs_per_sec;
> 
> round 3:
> write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1 ->
> 0 0 0 0 0, no valid blocks of this section, so discard issued,
> this time prefree bit of NO.3 and NO.4 is cleared, but the discard of
> this section is sent again...
> 
> To fix this problem, we can align the start and end value to section
> boundary for fstrim and real-time discard operation, and decide to issue
> discard only when the whole section is invalid, which can issue discard
> aligned to section size as much as possible and avoid redundant discard.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

