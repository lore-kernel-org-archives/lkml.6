Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC305C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8719C21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbeLUI43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:56:29 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:56834 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbeLUI43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:56:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 098FA608A3B5;
        Fri, 21 Dec 2018 09:56:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mydFu8mka7Zc; Fri, 21 Dec 2018 09:56:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9A503608A3BA;
        Fri, 21 Dec 2018 09:56:26 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GGCenB1eW9gL; Fri, 21 Dec 2018 09:56:26 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 19A17608A3B5;
        Fri, 21 Dec 2018 09:56:26 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hsiangkao@mail.ru, kirill.shutemov@linux.intel.com,
        stable@vger.kernel.org, zhangjun <openzhangj@gmail.com>
Subject: Re: [PATCH] ubifs: Get/put page when changing PG_private
Date:   Fri, 21 Dec 2018 09:56:25 +0100
Message-ID: <386368225.TvJUPtmGVW@blindfold>
In-Reply-To: <20181215150130.19381-1-richard@nod.at>
References: <20181215150130.19381-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 15. Dezember 2018, 16:01:30 CET schrieb Richard Weinberger:
> The page migration code assumes that a page with PG_private
> set has its page count elevated by 1.
> UBIFS never did this and therefore the migration code was unable
> to migrate some pages owned by UBIFS.
> The lead to situations where the CMA memory allocator failed to
> allocate memory.
> 
> Fix this by using get/put_page when changing PG_private.
> 
> Cc: <stable@vger.kernel.org>
> Cc: zhangjun <openzhangj@gmail.com>
> Fixes: 4ac1c17b2044 ("UBIFS: Implement ->migratepage()")
> Reported-by: zhangjun <openzhangj@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

FYI, on the XFS side a similar change caused a regression.
https://marc.info/?l=linux-fsdevel&m=154530861202448&w=2

Until this regression is not fully understood, including the implications
for UBIFS, I'll not merge this patch.

Thanks,
//richard


