Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F12BC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 04:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBB220833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 04:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBB220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeINJbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 05:31:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49302 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeINJbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 05:31:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0fYu-0003io-3e; Fri, 14 Sep 2018 04:18:32 +0000
Date:   Fri, 14 Sep 2018 05:18:32 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] iov_iter: Add mapping and discard iterator types
Message-ID: <20180914041831.GY19965@ZenIV.linux.org.uk>
References: <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk>
 <153685392942.14766.3347355712333618914.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153685392942.14766.3347355712333618914.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 04:52:09PM +0100, David Howells wrote:
> Add two new iterator types to iov_iter:
> 
>  (1) ITER_MAPPING
> 
>      This walks through a set of pages attached to an address_space that
>      are pinned or locked, starting at a given page and offset and walking
>      for the specified amount of space.  A facility to get a callback each
>      time a page is entirely processed is provided.
> 
>      This is useful for copying data from socket buffers to inodes in
>      network filesystems.

Interesting...  Questions:
	* what will hold those pages?  IOW, where will you unlock/drop/whatnot
those sucker?
	* "callback" sounds dangerous - it appears to imply that you won't
copy to/from the same page twice.  Not true for a lot of iov_iter users; what
happens if you pass such a beast to them?
	* why not simply "build and populate ITER_BVEC aliasing a piece of mapping",
possibly in "grab" and "grab+lock" variants?  Those ITER_MAPPING do seem to be
related to ITER_BVEC, at the very least.  Note, BTW, that iov_iter_get_pages...()
might mutate into something similar - "build and populate ITER_BVEC aliasing a piece
of given iov_iter".  Or, perhaps, a nicer-on-memory analogue of ITER_BVEC -
with <offset, bytes, pointer to pages array> instead of <offset, bytes, page> as
elements, with the same "populate from mapping" to get something similar to your
functionality and "populate from iov_iter" for iov_iter_get_pages... replacement.
