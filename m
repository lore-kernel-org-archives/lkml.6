Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC582469A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gBkoZIll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC582469A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934251AbeGCRTs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:19:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49418 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbeGCRTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:19:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w63HIu2B018129;
        Tue, 3 Jul 2018 17:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=40Jgs7qhoxFo8wqbFbpejJSOm22V/BSrZF4pqfhtq8Y=;
 b=gBkoZIllWu0SoueZPLN2cYF0xXrSPBhe32o0D9x9vg6o8dQqQdJ5H8ITdp8c8irDPQdo
 4outGipBcXZ6xwcfggOZnxMnlErehVp+gxctUAQdrmiUa/MxwJzjl9fZ/KsV9vW0IGr9
 PLzfjBByf8F7eEQQt3t4+dkMBXpIjZQ/Flx3nHai+GmlndehdPuUSYAOHCr2lKDBpbUW
 VVRkzqM/o/g0UE8WhhpgB0O/2w8Oo+i2kVIrpdFgFmraZsR/xoyomALUl4nXZ6tgTxmY
 D+bAhPcW0NDR5w7VJsyM6P30eXvxTDMtQpcqVvUGLq2n0XxnDSb00uLHWjAG+hhPc7v1 BQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jx1tp1g3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jul 2018 17:19:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w63HJOn2006927
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 17:19:24 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w63HJMPx006433;
        Tue, 3 Jul 2018 17:19:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Jul 2018 10:19:22 -0700
Date:   Tue, 3 Jul 2018 10:19:20 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, tytso@mit.edu,
        adilger.kernel@dilger.ca, dchinner@redhat.com,
        akpm@linux-foundation.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: xfs: use BUG_ON if writepage call comes from
 direct reclaim
Message-ID: <20180703171920.GC5711@magnolia>
References: <1530591079-33813-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530591079-33813-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530591079-33813-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8943 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:11:19PM +0800, Yang Shi wrote:
> direct reclaim doesn't write out filesystem page, only kswapd could do
> this. So, if it is called from direct relaim, it is definitely a bug.
> 
> And, Mel Gorman mentioned "Ultimately, this will be a BUG_ON." in commit
> 94054fa3fca1fd78db02cb3d68d5627120f0a1d4 ("xfs: warn if direct reclaim
> tries to writeback pages"),
> 
> It has been many years since that commit, so it should be safe to
> elevate WARN_ON to BUG_ON now.
> 
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  fs/xfs/xfs_aops.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 8eb3ba3..7efc2d2 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -1080,11 +1080,9 @@ static inline int xfs_bio_add_buffer(struct bio *bio, struct buffer_head *bh)
>  	 * allow reclaim from kswapd as the stack usage there is relatively low.
>  	 *
>  	 * This should never happen except in the case of a VM regression so
> -	 * warn about it.
> +	 * BUG about it.
>  	 */
> -	if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
> -			PF_MEMALLOC))
> -		goto redirty;
> +	BUG_ON((current->flags & (PF_MEMALLOC|PF_KSWAPD)) == PF_MEMALLOC);

Ugh, please do not increase the BUG() factor.  Even if this happens due
to a regression it's /much/ easier to debug if we don't halt the system.

(IOWs, I decline to take this patch.)

--D

>  
>  	/*
>  	 * Given that we do not allow direct reclaim to call us, we should
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
