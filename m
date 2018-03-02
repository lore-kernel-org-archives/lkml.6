Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936657AbeCBQgN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:36:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60622 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936306AbeCBQgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:36:10 -0500
Date: Fri, 2 Mar 2018 08:36:03 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Vratislav Bendel <vbendel@redhat.com>
Cc: linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        linux-kernel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH] xfs: Correctly invert xfs_buftarg LRU isolation logic
Message-ID: <20180302163603.GQ19312@magnolia>
References: <20180228154951.31714-1-vbendel@redhat.com>
 <20180301224800.GI12763@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301224800.GI12763@magnolia>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020194
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 02:48:00PM -0800, Darrick J. Wong wrote:
> On Wed, Feb 28, 2018 at 04:49:51PM +0100, Vratislav Bendel wrote:
> > The function xfs_buftarg_isolate() used by xfs buffer schrinkers 
> > to determine whether a buffer should be isolated and disposed 
> > from LRU list, has inverted logic.
> > 
> > Excerpt from xfs_buftarg_isolate():
> >         /*
> >          * Decrement the b_lru_ref count unless the value is already
> >          * zero. If the value is already zero, we need to reclaim the
> >          * buffer, otherwise it gets another trip through the LRU.
> >          */
> >         if (!atomic_add_unless(&bp->b_lru_ref, -1, 0)) {
> >                 spin_unlock(&bp->b_lock);
> >                 return LRU_ROTATE;
> >         }
> > 
> > However, as per documentation, atomic_add_unless() returns _zero_
> > if the atomic value was originally equal to the specified *unsless* value.
> > 
> > Ultimately causing a xfs_buffer with ->b_lru_ref == 0, to take another 
> > trip around LRU, while isolating buffers with non-zero b_lru_ref.
> > 
> > Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
> > CC: Brian Foster <bfoster@redhat.com>
> 
> Looks ok, will test...
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

This tests ok, but please address Brian and Luis' comments before I put
this in the upstream tream.

--D

> --D
> 
> > ---
> >  fs/xfs/xfs_buf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index d1da2ee9e6db..ac669a10c62f 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -1708,7 +1708,7 @@ xfs_buftarg_isolate(
> >  	 * zero. If the value is already zero, we need to reclaim the
> >  	 * buffer, otherwise it gets another trip through the LRU.
> >  	 */
> > -	if (!atomic_add_unless(&bp->b_lru_ref, -1, 0)) {
> > +	if (atomic_add_unless(&bp->b_lru_ref, -1, 0)) {
> >  		spin_unlock(&bp->b_lock);
> >  		return LRU_ROTATE;
> >  	}
> > -- 
> > 2.14.3
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
