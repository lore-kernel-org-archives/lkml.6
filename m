Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10941C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99D5208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99D5208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932964AbeFTInq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:43:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:58080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932303AbeFTInn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:43:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A626EAE82;
        Wed, 20 Jun 2018 08:25:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6705F1E0A21; Wed, 20 Jun 2018 10:25:26 +0200 (CEST)
Date:   Wed, 20 Jun 2018 10:25:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        y2038@lists.linaro.org, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] reiserfs: use monotonic time for j_trans_start_time
Message-ID: <20180620082526.xic4dxre3ucpezrb@quack2.suse.cz>
References: <20180619154343.3640484-1-arnd@arndb.de>
 <20180619154343.3640484-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619154343.3640484-2-arnd@arndb.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-06-18 17:43:14, Arnd Bergmann wrote:
> Using CLOCK_REALTIME time_t timestamps breaks on 32-bit systems
> in 2038, and gives surprising results with a concurrent settimeofday().
> 
> This changes the reiserfs journal timestamps to use ktime_get_seconds()
> instead, which makes it use a 64-bit CLOCK_MONOTONIC stamp.
> 
> In the procfs output, the monotonic timestamp needs to be converted
> back to CLOCK_REALTIME to keep the existing ABI.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
...
> diff --git a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
> index e39b3910d24d..520f9003c13a 100644
> --- a/fs/reiserfs/procfs.c
> +++ b/fs/reiserfs/procfs.c
> @@ -303,6 +303,10 @@ static int show_journal(struct seq_file *m, void *unused)
>  	struct reiserfs_sb_info *r = REISERFS_SB(sb);
>  	struct reiserfs_super_block *rs = r->s_rs;
>  	struct journal_params *jp = &rs->s_v1.s_journal;
> +	ktime_t j_trans_start_ktime = ktime_set(JF(j_trans_start_time), 0);
> +
> +	/* print as CLOCK_REALTIME */
> +	j_trans_start_ktime = ktime_mono_to_real(j_trans_start_ktime);
>  
>  	seq_printf(m,		/* on-disk fields */
>  		   "jp_journal_1st_block: \t%i\n"
> @@ -325,7 +329,7 @@ static int show_journal(struct seq_file *m, void *unused)
>  		   "j_bcount: \t%lu\n"
>  		   "j_first_unflushed_offset: \t%lu\n"
>  		   "j_last_flush_trans_id: \t%u\n"
> -		   "j_trans_start_time: \t%li\n"
> +		   "j_trans_start_time: \t%lli\n"
>  		   "j_list_bitmap_index: \t%i\n"
>  		   "j_must_wait: \t%i\n"
>  		   "j_next_full_flush: \t%i\n"
> @@ -366,7 +370,7 @@ static int show_journal(struct seq_file *m, void *unused)
>  		   JF(j_bcount),
>  		   JF(j_first_unflushed_offset),
>  		   JF(j_last_flush_trans_id),
> -		   JF(j_trans_start_time),
> +		   ktime_divns(j_trans_start_ktime, NSEC_PER_SEC),

Hum, this looks cumbersome - maybe have a helper function converting
MONOTONIC to REALTIME seconds? Regardless the code looks correct and
reiserfs is old enough that I'm happy someone improves anything there so
I'm OK even with the current code. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
