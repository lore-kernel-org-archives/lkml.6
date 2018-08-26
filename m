Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE81C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1DA208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKO/eJeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1DA208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeHZUrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 16:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeHZUrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 16:47:42 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32FFD208C1;
        Sun, 26 Aug 2018 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535303076;
        bh=ohaZbZAB95OjMvy7U3GOyZwt2LQUz230ySU1sSUuS6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKO/eJebcKyjtkaEnYRW+KGAwoHJC+HtU56EmGM0fagRT8D186na3vA2xa+XvLaR4
         UWtUnK1ihI5Ls4gS+XSKfYaOgsR/XXOLj94Iwu9AiokLVvD24lNKyf//aRwWR24lR2
         Bpr/GuK13K/i6VdnHAyhWzlVd5DC1GiW9vordyUE=
Date:   Sun, 26 Aug 2018 10:04:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chuck Lever <chucklever@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [RFC PATCH 02/10] fs-verity: add data verification hooks for
 ->readpages()
Message-ID: <20180826170433.GA728@sol.localdomain>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-3-ebiggers@kernel.org>
 <C86750D6-CA95-4A7F-9204-51345C497EC2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C86750D6-CA95-4A7F-9204-51345C497EC2@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuck,

On Sun, Aug 26, 2018 at 11:55:57AM -0400, Chuck Lever wrote:
> > +
> > +/**
> > + * fsverity_verify_page - verify a data page
> > + *
> > + * Verify a page that has just been read from a file against that file's Merkle
> > + * tree.  The page is assumed to be a pagecache page.
> > + *
> > + * Return: true if the page is valid, else false.
> > + */
> > +bool fsverity_verify_page(struct page *data_page)
> > +{
> > +	struct inode *inode = data_page->mapping->host;
> > +	const struct fsverity_info *vi = get_fsverity_info(inode);
> > +	struct ahash_request *req;
> > +	bool valid;
> > +
> > +	req = ahash_request_alloc(vi->hash_alg->tfm, GFP_KERNEL);
> > +	if (unlikely(!req))
> > +		return false;
> > +
> > +	valid = verify_page(inode, vi, req, data_page);
> > +
> > +	ahash_request_free(req);
> > +
> > +	return valid;
> > +}
> > +EXPORT_SYMBOL_GPL(fsverity_verify_page);
> > +
> > +/**
> > + * fsverity_verify_bio - verify a 'read' bio that has just completed
> > + *
> > + * Verify a set of pages that have just been read from a file against that
> > + * file's Merkle tree.  The pages are assumed to be pagecache pages.  Pages that
> > + * fail verification are set to the Error state.  Verification is skipped for
> > + * pages already in the Error state, e.g. due to fscrypt decryption failure.
> > + */
> > +void fsverity_verify_bio(struct bio *bio)
> 
> Hi Eric-
> 
> This kind of API won't work for remote filesystems, which do not use
> "struct bio" to do their I/O. Could a remote filesystem solely use
> fsverity_verify_page instead?
> 

Yes, filesystems don't have to use fsverity_verify_bio().  They can call
fsverity_verify_page() on each page instead.  I will clarify this in the next
revision of the patchset.

- Eric
