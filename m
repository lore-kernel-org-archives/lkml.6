Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031848AbeBONBM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:01:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53486 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030561AbeBONBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:01:08 -0500
Date: Thu, 15 Feb 2018 13:01:15 +0000
From: Will Deacon <will.deacon@arm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: dcache: Avoid livelock between d_alloc_parallel and
 __d_add
Message-ID: <20180215130114.GD16623@arm.com>
References: <1518526731-26546-1-git-send-email-will.deacon@arm.com>
 <20180213151608.GA17791@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213151608.GA17791@bombadil.infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Tue, Feb 13, 2018 at 07:16:08AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 13, 2018 at 12:58:51PM +0000, Will Deacon wrote:
> > This patch resolves the livelock by not taking hlist_bl_lock in
> > d_alloc_parallel if the sequence counter is odd, since any subsequent
> > masked comparison with i_dir_seq will fail anyway.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Thanks!

> I wonder whether it makes sense to turn i_dir_seq into a seqcount_t,
> which would give us the lockdep checking as well.

I'm not sure it's quite as simple as that. start_dir_add looks very much
like it's intended to run concurrently, so we'd need a write_seqcount
implementation that provides the same atomicity guarantees.

Will
