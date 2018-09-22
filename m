Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A43C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 05:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C176C204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 05:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C176C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbeIVLTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 07:19:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeIVLTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 07:19:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E4B7308AA0E;
        Sat, 22 Sep 2018 05:27:11 +0000 (UTC)
Received: from rh (ovpn-116-15.phx2.redhat.com [10.3.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95FF980C3;
        Sat, 22 Sep 2018 05:27:07 +0000 (UTC)
Received: from [::1] (helo=rh)
        by rh with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <dchinner@redhat.com>)
        id 1g3aRZ-0004w1-Mc; Sat, 22 Sep 2018 15:27:01 +1000
Date:   Sat, 22 Sep 2018 15:26:59 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Wen Xu <wen.xu@gatech.edu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 3.16 52/63] xfs: validate cached inodes are free when
 allocated
Message-ID: <20180922052659.GC19103@rh>
References: <lsq.1537575341.194909669@decadent.org.uk>
 <lsq.1537575342.534061407@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsq.1537575342.534061407@decadent.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sat, 22 Sep 2018 05:27:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 01:15:42AM +0100, Ben Hutchings wrote:
> 3.16.58-rc1 review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Dave Chinner <dchinner@redhat.com>
> 
> commit afca6c5b2595fc44383919fba740c194b0b76aff upstream.
> 
> A recent fuzzed filesystem image cached random dcache corruption
> when the reproducer was run. This often showed up as panics in
> lookup_slow() on a null inode->i_ops pointer when doing pathwalks.
.....
> [bwh: Backported to 3.16:
>  - Look up mode in XFS inode, not VFS inode
>  - Use positive error codes, and EIO instead of EFSCORRUPTED]

Again, why EIO?

And ....
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  fs/xfs/xfs_icache.c | 73 +++++++++++++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 25 deletions(-)
> 
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -133,6 +133,46 @@ xfs_inode_free(
>  }
>  
>  /*
> + * If we are allocating a new inode, then check what was returned is
> + * actually a free, empty inode. If we are not allocating an inode,
> + * then check we didn't find a free inode.
> + *
> + * Returns:
> + *	0		if the inode free state matches the lookup context
> + *	ENOENT		if the inode is free and we are not allocating
> + *	EFSCORRUPTED	if there is any state mismatch at all

You changed the code but not the comment.

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com
