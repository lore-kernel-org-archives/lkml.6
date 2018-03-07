Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeCGAeK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 19:34:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43270 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753873AbeCGAeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 19:34:09 -0500
Date: Tue, 6 Mar 2018 16:34:03 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Vratislav Bendel <vbendel@redhat.com>
Cc: linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Correctly invert xfs_buftarg LRU isolation logic
Message-ID: <20180307003403.GU18989@magnolia>
References: <20180306102638.25322-1-vbendel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306102638.25322-1-vbendel@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803070002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 11:26:38AM +0100, Vratislav Bendel wrote:
> Due to an inverted logic mistake in xfs_buftarg_isolate()
> the xfs_buffers with zero b_lru_ref will take another trip
> around LRU, while isolating buffers with non-zero b_lru_ref.
> 
> Additionally those isolated buffers end up right back on the LRU
> once they are released, because b_lru_ref remains elevated.
> 
> Fix that circuitous route by leaving them on the LRU
> as originally intended.
> 
> Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks ok, tests ok...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index d1da2ee9e6db..ac669a10c62f 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1708,7 +1708,7 @@ xfs_buftarg_isolate(
>  	 * zero. If the value is already zero, we need to reclaim the
>  	 * buffer, otherwise it gets another trip through the LRU.
>  	 */
> -	if (!atomic_add_unless(&bp->b_lru_ref, -1, 0)) {
> +	if (atomic_add_unless(&bp->b_lru_ref, -1, 0)) {
>  		spin_unlock(&bp->b_lock);
>  		return LRU_ROTATE;
>  	}
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
