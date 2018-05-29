Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033144AbeE2C5a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:57:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935511AbeE2C52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:57:28 -0400
Date: Mon, 28 May 2018 19:57:22 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Greg Thelen <gthelen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: convert scan_control.priority int => byte
Message-ID: <20180529025722.GA25784@bombadil.infradead.org>
References: <20180529024025.58353-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529024025.58353-1-gthelen@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 07:40:25PM -0700, Greg Thelen wrote:
> Reclaim priorities range from 0..12(DEF_PRIORITY).
> scan_control.priority is a 4 byte int, which is overkill.
> 
> Since commit 6538b8ea886e ("x86_64: expand kernel stack to 16K") x86_64
> stack overflows are not an issue.  But it's inefficient to use 4 bytes
> for priority.

If you're looking to shave a few more bytes, allocation order can fit
in a u8 too (can't be more than 6 bits, and realistically won't be more
than 4 bits).  reclaim_idx likewise will fit in a u8, and actually won't
be more than 3 bits.

I am sceptical that nr_to_reclaim should really be an unsigned long; I
don't think we should be trying to free 4 billion pages in a single call.
nr_scanned might be over 4 billion (!) but nr_reclaimed can probably
shrink to unsigned int along with nr_to_reclaim.
