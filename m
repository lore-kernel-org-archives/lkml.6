Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeEBRdZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:33:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeEBRdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:33:24 -0400
Date: Wed, 2 May 2018 10:33:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, bcrl@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-abi-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: Add aio priority support for block_dev
Message-ID: <20180502173322.GB27997@infradead.org>
References: <20180430165740.2842-1-adam.manzanares@wdc.com>
 <20180430165740.2842-3-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430165740.2842-3-adam.manzanares@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1603,6 +1603,15 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  		goto out_put_req;
>  	}
>  
> +	if (req->common.ki_flags & IOCB_IOPRIO)
> +		/*
> +		 * The IOCB_IOPRIO flag is set when the user supplied iocb
> +		 * aio_rw_flag field has the RWF_IOPRIO flag set. If so,
> +		 * aio_reqprio is interpreted as a I/O scheduling class and
> +		 * priority.
> +		 */
> +		req->common.ki_ioprio = iocb->aio_reqprio;

Do we need any validation of the field here?

The only other thing I am a bit worried about is bloating struct kiocb
with a field for a relatively uncommon feature, but I can't really
see any much better way to pass it.
