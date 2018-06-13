Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2AC6AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DC1208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ihgQY+Ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DC1208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935932AbeFMOse (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:48:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935691AbeFMOsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Juow3VUOypXj8FAiGiCTH1sCFjZDqmbGAQNBXIfktf0=; b=ihgQY+BaIYO6FmZ0xuY6/NCrl
        rbIi6IEKtTMtNNM+XGuALTMz7Eq6gOjQzJIuklAG4EmMom8/ruoX7gccRIW0AZRwlMLCzflBiHSqN
        cg7CSb8W2luzEKOAIcpm89gQKuMh7hIFps8dvdEPJi6S/HNehkbhBCAYR4OGGjI0cp1yoJDUNrg7p
        ArjFZ9bRU6TSjmn9/o2SSm1GsmWdVI0gRwyjpUkMFKQHawpaHrSPYCeW9CJ2WAOBZO5B9BJo9kwkC
        m/yzwjvJscjlHe0dzWOehkx+nZ5pYKUu1ovVncZAoOqHudGw8gjPNzhCqp0SZV5zCxwO1dbJlQ8np
        jb3tVH4kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT74M-000482-DU; Wed, 13 Jun 2018 14:48:18 +0000
Date:   Wed, 13 Jun 2018 07:48:18 -0700
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
Subject: Re: [PATCH V6 13/30] block: introduce rq_for_each_chunk()
Message-ID: <20180613144818.GD4693@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-14-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609123014.8861-14-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 08:29:57PM +0800, Ming Lei wrote:
> There are still cases in which rq_for_each_chunk() is required, for
> example, loop.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/blkdev.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bca3a92eb55f..4eaba73c784a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -941,6 +941,10 @@ struct req_iterator {
>  	__rq_for_each_bio(_iter.bio, _rq)			\
>  		bio_for_each_segment(bvl, _iter.bio, _iter.iter)
>  
> +#define rq_for_each_chunk(bvl, _rq, _iter)			\
> +	__rq_for_each_bio(_iter.bio, _rq)			\
> +		bio_for_each_chunk(bvl, _iter.bio, _iter.iter)

We have a single users of this in the loop driver.  I'd rather
see the obvious loop open coded.
