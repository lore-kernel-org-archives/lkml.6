Return-Path: <david@fromorbit.com>
X-Google-Smtp-Source: AIpwx4/cBit5XFelMvDm9dXXDwLUAd3Ut63qOoAXHKwi7Dtxe1hoRX9sl9HeIq0YgzxFKSRE/gPd
ARC-Seal: i=1; a=rsa-sha256; t=1522017258; cv=none;
        d=google.com; s=arc-20160816;
        b=tlgIzPmty80wTaDlNJPRp5GQkwo5at+kEEPlfqQVaVyRFgSWMJbXLb9PSXZSqbfUDp
         hamFVdqQiLfPr8Q4wy0pncS9f26n4TS2SpzwwRFy5AhRVUNNVnZn/KQ7nMqRJBx7YHzm
         jF6E11GSo9h2QzeU0cdWtcjQp9p4LUOApx1ai1Qhyoojipf79hnjiKhDq9ktiFwJ96wZ
         LvVRj8PDdxl/OE059MclhtcD/qjcc3HS3+F7WUr9jJwPikZ1NDqWQ5XmwoslA9pXW1cb
         ydq8Jm/5tKedQ2CcYar0UggYPnBF7YnrS9GIZL766+7NAUr5wjhZAhdNaknvJXa0o7SZ
         XQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=rtUNXrHnX0Fxnoxp8s2rZcTLMxtvOLG7IbrxsygIFJ4=;
        b=G5So9eskn1JZxh+kmMCFjBROO/326kERR1QXIzyIaRZO8Tao63NWwvI0OZqI12dd0t
         MBatnywE7fEIpsb22ZPlTE+1ONphb5ZSHRDN3sZdCdkNZOKvR5MBuoFJdU7giCgiW/FT
         KiejzTPThcO0QlcEXDQnQVJPBsa6HVnaCmoSvTPXqntPE3fv/b9Uh/N1I+5BrGWpvjI0
         vdV5LEVd4+cgWEMp+jjIa0kMmiRHkfz3nDFdTVekfOpdOAgSp/1o5caRYF5GR7/FykUA
         GTvQJtSDw03NrsPPKhxnTbhsreCvZkrJ5h0aPHiUaQVygT++OAX3ozuHi1osLYzADgYR
         /z9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 150.101.137.143 is neither permitted nor denied by best guess record for domain of david@fromorbit.com) smtp.mailfrom=david@fromorbit.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 150.101.137.143 is neither permitted nor denied by best guess record for domain of david@fromorbit.com) smtp.mailfrom=david@fromorbit.com
Date: Mon, 26 Mar 2018 09:33:57 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Sasha Levin <alexander.levin@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Josh Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>,
	Michal Hocko <mhocko@kernel.org>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Message-ID: <20180325223357.GJ18129@dastard>
References: <20171123060137.GL2135@magnolia>
 <20180323013037.GA9190@wotan.suse.de>
 <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323182302.GB9190@wotan.suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1595950768867963736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 06:23:02PM +0000, Luis R. Rodriguez wrote:
> On Fri, Mar 23, 2018 at 10:26:20AM -0700, Darrick J. Wong wrote:
> > On Fri, Mar 23, 2018 at 05:08:13PM +0000, Luis R. Rodriguez wrote:
> > > On Thu, Mar 22, 2018 at 08:41:45PM -0700, Darrick J. Wong wrote:
> > > > On Fri, Mar 23, 2018 at 01:30:37AM +0000, Luis R. Rodriguez wrote:
> > > > > On Wed, Nov 22, 2017 at 10:01:37PM -0800, Darrick J. Wong wrote:
> > > > > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > > > > index 61d1cb7..8012741 100644
> > > > > > --- a/fs/xfs/xfs_inode.c
> > > > > > +++ b/fs/xfs/xfs_inode.c
> > > > > > @@ -2401,6 +2401,24 @@ xfs_ifree_cluster(
> > > > > >  }
> > > > > >  
> > > > > >  /*
> > > > > > + * Free any local-format buffers sitting around before we reset to
> > > > > > + * extents format.
> > > > > > + */
> > > > > > +static inline void
> > > > > > +xfs_ifree_local_data(
> > > > > > +	struct xfs_inode	*ip,
> > > > > > +	int			whichfork)
> > > > > > +{
> > > > > > +	struct xfs_ifork	*ifp;
> > > > > > +
> > > > > > +	if (XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_LOCAL)
> > > > > > +		return;
> > > > > 
> > > > > I'm new to all this so this was a bit hard to follow. I'm confused with how
> > > > > commit 43518812d2 ("xfs: remove support for inlining data/extents into the
> > > > > inode fork") exacerbated the leak, isn't that commit about
> > > > > XFS_DINODE_FMT_EXTENTS?
> > > > 
> > > > Not specifically _EXTENTS, merely any fork (EXTENTS or LOCAL) whose
> > > > incore data was small enough to fit in if_inline_ata.
> > > 
> > > Got it, I thought those were XFS_DINODE_FMT_EXTENTS by definition.
> > > 
> > > > > Did we have cases where the format was XFS_DINODE_FMT_LOCAL and yet
> > > > > ifp->if_u1.if_data == ifp->if_u2.if_inline_data ?
> > > > 
> > > > An empty directory is 6 bytes, which is what you get with a fresh mkdir
> > > > or after deleting everything in the directory.  Prior to the 43518812d2
> > > > patch we could get away with not even checking if we had to free if_data
> > > > when deleting a directory because it fit within if_inline_data.
> > > 
> > > Ah got it. So your fix *is* also applicable even prior to commit 43518812d2.
> > 
> > You'd have to modify the patch so that it doesn't try to kmem_free
> > if_data if if_data == if_inline_data but otherwise (in theory) I think
> > that the concept applies to pre-4.15 kernels.
> > 
> > (YMMV, please do run this through QA/kmemleak just in case I'm wrong, etc...)
> 
> Well... so we need a resolution and better get testing this already given that
> *I believe* the new auto-selection algorithm used to cherry pick patches onto
> stable for linux-4.14.y (covered on a paper [0] and when used, stable patches
> are prefixed with AUTOSEL, a recent discussion covered this in November 2017
> [1]) recommended to merge your commit 98c4f78dcdd8 ("xfs: always free inline
> data before resetting inode fork during ifree") as stable commit 1eccdbd4836a41
> on v4.14.17 *without* merging commit 43518812d2 ("xfs: remove support for
> inlining data/extents into the inode fork").

Yikes. That sets off all my "how to break filesysetms for fun and
profit" alarm bells. This is like playing russian roulette with all
our user's data.  XFS fixes that look like they are simple often
have subtle dependencies in them that automated backports won't ever
be able to understand, and if we don't get that right, we break
stuff.

Filesystems aren't like drivers or memory management - you can't
reboot to fix a filesystem corruption or data loss bug. User's tend
to care a lot more about their data and cat photos than they do
about how often the dodgy hardware they bought on ebay needs OS
rebooting to get working again..

> I do wonder if other XFS folks are *at least* aware that the auto-selection
> algorithm now currently merging patches onto stable for XFS?

No I wasn't aware that this was happening.  I'm kinda shit scared
right now hearing about how automated backports of random kernel
patches are being done with minimal oversight and no visibility to
the subsystem developers. When did this start happening?

At this point I'd be much more comfortable if XFS was blacklisted
until there's solid subsystem developer visibility of the iautomated
backports, not to mention a solid set of automated regression
testing backing this automated backport proceedure.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
