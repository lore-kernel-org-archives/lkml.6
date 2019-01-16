Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8312C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B68320859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfAPCvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:51:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbfAPCvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:51:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 779FD4E916;
        Wed, 16 Jan 2019 02:51:02 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34C9C601AD;
        Wed, 16 Jan 2019 02:50:55 +0000 (UTC)
Date:   Wed, 16 Jan 2019 10:50:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <20190116025048.GB26146@ming.t460p>
References: <20190116134824.74c2d7da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116134824.74c2d7da@canb.auug.org.au>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 16 Jan 2019 02:51:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 01:48:24PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> fs/gfs2/lops.c: In function 'gfs2_end_log_read':
> fs/gfs2/lops.c:394:39: error: macro "bio_for_each_segment_all" requires 4 arguments, but only 3 given
>   bio_for_each_segment_all(bvec, bio, i) {
>                                        ^
> fs/gfs2/lops.c:394:2: error: 'bio_for_each_segment_all' undeclared (first use in this function); did you mean 'bio_first_page_all'?
>   bio_for_each_segment_all(bvec, bio, i) {
>   ^~~~~~~~~~~~~~~~~~~~~~~~
>   bio_first_page_all
> fs/gfs2/lops.c:394:2: note: each undeclared identifier is reported only once for each function it appears in
> fs/gfs2/lops.c:394:26: error: expected ';' before '{' token
>   bio_for_each_segment_all(bvec, bio, i) {
>                           ^              ~
>                           ;
> 
> Caused by commit
> 
>   eb754eb2a953 ("block: allow bio_for_each_segment_all() to iterate over multi-page bvec")
> 
> One instance of bio_for_each_segment_all() was missed.
> 
> I have applied the following fix patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 16 Jan 2019 13:44:02 +1100
> Subject: [PATCH] block: fix up for bio_for_each_segment_all() API change
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/gfs2/lops.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index ef68bf6232e7..15deefeaafd0 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -390,8 +390,9 @@ static void gfs2_end_log_read(struct bio *bio)
>  	struct page *page;
>  	struct bio_vec *bvec;
>  	int i;
> +	struct bvec_iter_all iter_all;
>  
> -	bio_for_each_segment_all(bvec, bio, i) {
> +	bio_for_each_segment_all(bvec, bio, i, iter_all) {
>  		page = bvec->bv_page;
>  		if (bio->bi_status) {
>  			int err = blk_status_to_errno(bio->bi_status);

Yeah, we need the fix, and I just posted it minutes ago, sorry for
the trouble, :-(

https://marc.info/?l=linux-block&m=154760499205773&w=2

Thanks,
Ming
