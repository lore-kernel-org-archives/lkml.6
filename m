Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ajRveAFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A89B460290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeFFPJl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:09:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50456 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeFFPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:09:37 -0400
Date: Wed, 6 Jun 2018 08:09:05 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 01/39] vfs: dedpue: return loff_t
Message-ID: <20180606150905.GC9426@magnolia>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-2-mszeredi@redhat.com>
 <20180604084336.GA11333@infradead.org>
 <CAJfpegun8HyjODXguHstxYrGE2nuSoCCicaHT3yfYWMkxxmVWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegun8HyjODXguHstxYrGE2nuSoCCicaHT3yfYWMkxxmVWg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8915 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=881
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806060173
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:33:22AM +0200, Miklos Szeredi wrote:
> On Mon, Jun 4, 2018 at 10:43 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > On Tue, May 29, 2018 at 04:43:01PM +0200, Miklos Szeredi wrote:
> >> f_op->dedupe_file_range() gets a u64 length to dedup and returns an ssize_t
> >> actual length deduped.  This breaks badly on 32bit archs since the returned
> >> length will be truncated and possibly overflow into the sign bit (xfs and
> >> ocfs2 are affected, btrfs limits actual length to 16MiB).
> >
> > Can we just make it return 0 vs errno?  The only time we return
> > a different length than the one passed in is due to the btrfs cap.
> >
> > Given that this API started out on btrfs we should just do the cap
> > everywhere to not confuse userspace.
> 
> And that's a completely arbitrary cap; sure btrfs started out with
> that, but there's no fundamental reason for that becoming the global
> limit.  Xfs now added a different, larger limit, so based on what
> reason should that limit be reduced?
> 
> I don't care either way, but at this stage I'm not going to change
> this patch, unless there's a very good reason to do so, because if I
> do someone will come and suggest another improvement, ad-infinitum...

I think we should hoist the MAX_RW_COUNT/2 limit to the VFS helpers
since afaict we generally cap max IO per call at MAX_RW_COUNT.  (I
probably should've capped ocfs2 back when I did xfs, but forgot).  If
btrfs wants to keep their lower (16M) limit then they're free to do so;
the interface documentation allows for this.  One of the btrfs
developers seems to be working on a patch series to raise the limit[1]
anyway.

--D

[1] https://www.spinics.net/lists/linux-btrfs/msg78392.html

> 
> Thanks,
> Miklos
