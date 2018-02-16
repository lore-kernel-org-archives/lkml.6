Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422915AbeBPANV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:13:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48276 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164918AbeBPANT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:13:19 -0500
Date: Fri, 16 Feb 2018 00:13:17 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/3] proc: randomize "struct pde_opener"
Message-ID: <20180216001317.GG30522@ZenIV.linux.org.uk>
References: <20180214063033.GA15579@avx2>
 <20180214081935.GA17157@avx2>
 <20180215190713.GF30522@ZenIV.linux.org.uk>
 <20180215214113.GA27190@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215214113.GA27190@avx2>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 12:41:13AM +0300, Alexey Dobriyan wrote:
> On Thu, Feb 15, 2018 at 07:07:13PM +0000, Al Viro wrote:
> > On Wed, Feb 14, 2018 at 11:19:35AM +0300, Alexey Dobriyan wrote:
> > 
> > > The more the merrier.
> > 
> > ITYM "Sanity is overrated anyway."
> 
> If you view annotations as debugging option the thing is not that bad.

Yes, if your goal is to debug gcc.  Look, randomize_layout is a bad idea,
with worse implementation.  It's security theatre with no real benefits,
it makes for much harder kernel debugging, it buggers cachelines without
noticing *AND* it triggers gcc version-dependent miscompiles that
cheerfully cause memory corruption.

IMO we should remove that misfeature from at least the core VFS data
structures.  Sure, it's one of the "if you are dumb enough to enable
it, you get to pay the price" things, but that kind of garbage tends
to leak into distro builds.

I hoped that Kees would get a clue and remove the particularly bad
instances himself, but since that hasn't happened yet, I'm removing
the VFS ones this cycle.

And gcc bugs are not the only problem here.  Look at this:
struct dentry {
        /* RCU lookup touched fields */
        unsigned int d_flags;           /* protected by d_lock */
        seqcount_t d_seq;               /* per dentry seqlock */
        struct hlist_bl_node d_hash;    /* lookup hash list */
        struct dentry *d_parent;        /* parent directory */
        struct qstr d_name;
        struct inode *d_inode;          /* Where the name belongs to - NULL is
                                         * negative */
        unsigned char d_iname[DNAME_INLINE_LEN];        /* small names */

        /* Ref lookup also touches following */
        struct lockref d_lockref;       /* per-dentry lock and refcount */
        const struct dentry_operations *d_op;
        struct super_block *d_sb;       /* The root of the dentry tree */
        unsigned long d_time;           /* used by d_revalidate */
        void *d_fsdata;                 /* fs-specific data */

        union {
                struct list_head d_lru;         /* LRU list */
                wait_queue_head_t *d_wait;      /* in-lookup ones only */
        };
        struct list_head d_child;       /* child of parent list */
        struct list_head d_subdirs;     /* our children */
        /*
         * d_alias and d_rcu can share memory
         */
        union {
                struct hlist_node d_alias;      /* inode alias list */
                struct hlist_bl_node d_in_lookup_hash;  /* only for in-lookup ones */
                struct rcu_head d_rcu;
        } d_u;
} __randomize_layout;

Guess what happens to cache footprint of dcache lookups if the bunch in the
beginning gets spread over the entire thing?  Right...  And that's besides the
outright miscompiles.
