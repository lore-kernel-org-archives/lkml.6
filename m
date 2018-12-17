Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFC9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7922A20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="INMDhYmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbeLQT7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:59:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732626AbeLQT73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yYuUKtPqNzf0rYMCQlFGCXydmIl4+kyjpeJSfCXAs+k=; b=INMDhYmUufooanLhcpP7bZe0O
        apew/fFePpE6mppsGIFU5QULl+aHTVcMONq9WRN8EQvj3ri6VNOQltVDX2EM7qXdhdMps/rsQK12i
        QeCIfWhTIJp03GamX5adn8pc0O+0CxEouPQkvK/OyGDI2BSc7ztkLxe+uJEe8kK6RMbIP5aMbl1Vd
        HcslZDhMwOMP+jxQHKRPDUGlQEY2bvLD2HGFnyvsKZTLKLsVBYr7rmwdLkT4ptOm80Kp07JZzdC4J
        dLJ+rmEgO0StIvgbuQ+cn+0k3CIcvFbqRRwpKnkUwePLQF9B7alFu/ET+onCJY0NuSe7uU6jTKEjh
        uG+3U5NgA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYz2w-0005On-Bb; Mon, 17 Dec 2018 19:59:22 +0000
Date:   Mon, 17 Dec 2018 11:59:22 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181217195922.GQ10600@bombadil.infradead.org>
References: <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard>
 <20181214154321.GF8896@quack2.suse.cz>
 <20181216215819.GC10644@dastard>
 <20181217181148.GA3341@redhat.com>
 <20181217183443.GO10600@bombadil.infradead.org>
 <20181217194759.GB3341@redhat.com>
 <20181217195150.GP10600@bombadil.infradead.org>
 <20181217195408.GC3341@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217195408.GC3341@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 02:54:08PM -0500, Jerome Glisse wrote:
> On Mon, Dec 17, 2018 at 11:51:51AM -0800, Matthew Wilcox wrote:
> > On Mon, Dec 17, 2018 at 02:48:00PM -0500, Jerome Glisse wrote:
> > > On Mon, Dec 17, 2018 at 10:34:43AM -0800, Matthew Wilcox wrote:
> > > > No.  The solution John, Dan & I have been looking at is to take the
> > > > dirty page off the LRU while it is pinned by GUP.  It will never be
> > > > found for writeback.
> > > 
> > > With the solution you are proposing we loose GUP fast and we have to
> > > allocate a structure for each page that is under GUP, and the LRU
> > > changes too. Moreover by not writing back there is a greater chance
> > > of data loss.
> > 
> > Why can't you store the hmm_data in a side data structure?  Why does it
> > have to be in struct page?
> 
> hmm_data is not even the issue here, we can have a pincount without
> moving things around. So i do not see the need to complexify any of
> the existing code to add new structure and consume more memory for
> no good reasons. I do not see any benefit in that.

You said "we have to allocate a structure for each page that is under
GUP".  The only reason to do that is if we want to keep hmm_data in
struct page.  If we ditch hmm_data, there's no need to allocate a
structure, and we don't lose GUP fast either.
