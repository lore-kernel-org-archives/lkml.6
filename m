Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E8EC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5DF2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfAUQXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:23:41 -0500
Received: from verein.lst.de ([213.95.11.211]:59452 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728754AbfAUQXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:23:40 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CED4A68DD6; Mon, 21 Jan 2019 17:23:38 +0100 (CET)
Date:   Mon, 21 Jan 2019 17:23:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH v1] fs/jfs: Switch to use new generic UUID API
Message-ID: <20190121162338.GA29537@lst.de>
References: <20190110134153.83901-1-andriy.shevchenko@linux.intel.com> <20190121084950.GG18680@lst.de> <6ccf3581-71b8-6502-5050-643006423a63@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ccf3581-71b8-6502-5050-643006423a63@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:19:15AM -0600, Dave Kleikamp wrote:
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 65d8fc87ab11..c15ff56a8516 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -174,9 +174,11 @@ static int jfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_files = maxinodes;
>  	buf->f_ffree = maxinodes - (atomic_read(&imap->im_numinos) -
>  				    atomic_read(&imap->im_numfree));
> -	buf->f_fsid.val[0] = (u32)crc32_le(0, sbi->uuid, sizeof(sbi->uuid)/2);
> -	buf->f_fsid.val[1] = (u32)crc32_le(0, sbi->uuid + sizeof(sbi->uuid)/2,
> -					sizeof(sbi->uuid)/2);
> +	buf->f_fsid.val[0] = crc32_le(0, (char *)&sbi->uuid,
> +				      sizeof(sbi->uuid)/2);
> +	buf->f_fsid.val[1] = crc32_le(0,
> +				      (char *)&sbi->uuid + sizeof(sbi->uuid)/2,
> +				      sizeof(sbi->uuid)/2);

I'd really love to see a little helper to calculate the fsid, and
a comment on that function documenting the design decision behind it.
