Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3D2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14862086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0f1OPUlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14862086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbeGKRt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:49:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388924AbeGKRt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:49:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6BHiNA1080904;
        Wed, 11 Jul 2018 17:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=AUMt5WLeKxeyrBngqMBXAvHNPb5gKke3atiljqq7sVo=;
 b=0f1OPUlFMt3aGkFvFLvHX3ilY4O3BJ/lqEvYb0bnY+0vR898Q3cA3z1snmobusfM3stF
 cCGMSqDJthzMW7V9OciWPoMpA0K+gzj8Jh5ffwgfDifYmeaK1Aw12XGnRFOJgQ/wdFP+
 soWP8+PES8UWCDmwZic0KUxabKsdb7aDahGN4sZP3DCcc4v3EEQk8M6LHAPDVdN43wWH
 X+p+utsITYKjA52uTGJ4OeiBdZ2Xz4F47ScaIw0iJkHx2YM78SITlh42/WlAGVeMF1BN
 YKQeEAoYliJ/zDrhrfAYNPGcuWpUS7HnG47oyQgBWskkWM3/T1eR0MiUF/1Wmt6YrheJ Xw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2k2p767a1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 17:44:23 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6BHiMGG022253
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 17:44:23 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6BHiMdD026106;
        Wed, 11 Jul 2018 17:44:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 10:44:22 -0700
Date:   Wed, 11 Jul 2018 10:44:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs_attr_leaf: use swap macro in xfs_attr3_leaf_rebalance
Message-ID: <20180711174421.GH32415@magnolia>
References: <20180709161247.GA4746@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709161247.GA4746@embeddedor.com>
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

On Mon, Jul 09, 2018 at 11:12:47AM -0500, Gustavo A. R. Silva wrote:
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
>  fs/xfs/libxfs/xfs_attr_leaf.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
> index 76e9004..ec0bf96 100644
> --- a/fs/xfs/libxfs/xfs_attr_leaf.c
> +++ b/fs/xfs/libxfs/xfs_attr_leaf.c
> @@ -1570,17 +1570,10 @@ xfs_attr3_leaf_rebalance(
>  	 */
>  	swap = 0;
>  	if (xfs_attr3_leaf_order(blk1->bp, &ichdr1, blk2->bp, &ichdr2)) {
> -		struct xfs_da_state_blk	*tmp_blk;
> -		struct xfs_attr3_icleaf_hdr tmp_ichdr;
> +		swap(blk1, blk2);
>  
> -		tmp_blk = blk1;
> -		blk1 = blk2;
> -		blk2 = tmp_blk;
> -
> -		/* struct copies to swap them rather than reconverting */
> -		tmp_ichdr = ichdr1;
> -		ichdr1 = ichdr2;
> -		ichdr2 = tmp_ichdr;
> +		/* swap structures rather than reconverting them */
> +		swap(ichdr1, ichdr2);
>  
>  		leaf1 = blk1->bp->b_addr;
>  		leaf2 = blk2->bp->b_addr;
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
