Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F8DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD4A23F4E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD4A23F4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeFVJBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:01:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:54522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeFVJBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:01:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B7231AF9C;
        Fri, 22 Jun 2018 09:01:51 +0000 (UTC)
Date:   Fri, 22 Jun 2018 11:01:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
Message-ID: <20180622090151.GS10465@dhcp22.suse.cz>
References: <20180614073153.GB9371@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806141424510.30404@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615073201.GB24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806150724260.15022@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615115547.GH24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806150832100.26650@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615130925.GI24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806181003560.4201@file01.intranet.prod.int.rdu2.redhat.com>
 <20180619104312.GD13685@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806191228110.25656@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1806191228110.25656@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-06-18 21:17:24, Mikulas Patocka wrote:
[...]
> > But seriously, isn't the best way around the throttling issue to use
> > PF_LESS_THROTTLE?
> 
> Yes - it could be done by setting PF_LESS_THROTTLE. But I think it would 
> be better to change it just in one place than to add PF_LESS_THROTTLE to 
> every block device driver (because adding it to every block driver results 
> in more code).

Why would every block device need this? I thought we were talking about
mempool allocator and the md variant of it. They are explicitly doing
their own back off so PF_LESS_THROTTLE sounds appropriate to me.

> What about this patch? If __GFP_NORETRY and __GFP_FS is not set (i.e. the 
> request comes from a block device driver or a filesystem), we should not 
> sleep.

Why? How are you going to audit all the callers that the behavior makes
sense and moreover how are you going to ensure that future usage will
still make sense. The more subtle side effects gfp flags have the harder
they are to maintain.

> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> Index: linux-2.6/mm/vmscan.c
> ===================================================================
> --- linux-2.6.orig/mm/vmscan.c
> +++ linux-2.6/mm/vmscan.c
> @@ -2674,6 +2674,7 @@ static bool shrink_node(pg_data_t *pgdat
>  		 * the LRU too quickly.
>  		 */
>  		if (!sc->hibernation_mode && !current_is_kswapd() &&
> +		   (sc->gfp_mask & (__GFP_NORETRY | __GFP_FS)) != __GFP_NORETRY &&
>  		   current_may_throttle() && pgdat_memcg_congested(pgdat, root))
>  			wait_iff_congested(BLK_RW_ASYNC, HZ/10);
>  

-- 
Michal Hocko
SUSE Labs
