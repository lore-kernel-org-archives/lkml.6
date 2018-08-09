Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28E1C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B79621B31
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B79621B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeHIJhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:37:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:44262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728056AbeHIJhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:37:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87CACAEC0;
        Thu,  9 Aug 2018 07:14:21 +0000 (UTC)
Date:   Thu, 9 Aug 2018 09:14:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC v2 02/10] mm: Make shrink_slab() lockless
Message-ID: <20180809071418.GA24884@dhcp22.suse.cz>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365626605.19074.16202958374930777592.stgit@localhost.localdomain>
 <591d2063-0511-103d-bef6-dd35f55afe32@virtuozzo.com>
 <4ceb948c-7ce7-0db3-17d8-82ef1e6e47cc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ceb948c-7ce7-0db3-17d8-82ef1e6e47cc@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-08-18 16:20:54, Kirill Tkhai wrote:
> [Added two more places needed srcu_dereference(). All ->shrinker_map
>  dereferences must be under SRCU, and this v2 adds missed in previous]
> 
> The patch makes shrinker list and shrinker_idr SRCU-safe
> for readers. This requires synchronize_srcu() on finalize
> stage unregistering stage, which waits till all parallel
> shrink_slab() are finished
> 
> Note, that patch removes rwsem_is_contended() checks from
> the code, and this does not result in delays during
> registration, since there is no waiting at all. Unregistration
> case may be optimized by splitting unregister_shrinker()
> in tho stages, and this is made in next patches.
>     
> Also, keep in mind, that in case of SRCU is not allowed
> to make unconditional (which is done in previous patch),
> it is possible to use percpu_rw_semaphore instead of it.
> percpu_down_read() will be used in shrink_slab_memcg()
> and in shrink_slab(), and consecutive calls
> 
>         percpu_down_write(percpu_rwsem);
>         percpu_up_write(percpu_rwsem);
> 
> will be used instead of synchronize_srcu().

An obvious question. Why didn't you go that way? What are pros/cons of
both approaches?
-- 
Michal Hocko
SUSE Labs
