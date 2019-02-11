Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3150C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E5B2229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfBKRcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:32:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:41784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727393AbfBKRck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:32:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92D67AF7A;
        Mon, 11 Feb 2019 17:32:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 34B831E09A8; Mon, 11 Feb 2019 18:32:39 +0100 (CET)
Date:   Mon, 11 Feb 2019 18:32:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: Re: [PATCH] udf: disallow RW mount without valid integrity descriptor
Message-ID: <20190211173239.GL19029@quack2.suse.cz>
References: <20190211142438.16599-1-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211142438.16599-1-steve@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-02-19 08:24:38, Steve Magnani wrote:
> Refuse to mount a volume read-write without a coherent Logical Volume
> Integrity Descriptor, because we can't generate truly unique IDs without 
> one.
> 
> This fixes a bug where all inodes created on a UDF filesystem following
> mount without a coherent LVID are assigned UID 0.
> 
> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

Thanks. Added to my tree.

								Honza

> ---
> --- a/fs/udf/super.c	2018-11-16 06:43:00.622344354 -0600
> +++ b/fs/udf/super.c	2019-02-11 08:08:00.478331631 -0600
> @@ -1474,6 +1474,17 @@ static int udf_load_logicalvol(struct su
>  	if (lvd->integritySeqExt.extLength)
>  		udf_load_logicalvolint(sb, leea_to_cpu(lvd->integritySeqExt));
>  	ret = 0;
> +
> +	if (!sbi->s_lvid_bh) {
> +		/* We can't generate UIDs without a valid LVID */
> +		if (sb_rdonly(sb))
> +			UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
> +		else {
> +			udf_warn(sb, "Damaged or missing LVID, forcing "
> +				     "readonly mount\n");
> +			ret = -EACCES;
> +		}
> +	}
>  out_bh:
>  	brelse(bh);
>  	return ret;
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
