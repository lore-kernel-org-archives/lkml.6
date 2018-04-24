Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeDXMYT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757691AbeDXMYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:24:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12FE21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jlayton@kernel.org
Message-ID: <1524572654.5929.3.camel@kernel.org>
Subject: Re: [PATCH] Always report a writeback error once
From: Jeff Layton <jlayton@kernel.org>
To: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andres Freund <andres@anarazel.de>
Date: Tue, 24 Apr 2018 08:24:14 -0400
In-Reply-To: <20180423204208.GG13383@bombadil.infradead.org>
References: <20180423204208.GG13383@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-23 at 13:42 -0700, Matthew Wilcox wrote:
> The errseq_t infrastructure assumes that errors which occurred before
> the file descriptor was opened are of no interest to the application.
> This turns out to be a regression for some applications, notably Postgres.
> 
> Before errseq_t, a writeback error would be reported exactly once (as
> long as the inode remained in memory), so Postgres could open a file,
> call fsync() and find out whether there had been a writeback error on
> that file from another process.
> 
> This patch restores that behaviour by reporting errors to file descriptors
> which are opened after the error occurred, but before it was reported
> to any file descriptor.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5660e13d2fd6 ("fs: new infrastructure for writeback error handling and reporting")
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> 
> diff --git a/lib/errseq.c b/lib/errseq.c
> index df782418b333..093f1fba4ee0 100644
> --- a/lib/errseq.c
> +++ b/lib/errseq.c
> @@ -119,19 +119,11 @@ EXPORT_SYMBOL(errseq_set);
>  errseq_t errseq_sample(errseq_t *eseq)
>  {
>  	errseq_t old = READ_ONCE(*eseq);
> -	errseq_t new = old;
>  
> -	/*
> -	 * For the common case of no errors ever having been set, we can skip
> -	 * marking the SEEN bit. Once an error has been set, the value will
> -	 * never go back to zero.
> -	 */
> -	if (old != 0) {
> -		new |= ERRSEQ_SEEN;
> -		if (old != new)
> -			cmpxchg(eseq, old, new);
> -	}
> -	return new;
> +	/* If nobody has seen this error yet, then we can be the first. */
> +	if (!(old & ERRSEQ_SEEN))
> +		old = 0;
> +	return old;
>  }
>  EXPORT_SYMBOL(errseq_sample);
>  

Patch looks good to me, modulo the comment fix that Andres pointed out.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
