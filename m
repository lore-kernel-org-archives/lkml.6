Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B04C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6B725477
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGwqEDUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6B725477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965758AbeF0SOB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:14:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965539AbeF0SN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DBl1T1oPZWEt0yUR/Al7AEJfWm+DmJ+hXGN+h+pSnXM=; b=rGwqEDUHSOeR7SFg1kH6R8FAM
        PHGaHPOYmen1SDnm0a0cW5O6RWcpciqgU5+CtnvRmZr7vNgd8aEYaItiY0/LgjHiwNSB0aGGUWv/F
        plshzDfyHS4KC1sECFKeUKUspKk2iQ5jwE0+RX2ygr2rQU3SqikCwtJeXUl7CJqYUOKFCDDda3hvF
        spueZKryt/QJsz0/YDyW7mp6T0QiA/wjcX4S/ETUlETn2d5pSQh4IIoxCWYJMO/2SS4sDBchk1rzH
        Y/M6smhubRHaxkswbtpnU7sJQX6Xv6qTmyHoGUxkTvj6Ap06Rvf93j2W15MvS2mqNTYYxXYQqXgjI
        LRWhiqWZQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYEwu-00007W-GW; Wed, 27 Jun 2018 18:13:48 +0000
Subject: Re: [PATCH V7 24/24] block: document usage of bio iterator helpers
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>
References: <20180627124548.3456-1-ming.lei@redhat.com>
 <20180627124548.3456-25-ming.lei@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <98d6ba9d-ec7a-b05b-94bb-e798ad0e0ea7@infradead.org>
Date:   Wed, 27 Jun 2018 11:13:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627124548.3456-25-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/2018 05:45 AM, Ming Lei wrote:
> Now multipage bvec is supported, and some helpers may return page by
> page, and some may return segment by segment, this patch documents the
> usage for helping us use them correctly.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Documentation/block/biovecs.txt | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/block/biovecs.txt b/Documentation/block/biovecs.txt
> index 25689584e6e0..f63af564ae89 100644
> --- a/Documentation/block/biovecs.txt
> +++ b/Documentation/block/biovecs.txt
> @@ -117,3 +117,30 @@ Other implications:
>     size limitations and the limitations of the underlying devices. Thus
>     there's no need to define ->merge_bvec_fn() callbacks for individual block
>     drivers.
> +
> +Usage of helpers:
> +=================
> +
> +* The following helpers which name has suffix of "_all" can only be used on

                   helpers whose names have the suffix of "_all" can only be used on

> +non-BIO_CLONED bio, and ususally they are used by filesystem code, and driver

                           usually

> +shouldn't use them becasue bio may have been splitted before they got to the

                      because                   split

> +driver:
> +
> +	bio_for_each_segment_all()
> +	bio_first_bvec_all()
> +	bio_first_page_all()
> +	bio_last_bvec_all()
> +
> +* The following helpers iterate over singlepage bvec, and the local

                   preferably:          single-page

> +variable of 'struct bio_vec' or the reference records single page io

                                                                     IO or I/O

> +vector during the itearation:
> +
> +	bio_for_each_segment()
> +	bio_for_each_segment_all()
> +
> +* The following helper iterates over multipage bvec, and each bvec may

                          preferably:   multi-page

> +include multiple physically contiguous pages, and the local variable of
> +'struct bio_vec' or the reference records multi page io vector during the

                                             multi-page IO or I/O

> +itearation:
> +
> +	bio_for_each_bvec()
> 


-- 
~Randy
