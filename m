Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541ADC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2091D20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2091D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeLKRV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:21:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35543 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeLKRV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:21:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02B4A811DC;
        Tue, 11 Dec 2018 17:21:55 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE9705D73F;
        Tue, 11 Dec 2018 17:21:53 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
References: <20181128183531.5139-1-willy@infradead.org>
        <x49va46e1p0.fsf@segfault.boston.devel.redhat.com>
        <x49pnuee1gm.fsf@segfault.boston.devel.redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 11 Dec 2018 12:21:52 -0500
In-Reply-To: <x49pnuee1gm.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
        message of "Thu, 06 Dec 2018 17:26:33 -0500")
Message-ID: <x49mupcm11r.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 11 Dec 2018 17:21:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Moyer <jmoyer@redhat.com> writes:

> Jeff Moyer <jmoyer@redhat.com> writes:
>
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>>> This custom resizing array was vulnerable to a Spectre attack (speculating
>>> off the end of an array to a user-controlled offset).  The XArray is
>>> not vulnerable to Spectre as it always masks its lookups to be within
>>> the bounds of the array.
>>
>> I'm not a big fan of completely re-writing the code to fix this.  Isn't
>> the below patch sufficient?
>
> Too quick on the draw.  Here's a patch that compiles.  ;-)

Hi, Matthew,

I'm going to submit this version formally.  If you're interested in
converting the ioctx_table to xarray, you can do that separately from a
security fix.  I would include a performance analysis with that patch,
though.  The idea of using a radix tree for the ioctx table was
discarded due to performance reasons--see commit db446a08c23d5 ("aio:
convert the ioctx list to table lookup v3").  I suspect using the xarray
will perform similarly.

Cheers,
Jeff

> diff --git a/fs/aio.c b/fs/aio.c
> index 97f983592925..aac9659381d2 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -45,6 +45,7 @@
>  
>  #include <asm/kmap_types.h>
>  #include <linux/uaccess.h>
> +#include <linux/nospec.h>
>  
>  #include "internal.h"
>  
> @@ -1038,6 +1039,7 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
>  	if (!table || id >= table->nr)
>  		goto out;
>  
> +	id = array_index_nospec(id, table->nr);
>  	ctx = rcu_dereference(table->table[id]);
>  	if (ctx && ctx->user_id == ctx_id) {
>  		if (percpu_ref_tryget_live(&ctx->users))
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
