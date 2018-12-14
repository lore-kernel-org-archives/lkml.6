Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECD1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B085208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B085208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbeLNLZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:25:56 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:50498 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeLNLZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:25:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EB6C06083257;
        Fri, 14 Dec 2018 12:25:52 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lMjJmYC0ogcA; Fri, 14 Dec 2018 12:25:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 91BE76083246;
        Fri, 14 Dec 2018 12:25:52 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a-l_qMXLjYq0; Fri, 14 Dec 2018 12:25:52 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 7B9136083243;
        Fri, 14 Dec 2018 12:25:51 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     zhangjun <openzhangj@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>, hch@lst.de,
        bfoster@redhat.com, darrick.wong@oracle.com,
        Dave Chinner <david@fromorbit.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        n-horiguchi@ah.jp.nec.com, mgorman@techsingularity.net,
        aarcange@redhat.com, willy@infradead.org,
        linux@dominikbrodowski.net, linux-mm@kvack.org,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] fix page_count in ->iomap_migrate_page()
Date:   Fri, 14 Dec 2018 12:25:50 +0100
Message-ID: <1618433.IpySj692Hd@blindfold>
In-Reply-To: <1544766961-3492-1-git-send-email-openzhangj@gmail.com>
References: <1544766961-3492-1-git-send-email-openzhangj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC'ing authors of the code plus mm folks]

Am Freitag, 14. Dezember 2018, 06:56:01 CET schrieb zhangjun:
> IOMAP uses PG_private a little different with buffer_head based
> filesystem.
> It uses it as marker and when set, the page counter is not incremented,
> migrate_page_move_mapping() assumes that PG_private indicates a counter
> of +1.
> so, we have to pass a extra count of -1 to migrate_page_move_mapping()
> if the flag is set.
> 
> Signed-off-by: zhangjun <openzhangj@gmail.com>
> ---
>  fs/iomap.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 64ce240..352e58a 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -544,8 +544,17 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
>  		struct page *page, enum migrate_mode mode)
>  {
>  	int ret;
> +	int extra_count = 0;
>  
> -	ret = migrate_page_move_mapping(mapping, newpage, page, NULL, mode, 0);
> +	/*
> +	 * IOMAP uses PG_private as marker and does not raise the page counter.
> +	 * migrate_page_move_mapping() expects a incremented counter if PG_private
> +	 * is set. Therefore pass -1 as extra_count for this case.
> +	 */
> +	if (page_has_private(page))
> +		extra_count = -1;
> +	ret = migrate_page_move_mapping(mapping, newpage, page,
> +		       NULL, mode, extra_count);
>  	if (ret != MIGRATEPAGE_SUCCESS)
>  		return ret;

This is the third place which needs this workaround.
UBIFS, F2FS, and now iomap.

I agree with Dave that nobody can assume that PG_private implies an additional
page reference.
But page migration does that. Including parts of the write back code.

Thanks,
//richard


