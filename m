Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753788AbeDRO2T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:28:19 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:24141 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeDRO2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:28:18 -0400
To: mhocko@kernel.org
Cc: rientjes@google.com, akpm@linux-foundation.org, aarcange@redhat.com,
        guro@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper unmap
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180418075051.GO17484@dhcp22.suse.cz>
        <201804182049.EDJ21857.OHJOMOLFQVFFtS@I-love.SAKURA.ne.jp>
        <20180418115830.GA17484@dhcp22.suse.cz>
        <201804182225.EII57887.OLMHOFVtQSFJOF@I-love.SAKURA.ne.jp>
        <20180418134401.GF17484@dhcp22.suse.cz>
In-Reply-To: <20180418134401.GF17484@dhcp22.suse.cz>
Message-Id: <201804182328.HIC57360.QHMFJtOLVFOSFO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Wed, 18 Apr 2018 23:28:01 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko wrote:
> > > > Then, I'm tempted to call __oom_reap_task_mm() before holding mmap_sem for write.
> > > > It would be OK to call __oom_reap_task_mm() at the beginning of __mmput()...
> > > 
> > > I am not sure I understand.
> > 
> > To reduce possibility of __oom_reap_task_mm() giving up reclaim and
> > setting MMF_OOM_SKIP.
> 
> Still do not understand. Do you want to call __oom_reap_task_mm from
> __mmput?

Yes.

>          If yes why would you do so when exit_mmap does a stronger
> version of it?

Because memory which can be reclaimed by the OOM reaper is guaranteed
to be reclaimed before setting MMF_OOM_SKIP when the OOM reaper and
exit_mmap() contended, because the OOM reaper (weak reclaim) sets
MMF_OOM_SKIP after one second for safety in case of exit_mmap()
(strong reclaim) failing to make forward progress.
