Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0361CECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05B420868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05B420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeJ0ELY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:11:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725749AbeJ0ELY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:11:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9ABBDB074;
        Fri, 26 Oct 2018 19:33:05 +0000 (UTC)
Date:   Fri, 26 Oct 2018 21:33:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
Message-ID: <20181026193304.GD18839@dhcp22.suse.cz>
References: <20181022071323.9550-1-mhocko@kernel.org>
 <20181022071323.9550-3-mhocko@kernel.org>
 <20181026142531.GA27370@cmpxchg.org>
 <20181026192551.GC18839@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026192551.GC18839@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-10-18 21:25:51, Michal Hocko wrote:
> On Fri 26-10-18 10:25:31, Johannes Weiner wrote:
[...]
> > There is of course the scenario brought forward in this thread, where
> > multiple threads of a process race and the second one enters oom even
> > though it doesn't need to anymore. What the global case does to catch
> > this is to grab the oom lock and do one last alloc attempt. Should
> > memcg lock the oom_lock and try one more time to charge the memcg?
> 
> That would be another option. I agree that making it more towards the
> global case makes it more attractive. My tsk_is_oom_victim is more
> towards "plug this particular case".

Nevertheless let me emphasise that tsk_is_oom_victim will close the race
completely, while mem_cgroup_margin will always be racy. So the question
is whether we want to close the race because it is just too easy for
userspace to hit it or keep the global and memcg oom handling as close
as possible.
-- 
Michal Hocko
SUSE Labs
