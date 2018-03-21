Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbeCUWqf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:46:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753659AbeCUWqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:46:33 -0400
Date: Wed, 21 Mar 2018 15:46:31 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] mm: mmap: unmap large mapping by section
Message-ID: <20180321224631.GB3969@bombadil.infradead.org>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
 <1521581486-99134-2-git-send-email-yang.shi@linux.alibaba.com>
 <20180321130833.GM23100@dhcp22.suse.cz>
 <f88deb20-bcce-939f-53a6-1061c39a9f6c@linux.alibaba.com>
 <20180321172932.GE4780@bombadil.infradead.org>
 <f057a634-7e0a-1b51-eede-dcb6f128b18e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f057a634-7e0a-1b51-eede-dcb6f128b18e@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 02:45:44PM -0700, Yang Shi wrote:
> Marking vma as deleted sounds good. The problem for my current approach is
> the concurrent page fault may succeed if it access the not yet unmapped
> section. Marking deleted vma could tell page fault the vma is not valid
> anymore, then return SIGSEGV.
> 
> > does not care; munmap will need to wait for the existing munmap operation
> 
> Why mmap doesn't care? How about MAP_FIXED? It may fail unexpectedly, right?

The other thing about MAP_FIXED that we'll need to handle is unmapping
conflicts atomically.  Say a program has a 200GB mapping and then
mmap(MAP_FIXED) another 200GB region on top of it.  So I think page faults
are also going to have to wait for deleted vmas (then retry the fault)
rather than immediately raising SIGSEGV.
