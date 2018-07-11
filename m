Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914FBC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E622086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ifIC6Zmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E622086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388919AbeGKRtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:49:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43780 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeGKRtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:49:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6BHiBs2080547;
        Wed, 11 Jul 2018 17:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=KjEmsj8n+Qyf48zhleVbDeTKFPcPE/4n3ug8GbUYyI8=;
 b=ifIC6ZmwqgYjANeSvIJrbhxmZ/xgJUDGvoXW24pCJvDh/FtOGsF3oXQVbXz9OIUzeX+d
 YXJABXHzzwkZHeLT8kRn+mEgyj/6ij8EH6PGw1yvmOfM/1gH9m6AQCxd+rRuWUY1zm7G
 RJqJQ9FanQtZhFDrmKRpt2frXPp0HDeOlZc4eGBVfLCS38Xrl9Bn3s0NtJ9LfNO5FqJq
 fbEOI3ngfp1dHl/7P/sYsRpNznyEqltyfNijHGfgnMTiqIhyOOKXoBbZiLdswJbpo7bL
 g9QwXhD83mx2wdt8oiIiROsxi+45w8U5EgaaofYObblNDtkZJT4+NMi8bfWCq9TEsVEo SQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k2p767a0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 17:44:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6BHiDZp022156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 17:44:13 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6BHiCqK026034;
        Wed, 11 Jul 2018 17:44:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 10:44:12 -0700
Date:   Wed, 11 Jul 2018 10:44:11 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xfs_bmap_util: use swap macro
Message-ID: <20180711174411.GG32415@magnolia>
References: <20180709210259.GA18992@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709210259.GA18992@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:02:59PM -0500, Gustavo A. R. Silva wrote:
> Make use of the swap macro and remove some unnecessary variables.
> This makes the code easier to read and maintain. Also, reduces the
> stack usage.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Looks ok, will test...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> Changes in v2
>  - Use swap in a couple more of places.
> 
>  fs/xfs/xfs_bmap_util.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 83b1e8c..a657d0a 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -1691,7 +1691,6 @@ xfs_swap_extent_forks(
>  	int			*src_log_flags,
>  	int			*target_log_flags)
>  {
> -	struct xfs_ifork	tempifp, *ifp, *tifp;
>  	xfs_filblks_t		aforkblks = 0;
>  	xfs_filblks_t		taforkblks = 0;
>  	xfs_extnum_t		junk;
> @@ -1733,11 +1732,7 @@ xfs_swap_extent_forks(
>  	/*
>  	 * Swap the data forks of the inodes
>  	 */
> -	ifp = &ip->i_df;
> -	tifp = &tip->i_df;
> -	tempifp = *ifp;		/* struct copy */
> -	*ifp = *tifp;		/* struct copy */
> -	*tifp = tempifp;	/* struct copy */
> +	swap(ip->i_df, tip->i_df);
>  
>  	/*
>  	 * Fix the on-disk inode values
> @@ -1746,13 +1741,8 @@ xfs_swap_extent_forks(
>  	ip->i_d.di_nblocks = tip->i_d.di_nblocks - taforkblks + aforkblks;
>  	tip->i_d.di_nblocks = tmp + taforkblks - aforkblks;
>  
> -	tmp = (uint64_t) ip->i_d.di_nextents;
> -	ip->i_d.di_nextents = tip->i_d.di_nextents;
> -	tip->i_d.di_nextents = tmp;
> -
> -	tmp = (uint64_t) ip->i_d.di_format;
> -	ip->i_d.di_format = tip->i_d.di_format;
> -	tip->i_d.di_format = tmp;
> +	swap(ip->i_d.di_nextents, tip->i_d.di_nextents);
> +	swap(ip->i_d.di_format, tip->i_d.di_format);
>  
>  	/*
>  	 * The extents in the source inode could still contain speculative
> @@ -1846,7 +1836,6 @@ xfs_swap_extents(
>  	int			src_log_flags, target_log_flags;
>  	int			error = 0;
>  	int			lock_flags;
> -	struct xfs_ifork	*cowfp;
>  	uint64_t		f;
>  	int			resblks = 0;
>  
> @@ -1987,18 +1976,11 @@ xfs_swap_extents(
>  
>  	/* Swap the cow forks. */
>  	if (xfs_sb_version_hasreflink(&mp->m_sb)) {
> -		xfs_extnum_t	extnum;
> -
>  		ASSERT(ip->i_cformat == XFS_DINODE_FMT_EXTENTS);
>  		ASSERT(tip->i_cformat == XFS_DINODE_FMT_EXTENTS);
>  
> -		extnum = ip->i_cnextents;
> -		ip->i_cnextents = tip->i_cnextents;
> -		tip->i_cnextents = extnum;
> -
> -		cowfp = ip->i_cowfp;
> -		ip->i_cowfp = tip->i_cowfp;
> -		tip->i_cowfp = cowfp;
> +		swap(ip->i_cnextents, tip->i_cnextents);
> +		swap(ip->i_cowfp, tip->i_cowfp);
>  
>  		if (ip->i_cowfp && ip->i_cowfp->if_bytes)
>  			xfs_inode_set_cowblocks_tag(ip);
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
