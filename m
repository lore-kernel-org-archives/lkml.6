Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932349AbeDWU5f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 16:57:35 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35013 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932163AbeDWU5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 16:57:32 -0400
X-ME-Sender: <xms:u0jeWq42P5nufRjixjT5jLxQF29wOaB8BfouTklbH0Oh7DC2HO9kNg>
Date: Mon, 23 Apr 2018 13:57:30 -0700
From: Andres Freund <andres@anarazel.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Always report a writeback error once
Message-ID: <20180423205730.34wvykqhefbkrtfw@alap3.anarazel.de>
References: <20180423204208.GG13383@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423204208.GG13383@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-04-23 13:42:08 -0700, Matthew Wilcox wrote:
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

There's a comment above this:
 *
 * This function allows callers to sample an errseq_t value, marking it as
 * "seen" if required.

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

Which seems not to be true anymore after this hunk.


> +	/* If nobody has seen this error yet, then we can be the first. */
> +	if (!(old & ERRSEQ_SEEN))
> +		old = 0;
> +	return old;
>  }
>  EXPORT_SYMBOL(errseq_sample);

I've never really looked at this code in any depth before, but won't
this potentially lead to the same error being reported on multiple FDs?
Imagine two fds (potentially in different processes) getting the 0
returned by errseq_sample() because it's not ERRSEQ_SEEN. Afaict
file_check_and_advance_wb_err() will return an error that's always
unlike 0 in that case, and thus the error will returned on both fds?

I'm personally perfectly fine with that, but it's not necessarily what's
described as desired in your email?.

Greetings,

Andres Freund
