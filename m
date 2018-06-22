Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36BFC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75C02249A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75C02249A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeFVHlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:41:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:48678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeFVHlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:41:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E215BAE8C;
        Fri, 22 Jun 2018 07:41:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7EC191E34BE; Fri, 22 Jun 2018 09:41:42 +0200 (CEST)
Date:   Fri, 22 Jun 2018 09:41:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, y2038@lists.linaro.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] jbd2: replace current_kernel_time64 with ktime
 equivalent
Message-ID: <20180622074142.kjs6sozf3it42wef@quack2.suse.cz>
References: <20180620153322.54221-1-arnd@arndb.de>
 <20180620153322.54221-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620153322.54221-5-arnd@arndb.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-06-18 17:33:02, Arnd Bergmann wrote:
> jbd2 is one of the few callers of current_kernel_time64(), which
> is a wrapper around ktime_get_coarse_real_ts64(). This calls the
> latter directly for consistency with the rest of the kernel that
> is moving to the ktime_get_ family of time accessors.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 8de0e7723316..150cc030b4d7 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -121,7 +121,7 @@ static int journal_submit_commit_record(journal_t *journal,
>  	struct commit_header *tmp;
>  	struct buffer_head *bh;
>  	int ret;
> -	struct timespec64 now = current_kernel_time64();
> +	struct timespec64 now;
>  
>  	*cbh = NULL;
>  
> @@ -134,6 +134,7 @@ static int journal_submit_commit_record(journal_t *journal,
>  		return 1;
>  
>  	tmp = (struct commit_header *)bh->b_data;
> +	ktime_get_coarse_real_ts64(&now);
>  	tmp->h_commit_sec = cpu_to_be64(now.tv_sec);
>  	tmp->h_commit_nsec = cpu_to_be32(now.tv_nsec);
>  
> -- 
> 2.9.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
