Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E881C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5740F21567
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5740F21567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeHYGIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 02:08:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbeHYGIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 02:08:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9A7667B24E499;
        Sat, 25 Aug 2018 10:30:53 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.399.0; Sat, 25 Aug
 2018 10:30:50 +0800
Subject: Re: [f2fs-dev] [RFC PATCH 02/10] fs-verity: add data verification
 hooks for ->readpages()
To:     Eric Biggers <ebiggers@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        "Mimi Zohar" <zohar@linux.vnet.ibm.com>,
        Victor Hsieh <victorhsieh@google.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-3-ebiggers@kernel.org>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <2f2382c3-e5e9-f0da-dc89-42dfc7b2b636@huawei.com>
Date:   Sat, 25 Aug 2018 10:29:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180824161642.1144-3-ebiggers@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/8/25 0:16, Eric Biggers wrote:
> +/**
> + * fsverity_verify_page - verify a data page
> + *
> + * Verify a page that has just been read from a file against that file's Merkle
> + * tree.  The page is assumed to be a pagecache page.
> + *
> + * Return: true if the page is valid, else false.
> + */
> +bool fsverity_verify_page(struct page *data_page)
> +{
> +	struct inode *inode = data_page->mapping->host;
> +	const struct fsverity_info *vi = get_fsverity_info(inode);
> +	struct ahash_request *req;
> +	bool valid;
> +
> +	req = ahash_request_alloc(vi->hash_alg->tfm, GFP_KERNEL);
> +	if (unlikely(!req))
> +		return false;
> +
> +	valid = verify_page(inode, vi, req, data_page);
> +
> +	ahash_request_free(req);
> +
> +	return valid;
> +}
> +EXPORT_SYMBOL_GPL(fsverity_verify_page);
> +
> +/**
> + * fsverity_verify_bio - verify a 'read' bio that has just completed
> + *
> + * Verify a set of pages that have just been read from a file against that
> + * file's Merkle tree.  The pages are assumed to be pagecache pages.  Pages that
> + * fail verification are set to the Error state.  Verification is skipped for
> + * pages already in the Error state, e.g. due to fscrypt decryption failure.
> + */
> +void fsverity_verify_bio(struct bio *bio)
> +{
> +	struct inode *inode = bio_first_page_all(bio)->mapping->host;
> +	const struct fsverity_info *vi = get_fsverity_info(inode);
> +	struct ahash_request *req;
> +	struct bio_vec *bv;
> +	int i;
> +
> +	req = ahash_request_alloc(vi->hash_alg->tfm, GFP_KERNEL);
> +	if (unlikely(!req)) {
> +		bio_for_each_segment_all(bv, bio, i)
> +			SetPageError(bv->bv_page);
> +		return;
> +	}
> +
> +	bio_for_each_segment_all(bv, bio, i) {
> +		struct page *page = bv->bv_page;
> +
> +		if (!PageError(page) && !verify_page(inode, vi, req, page))
> +			SetPageError(page);
> +	}
> +
> +	ahash_request_free(req);
> +}
> +EXPORT_SYMBOL_GPL(fsverity_verify_bio);

Out of curiosity, I quickly scanned the fs-verity source code and some minor question out there....

If something is wrong, please point out, thanks in advance...

My first question is that 'Is there any way to skip to verify pages in a bio?'
I am thinking about
If metadata and data page are mixed in a filesystem of such kind, they could submit together in a bio, but metadata could be unsuitable for such kind of verification.

The second question is related to the first question --- 'Is there any way to verify a partial page?'
Take scalability into consideration, some files could be totally inlined or partially inlined in metadata.
Is there any way to deal with them in per-file approach? at least --- support for the interface?

At last, I hope filesystems could select the on-disk position of hash tree and 'struct fsverity_descriptor'
rather than fixed in the end of verity files...I think if fs-verity preparing such support and interfaces could be better.....hmmm... :(

Thanks,
Gao Xiang

