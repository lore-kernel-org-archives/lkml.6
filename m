Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A81C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B95208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="NQ5WRFGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B95208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754801AbeFTTdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:33:31 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:48630 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754653AbeFTTda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5JdjDvMk5yQ1H5dvBF4jlKKN5fQUxG40qqisxcfxRT0=; b=NQ5WRFGaHOb/vqtt++qEUzLD6P
        bRZx0l/eB2ZAKEAoh5baSeSPJ76CVAT+Rb91vIoKAv/aTTWzxdvJ6VIN+LE8rwG0SLX+jBySYA3+D
        omiDWlWGkzX3qIul/40fCa7/mWhNHrqCvhyBgXS4UGWyI+oyQ5TS14oQBOAMeDFMznhU=;
Date:   Wed, 20 Jun 2018 15:35:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] memcg, oom: move out_of_memory back to the charge
 path
Message-ID: <20180620193549.GA4734@cmpxchg.org>
References: <20180620103736.13880-1-mhocko@kernel.org>
 <20180620151812.GA2441@cmpxchg.org>
 <20180620153148.GO13685@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620153148.GO13685@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 05:31:48PM +0200, Michal Hocko wrote:
> This?
> 	if (order > PAGE_ALLOC_COSTLY_ORDER)
> 		return OOM_SKIPPED;
> 
> 	/*
> 	 * We are in the middle of the charge context here, so we
> 	 * don't want to block when potentially sitting on a callstack
> 	 * that holds all kinds of filesystem and mm locks.
> 	 *
> 	 * cgroup1 allows disabling the OOM killer and waiting for outside
> 	 * handling until the charge can succeed; remember the context and put
> 	 * the task to sleep at the end of the page fault when all locks are
> 	 * released.
> 	 *
> 	 * On the other hand, in-kernel OOM killer allows for an async victim
> 	 * memory reclaim (oom_reaper) and that means that we are not solely
> 	 * relying on the oom victim to make a forward progress and we can
> 	 * invoke the oom killer here.
> 	 *
> 	 * Please note that mem_cgroup_oom_synchronize might fail to find a
> 	 * victim and then we have rely on mem_cgroup_oom_synchronize otherwise
> 	 * we would fall back to the global oom killer in pagefault_out_of_memory
> 	 */
> 	if (memcg->oom_kill_disable) {
> 		if (!current->memcg_may_oom)
> 			return OOM_SKIPPED;
> 		css_get(&memcg->css);
> 		current->memcg_in_oom = memcg;
> 		current->memcg_oom_gfp_mask = mask;
> 		current->memcg_oom_order = order;
> 
> 		return OOM_ASYNC;
> 	}
> 
> 	if (mem_cgroup_out_of_memory(memcg, mask, order))
> 		return OOM_SUCCESS;
> 
> 	WARN(!current->memcg_may_oom,
> 			"Memory cgroup charge failed because of no reclaimable memory! "
> 			"This looks like a misconfiguration or a kernel bug.");
> 	return OOM_FAILED;

Yep, this looks good IMO.
