Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yml0n9zR"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5767B601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbeFFK6X (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:58:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeFFK6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:58:21 -0400
Date: Wed, 6 Jun 2018 03:58:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
        Martin Sebor <msebor@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] xfs: fix string handling in get/set functions
Message-ID: <20180606105817.GA6575@infradead.org>
References: <20180525151421.2317292-1-arnd@arndb.de>
 <7aad9fc3-ed65-a016-d477-5d830e31cb43@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aad9fc3-ed65-a016-d477-5d830e31cb43@sandeen.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 82f7c83c1dad..596e176c19a6 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1828,13 +1828,13 @@ xfs_ioc_getlabel(
>  	/* Paranoia */
>  	BUILD_BUG_ON(sizeof(sbp->sb_fname) > FSLABEL_MAX);
>  
> +	/* 1 larger than sb_fname, so this ensures a trailing NUL char */
> +	memset(label, 0, sizeof(label));

I don't get the comment.  In fact I don't even get why we need any
comment here.  This is a structure that gets copied to userspace,
and we zero the whole structure, as we should do by default for
anything that goes to userspace.

Otherwise this looks fine to me.
