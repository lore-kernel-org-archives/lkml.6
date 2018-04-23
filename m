Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932613AbeDWVvz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:51:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeDWVvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:51:50 -0400
Date: Mon, 23 Apr 2018 14:51:50 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Andres Freund <andres@anarazel.de>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Always report a writeback error once
Message-ID: <20180423215150.GI13383@bombadil.infradead.org>
References: <20180423204208.GG13383@bombadil.infradead.org>
 <20180423205730.34wvykqhefbkrtfw@alap3.anarazel.de>
 <20180423214348.GH13383@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423214348.GH13383@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 02:43:48PM -0700, Matthew Wilcox wrote:
> On Mon, Apr 23, 2018 at 01:57:30PM -0700, Andres Freund wrote:
> > On 2018-04-23 13:42:08 -0700, Matthew Wilcox wrote:
> > > @@ -119,19 +119,11 @@ EXPORT_SYMBOL(errseq_set);
> > >  errseq_t errseq_sample(errseq_t *eseq)
> > >  {
> > 
> > There's a comment above this:
> >  *
> >  * This function allows callers to sample an errseq_t value, marking it as
> >  * "seen" if required.
> 
> Oh, good catch.  I'll fix that.  Thanks!

How does this look?

@@ -111,27 +111,22 @@ EXPORT_SYMBOL(errseq_set);
  * errseq_sample() - Grab current errseq_t value.
  * @eseq: Pointer to errseq_t to be sampled.
  *
- * This function allows callers to sample an errseq_t value, marking it as
- * "seen" if required.
+ * This function allows callers to initialise their errseq_t variable.
+ * If the error has been "seen", new callers will not see an old error.
+ * If there is an unseen error in @eseq, the caller of this function will
+ * see it the next time it checks for an error.
  *
+ * Context: Any context.
  * Return: The current errseq value.
  */
 errseq_t errseq_sample(errseq_t *eseq)
