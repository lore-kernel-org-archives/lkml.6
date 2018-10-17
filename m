Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CA7C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234DA214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234DA214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJQKo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:44:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbeJQKo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:44:26 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C88154036E213;
        Wed, 17 Oct 2018 10:50:51 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Wed, 17 Oct 2018
 10:50:49 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: clear cold data flag if IO is not
 counted
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20181010212217.52289-1-jaegeuk@kernel.org>
 <20181017023404.GB77619@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1c88d521-c36d-91d5-b863-d3fae6be4737@huawei.com>
Date:   Wed, 17 Oct 2018 10:50:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017023404.GB77619@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/17 10:34, Jaegeuk Kim wrote:
> This reverts commit 66110abc4c931f879d70e83e1281f891699364bf.
> 
> If we clear the cold data flag out of the writeback flow, we can miscount
> -1 by end_io.
> 
> Balancing F2FS Async:
>  - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   ...
> 
> GC thread:                              IRQ
> - move_data_page()
>  - set_page_dirty()
>   - clear_cold_data()
>                                         - f2fs_write_end_io()
>                                          - type = WB_DATA_TYPE(page);
>                                            here, we get wrong type
>                                          - dec_page_count(sbi, type);
>  - f2fs_wait_on_page_writeback()
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

