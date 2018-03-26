Return-Path: <darrick.wong@oracle.com>
X-Google-Smtp-Source: AG47ELuPEoB/xHeLvRi5U1RxYxAwo+0vnTol9PSWZ1TH5kmygdu9iOHCGNntPpwHy7gS4jeH6ZAo
ARC-Seal: i=1; a=rsa-sha256; t=1522046919; cv=none;
        d=google.com; s=arc-20160816;
        b=W73ip0WBhUtDB02/L9wXl99kcI+y/wUWvvCfgcvJxU2fu4f0CUOjOgsGeVI076ImVZ
         bLve1A6j73rYY03YN4ubZSDiBKVEuJxYCpPrVcbF7oWMkbewqp/3SDXU1z/oAB3+mvF0
         dbm9+OOw9gCqXT2pmAxy9y/9SWP++ssafnJlHof7tn5CuRReI44AZOnOjKRX0mjoTBwF
         zpzJvBcKZHgZ2cMRTFGQGwQVC/sPtD0BEL0Q3FTvGkC+ySi3UVTPtsVRuzt41zJCHZnF
         6RlNYjJkTCyAaLhJ0NRiiz7FnSj7ILLhJPNSo/Ve3ISVbVF0tvjlhO1fdA1p+JtgCYrt
         ToHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=avZtNWep19ddQJTmjaCIz2jjwsmWwUtsv1fFxseMOBo=;
        b=D+ekgm9lP96AoHLlRN5RS1PKRh3lyyiadj8V9ljik1b9uHuArZlSMKYJ5aUcxETL41
         hujSBkUK4tOHVZrjAvAKZl7LKYry2AJGokywlyysq0aMOmIXkyxluD6Ihemt20sz0Qcn
         IdpDibDR3f/P9ALU95GA3Z48Q5oHEv7kA5/SNC1bNdhDmnxo+pExY+tqSn9v6t98xEqU
         Lzs2d5EFy4H8YcUZd0iZlZgP6xGbP9bZaHyUtztA3ozJqUhwvvrG8TfSnCL/7uWiYCmC
         mZfta2xgUQ6zcGZP7RmMi3sqhaeYkxXWBYflmtlZhCcLKACLLFK5BKcnMPSkhrKzYIH7
         RwOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=W0XtpVvw;
       spf=pass (google.com: domain of darrick.wong@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=darrick.wong@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=W0XtpVvw;
       spf=pass (google.com: domain of darrick.wong@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=darrick.wong@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Sun, 25 Mar 2018 23:48:19 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Josh Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Message-ID: <20180326064819.GS4818@magnolia>
References: <20171123060137.GL2135@magnolia>
 <20180323013037.GA9190@wotan.suse.de>
 <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
 <20180324090638.GB1170@kroah.com>
 <20180324172159.GR4818@magnolia>
 <20180326045241.GA3394@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326045241.GA3394@sasha-vm>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8843 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803260064
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1595981870598804582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 04:54:59AM +0000, Sasha Levin wrote:
> On Sat, Mar 24, 2018 at 10:21:59AM -0700, Darrick J. Wong wrote:
> >On Sat, Mar 24, 2018 at 10:06:38AM +0100, Greg Kroah-Hartman wrote:
> >> On Fri, Mar 23, 2018 at 06:23:02PM +0000, Luis R. Rodriguez wrote:
> >> > On Fri, Mar 23, 2018 at 10:26:20AM -0700, Darrick J. Wong wrote:
> >> > > On Fri, Mar 23, 2018 at 05:08:13PM +0000, Luis R. Rodriguez wrote:
> >> > > > On Thu, Mar 22, 2018 at 08:41:45PM -0700, Darrick J. Wong wrote:
> >> > > > > On Fri, Mar 23, 2018 at 01:30:37AM +0000, Luis R. Rodriguez wrote:
> >> > > > > > On Wed, Nov 22, 2017 at 10:01:37PM -0800, Darrick J. Wong wrote:
> >> > > > > > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> >> > > > > > > index 61d1cb7..8012741 100644
> >> > > > > > > --- a/fs/xfs/xfs_inode.c
> >> > > > > > > +++ b/fs/xfs/xfs_inode.c
> >> > > > > > > @@ -2401,6 +2401,24 @@ xfs_ifree_cluster(
> >> > > > > > >  }
> >> > > > > > >
> >> > > > > > >  /*
> >> > > > > > > + * Free any local-format buffers sitting around before we reset to
> >> > > > > > > + * extents format.
> >> > > > > > > + */
> >> > > > > > > +static inline void
> >> > > > > > > +xfs_ifree_local_data(
> >> > > > > > > +	struct xfs_inode	*ip,
> >> > > > > > > +	int			whichfork)
> >> > > > > > > +{
> >> > > > > > > +	struct xfs_ifork	*ifp;
> >> > > > > > > +
> >> > > > > > > +	if (XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_LOCAL)
> >> > > > > > > +		return;
> >> > > > > >
> >> > > > > > I'm new to all this so this was a bit hard to follow. I'm confused with how
> >> > > > > > commit 43518812d2 ("xfs: remove support for inlining data/extents into the
> >> > > > > > inode fork") exacerbated the leak, isn't that commit about
> >> > > > > > XFS_DINODE_FMT_EXTENTS?
> >> > > > >
> >> > > > > Not specifically _EXTENTS, merely any fork (EXTENTS or LOCAL) whose
> >> > > > > incore data was small enough to fit in if_inline_ata.
> >> > > >
> >> > > > Got it, I thought those were XFS_DINODE_FMT_EXTENTS by definition.
> >> > > >
> >> > > > > > Did we have cases where the format was XFS_DINODE_FMT_LOCAL and yet
> >> > > > > > ifp->if_u1.if_data == ifp->if_u2.if_inline_data ?
> >> > > > >
> >> > > > > An empty directory is 6 bytes, which is what you get with a fresh mkdir
> >> > > > > or after deleting everything in the directory.  Prior to the 43518812d2
> >> > > > > patch we could get away with not even checking if we had to free if_data
> >> > > > > when deleting a directory because it fit within if_inline_data.
> >> > > >
> >> > > > Ah got it. So your fix *is* also applicable even prior to commit 43518812d2.
> >> > >
> >> > > You'd have to modify the patch so that it doesn't try to kmem_free
> >> > > if_data if if_data == if_inline_data but otherwise (in theory) I think
> >> > > that the concept applies to pre-4.15 kernels.
> >> > >
> >> > > (YMMV, please do run this through QA/kmemleak just in case I'm wrong, etc...)
> >> >
> >> > Well... so we need a resolution and better get testing this already given that
> >> > *I believe* the new auto-selection algorithm used to cherry pick patches onto
> >> > stable for linux-4.14.y (covered on a paper [0] and when used, stable patches
> >> > are prefixed with AUTOSEL, a recent discussion covered this in November 2017
> >> > [1]) recommended to merge your commit 98c4f78dcdd8 ("xfs: always free inline
> >> > data before resetting inode fork during ifree") as stable commit 1eccdbd4836a41
> >> > on v4.14.17 *without* merging commit 43518812d2 ("xfs: remove support for
> >> > inlining data/extents into the inode fork").
> >> >
> >> > Sasha, Greg,
> >> >
> >> > Can you confirm if the algorithm was used in this case?
> >>
> >> No idea.
> >>
> >> I think xfs should just be added to the "blacklist" so that it is not
> >> even looked at for these types of auto-selected patches.  Much like the
> >> i915 driver currently is handled (it too is ignored for these patches
> >> due to objections from the maintainers of it.)
> >
> >Just out of curiosity, how does this autoselection mechanism work today?
> >If it's smart enough to cherry pick patches, apply them to a kernel,
> >build the kernel and run xfstests, and propose the patches if nothing
> >weird happened, then I'd be interested in looking further.  I've nothing
> >against algorithmic selection per se, but I'd want to know more about
> >the data sets and parameters that feed the algorithm.
> 
> It won't go beyond build testing.

No further regression testing ==> please blacklist XFS.

We will continue our current practices w.r.t. stable.

--D

> >I did receive the AUTOSEL tagged patches a few days ago, but I couldn't
> >figure out what automated regression testing, if any, had been done; or
> >whether the patch submission was asking if we wanted it put into 4.14
> >or if it was a declaration that they were on their way in.  Excuse me
> 
> There would be (at least) 3 different mails involved in this process:
> 
>  1. You'd get a mail from me, proposing this patch for stable. We give
>  at least 1 week (but usually closer to 2) to comment on whether this
>  patch should or should not go in stable.
> 
>  2. If no objections were received, Greg would add it to his queue and
>  you'd get another mail about that.
> 
>  3. A few more days later, Greg would release that stable tree and you'd
>  get another mail.
> 
> >for being behind the times, but I'd gotten accustomed xfs patches only
> >ending up in the stable kernels because we'd deliberately put them
> >there. :)
> >
> >If blacklisting xfs is more convenient then I'm happy to continue things
> >as they were.
> 
> No problem with blacklisting subsystems if maintainers prefer it that
> way, but the i915 case was slightly different as their development
> process was very quirky and testing was complex, so they asked to just
> keep doing their own selection for stable.
> 
> However, looking at stable history, it seems that no patch from fs/xfs/
> was proposed for stable for about half a year now, which is something
> that the autoselection project is trying to help with.
> 
> A different flow I'm working on for this is to send an email as a reply
> to the original patch submission to lkml if the patch is selected by the
> network, including details about which trees it was applied to and build
> results. I think it might work better for subsystems such as xfs.
> 
> 
> --
> Thanks,
> Sasha--
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
