Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeDLFiL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 01:38:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeDLFiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 01:38:09 -0400
Date: Wed, 11 Apr 2018 22:38:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 02/20] afs: Fix checker warnings
Message-ID: <20180412053807.GA32532@infradead.org>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
 <152296018223.31027.12652988859947053572.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152296018223.31027.12652988859947053572.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 09:29:42PM +0100, David Howells wrote:
> Fix warnings raised by checker, including:
> 
>  (*) Warnings raised by unequal comparison for the purposes of sorting,
>      where the endianness doesn't matter:
> 
> fs/afs/addr_list.c:246:21: warning: restricted __be16 degrades to integer
> fs/afs/addr_list.c:246:30: warning: restricted __be16 degrades to integer
> fs/afs/addr_list.c:248:21: warning: restricted __be32 degrades to integer
> fs/afs/addr_list.c:248:49: warning: restricted __be32 degrades to integer
> fs/afs/addr_list.c:283:21: warning: restricted __be16 degrades to integer
> fs/afs/addr_list.c:283:30: warning: restricted __be16 degrades to integer

Seriously - just do the endian swap.  In most case it it free anyway
becaue you have load instructions that can byte swap.  Bonus points
for doing the swap on the element iterated over.

__force hacks without a very good reason (and an explanation for the
reason in the code!) are an instance reason to NAK.

>  (*) afs_find_server() casts __be16/__be32 values to int in order to
>      directly compare them for the purpose of finding a match in a list,
>      but is should also annotate the cast with __force to avoid checker
>      warnings.

Same as above.
