Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C385CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9240B20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HueIVodI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfBUPyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:54:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43790 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfBUPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:54:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LFmhp7052884;
        Thu, 21 Feb 2019 15:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dSKI8hgsSaoDxFzUtcqGe17EV1u9L/1VTXgmJNHu2OQ=;
 b=HueIVodI7q0+9/ZoFXX6lbgtCeOWg3LgXwlhQlTa4jXhHGoprPT82bF0toY+OpjBMK7T
 U3CIuxwsWBVNzWdNcOZsOympnlNr0ANG4iJusW4vMjygbCQKfpjbYbfVvSBOaBdK7Qes
 3nZxFlBn3k8cEJ0zczJLLIDMuPxd+1aIuUi2t3ag5UzAm9X16VqkhgthzBo7O0u4M64Y
 XIKNWJ/lKiUZyjLyGdCLMkIV1caUFWuoQI+DPs220H7jEVyDhE6t75xl4KVogIFOdBWB
 vJhpotRCo05DaUr1w8nvwQCniqxKj8R7kPMokjXDU5j0tP0kY30CkTYikdABIyzcdpLQ 5Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qp81eh1vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:54:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1LFsWSf027236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:54:32 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1LFsVj0032466;
        Thu, 21 Feb 2019 15:54:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 07:54:31 -0800
Date:   Thu, 21 Feb 2019 07:54:31 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][xfs-next] xfs: fix uninitialized error variable
Message-ID: <20190221155431.GQ32253@magnolia>
References: <20190221112224.3748-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221112224.3748-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:22:24AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A previous commit removed the initialization of variable 'error' to zero,
> and can cause a bogus error return.  This occurs when error contains a
> non-zero garbage value and the call to xchk_should_terminate detects a
> pending fatal signal and checks for a zero error before setting it
> to -EAGAIN. Fix the issue by initializing error to zero.
> 
> Fixes: b9454fe056bd ("xfs: clean up the inode cluster checking in the inobt scrub")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thank you for the cleanup!

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/scrub/ialloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/scrub/ialloc.c b/fs/xfs/scrub/ialloc.c
> index 2c9dad2b61b1..700114f79a7d 100644
> --- a/fs/xfs/scrub/ialloc.c
> +++ b/fs/xfs/scrub/ialloc.c
> @@ -161,7 +161,7 @@ xchk_iallocbt_check_cluster_ifree(
>  	bool				irec_free;
>  	bool				ino_inuse;
>  	bool				freemask_ok;
> -	int				error;
> +	int				error = 0;
>  
>  	if (xchk_should_terminate(bs->sc, &error))
>  		return error;
> -- 
> 2.20.1
> 
