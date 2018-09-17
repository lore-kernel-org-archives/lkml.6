Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098C4ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF302146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF302146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeIRC2A convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:28:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeIRC2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:28:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB15530E6867;
        Mon, 17 Sep 2018 20:58:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64E2982218;
        Mon, 17 Sep 2018 20:58:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180914041831.GY19965@ZenIV.linux.org.uk>
References: <20180914041831.GY19965@ZenIV.linux.org.uk> <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk> <153685392942.14766.3347355712333618914.stgit@warthog.procyon.org.uk>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] iov_iter: Add mapping and discard iterator types
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3532.1537217936.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 17 Sep 2018 21:58:56 +0100
Message-ID: <3533.1537217936@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 17 Sep 2018 20:58:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> > Add two new iterator types to iov_iter:
> > 
> >  (1) ITER_MAPPING
> > 
> >      This walks through a set of pages attached to an address_space that
> >      are pinned or locked, starting at a given page and offset and walking
> >      for the specified amount of space.  A facility to get a callback each
> >      time a page is entirely processed is provided.
> > 
> >      This is useful for copying data from socket buffers to inodes in
> >      network filesystems.
> 
> Interesting...  Questions:
> 	* what will hold those pages?  IOW, where will you unlock/drop/whatnot
> those sucker?

The caller needs to have those pages pinned - say with PG_locked or
PG_writeback.  Sorry - I mentioned this in the cover, but not here.

You can either undo there changes in the callback or upon completion of the
iteration.

> 	* "callback" sounds dangerous - it appears to imply that you won't
> copy to/from the same page twice.  Not true for a lot of iov_iter users; what
> happens if you pass such a beast to them?

Similar to ITER_PIPE.  There's no rewind.  Once you've passed a page, it's
gone.  Under what circumstances would you want to copy to/from the same page
twice?

> 	* why not simply "build and populate ITER_BVEC aliasing a piece of
> mapping", possibly in "grab" and "grab+lock" variants?

ITER_BVEC is inefficient.  This is what the upstream now.  See
afs_load_bvec().

That what the code currently uses.  There's a
practical limit to the number of pages I can shovel into one in one go.

Further, every time I reach the end of a ITER_BVEC, I have to return to
process context, which then has to round up the next bundle of pages by
calling the radix tree.  It seems to work out better to put the radix
iteration into the iterator if we can.  The caller guarantees that the
contents of the region of interest are (a) fully populated and (b) pinned.

Yet further, with ITER_BVEC, I can't release any of the pinned pages until the
entire iteration is finished.  That means if I have a 4GB BVEC, those pages
are going to be pinned a long time.  With ITER_MAPPING, they're released
incrementally via the callback.

> Those ITER_MAPPING do seem to be related to ITER_BVEC, at the very least.

Only in the sense that the current position can be described by the same three
numbers: page, len, offset.  I'm reusing struct bio_vec so that I can share
some of the code with ITER_BVEC.

> Note, BTW, that iov_iter_get_pages...() might mutate into something similar
> - "build and populate ITER_BVEC aliasing a piece of given iov_iter".  Or,
> perhaps, a nicer-on-memory analogue of ITER_BVEC - with <offset, bytes,
> pointer to pages array> instead of <offset, bytes, page> as elements, with
> the same "populate from mapping" to get something similar to your
> functionality and "populate from iov_iter" for
> iov_iter_get_pages... replacement

The whole point is to avoid having to use ITER_BVEC.  ITER_BVEC has a number
of issues that ITER_MAPPING overcomes - though ITER_MAPPING can only be used
with a mapping (or, at least, a radix tree).

There is no point to the loop shifting page runs into a page array for use
with a BVEC when the mapping carries the same information.  You save memory
and processing time.

David
