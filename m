Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3700CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28CA208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28CA208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935957AbeFNBTW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:19:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935725AbeFNBTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:19:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2646840201D0;
        Thu, 14 Jun 2018 01:19:19 +0000 (UTC)
Received: from ming.t460p (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82EF22023487;
        Thu, 14 Jun 2018 01:19:03 +0000 (UTC)
Date:   Thu, 14 Jun 2018 09:18:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@fb.com>,
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
Subject: Re: [PATCH V6 00/30] block: support multipage bvec
Message-ID: <20180614011852.GA19828@ming.t460p>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180611164806.GA7452@infradead.org>
 <20180612034242.GC26412@ming.t460p>
 <20180613144253.GA4693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180613144253.GA4693@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 14 Jun 2018 01:19:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 14 Jun 2018 01:19:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 07:42:53AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 12, 2018 at 11:42:49AM +0800, Ming Lei wrote:
> > On Mon, Jun 11, 2018 at 09:48:06AM -0700, Christoph Hellwig wrote:
> > > І think the new naming scheme in this series is a nightmare.  It
> > > confuses the heck out of me, and that is despite knowing many bits of
> > > the block layer inside out, and reviewing previous series.
> > 
> > In V5, there isn't such issue, since bio_for_each_segment* is renamed
> > into bio_for_each_page* first before doing the change.
> 
> But now we are at V6 where that isn't the case..
> 
> > Seems Jens isn't fine with the big renaming, then I follow the suggestion
> > of taking 'chunk' for representing multipage bvec in V6.
> 
> Please don't use chunk.  We are iterating over bio_vec structures, while
> we have the concept of a chunk size for something else in the block layer,
> so this just creates confusion.  Nevermind names like
> bio_for_each_chunk_segment_all which just double the confusion.

We may keep the name of bio_for_each_segment_all(), and just change
the prototype in one single big patch.

> 
> So assuming that bio_for_each_segment is set to stay as-is for now,
> here is a proposal for sanity by using the vec name.
> 
> OLD:	    bio_for_each_segment
> NEW(page):  bio_for_each_segment, to be renamed bio_for_each_page later
> NEW(bvec):  bio_for_each_bvec
> 
> OLD:	    __bio_for_each_segment
> NEW(page):  __bio_for_each_segment, to be renamed __bio_for_each_page later
> NEW(bvec):  (no bvec version needed)

For the above two, basically similar with V6, just V6 takes chunk, :-)

> 
> OLD:	    bio_for_each_segment_all
> NEW(page):  bio_for_each_page_all (needs updated prototype anyway)
> NEW(bvec):  (no bvec version needed once bcache is fixed up)	

This one may cause confusing, since we iterate over pages via
bio_for_each_segment(), but the _all version takes another name
of page, still iterate over pages.

So could we change it in the following way?

 OLD:	    bio_for_each_segment_all
 NEW(page): bio_for_each_segment_all (update prototype in one tree-wide &
 			big patch, to be renamed bio_for_each_page_all)
 NEW(bvec):  (no bvec version needed once bcache is fixed up)	


Thanks,
Ming
