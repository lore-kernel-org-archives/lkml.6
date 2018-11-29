Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23E4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12A32081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12A32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeK2XYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:24:36 -0500
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:52910 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbeK2XYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:24:36 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl6.internode.on.net with ESMTP; 29 Nov 2018 22:49:23 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gSLHu-00065Z-JD; Thu, 29 Nov 2018 23:19:22 +1100
Date:   Thu, 29 Nov 2018 23:19:22 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 52/68] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181129121922.GL19305@dastard>
References: <20181129055559.159228-1-sashal@kernel.org>
 <20181129055559.159228-52-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129055559.159228-52-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:55:43AM -0500, Sasha Levin wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> [ Upstream commit b450672fb66b4a991a5b55ee24209ac7ae7690ce ]
> 
> If we are doing sub-block dio that extends EOF, we need to zero
> the unused tail of the block to initialise the data in it it. If we
> do not zero the tail of the block, then an immediate mmap read of
> the EOF block will expose stale data beyond EOF to userspace. Found
> with fsx running sub-block DIO sizes vs MAPREAD/MAPWRITE operations.
> 
> Fix this by detecting if the end of the DIO write is beyond EOF
> and zeroing the tail if necessary.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/iomap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index fa46e3ed8f53..82e35265679d 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -1678,7 +1678,14 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		dio->submit.cookie = submit_bio(bio);
>  	} while (nr_pages);
>  
> -	if (need_zeroout) {
> +	/*
> +	 * We need to zeroout the tail of a sub-block write if the extent type
> +	 * requires zeroing or the write extends beyond EOF. If we don't zero
> +	 * the block tail in the latter case, we can expose stale data via mmap
> +	 * reads of the EOF block.
> +	 */
> +	if (need_zeroout ||
> +	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
>  		/* zero out from the end of the write to the end of the block */
>  		pad = pos & (fs_block_size - 1);
>  		if (pad)

Same again - what's the test plan for these cherry-picked data
corruption fixes?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
