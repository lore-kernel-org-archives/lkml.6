Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6BC20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6BC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbeGSL4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:56:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:57284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726930AbeGSL4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:56:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 706F0ACCF;
        Thu, 19 Jul 2018 11:14:01 +0000 (UTC)
Date:   Thu, 19 Jul 2018 13:14:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, vdavydov.dev@gmail.com,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make flags of unsigned type in struct shrinker
Message-ID: <20180719111400.GY7193@dhcp22.suse.cz>
References: <153199724495.21131.9248876333336922199.stgit@localhost.localdomain>
 <153199748720.21131.6476256940113102483.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153199748720.21131.6476256940113102483.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 13:51:27, Kirill Tkhai wrote:
> Currently, there are two flags only, so unsigned
> is more then enough. Also, move int seeks to keep
> these fields together.

a slightly more explanation _why_ would be really helpful. I suspect
this is to pack the structure better,

struct shrinker {
	long unsigned int          (*count_objects)(struct shrinker *, struct shrink_control *); /*     0     8 */
	long unsigned int          (*scan_objects)(struct shrinker *, struct shrink_control *); /*     8     8 */
	int                        seeks;                /*    16     4 */

	/* XXX 4 bytes hole, try to pack */

	long int                   batch;                /*    24     8 */
	long unsigned int          flags;                /*    32     8 */
	struct list_head           list;                 /*    40    16 */
	atomic_long_t *            nr_deferred;          /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */

	/* size: 64, cachelines: 1, members: 7 */
	/* sum members: 60, holes: 1, sum holes: 4 */
};

suggests so. Which is a good thing.

> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

other than that looks reasonable to me
Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/shrinker.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index d58aaaed34a4..9443cafd1969 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -63,9 +63,9 @@ struct shrinker {
>  	unsigned long (*scan_objects)(struct shrinker *,
>  				      struct shrink_control *sc);
>  
> -	int seeks;	/* seeks to recreate an obj */
>  	long batch;	/* reclaim batch size, 0 = default */
> -	unsigned long flags;
> +	int seeks;	/* seeks to recreate an obj */
> +	unsigned flags;
>  
>  	/* These are for internal use */
>  	struct list_head list;

-- 
Michal Hocko
SUSE Labs
