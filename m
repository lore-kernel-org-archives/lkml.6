Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UpcKDPJOGVuzegAAmS7hNA
	; Thu, 07 Jun 2018 15:29:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ADA5F608BA; Thu,  7 Jun 2018 15:29:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 295846074D;
	Thu,  7 Jun 2018 15:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 295846074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935339AbeFGP33 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:29:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:33691 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933090AbeFGP30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:29:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DF6DEAD53;
        Thu,  7 Jun 2018 15:29:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C2912DAD20; Thu,  7 Jun 2018 17:26:39 +0200 (CEST)
Date: Thu, 7 Jun 2018 17:26:39 +0200
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: dsterba@suse.cz, Souptick Joarder <jrdr.linux@gmail.com>,
        clm@fb.com, jbacik@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: btrfs: Change return type to vm_fault_t
Message-ID: <20180607152639.su36dt3xjpigumw4@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180606142444.GA3806@jordon-HP-15-Notebook-PC>
 <20180606155347.GL3539@twin.jikos.cz>
 <20180606175049.GB12439@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606175049.GB12439@bombadil.infradead.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 10:50:49AM -0700, Matthew Wilcox wrote:
> On Wed, Jun 06, 2018 at 05:53:47PM +0200, David Sterba wrote:
> > On Wed, Jun 06, 2018 at 07:54:44PM +0530, Souptick Joarder wrote:
> > > @@ -9009,7 +9007,7 @@ int btrfs_page_mkwrite(struct vm_fault *vmf)
> > >  	unlock_extent_cached(io_tree, page_start, page_end, &cached_state);
> > >  
> > >  out_unlock:
> > > -	if (!ret) {
> > > +	if (!ret2) {
> > >  		btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE, true);
> > >  		sb_end_pagefault(inode->i_sb);
> > >  		extent_changeset_free(data_reserved);
> > 
> > 9013                 return VM_FAULT_LOCKED;
> > 9014         }
> > 9015         unlock_page(page);
> > 9016 out:
> > 9017         btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE, (ret != 0));
> > 9018         btrfs_delalloc_release_space(inode, data_reserved, page_start,
> > 9019                                      reserved_space, (ret != 0));
> > 
> > I've noticed that there's 'ret' used on lines 9017 and 19, comparing to
> > a raw number. Is this going to be ok once vm_fault_t is it's own type?
> > 
> > There's no corresponding define for 0 among the VM_FAULT_* values, I'd
> > expect 0 to work interchangeably, similar to the blk_status_t type:
> > 
> > https://elixir.bootlin.com/linux/latest/source/include/linux/blk_types.h#L30
> > 
> > #define	BLK_STS_OK 0
> > #define BLK_STS_NOTSUPP		((__force blk_status_t)1)
> > #define BLK_STS_TIMEOUT		((__force blk_status_t)2)
> > #define BLK_STS_NOSPC		((__force blk_status_t)3)
> > ...
> > 
> > Your patch is otherwise ok, I'm just curious if this is something to
> > watch for once vmfault type is switched.
> 
> Yes, sparse treats 0 specially for these kinds of types.  It goes back to
> the original use of __bitwise to mean "this is a special-endian type",
> but it's also meaningful for types which aren't _numbers_ so much as a
> collection of bits.

Ok, thanks.

> By the way, do you really think it improves this function to use 'ret' and
> 'ret2' like this?  It's your code, and you're entitled to adopt whatever
> stylistic preferences you like, but I personally find it easier to read
> with 'err' being an errno and 'ret' being the vm_fault_t.

The ret/err pattern caused some confusion so we're going to unify that a
bit and use 'ret' for the function scope return.
