Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEFDC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 04:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974132147A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 04:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbqGMDsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974132147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeHYHyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 03:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeHYHyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 03:54:22 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F1BA208C3;
        Sat, 25 Aug 2018 04:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535170609;
        bh=+4RbZxZYhoWETkpChCPyi+Q19qSeAE8r9IN8IOiuz20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fbqGMDsyZatNKkI1a8ILNozo2pM23Qljj+9fMbwe4g7O4Q6dlUCCZnBSCf1Kv5mHw
         I3YqIj8InHQYN5qzYrTsIq5H91xa1bRyVNuxNjs5pJNDxRQ1oG/Iqlez0S3UeKNmH3
         rOyRI5wkPMIVlKHcCXmTX5fKc8J3DOIrfDfJb6UQ=
Date:   Fri, 24 Aug 2018 21:16:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [RFC PATCH 02/10] fs-verity: add data verification hooks for
 ->readpages()
Message-ID: <20180825041647.GA726@sol.localdomain>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-3-ebiggers@kernel.org>
 <2f2382c3-e5e9-f0da-dc89-42dfc7b2b636@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2382c3-e5e9-f0da-dc89-42dfc7b2b636@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gao,

On Sat, Aug 25, 2018 at 10:29:26AM +0800, Gao Xiang wrote:
> Hi,
> 
> On 2018/8/25 0:16, Eric Biggers wrote:
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
> > +{
> > +	struct inode *inode = bio_first_page_all(bio)->mapping->host;
> > +	const struct fsverity_info *vi = get_fsverity_info(inode);
> > +	struct ahash_request *req;
> > +	struct bio_vec *bv;
> > +	int i;
> > +
> > +	req = ahash_request_alloc(vi->hash_alg->tfm, GFP_KERNEL);
> > +	if (unlikely(!req)) {
> > +		bio_for_each_segment_all(bv, bio, i)
> > +			SetPageError(bv->bv_page);
> > +		return;
> > +	}
> > +
> > +	bio_for_each_segment_all(bv, bio, i) {
> > +		struct page *page = bv->bv_page;
> > +
> > +		if (!PageError(page) && !verify_page(inode, vi, req, page))
> > +			SetPageError(page);
> > +	}
> > +
> > +	ahash_request_free(req);
> > +}
> > +EXPORT_SYMBOL_GPL(fsverity_verify_bio);
> 
> Out of curiosity, I quickly scanned the fs-verity source code and some minor question out there....
> 
> If something is wrong, please point out, thanks in advance...
> 
> My first question is that 'Is there any way to skip to verify pages in a bio?'
> I am thinking about
> If metadata and data page are mixed in a filesystem of such kind, they could submit together in a bio, but metadata could be unsuitable for such kind of verification.
> 

Pages below i_size are verified, pages above are not.

With my patches, ext4 and f2fs won't actually submit pages in both areas in the
same bio, and they won't call the fs-verity verification function for bios in
the data area.  But even if they did, there's also a check in verify_page() that
skips the verification if the page is above i_size.

> The second question is related to the first question --- 'Is there any way to verify a partial page?'
> Take scalability into consideration, some files could be totally inlined or partially inlined in metadata.
> Is there any way to deal with them in per-file approach? at least --- support for the interface?

Well, one problem is that inline data has its own separate I/O path; see
ext4_readpage_inline() and f2fs_read_inline_data().  So it would be a large
effort to support features like encryption and verity which require
postprocessing after reads, and probably not worthwhile especially for verity
which is primarily intended for large files.

A somewhat separate question is whether the zero padding to a block boundary
after i_size, before the Merkle tree begins, is needed.  The answer is yes,
since mixing data and metadata in the same page would cause problems.  First,
userspace would be able to mmap the page and see some of the metadata rather
than zeroes.  That's not a huge problem, but it breaks the standard behavior.
Second, any page containing data cannot be set Uptodate until it's been
verified.  So, a special case would be needed to handle reading the part of the
metadata that's located in a data page.

> At last, I hope filesystems could select the on-disk position of hash tree and 'struct fsverity_descriptor'
> rather than fixed in the end of verity files...I think if fs-verity preparing such support and interfaces could be better.....hmmm... :(

In theory it would be a much cleaner design to store verity metadata separately
from the data.  But the Merkle tree can be very large.  For example, a 1 GB file
using SHA-512 would have a 16.6 MB Merkle tree.  So the Merkle tree can't be an
extended attribute, since the xattrs API requires xattrs to be small (<= 64 KB),
and most filesystems further limit xattr sizes in their on-disk format to as
little as 4 KB.  Furthermore, even if both of these limits were to be increased,
the xattrs functions (both the syscalls, and the internal functions that
filesystems have) are all based around getting/setting the entire xattr value.

Also when used with fscrypt, we want the Merkle tree and fsverity_descriptor to
be encrypted, so they doesn't leak plaintext hashes.  And we want the Merkle
tree to be paged into memory, just like the file contents, to take advantage of
the usual Linux memory management.

What we really need is *streams*, like NTFS has.  But the filesystems we're
targetting don't support streams, nor does the Linux syscall interface have any
API for accessing streams, nor does the VFS support them.

Adding streams support to all those things would be a huge multi-year effort,
controversial, and almost certainly not worth it just for fs-verity.

So simply storing the verity metadata past i_size seems like the best solution
for now.

That being said, in the future we could pretty easily swap out the calls to
read_mapping_page() with something else if a particular filesystem wanted to
store the metadata somewhere else.  We actually even originally had a function
->read_metadata_page() in the filesystem's fsverity_operations, but it turned
out to be unnecessary and I replaced it with directly calling
read_mapping_page(), but it could be changed back at any time.

- Eric
