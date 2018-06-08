Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ngFdBLB7Glv9AgAAmS7hNA
	; Fri, 08 Jun 2018 12:50:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 01A3A608BA; Fri,  8 Jun 2018 12:50:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7A4FB607A4;
	Fri,  8 Jun 2018 12:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A4FB607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeFHMux (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:50:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751384AbeFHMuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:50:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A350C12BA;
        Fri,  8 Jun 2018 12:50:50 +0000 (UTC)
Received: from ming.t460p (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0890310EE6CE;
        Fri,  8 Jun 2018 12:50:33 +0000 (UTC)
Date: Fri, 8 Jun 2018 20:50:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: dsterba@suse.cz, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>
Subject: Re: [RESEND PATCH V5 00/33] block: support multipage bvec
Message-ID: <20180608125023.GA9444@ming.t460p>
References: <20180525034621.31147-1-ming.lei@redhat.com>
 <20180601140954.GY3539@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601140954.GY3539@suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 08 Jun 2018 12:50:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 08 Jun 2018 12:50:50 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 04:09:54PM +0200, David Sterba wrote:
> On Fri, May 25, 2018 at 11:45:48AM +0800, Ming Lei wrote:
> >  fs/btrfs/check-integrity.c          |   6 +-
> >  fs/btrfs/compression.c              |   8 +-
> >  fs/btrfs/disk-io.c                  |   3 +-
> >  fs/btrfs/extent_io.c                |  14 ++-
> >  fs/btrfs/file-item.c                |   4 +-
> >  fs/btrfs/inode.c                    |  12 ++-
> >  fs/btrfs/raid56.c                   |   5 +-
> 
> For the btrfs bits,
> Acked-by: David Sterba <dsterba@suse.com>
> 
> but that's from the bio API user perspective only, I'll leave the design
> and implementation questions to others.
> 
> I've let the patchset through fstests, no problems. One thing that caught

Thanks for your test!

> my eye was use of the 'struct bvec_iter_all' in random functions. As
> this structure is a compound of 2 others and is 40 bytes in size, I was
> curious how this increased stack consumption.
> 
> Measured with -fstack-usage before and after patch 22/33 "btrfs: conver to
> bio_for_each_page_all2"
> 
> -disk-io.c:btree_csum_one_bio                             48 static
> +disk-io.c:btree_csum_one_bio                             80 static
> -extent_io.c:end_bio_extent_buffer_writepage              56 static
> +extent_io.c:end_bio_extent_buffer_writepage              80 static
> -extent_io.c:end_bio_extent_readpage                      176 dynamic,bounded
> +extent_io.c:end_bio_extent_readpage                      240 dynamic,bounded
> -extent_io.c:end_bio_extent_writepage                     56 static
> +extent_io.c:end_bio_extent_writepage                     120 static
> -inode.c:btrfs_retry_endio                                96 dynamic,bounded
> +inode.c:btrfs_retry_endio                                144 dynamic,bounded
> -inode.c:btrfs_retry_endio_nocsum                         72 dynamic,bounded
> +inode.c:btrfs_retry_endio_nocsum                         104 dynamic,bounded
> -raid56.c:set_bio_pages_uptodate                          8 static
> +raid56.c:set_bio_pages_uptodate                          40 static
> 
> It's not that bad, but still quite a lot just to iterate a list of bios. I
> think it's worth mentioning as it affects several other filesystems and
> should be possibly optimized in the future.

OK.

We could decrease the affect by using a lightweight iterator for
bio_for_each_page_all2(), will do it in V6.


Thanks,
Ming
