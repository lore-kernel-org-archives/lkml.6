Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB787C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757B921580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757B921580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeI0Rbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:31:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:60768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbeI0Rbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:31:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF211AE67;
        Thu, 27 Sep 2018 11:13:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7182A1E360F; Thu, 27 Sep 2018 13:13:54 +0200 (CEST)
Date:   Thu, 27 Sep 2018 13:13:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Barret Rhoden <brho@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        hch@lst.de, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com
Subject: Re: [PATCH v5 07/11] filesystem-dax: Introduce
 dax_lock_mapping_entry()
Message-ID: <20180927111354.GA16469@quack2.suse.cz>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153074046078.27838.5465590228767136915.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180924115721.75893931@gnomeregan.cam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924115721.75893931@gnomeregan.cam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-09-18 11:57:21, Barret Rhoden wrote:
> Hi Dan -
> 
> On 2018-07-04 at 14:41 Dan Williams <dan.j.williams@intel.com> wrote:
> [snip]
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 4de11ed463ce..57ec272038da 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> [snip]
> > +bool dax_lock_mapping_entry(struct page *page)
> > +{
> > +	pgoff_t index;
> > +	struct inode *inode;
> > +	bool did_lock = false;
> > +	void *entry = NULL, **slot;
> > +	struct address_space *mapping;
> > +
> > +	rcu_read_lock();
> > +	for (;;) {
> > +		mapping = READ_ONCE(page->mapping);
> > +
> > +		if (!dax_mapping(mapping))
> > +			break;
> > +
> > +		/*
> > +		 * In the device-dax case there's no need to lock, a
> > +		 * struct dev_pagemap pin is sufficient to keep the
> > +		 * inode alive, and we assume we have dev_pagemap pin
> > +		 * otherwise we would not have a valid pfn_to_page()
> > +		 * translation.
> > +		 */
> > +		inode = mapping->host;
> > +		if (S_ISCHR(inode->i_mode)) {
> > +			did_lock = true;
> > +			break;
> > +		}
> > +
> > +		xa_lock_irq(&mapping->i_pages);
> > +		if (mapping != page->mapping) {
> > +			xa_unlock_irq(&mapping->i_pages);
> > +			continue;
> > +		}
> > +		index = page->index;
> > +
> > +		entry = __get_unlocked_mapping_entry(mapping, index, &slot,
> > +				entry_wait_revalidate);
> > +		if (!entry) {
> > +			xa_unlock_irq(&mapping->i_pages);
> > +			break;
> > +		} else if (IS_ERR(entry)) {
> > +			WARN_ON_ONCE(PTR_ERR(entry) != -EAGAIN);
> > +			continue;
> 
> In the IS_ERR case, do you need to xa_unlock the mapping?  It looks
> like you'll deadlock the next time around the loop.

Yep, that looks certainly wrong. I'll send a fix.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
