Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEEFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EA22082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TE4/WoVv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M+++dudH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EA22082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeH3Luk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:50:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeH3Luj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:50:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2EA2660385; Thu, 30 Aug 2018 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535615388;
        bh=AG6ZOoYyoR7k8qYO9JAXJn0YpN9DdV4Ht1N8FzdIv3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TE4/WoVvkAx8jluLVlqoJlbNbJlITT5P7fb3r436fkyurkea3ADe4BAEqqK43/8qn
         GtrGSsX5anRCQcYSLqfyeLroAzrqeX+VNrv1ltFTfIohipmrhF6RdTIRZ09UCIXFS/
         oS4lqrxYK3pfhTAuXRuQ/ixqBX4gimRH/LmJ06rM=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 535FD60271;
        Thu, 30 Aug 2018 07:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535615387;
        bh=AG6ZOoYyoR7k8qYO9JAXJn0YpN9DdV4Ht1N8FzdIv3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+++dudHRMM4JX6+JbBhjCmu7nfl/F6344YZxRe204QhIiXYKsQKolsJVhrOd1Yfo
         +y3ni4YGdmMnUlr7H5Ez0Jgx3clY7wmJBbxznk/43Re8EsMb/HJKsXlihNCap1jNga
         EvTEM+PuNBC3Dd1MNIQ3LC6YRfyQSDtN536IYJCM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 535FD60271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Thu, 30 Aug 2018 13:19:42 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid wrong decrypted data from disk
Message-ID: <20180830074942.GD12489@codeaurora.org>
References: <20180827225226.14272-1-jaegeuk@kernel.org>
 <20180830062903.GC12489@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830062903.GC12489@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:59:03AM +0530, Sahitya Tummala wrote:
> On Mon, Aug 27, 2018 at 03:52:26PM -0700, Jaegeuk Kim wrote:
> > 1. Create a file in an encrypted directory
> > 2. Do GC & drop caches
> > 3. Read stale data before its bio for metapage was not issued yet
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 382c1ef9a9e4..c3557fd4a0bd 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1550,6 +1550,13 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
> >  			bio = NULL;
> >  		}
> >  		if (bio == NULL) {
> > +			/*
> > +			 * If the page is under writeback, we need to wait for
> > +			 * its completion to see the correct decrypted data.
> > +			 */
> > +			if (unlikely(f2fs_encrypted_file(inode)))
> > +				f2fs_wait_on_block_writeback(F2FS_I_SB(inode), block_nr);
> > +
> 
> I am not sure if this really helps the case.
> 
> When the data is being moved by GC, the writeback is set on the encrypted page
> which belongs to meta mapping. But before that writeback could complete, the read
> will happen on the original file where it's corresponding page will not have any
> writeback set, right?

Never mind, got it. Tested with your latest v3 patch and it is fixing the
problem. Thanks.

> 
> >  			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
> >  					is_readahead ? REQ_RAHEAD : 0);
> >  			if (IS_ERR(bio)) {
> > -- 
> > 2.17.0.441.gb46fe60e1d-goog
> > 
> > 
> > ------------------------------------------------------------------------------
> > Check out the vibrant tech community on one of the world's most
> > engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> -- 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
