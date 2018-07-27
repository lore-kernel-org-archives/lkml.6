Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B45C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491E52088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491E52088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeG0C7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 22:59:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9729 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731937AbeG0C7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 22:59:34 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4EFC925E444A4;
        Fri, 27 Jul 2018 09:40:05 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.382.0; Fri, 27 Jul
 2018 09:40:02 +0800
Subject: Re: [PATCH 00/25] staging: erofs: introduce erofs file system
To:     Christian Kujau <lists@nerdbynature.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
 <alpine.DEB.2.21.999.1807261707460.11672@trent.utfs.org>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <bcb9e620-f73b-4dbc-630b-af925c3d8ebd@huawei.com>
Date:   Fri, 27 Jul 2018 09:39:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.999.1807261707460.11672@trent.utfs.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian, 

On 2018/7/27 8:25, Christian Kujau wrote:
> On Thu, 26 Jul 2018, Gao Xiang wrote:
>> EROFS file system is a read-only file system with compression
>> support designed for certain devices (especially embeded
>> devices) with very limited physical memory and lots of memory
> Out of curiousity, and as Richard already asked[0] - what about existing 
> file system, why can't they be used or extended instead of introducing yet 
> another file system into the kernel? JFFS2? UBIFS? CramFs? SquashFS? 
> ROMFS? F2FS? YAFFS?
> 
> Christian.
> 

Every file system has its typical usage case.

I don't think there exists a silver bullet solving all usage cases optimally.
JFFS2, YAFFS and UBIFS are designed for raw flash, we use UFS or eMMC solution
rather than raw nand flash.

Cramfs and ROMFS are too simple for us, and it is actually useless because no
similar & duplicate code with EROFS.

We can save about 200MB+ metadata space than EXT4 by just using EROFS
_without_ compression support in our products, which could be more compared
with F2FS(F2FS has more useless metadata for read-only use such as SIT, and SSA).
Since we are a read-only file system, we could use aggressive inline(compact) and data
deduplication approach. It is not a small number storage space because we
leave some compression ratio for better performance in low memory scenario.

and I don't think SquashFS is optimal for us, 1) it doesn't have the inline
consideration by design (inline could save storage space also reduce extra data IOs),
2) it is designed for saving more storage space rather than keeping high performance
for limited physical memory scenario; 3) it has many compatible code for its historial
design, actually its on-disk layout design is hard to be extended considering its
historial images 4) It is not designed for VLE, we need to rewrite more than half of
its current code 5) EROFS has no similar code with the current SquashFS.

In the end, I don't think F2FS could be an expansion of NILFS2, BTRFS
is an b-tree expansion of some read-write file system. You could call EROFS
as ROMFS2 or Squashfs+ but EROFS is a completely different solution.
We need to evaluate the optimal file system for each specific usage case (actually
we think erofs almost reaches our requirements for our Android products rather
than SquashFS) and KISS for each solution.


Thanks for your reply :)

Thanks,
Gao Xiang

> [0] https://marc.info/?l=linux-kernel&m=152783930418348&w=2
