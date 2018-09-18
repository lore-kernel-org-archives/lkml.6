Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2754AECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25E6214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh6toQjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25E6214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeIRSye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:54:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbeIRSyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:54:33 -0400
Received: from [192.168.0.101] (unknown [49.77.217.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146B82146D;
        Tue, 18 Sep 2018 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537276919;
        bh=j41sgoeYYs4xcoMxxjh7WldDlBOpBtXoKYOPRrqsd+E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Kh6toQjfVBagSvSPuaa/YJDXDl5bua0/v50OMeVBIRCOa//vBiZjBUeX9rn1smbIK
         5szjm5NMJsBwbTd2mO5/QLXd6mEX2j2wpenMLx4EqNsPTSBXmXwLynKsLCrRr608zf
         5NrnvbQlUAxvi+i07uLxoYDJI4ITdJoCW/9hZRzg=
Subject: Re: [PATCH] f2fs: avoid GC causing encrypted file corrupted
To:     Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org,
        yuchao0@huawei.com, yunlong.song@icloud.com
Cc:     miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com,
        heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <19e63fa7-1a48-c1de-eef5-cde242e8300d@kernel.org>
Date:   Tue, 18 Sep 2018 21:21:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/18 20:39, Yunlong Song wrote:
> The encrypted file may be corrupted by GC in following case:
> 
> Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
> Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
> segment 2,
> 
> Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |
> 
> Before page 1 is written back and if segment 2 become a victim, then
> page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,
> during the GC process of Time 2, f2fs should wait for page 1 written back
> before reading it, or move_data_block will read a garbage block from
> blkaddr B since page is not written back to blkaddr B yet.
> 
> Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
> ra_data_block to read encrypted block, but it forgets to add
> f2fs_wait_on_page_writeback to avoid racing between GC and flush.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
