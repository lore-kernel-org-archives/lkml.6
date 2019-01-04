Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CC0C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F6A21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfADJb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:31:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60759 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfADJb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:31:58 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 33FE1698C21B4;
        Fri,  4 Jan 2019 17:31:55 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Fri, 4 Jan 2019
 17:31:53 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: wait on atomic writes to count
 F2FS_CP_WB_DATA
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <stable@vger.kernel.org>
References: <20190104042025.31982-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3e50bcd6-1730-c28d-2d28-7a8e57f456cf@huawei.com>
Date:   Fri, 4 Jan 2019 17:31:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190104042025.31982-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/4 12:20, Jaegeuk Kim wrote:
> Otherwise, we can get wrong counts incurring checkpoint hang.
> 
> IO_W (CP:  -24, Data:   24, Flush: (   0    0    1), Discard: (   0    0))
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Good catch! ;)

I can understand this condition, but for other new developer who reads this
commit, it will be a little hard to understand situation here.

How about explaining a little more about problem here, maybe:

Thread A			Thread B		
- f2fs_write_data_pages
 -  __write_data_page
  - f2fs_submit_page_write
   - inc_page_count(F2FS_WB_DATA)
     type is F2FS_WB_DATA due to file is non-atomic one
- f2fs_ioc_start_atomic_write
 - set_inode_flag(FI_ATOMIC_FILE)
				- f2fs_write_end_io
				 - dec_page_count(F2FS_WB_CP_DATA)
				   type is F2FS_WB_DATA due to file becomes
				   atomic one

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


