Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A5C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DE220851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DE220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeLMOXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:23:42 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:33262 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:23:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 62D446083254;
        Thu, 13 Dec 2018 15:23:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U1Lavz_jk_qo; Thu, 13 Dec 2018 15:23:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DB8656083255;
        Thu, 13 Dec 2018 15:23:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kzNdH1PHB-Kv; Thu, 13 Dec 2018 15:23:38 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 762426083253;
        Thu, 13 Dec 2018 15:23:38 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     zhangjun <openzhangj@gmail.com>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org
Subject: Re: ubifs: fix page_count in ->ubifs_migrate_page()
Date:   Thu, 13 Dec 2018 15:23:37 +0100
Message-ID: <5829763.q4qAXljTxb@blindfold>
In-Reply-To: <1544624037-3436-1-git-send-email-openzhangj@gmail.com>
References: <1544624037-3436-1-git-send-email-openzhangj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello zhangjun,

thanks a lot for bringing this up!

Am Mittwoch, 12. Dezember 2018, 15:13:57 CET schrieb zhangjun:
> Because the PagePrivate() in UBIFS is different meanings,
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

As you noted, UBIFS uses PG_private a little different.
It uses it as marker and when set, the page counter is not incremented,
since no private data is attached.
The migration code assumes that PG_private indicates a counter of +1.
So, we have to pass a extra count of -1 to migrate_page_move_mapping() if
the flag is set.
Just like F2FS does. Not really nice but hey...

> Signed-off-by: zhangjun <openzhangj@gmail.com>

Fixes: 4ac1c17b2044 ("UBIFS: Implement ->migratepage()")

> ---
>  fs/ubifs/file.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index 1b78f2e..2136a5c 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -1480,8 +1480,15 @@ static int ubifs_migrate_page(struct address_space *mapping,
>  		struct page *newpage, struct page *page, enum migrate_mode mode)
>  {
>  	int rc;
> +	int extra_count;
>  
> -	rc = migrate_page_move_mapping(mapping, newpage, page, NULL, mode, 0);
> +	/*
> +	 * UBIFS is using PagePrivate() which can have different meanings across
> +	 * filesystems. So here adjusting the 'extra_count' make it work.
> +	 */

Please rewrite that comment.
/*
 * UBIFS uses PG_private as marker and does not raise the page counter.
 * migrate_page_move_mapping() expects a incremented counter if PG_private
 * is set. Therefore pass -1 as extra_count for this case.
 */

> +	extra_count = 0 - page_has_private(page);

if (page_has_private(page))
	extra_count = -1;

That way this corner is much more obvious.

Thanks,
//richard


