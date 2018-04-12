Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeDLGGH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:06:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56978 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeDLGGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:06:06 -0400
Date: Thu, 12 Apr 2018 07:06:01 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/20] afs: Fix checker warnings
Message-ID: <20180412060600.GT30522@ZenIV.linux.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
 <152296018223.31027.12652988859947053572.stgit@warthog.procyon.org.uk>
 <20180412053807.GA32532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412053807.GA32532@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 10:38:07PM -0700, Christoph Hellwig wrote:
> On Thu, Apr 05, 2018 at 09:29:42PM +0100, David Howells wrote:
> > Fix warnings raised by checker, including:
> > 
> >  (*) Warnings raised by unequal comparison for the purposes of sorting,
> >      where the endianness doesn't matter:
> > 
> > fs/afs/addr_list.c:246:21: warning: restricted __be16 degrades to integer
> > fs/afs/addr_list.c:246:30: warning: restricted __be16 degrades to integer
> > fs/afs/addr_list.c:248:21: warning: restricted __be32 degrades to integer
> > fs/afs/addr_list.c:248:49: warning: restricted __be32 degrades to integer
> > fs/afs/addr_list.c:283:21: warning: restricted __be16 degrades to integer
> > fs/afs/addr_list.c:283:30: warning: restricted __be16 degrades to integer
> 
> Seriously - just do the endian swap.  In most case it it free anyway
> becaue you have load instructions that can byte swap.  Bonus points
> for doing the swap on the element iterated over.
> __force hacks without a very good reason (and an explanation for the
> reason in the code!) are an instance reason to NAK.

Nope.  It's an arbitrary comparison for sorting purposes.  There's no reason
for byteswapping anything, and while a comment to the effect that all we
care about is *some* linear order, no matter which one, would be a good idea,
that's about it.
