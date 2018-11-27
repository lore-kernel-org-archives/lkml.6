Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE909C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FC32086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KbJBw924"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FC32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbeK1DXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:23:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44022 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbeK1DXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:23:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wARGOMCH103358;
        Tue, 27 Nov 2018 16:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yiTuleaTQ9T92kvKXA4hTuFDIUskdv//2MBFzmEeG4I=;
 b=KbJBw924bhiE77cpi7vnxNtUIIXTyNVutvoP410fXy8YdG9uiUI+7HRRVbrhc0SE7vXh
 iEWXLjOdTx90iN15POkAxyZI8k21y1FMFpZKAAMh+s+/KKWB5wBJmdApEDVrriuahhUp
 Ww6GWaua+GMmWwecPLIqRzGQfHrQ2Ni34yPKxqviI4ka2Sw8HHOlM4CNNq19bwNFNPgu
 WLGlS6bobGTr0iaAvpm59OQaCEC4f8T2x6nxTxExQFcemdtamoe4CUgv5a0wxF8qh7xT
 mbBTgvznjbGoWZ8Mdrz5rs9ZZI/Otx+W6bdqzwl59q4B/lj7Rv95ebaV4apK0y02pUfJ +g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nxx2u5417-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 16:25:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wARGPHfm017957
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 16:25:17 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wARGPH8Y004144;
        Tue, 27 Nov 2018 16:25:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 08:25:17 -0800
Date:   Tue, 27 Nov 2018 08:25:16 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Pan Bian <bianpan2016@163.com>, Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] xfs: libxfs: move xfs_perag_put late
Message-ID: <20181127162516.GG6792@magnolia>
References: <1543278818-117362-1-git-send-email-bianpan2016@163.com>
 <20181127091602.eaeczahefobpx544@hades.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127091602.eaeczahefobpx544@hades.usersys.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:16:02AM +0100, Carlos Maiolino wrote:
> On Tue, Nov 27, 2018 at 08:33:38AM +0800, Pan Bian wrote:
> > The function xfs_alloc_get_freelist calls xfs_perag_put to drop the
> > reference. However, pag->pagf_btreeblks is read and write after the 
> > put operation. This patch moves the put operation late.
> 
> I'm not a native English speaker too, but I believe it should be "is read and
> written after..."
> 
> But, for the code itself, you can add:
> 
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> 
> Cheers
> 
> > 
> > Signed-off-by: Pan Bian <bianpan2016@163.com>

Looks ok, will amend the changelog on the way in.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> > ---
> > V2: correct the commit log
> > ---
> >  fs/xfs/libxfs/xfs_alloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> > index e1c0c0d..4be387d 100644
> > --- a/fs/xfs/libxfs/xfs_alloc.c
> > +++ b/fs/xfs/libxfs/xfs_alloc.c
> > @@ -2435,7 +2435,6 @@ xfs_alloc_get_freelist(
> >  	be32_add_cpu(&agf->agf_flcount, -1);
> >  	xfs_trans_agflist_delta(tp, -1);
> >  	pag->pagf_flcount--;
> > -	xfs_perag_put(pag);
> >  
> >  	logflags = XFS_AGF_FLFIRST | XFS_AGF_FLCOUNT;
> >  	if (btreeblk) {
> > @@ -2443,6 +2442,7 @@ xfs_alloc_get_freelist(
> >  		pag->pagf_btreeblks++;
> >  		logflags |= XFS_AGF_BTREEBLKS;
> >  	}
> > +	xfs_perag_put(pag);
> >  
> >  	xfs_alloc_log_agf(tp, agbp, logflags);
> >  	*bnop = bno;
> > -- 
> > 2.7.4
> > 
> > 
> 
> -- 
> Carlos
