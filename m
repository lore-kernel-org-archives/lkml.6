Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeCOPxW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:53:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36040 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932686AbeCOPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:53:20 -0400
Date: Thu, 15 Mar 2018 08:53:16 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH RFC] xfs, memcg: Call xfs_fs_nr_cached_objects() only in
 case of global reclaim
Message-ID: <20180315155316.GY4865@magnolia>
References: <152112607662.7371.16175767692798928059.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152112607662.7371.16175767692798928059.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=976
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 06:01:34PM +0300, Kirill Tkhai wrote:
> xfs_reclaim_inodes_count(XFS_M(sb)) does not care about memcg.
> So, it's called for memcg reclaim too, e.g. this list is shrinked
> disproportionality to another lists.
> 
> This looks confusing, so I'm reporting about this.
> Consider this patch as RFC.

So... I think the reasoning here is that xfs doesn't allocate inodes on
behalf of any particular memcg (or put another way the cost of the
inodes is shared by everything in the system) so if the shrinkers get
called because a particular memcg is bumping up against its limits it
makes no sense to try to purge xfs inodes?

Followup questions: does the same reasoning apply to the xfs buffer and
quota shrinkers?  Do any filesystems associate their metadata memory
allocations with a specific memcg?  If not, why not put this in
super_cache_{scan,count}?

--D

> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/xfs/xfs_super.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 951271f57d00..124568aefa94 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1788,6 +1788,8 @@ xfs_fs_nr_cached_objects(
>  	struct super_block	*sb,
>  	struct shrink_control	*sc)
>  {
> +	if (sc->memcg)
> +		return 0;
>  	return xfs_reclaim_inodes_count(XFS_M(sb));
>  }
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
