Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeCCQ5f (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 11:57:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbeCCQ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 11:57:33 -0500
Date: Sat, 3 Mar 2018 08:57:28 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 08/61] xarray: Add the xa_lock to the radix_tree_root
Message-ID: <20180303165727.GA29990@bombadil.infradead.org>
References: <20180219194556.6575-1-willy@infradead.org>
 <20180219194556.6575-9-willy@infradead.org>
 <1520088922.4280.47.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520088922.4280.47.camel@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03, 2018 at 09:55:22AM -0500, Jeff Layton wrote:
> On Mon, 2018-02-19 at 11:45 -0800, Matthew Wilcox wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> > 
> > This results in no change in structure size on 64-bit x86 as it fits in
> > the padding between the gfp_t and the void *.
> > 
> 
> While the patch itself looks fine, we should take note that this will
> likely increase the size of radix_tree_root on 32-bit arches.
> 
> I don't think that's necessarily a deal breaker, but there are a lot of
> users of radix_tree_root. Many of those users have their own spinlock
> for radix tree accesses, and could be trivially changed to use the
> xa_lock. That would need to be done piecemeal though.
> 
> A less disruptive idea might be to just create some new struct that's a
> spinlock + radix_tree_root, and then use that going forward in the
> xarray conversion. That might be better anyway if you're considering a
> more phased approach for getting this merged.

Well, it's a choice.  If we do:

struct xarray {
	spinlock_t xa_lock;
	struct radix_tree_root root;
};

then the padding on 64-bit turns that into a 24-byte struct.  So do we
spend the extra 4 bytes on 32-bit and have the struct the way we want it
to look from the beginning, or do we spend the extra 8 bytes on 64-bit
and have to redo the struct accessors after the conversions are complete?
I chose option (a), but reasonable people can disagree on that choice.
