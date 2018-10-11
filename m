Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282F4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF87820644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OeVyeleg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DHukjux+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF87820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeJKHyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:54:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38080 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJKHyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:54:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF33360B0D; Thu, 11 Oct 2018 00:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539217781;
        bh=IRb2Z5cCU5V0HCheMAzDbIIVtlc/k6WKyWbY6O26k/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeVyelegPAhdlnBKy+KxbkKYZQh7/Unt0YBTUQstNstooyElWseGOlOWJ+h6Jtd+7
         49yeT+94CcBC4Mm7eppQ+TQhVzJAxcjajTBU4fraSTkzXTo6zRC9QAcJxceGnn2GK+
         Mc4lxpdl9TCTW7E17+Wz7tl50vdAw1vuNYJX1umw=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D52B4600E6;
        Thu, 11 Oct 2018 00:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539217780;
        bh=IRb2Z5cCU5V0HCheMAzDbIIVtlc/k6WKyWbY6O26k/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DHukjux+aMdVwFB1SawUcsrhfABb6wVnwY3eFStjVCT60msWAjUZ591LbyBnxgyOk
         MsBwqpBeML1BJDXODPUVT4Mg90o5mKV5n+n6V/wG3FPldSnyF6qMNaI8QHsb0yYepb
         VVvL9dSVbEPTEkXCXJcOCRSEbWhNMnLvks2zAM7E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D52B4600E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Thu, 11 Oct 2018 05:59:35 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix data corruption issue with hardware encryption
Message-ID: <20181011002935.GA24669@codeaurora.org>
References: <1539149182-12729-1-git-send-email-stummala@codeaurora.org>
 <20181010213402.GA52406@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010213402.GA52406@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 02:34:02PM -0700, Jaegeuk Kim wrote:
> On 10/10, Sahitya Tummala wrote:
> > Direct IO can be used in case of hardware encryption. The following
> > scenario results into data corruption issue in this path -
> > 
> > Thread A -                          Thread B-
> > -> write file#1 in direct IO
> >                                     -> GC gets kicked in
> >                                     -> GC submitted bio on meta mapping
> > 				       for file#1, but pending completion
> > -> write file#1 again with new data
> >    in direct IO
> >                                     -> GC bio gets completed now
> >                                     -> GC writes old data to the new
> >                                        location and thus file#1 is
> > 				       corrupted.
> > 
> > Fix this by submitting and waiting for pending io on meta mapping
> > for direct IO case in f2fs_map_blocks().
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> >  fs/f2fs/data.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 9ef6f1f..7b2fef0 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1028,6 +1028,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> >  		map->m_pblk = ei.blk + pgofs - ei.fofs;
> >  		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
> >  		map->m_flags = F2FS_MAP_MAPPED;
> > +		/* for HW encryption, but to avoid potential issue in future */
> > +		if (flag == F2FS_GET_BLOCK_DIO) {
> > +			blkaddr = map->m_pblk;
> > +			for (; blkaddr < map->m_pblk + map->m_len; blkaddr++)
> > +				f2fs_wait_on_block_writeback(sbi, blkaddr);
> 
> Do we need this? IIRC, DIO would give create=1.

Yes, we need it. When we are overwriting an existing file, DIO calls
f2fs_map_blocks() with create=0. From the DIO code, I see that this happens
because blockdev_direct_IO() passes this dio flag DIO_SKIP_HOLES. And then
in get_more_blocks(), below code updates create=0, when we are overwriting
an existing file.

                create = dio->op == REQ_OP_WRITE;
                if (dio->flags & DIO_SKIP_HOLES) {
                        if (fs_startblk <= ((i_size_read(dio->inode) - 1) >>
                                                        i_blkbits))
                                create = 0;
                }

                ret = (*sdio->get_block)(dio->inode, fs_startblk,
                                                map_bh, create);

> 
> > +		}
> >  		if (map->m_next_extent)
> >  			*map->m_next_extent = pgofs + map->m_len;
> >  		goto out;
> > @@ -1188,6 +1194,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> >  	goto next_dnode;
> >  
> >  sync_out:
> > +	/* for hardware encryption, but to avoid potential issue in future */
> > +	if (flag == F2FS_GET_BLOCK_DIO && map->m_flags & F2FS_MAP_MAPPED) {
> > +		blkaddr = map->m_pblk;
> > +		for (; blkaddr < map->m_pblk + map->m_len; blkaddr++)
> > +			f2fs_wait_on_block_writeback(sbi, blkaddr);
> > +	}
> >  	if (flag == F2FS_GET_BLOCK_PRECACHE) {
> >  		if (map->m_flags & F2FS_MAP_MAPPED) {
> >  			unsigned int ofs = start_pgofs - map->m_lblk;
> > -- 
> > Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
