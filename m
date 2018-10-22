Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36635C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0820F20853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0820F20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeJVTBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:01:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:53006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbeJVTBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:01:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEEFBAE86;
        Mon, 22 Oct 2018 10:43:41 +0000 (UTC)
Date:   Mon, 22 Oct 2018 12:43:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] mm, oom: marks all killed tasks as oom victims
Message-ID: <20181022104341.GY18839@dhcp22.suse.cz>
References: <20181022071323.9550-1-mhocko@kernel.org>
 <20181022071323.9550-2-mhocko@kernel.org>
 <201810220758.w9M7wojE016890@www262.sakura.ne.jp>
 <20181022084842.GW18839@dhcp22.suse.cz>
 <f5b257f9-47a5-e071-02fa-ce901bd34b04@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b257f9-47a5-e071-02fa-ce901bd34b04@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-10-18 18:42:30, Tetsuo Handa wrote:
> On 2018/10/22 17:48, Michal Hocko wrote:
> > On Mon 22-10-18 16:58:50, Tetsuo Handa wrote:
> >> Michal Hocko wrote:
> >>> --- a/mm/oom_kill.c
> >>> +++ b/mm/oom_kill.c
> >>> @@ -898,6 +898,7 @@ static void __oom_kill_process(struct task_struct *victim)
> >>>  		if (unlikely(p->flags & PF_KTHREAD))
> >>>  			continue;
> >>>  		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
> >>> +		mark_oom_victim(p);
> >>>  	}
> >>>  	rcu_read_unlock();
> >>>  
> >>> -- 
> >>
> >> Wrong. Either
> > 
> > You are right. The mm might go away between process_shares_mm and here.
> > While your find_lock_task_mm would be correct I believe we can do better
> > by using the existing mm that we already have. I will make it a separate
> > patch to clarity.
> 
> Still wrong. p->mm == NULL means that we are too late to set TIF_MEMDIE
> on that thread. Passing non-NULL mm to mark_oom_victim() won't help.

Why would it be too late? Or in other words why would this be harmful?
-- 
Michal Hocko
SUSE Labs
