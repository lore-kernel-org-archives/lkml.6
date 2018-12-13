Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F98C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB862086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB862086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeLMVgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:36:51 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:39872 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbeLMVgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:36:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DB1AA6083256;
        Thu, 13 Dec 2018 22:36:48 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0rCerxW0RO-f; Thu, 13 Dec 2018 22:36:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 71A2A6083246;
        Thu, 13 Dec 2018 22:36:48 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qb1VqvaGNiG1; Thu, 13 Dec 2018 22:36:48 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id E56D0608A3BE;
        Thu, 13 Dec 2018 22:36:47 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     zhangjun <openzhangj@gmail.com>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] ubifs: fix page_count in ->ubifs_migrate_page()
Date:   Thu, 13 Dec 2018 22:36:47 +0100
Message-ID: <8239265.3QN2sXB6kY@blindfold>
In-Reply-To: <1544728817-2870-1-git-send-email-openzhangj@gmail.com>
References: <1544728817-2870-1-git-send-email-openzhangj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 13. Dezember 2018, 20:20:17 CET schrieb zhangjun:
> Because the PagePrivate() in UBIFS is different meanings,

...has different meanings...

I'll fix up that myself after applying your patch. No need to send a v3.

> alloc_cma() will fail when one dirty page cache located in
> the type of MIGRATE_CMA
> 
> If not adjust the 'extra_count' for dirty page,
> ubifs_migrate_page() -> migrate_page_move_mapping() will
> always return -EAGAIN for:
> 	expected_count += page_has_private(page)
> This causes the migration to fail until the page cache is cleaned
> 
> In general, PagePrivate() indicates that buff_head is already bound
> to this page, and at the same time page_count() will also increase.
> But UBIFS set private flag when the cache is dirty, and page_count()
> not increase.
> Therefore, the expected_count of UBIFS is different from the general
> case.
> 
> Signed-off-by: zhangjun <openzhangj@gmail.com>

Fixes: 4ac1c17b2044 ("UBIFS: Implement ->migratepage()")

> ---
>  fs/ubifs/file.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index 1b78f2e..890dfce 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -1480,8 +1480,17 @@ static int ubifs_migrate_page(struct address_space *mapping,
>  		struct page *newpage, struct page *page, enum migrate_mode mode)
>  {
>  	int rc;
> +	int extra_count = 0;
>  
> -	rc = migrate_page_move_mapping(mapping, newpage, page, NULL, mode, 0);
> +	/*
> +	 * UBIFS uses PG_private as marker and does not raise the page counter.
> +	 * migrate_page_move_mapping() expects a incremented counter if
> +	 * PG_private is set. Therefore pass -1 as extra_count for this case.
> +	 */
> +	if (page_has_private(page))
> +		extra_count = -1;
> +	rc = migrate_page_move_mapping(mapping, newpage, page,
> +			NULL, mode, extra_count);
>  	if (rc != MIGRATEPAGE_SUCCESS)
>  		return rc;
>  

Let's wait a few days to give Kirill a chance to review, then I'll apply the patch.

Thanks,
//richard 



