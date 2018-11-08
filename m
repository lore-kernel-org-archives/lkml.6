Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A38C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA02F2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA02F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeKHTHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:07:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:52396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbeKHTHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:07:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F371AFFB;
        Thu,  8 Nov 2018 09:32:25 +0000 (UTC)
Date:   Thu, 8 Nov 2018 10:32:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/3] oom: rework oom_reaper vs. exit_mmap handoff
Message-ID: <20181108093224.GS27423@dhcp22.suse.cz>
References: <20181025082403.3806-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025082403.3806-1-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-10-18 10:24:00, Michal Hocko wrote:
> The previous version of this RFC has been posted here [1]. I have fixed
> few issues spotted during the review and by 0day bot. I have also reworked
> patch 2 to be ratio rather than an absolute number based.
> 
> With this series applied the locking protocol between the oom_reaper and
> the exit path is as follows.
> 
> All parts which cannot race should use the exclusive lock on the exit
> path. Once the exit path has passed the moment when no blocking locks
> are taken then it clears mm->mmap under the exclusive lock. oom_reaper
> checks for this and sets MMF_OOM_SKIP only if the exit path is not guaranteed
> to finish the job. This is patch 3 so see the changelog for all the details.
> 
> I would really appreciate if David could give this a try and see how
> this behaves in workloads where the oom_reaper falls flat now. I have
> been playing with sparsely allocated memory with a high pte/real memory
> ratio and large mlocked processes and it worked reasonably well.

Does this help workloads you were referring to earlier David?

> There is still some room for tuning here of course. We can change the
> number of retries for the oom_reaper as well as the threshold when the
> keep retrying.
> 
> Michal Hocko (3):
>       mm, oom: rework mmap_exit vs. oom_reaper synchronization
>       mm, oom: keep retrying the oom_reap operation as long as there is substantial memory left
>       mm, oom: hand over MMF_OOM_SKIP to exit path if it is guranteed to finish
> 
> Diffstat:
>  include/linux/oom.h |  2 --
>  mm/internal.h       |  3 +++
>  mm/memory.c         | 28 ++++++++++++++--------
>  mm/mmap.c           | 69 +++++++++++++++++++++++++++++++++--------------------
>  mm/oom_kill.c       | 45 ++++++++++++++++++++++++----------
>  5 files changed, 97 insertions(+), 50 deletions(-)
> 
> [1] http://lkml.kernel.org/r/20180910125513.311-1-mhocko@kernel.org
> 

-- 
Michal Hocko
SUSE Labs
