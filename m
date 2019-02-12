Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED0EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5078B218D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gyxqr3ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfBLNva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:51:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLNva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=87fOArnzsZbXpqgOTphW64jpmWJ3K5CP7SJkFFXGk2Q=; b=gyxqr3niwQ0yTJkKb5q1BnhXH
        HwgtahLGf4M0eoxvx8cl5Xz1wZPPhWuAyvL2iHCD2+vFeRMI0aeuaQoc8zK7kYEohhazLExIbmJxp
        BsZc1OPw+mxBitMaVvv6eL4hWeGx3Hwl+xq6XvU2PQDY8M7VNKEQTd7+O6S2/gAmrX4aE5jo1Znzk
        mH6hKWQ9mjD+B3JtWPqUQqZdl3aCeg4o5sppcSxdDsq6IFl3XUOLNc8Q04jKzYAESUskX1g9rtcGW
        V5Ux+Hd/Ktg5y07xoPptA4DAntBLV8hEmxqYHGyzIGddtCHKrCGPdcHaj6aF0RSmZ1fTVr/WZzy1s
        B2pBeTU4w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtYTB-0005lb-TE; Tue, 12 Feb 2019 13:51:29 +0000
Date:   Tue, 12 Feb 2019 05:51:29 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xarray: Document erasing entries during iteration
Message-ID: <20190212135129.GL12668@bombadil.infradead.org>
References: <20190212072958.17373-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212072958.17373-1-tobin@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:29:58PM +1100, Tobin C. Harding wrote:
> I had my first go using the XArray today and during that I wondered if
> it was safe to remove items during iteration.  Conceptually it seems
> fine and it seemed to work just fine in code - is this something people
> should not be doing for any reason?  Is this the best way to traverse
> the tree and get every thing just to erase it?  Are we even supposed to
> be thinking this is a tree or should we just be thinking it is an array?

You should be thinking it's an array.  I've done everything I can to
hide the fact that it's implemented as a tree because it's conceptually
an array.

The xa_for_each() iterator is designed to be extremely robust, at the
expense of some performance.  The only state it keeps is the @index,
so you can do anything you like to the XArray during the iteration.

It's definitely worth being clearer in the documentation, for
the benefit of people who're wondering what the equivalent of
list_for_each_entry_safe() is.  So I'll apply this patch in a day or
two unless anybody has further comment on it.

> (As you might have guessed I _still_ don't know exactly how a radix tree
> works :)

That is _fine_.  As you know I hope to get rid of the radix tree soon ;-)

> Oh, and FTR the XArray is hot - good effort man.
> 
> thanks,
> Tobin.
> 
> 
>  Documentation/core-api/xarray.rst | 3 ++-
>  include/linux/xarray.h            | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
> index 5d54b27c6eba..2578e0bdaa17 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst
> @@ -97,7 +97,8 @@ You can copy entries out of the XArray into a plain array by calling
>  :c:func:`xa_extract`.  Or you can iterate over the present entries in
>  the XArray by calling :c:func:`xa_for_each`.  You may prefer to use
>  :c:func:`xa_find` or :c:func:`xa_find_after` to move to the next present
> -entry in the XArray.
> +entry in the XArray.  It is safe to call :c:func:`xa_release` on entries
> +as you iterate over the array using :c:func:`xa_for_each`.

that's spelled `xa_erase` ;-)

>  Calling :c:func:`xa_store_range` stores the same entry in a range
>  of indices.  If you do this, some of the other operations will behave
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 5d9d318bcf7a..1f8974281a0a 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -407,6 +407,8 @@ static inline bool xa_marked(const struct xarray *xa, xa_mark_t mark)
>   * you should use the xas_for_each() iterator instead.  The xas_for_each()
>   * iterator will expand into more inline code than xa_for_each().
>   *
> + * It is safe to erase entries from the XArray as you iterate over it.
> + *
>   * Context: Any context.  Takes and releases the RCU lock.
>   */
>  #define xa_for_each(xa, index, entry) \
> -- 
> 2.20.1
> 
