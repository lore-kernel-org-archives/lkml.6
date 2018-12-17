Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A69C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F84D2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733169AbeLQVPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:15:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbeLQVPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:15:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD1939F754;
        Mon, 17 Dec 2018 21:15:38 +0000 (UTC)
Received: from redhat.com (ovpn-125-170.rdu2.redhat.com [10.10.125.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2186600C9;
        Mon, 17 Dec 2018 21:15:35 +0000 (UTC)
Date:   Mon, 17 Dec 2018 16:15:33 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20181217211533.GE3341@redhat.com>
References: <20181214154321.GF8896@quack2.suse.cz>
 <20181216215819.GC10644@dastard>
 <20181217181148.GA3341@redhat.com>
 <20181217183443.GO10600@bombadil.infradead.org>
 <20181217194759.GB3341@redhat.com>
 <20181217195150.GP10600@bombadil.infradead.org>
 <20181217195408.GC3341@redhat.com>
 <20181217195922.GQ10600@bombadil.infradead.org>
 <20181217205500.GD3341@redhat.com>
 <20181217210358.GR10600@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181217210358.GR10600@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 17 Dec 2018 21:15:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 01:03:58PM -0800, Matthew Wilcox wrote:
> On Mon, Dec 17, 2018 at 03:55:01PM -0500, Jerome Glisse wrote:
> > On Mon, Dec 17, 2018 at 11:59:22AM -0800, Matthew Wilcox wrote:
> > > On Mon, Dec 17, 2018 at 02:54:08PM -0500, Jerome Glisse wrote:
> > > > On Mon, Dec 17, 2018 at 11:51:51AM -0800, Matthew Wilcox wrote:
> > > > > On Mon, Dec 17, 2018 at 02:48:00PM -0500, Jerome Glisse wrote:
> > > > > > On Mon, Dec 17, 2018 at 10:34:43AM -0800, Matthew Wilcox wrote:
> > > > > > > No.  The solution John, Dan & I have been looking at is to take the
> > > > > > > dirty page off the LRU while it is pinned by GUP.  It will never be
> > > > > > > found for writeback.
> > > > > > 
> > > > > > With the solution you are proposing we loose GUP fast and we have to
> > > > > > allocate a structure for each page that is under GUP, and the LRU
> > > > > > changes too. Moreover by not writing back there is a greater chance
> > > > > > of data loss.
> > > > > 
> > > > > Why can't you store the hmm_data in a side data structure?  Why does it
> > > > > have to be in struct page?
> > > > 
> > > > hmm_data is not even the issue here, we can have a pincount without
> > > > moving things around. So i do not see the need to complexify any of
> > > > the existing code to add new structure and consume more memory for
> > > > no good reasons. I do not see any benefit in that.
> > > 
> > > You said "we have to allocate a structure for each page that is under
> > > GUP".  The only reason to do that is if we want to keep hmm_data in
> > > struct page.  If we ditch hmm_data, there's no need to allocate a
> > > structure, and we don't lose GUP fast either.
> > 
> > And i have propose a way that do not need to ditch hmm_data nor
> > needs to remove page from the lru. What is it you do not like
> > with that ?
> 
> I don't like bounce buffering.  I don't like "end of writeback doesn't
> mark page as clean".  I don't like pages being on the LRU that aren't
> actually removable.  I don't like writing pages back which we know we're
> going to have to write back again.

And my solution allow to pick at which ever point ... you can decide to
abort write back if you feel it is better, you can remove from LRU on
first write back abort ... So you can do everything you want in my solution
it is as flexible. Right now i am finishing couple patchset once i am
done i will do an RFC on that, in my RFC i will keep write back and
bounce but it can easily be turn into no write back and remove from
LRU. My feeling is that not writing back means data loss, at the same
time if the page is on continuous write one can argue that what ever
snapshot we write back might be pointless. I do not see any strong
argument either ways.

Cheers.
Jérôme
