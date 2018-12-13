Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AE3C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589FF20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589FF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbeLMQBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:01:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:33674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727942AbeLMQBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:01:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7132AED2;
        Thu, 13 Dec 2018 16:01:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 518BF1E13E6; Thu, 13 Dec 2018 17:01:18 +0100 (CET)
Date:   Thu, 13 Dec 2018 17:01:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: Re: [PATCH][v6] filemap: drop the mmap_sem for all blocking
 operations
Message-ID: <20181213160118.GA27517@quack2.suse.cz>
References: <20181211173801.29535-4-josef@toxicpanda.com>
 <20181212152757.10017-1-josef@toxicpanda.com>
 <20181212155536.5fb770a0c9b4f2399d4794e4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212155536.5fb770a0c9b4f2399d4794e4@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-12-18 15:55:36, Andrew Morton wrote:
> On Wed, 12 Dec 2018 10:27:57 -0500 Josef Bacik <josef@toxicpanda.com> wrote:
> 
> > v5->v6:
> > - added more comments as per Andrew's suggestion.
> > - fixed the fpin leaks in the two error paths that were pointed out.
> > 
> 
> hm,
> 
> > --- a/mm/filemap.c~filemap-drop-the-mmap_sem-for-all-blocking-operations-v6
> > +++ a/mm/filemap.c
> > @@ -2461,7 +2476,8 @@ static struct file *do_sync_mmap_readahe
> >  
> >  /*
> >   * Asynchronous readahead happens when we find the page and PG_readahead,
> > - * so we want to possibly extend the readahead further..
> > + * so we want to possibly extend the readahead further.  We return the file that
> > + * was pinned if we have to drop the mmap_sem in order to do IO.
> >   */
> >  static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
> >  					    struct page *page)
> > @@ -2545,14 +2561,15 @@ retry_find:
> >  		page = pagecache_get_page(mapping, offset,
> >  					  FGP_CREAT|FGP_FOR_MMAP,
> >  					  vmf->gfp_mask);
> > -		if (!page)
> > +		if (!page) {
> > +			if (fpin)
> > +				goto out_retry;
> 
> Is this right?  If pagecache_get_page() returns NULL we can now return
> VM_FAULT_MAJOR|VM_FAULT_RETRY whereas we used to return ENOMEM.

Yes, but once we've dropped mmap_sem, there's no way safely return -ENOMEM.
So VM_FAULT_RETRY is really the only option to tell the caller that
mmap_sem is not held anymore...

So the patch looks good to me now. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>


								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
