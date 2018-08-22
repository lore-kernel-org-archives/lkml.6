Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA8BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790522147A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790522147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeHVTeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:34:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:33952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbeHVTeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:34:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA206AF79;
        Wed, 22 Aug 2018 16:08:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 958C71E361C; Wed, 22 Aug 2018 18:08:32 +0200 (CEST)
Date:   Wed, 22 Aug 2018 18:08:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/quota: Fix spectre gadget in do_quotactl
Message-ID: <20180822160832.GF23037@quack2.suse.cz>
References: <20180731013731.1987-1-jcline@redhat.com>
 <20180731013731.1987-3-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731013731.1987-3-jcline@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-07-18 01:37:31, Jeremy Cline wrote:
> 'type' is user-controlled, so sanitize it after the bounds check to
> avoid using it in speculative execution. This covers the following
> potential gadgets detected with the help of smatch:
> 
> * fs/ext4/super.c:5741 ext4_quota_read() warn: potential spectre issue
>   'sb_dqopt(sb)->files' [r]
> * fs/ext4/super.c:5778 ext4_quota_write() warn: potential spectre issue
>   'sb_dqopt(sb)->files' [r]
> * fs/f2fs/super.c:1552 f2fs_quota_read() warn: potential spectre issue
>   'sb_dqopt(sb)->files' [r]
> * fs/f2fs/super.c:1608 f2fs_quota_write() warn: potential spectre issue
>   'sb_dqopt(sb)->files' [r]
> * fs/quota/dquot.c:412 mark_info_dirty() warn: potential spectre issue
>   'sb_dqopt(sb)->info' [w]
> * fs/quota/dquot.c:933 dqinit_needed() warn: potential spectre issue
>   'dquots' [r]
> * fs/quota/dquot.c:2112 dquot_commit_info() warn: potential spectre
>   issue 'dqopt->ops' [r]
> * fs/quota/dquot.c:2362 vfs_load_quota_inode() warn: potential spectre
>   issue 'dqopt->files' [w] (local cap)
> * fs/quota/dquot.c:2369 vfs_load_quota_inode() warn: potential spectre
>   issue 'dqopt->ops' [w] (local cap)
> * fs/quota/dquot.c:2370 vfs_load_quota_inode() warn: potential spectre
>   issue 'dqopt->info' [w] (local cap)
> * fs/quota/quota.c:110 quota_getfmt() warn: potential spectre issue
>   'sb_dqopt(sb)->info' [r]
> * fs/quota/quota_v2.c:84 v2_check_quota_file() warn: potential spectre
>   issue 'quota_magics' [w]
> * fs/quota/quota_v2.c:85 v2_check_quota_file() warn: potential spectre
>   issue 'quota_versions' [w]
> * fs/quota/quota_v2.c:96 v2_read_file_info() warn: potential spectre
>   issue 'dqopt->info' [r]
> * fs/quota/quota_v2.c:172 v2_write_file_info() warn: potential spectre
>   issue 'dqopt->info' [r]
> 
> Additionally, a quick inspection indicates there are array accesses with
> 'type' in quota_on() and quota_off() functions which are also addressed
> by this.
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

OK, this looks good. I'll take both patches through my tree (I'll fixup the
first patch myself).

									Honza

> ---
> 
> This patch isn't going to cleanly apply to stable without the "fs/quota:
> Replace XQM_MAXQUOTAS usage with MAXQUOTAS" patch, but I'm not sure that
> patch is really stable material and XQM_MAXQUOTAS has been 3 since
> pre-v4.4 so the end result will be the same even if that patch isn't
> backported.
> 
>  fs/quota/quota.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index d403392d8a0f..f0cbf58ad4da 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -18,6 +18,7 @@
>  #include <linux/quotaops.h>
>  #include <linux/types.h>
>  #include <linux/writeback.h>
> +#include <linux/nospec.h>
>  
>  static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
>  				     qid_t id)
> @@ -701,6 +702,7 @@ static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id,
>  
>  	if (type >= MAXQUOTAS)
>  		return -EINVAL;
> +	type = array_index_nospec(type, MAXQUOTAS);
>  	/*
>  	 * Quota not supported on this fs? Check this before s_quota_types
>  	 * since they needn't be set if quota is not supported at all.
> -- 
> 2.17.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
