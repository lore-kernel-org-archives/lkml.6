Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C3AF7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783A6208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EwTFtOCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783A6208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935915AbeFMOrt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:47:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935691AbeFMOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2KCaz3pxWGIudojwQMWRhZdC0E7l+STEb+DwGdQaK3I=; b=EwTFtOCrCDHejav+hpVfDmmgr
        OGdBirc97OW0XIIT4GvZ099ANL5NjIvHyzOcnUnrU4wvGBaI7Erv6nlFAq8Y0IuYjT59Eog4ArMC6
        efNoenUMkEC3xztmgkQmVNd2AeONdSh+zxqMJKwn0n6Hl6uWNxt841yZASKxTdrVZw/3KCVa1M/gI
        fZE9DIAMepYLUbIeXsnv13GAxSmgZxWAGc+Y4eb5ktrecya+ENvuhLScfeAXwOBwoy5MZmfNsk9ZV
        74oYXfDrJftdtkeKISsClB7rZ9hyRnPHvgf7lgKsn8BXtXpZxTAPwyLSKPsSh/7b9pWyoU6HgaspE
        vmCkEAFPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT73m-000436-4s; Wed, 13 Jun 2018 14:47:42 +0000
Date:   Wed, 13 Jun 2018 07:47:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 12/30] block: introduce bio_chunks()
Message-ID: <20180613144741.GC4693@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-13-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609123014.8861-13-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline unsigned bio_chunks(struct bio *bio)
> +{
> +	unsigned chunks = 0;
> +	struct bio_vec bv;
> +	struct bvec_iter iter;
>  
> -	return segs;
> +	/*
> +	 * We special case discard/write same/write zeroes, because they
> +	 * interpret bi_size differently:
> +	 */
> +	switch (bio_op(bio)) {
> +	case REQ_OP_DISCARD:
> +	case REQ_OP_SECURE_ERASE:
> +	case REQ_OP_WRITE_ZEROES:
> +		return 0;
> +	case REQ_OP_WRITE_SAME:
> +		return 1;
> +	default:
> +		bio_for_each_chunk(bv, bio, iter)
> +			chunks++;
> +		return chunks;

Shouldn't this just return bio->bi_vcnt?
