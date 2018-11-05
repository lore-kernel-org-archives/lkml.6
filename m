Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3678ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3352086B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3352086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeKESTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:19:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:51294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbeKESTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:19:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC9F0ACE7;
        Mon,  5 Nov 2018 09:01:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 29D5C1E07AB; Mon,  5 Nov 2018 10:01:14 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:01:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Wang Long <wanglong19@meituan.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <dchinner@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] mm: fix uninitialized variable warnings
Message-ID: <20181105090114.GD6953@quack2.suse.cz>
References: <20181102153138.1399758-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102153138.1399758-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-11-18 16:31:06, Arnd Bergmann wrote:
> In a rare randconfig build, I got a warning about possibly uninitialized
> variables:
> 
> mm/page-writeback.c: In function 'balance_dirty_pages':
> mm/page-writeback.c:1623:16: error: 'writeback' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     mdtc->dirty += writeback;
>                 ^~
> mm/page-writeback.c:1624:4: error: 'filepages' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     mdtc_calc_avail(mdtc, filepages, headroom);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/page-writeback.c:1624:4: error: 'headroom' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> The compiler evidently fails to notice that the usage is in dead code
> after 'mdtc' is set to NULL when CONFIG_CGROUP_WRITEBACK is disabled.
> Adding an IS_ENABLED() check makes this clear to the compiler.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'm surprised the compiler was not able to infer this since:

struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
                                                     &mdtc_stor : NULL;

and if CONFIG_CGROUP_WRITEBACK is disabled, mdtc_valid() is defined to
'false'.  But possibly the function is just too big and the problematic
condition is in the loop so maybe it all confuses the compiler too much.

> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 3f690bae6b78..f02535b7731a 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1611,7 +1611,7 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
>  			bg_thresh = gdtc->bg_thresh;
>  		}
>  
> -		if (mdtc) {
> +		if (IS_ENABLED(CONFIG_CGROUP_WRITEBACK) && mdtc) {
>  			unsigned long filepages, headroom, writeback;

Honestly, I don't like the IS_ENABLED(CONFIG_CGROUP_WRITEBACK) check here.
It just looks too arbitrary. Could we perhaps change the code like

struct dirty_throttle_control * const mdtc = &mdtc_stor;

And then replace checks for !mtdc in the function to !mdtc_valid(mdtc)?
That is the same thing as currently and it should make it obvious to the
compiler as well as human what is going on... Tejun?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
