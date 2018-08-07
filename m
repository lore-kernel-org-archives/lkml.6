Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93201C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B0821734
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kukMeRY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B0821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389943AbeHGRln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:41:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59078 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHGRlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:41:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w77FORVa129679;
        Tue, 7 Aug 2018 15:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=p6Md5fAeaNLC34iTeJCCg2A5BQd8yihhoxLfGlnC00w=;
 b=kukMeRY4dmFU1+EWrpxEsh50424VjlmMKZ0bhpQb7SCLAOkagBOvsgG0u0PqRb3235US
 fq8TD0SXWknpDvqHPGZKzcuJ6b7JNt8QldgkF0Ip9XULs7E9t0lua3G6YaMfjry3rJG1
 qAqLMVADnd3BQy/iPl+cKrAkaWn2dMeQCOcz7pPSEBP9e8U4GgZkde6HlxJ28A5m0xVR
 FljTO+dlwhfvwh1KpVhZiMJigqpoZi4GVeBpzbR9cdC8KUJq+UKIaPaNRUUDxDwPSWcL
 B7gsE1RQsZ8dYzvgQFE1Q3bxFrsxcHdbaZ9yMTd5JA3L1N3VCwkbgeMHNfbwS6XvuYF/ WA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kn4spswgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Aug 2018 15:26:47 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w77FQkoX003097
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Aug 2018 15:26:46 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w77FQkad028090;
        Tue, 7 Aug 2018 15:26:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Aug 2018 08:26:46 -0700
Date:   Tue, 7 Aug 2018 08:26:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-xfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: xfs: cancel dfops on xfs_defer_finish() error
Message-ID: <20180807152644.GC30972@magnolia>
References: <18f3296d-e5d4-4d76-51f8-a40d0ceaa20e@canonical.com>
 <20180807143720.GA55416@bfoster>
 <20180807151029.GA30972@magnolia>
 <20180807151836.GB55416@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807151836.GB55416@bfoster>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8977 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808070154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 11:18:36AM -0400, Brian Foster wrote:
> On Tue, Aug 07, 2018 at 08:10:29AM -0700, Darrick J. Wong wrote:
> > On Tue, Aug 07, 2018 at 10:37:21AM -0400, Brian Foster wrote:
> > > On Tue, Aug 07, 2018 at 03:14:07PM +0100, Colin Ian King wrote:
> > > > Hi,
> > > > 
> > > > Recent commit 82ff27bc52a88cb5cc400bfa64e210d3ec8dfebd ("xfs: automatic
> > > > dfops buffer relogging") removed the assignment of variable error:
> > > > 
> > > > -       error = xfs_defer_bjoin(tp->t_dfops, bp);
> > > >         if (error) {
> > > >                 xfs_trans_bhold_release(tp, bp);
> > > >                 xfs_trans_brelse(tp, bp);
> > > > 
> > > 
> > > Hmm, I _think_ we can just drop these error checks now that this
> > > pre-finish error state is non-existent, something like the appended diff
> > > (with additional cleanups). E.g., if the buffer is held in the
> > > transaction then the bjoin is implicit. If the finish fails, then the
> > > state is essentially unchanged by the relogging patch.
> > > 
> > > That said, the error handling is a bit tricky here. Darrick, I think you
> > > reworked this recently.. thoughts?
> > > 
> > > Brian
> > > 
> > > --- 8< ---
> > > 
> > > diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
> > > index 70a76ac41f01..2106c4142ecd 100644
> > > --- a/fs/xfs/xfs_dquot.c
> > > +++ b/fs/xfs/xfs_dquot.c
> > > @@ -311,7 +311,7 @@ xfs_dquot_disk_alloc(
> > >  			XFS_DQUOT_CLUSTER_SIZE_FSB, XFS_BMAPI_METADATA,
> > >  			XFS_QM_DQALLOC_SPACE_RES(mp), &map, &nmaps);
> > >  	if (error)
> > > -		goto error0;
> > > +		return error;
> > >  	ASSERT(map.br_blockcount == XFS_DQUOT_CLUSTER_SIZE_FSB);
> > >  	ASSERT(nmaps == 1);
> > >  	ASSERT((map.br_startblock != DELAYSTARTBLOCK) &&
> > > @@ -326,8 +326,8 @@ xfs_dquot_disk_alloc(
> > >  	bp = xfs_trans_get_buf(tp, mp->m_ddev_targp, dqp->q_blkno,
> > >  			mp->m_quotainfo->qi_dqchunklen, 0);
> > >  	if (!bp) {
> > > -		error = -ENOMEM;
> > > -		goto error1;
> > > +		xfs_defer_cancel(tp);
> > > +		return -ENOMEM;
> > 
> > The only caller of xfs_dquot_disk_alloc checks the return value and
> > xfs_trans_cancels the transaction, which should take care of calling
> > xfs_defer_cancel, right?
> > 
> 
> Yeah. IIRC I originally left the defer_cancel() alone in this function
> just to be consistent, since it calls xfs_defer_finish() as well on the
> caller's transaction. Technically I don't think it matters either way,
> so I don't have much preference on if it stays or goes (assuming the
> other changes are correct)...

I can't think of a good reason for anything (except xfs_trans_cancel) to
call xfs_defer_cancel.  It's never correct to kill all the deferred ops
attached to a transaction and then continue logging things to the
transaction, which means that the only thing you can really do after
cancelling the dfops is to cancel the transaction.  I'd have to look
more carefully but I think all the remaining callers can all go away.

xfs_defer_finish is a different story -- it can be used (by online
repair for example) to process the deferred operations so they don't sit
around pinning memory and log, even if there's a lot more work to be
done before _trans_commit.  But I don't think we need to _defer_cancel
if things go awry.

--D

> Brian
> 
> > --D
> > 
> > >  	}
> > >  	bp->b_ops = &xfs_dquot_buf_ops;
> > >  
> > > @@ -349,10 +349,8 @@ xfs_dquot_disk_alloc(
> > >  	 * the buffer locked across the _defer_finish call.  We can now do
> > >  	 * this correctly with xfs_defer_bjoin.
> > >  	 *
> > > -	 * Above, we allocated a disk block for the dquot information and
> > > -	 * used get_buf to initialize the dquot.  If the _defer_bjoin fails,
> > > -	 * the buffer is still locked to *tpp, so we must _bhold_release and
> > > -	 * then _trans_brelse the buffer.  If the _defer_finish fails, the old
> > > +	 * Above, we allocated a disk block for the dquot information and used
> > > +	 * get_buf to initialize the dquot. If the _defer_finish fails, the old
> > >  	 * transaction is gone but the new buffer is not joined or held to any
> > >  	 * transaction, so we must _buf_relse it.
> > >  	 *
> > > @@ -362,24 +360,14 @@ xfs_dquot_disk_alloc(
> > >  	 * manually or by committing the transaction.
> > >  	 */
> > >  	xfs_trans_bhold(tp, bp);
> > > -	if (error) {
> > > -		xfs_trans_bhold_release(tp, bp);
> > > -		xfs_trans_brelse(tp, bp);
> > > -		goto error1;
> > > -	}
> > >  	error = xfs_defer_finish(tpp);
> > >  	tp = *tpp;
> > >  	if (error) {
> > >  		xfs_buf_relse(bp);
> > > -		goto error0;
> > > +		return error;
> > >  	}
> > >  	*bpp = bp;
> > >  	return 0;
> > > -
> > > -error1:
> > > -	xfs_defer_cancel(tp);
> > > -error0:
> > > -	return error;
> > >  }
> > >  
> > >  /*
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
