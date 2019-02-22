Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3986B206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfBVWpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:45:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfBVWpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:45:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25E0ACAA72;
        Fri, 22 Feb 2019 22:45:22 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBF4D5D9CA;
        Fri, 22 Feb 2019 22:45:19 +0000 (UTC)
Date:   Fri, 22 Feb 2019 17:45:18 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     sultan@kerneltoast.com
Cc:     dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: dm crypt: fix memory leak in dm_crypt_integrity_io_alloc() error
 path
Message-ID: <20190222224518.GA11359@redhat.com>
References: <20190216210022.29483-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216210022.29483-1-sultan@kerneltoast.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 22 Feb 2019 22:45:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16 2019 at  4:00pm -0500,
sultan@kerneltoast.com <sultan@kerneltoast.com> wrote:

> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> dm_crypt_integrity_io_alloc() allocates space for an integrity payload but
> doesn't free it in the error path, leaking memory. Add a bio_integrity_free()
> invocation upon error to fix the memory leak.
> 
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  drivers/md/dm-crypt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index dd538e6b2..f731e1fe0 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -939,8 +939,10 @@ static int dm_crypt_integrity_io_alloc(struct dm_crypt_io *io, struct bio *bio)
>  
>  	ret = bio_integrity_add_page(bio, virt_to_page(io->integrity_metadata),
>  				     tag_len, offset_in_page(io->integrity_metadata));
> -	if (unlikely(ret != tag_len))
> +	if (unlikely(ret != tag_len)) {
> +		bio_integrity_free(bio);
>  		return -ENOMEM;
> +	}
>  
>  	return 0;
>  }

Since commit 7c20f11680a4 bio_integrity_free() is no longer and exported
symbol.

But that aside, this dm-crypt clone bio's endio will clean up the bip
once -ENOMEM return starts to make its way out via
crypt_alloc_buffer()'s bio_put().

Mike

