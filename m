Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082EAC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15CC27B77
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15CC27B77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753607AbeF2HVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:21:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751679AbeF2HVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:21:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6BFBBAE1F;
        Fri, 29 Jun 2018 07:21:33 +0000 (UTC)
Date:   Fri, 29 Jun 2018 09:21:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg Thelen <gthelen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg, oom: move out_of_memory back to the charge path
Message-ID: <20180629072132.GA13860@dhcp22.suse.cz>
References: <20180628151101.25307-1-mhocko@kernel.org>
 <xr93in62jy8k.fsf@gthelen.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xr93in62jy8k.fsf@gthelen.svl.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-06-18 16:19:07, Greg Thelen wrote:
> Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > +	if (mem_cgroup_out_of_memory(memcg, mask, order))
> > +		return OOM_SUCCESS;
> > +
> > +	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
> > +		"This looks like a misconfiguration or a kernel bug.");
> 
> I'm not sure here if the warning should here or so strongly worded.  It
> seems like the current task could be oom reaped with MMF_OOM_SKIP and
> thus mem_cgroup_out_of_memory() will return false.  So there's nothing
> alarming in that case.

If the task is reaped then its charges should be released as well and
that means that we should get below the limit. Sure there is some room
for races but this should be still unlikely. Maybe I am just
underestimating though.

What would you suggest instead?
-- 
Michal Hocko
SUSE Labs
