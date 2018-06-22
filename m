Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBC3C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F0A23E45
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F0A23E45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeFVHiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:38:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:48521 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeFVHiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:38:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DB5FCAE8C;
        Fri, 22 Jun 2018 07:38:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8D37C1E34BE; Fri, 22 Jun 2018 09:38:21 +0200 (CEST)
Date:   Fri, 22 Jun 2018 09:38:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, y2038@lists.linaro.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] ext4: use 64-bit timestamps for mmp_time
Message-ID: <20180622073821.vmom4rvvxzrhd3se@quack2.suse.cz>
References: <20180620153322.54221-1-arnd@arndb.de>
 <20180620153322.54221-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620153322.54221-2-arnd@arndb.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-06-18 17:32:59, Arnd Bergmann wrote:
> The mmp_time field is 64 bits wide, which is good, but calling
> get_seconds() results in a 32-bit value on 32-bit architectures. Using
> ktime_get_real_seconds() instead returns 64 bits everywhere.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good.

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mmp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 27b9a76a0dfa..39da4eb48361 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -147,7 +147,7 @@ static int kmmpd(void *data)
>  
>  	mmp_block = le64_to_cpu(es->s_mmp_block);
>  	mmp = (struct mmp_struct *)(bh->b_data);
> -	mmp->mmp_time = cpu_to_le64(get_seconds());
> +	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
>  	/*
>  	 * Start with the higher mmp_check_interval and reduce it if
>  	 * the MMP block is being updated on time.
> @@ -165,7 +165,7 @@ static int kmmpd(void *data)
>  			seq = 1;
>  
>  		mmp->mmp_seq = cpu_to_le32(seq);
> -		mmp->mmp_time = cpu_to_le64(get_seconds());
> +		mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
>  		last_update_time = jiffies;
>  
>  		retval = write_mmp_block(sb, bh);
> @@ -244,7 +244,7 @@ static int kmmpd(void *data)
>  	 * Unmount seems to be clean.
>  	 */
>  	mmp->mmp_seq = cpu_to_le32(EXT4_MMP_SEQ_CLEAN);
> -	mmp->mmp_time = cpu_to_le64(get_seconds());
> +	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
>  
>  	retval = write_mmp_block(sb, bh);
>  
> -- 
> 2.9.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
