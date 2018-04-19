Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeDSKqF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:46:05 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:10339 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeDSKqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:46:03 -0400
To: mhocko@kernel.org, rientjes@google.com
Cc: akpm@linux-foundation.org, aarcange@redhat.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper unmap
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com>
        <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
        <20180418075051.GO17484@dhcp22.suse.cz>
        <alpine.DEB.2.21.1804181159020.227784@chino.kir.corp.google.com>
        <20180419063556.GK17484@dhcp22.suse.cz>
In-Reply-To: <20180419063556.GK17484@dhcp22.suse.cz>
Message-Id: <201804191945.BBF87517.FVMLOQFOHSFJOt@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Thu, 19 Apr 2018 19:45:46 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko wrote:
> > exit_mmap() does not block before set_bit(MMF_OOM_SKIP) once it is 
> > entered.
> 
> Not true. munlock_vma_pages_all might take page_lock which can have
> unpredictable dependences. This is the reason why we are ruling out
> mlocked VMAs in the first place when reaping the address space.

Wow! Then,

> While you are correct, strictly speaking, because unmap_vmas can race
> with the oom reaper. With the lock held during the whole operation we
> can indeed trigger back off in the oom_repaer. It will keep retrying but
> the tear down can take quite some time. This is a fair argument. On the
> other hand your lock protocol introduces the MMF_OOM_SKIP problem I've
> mentioned above and that really worries me. The primary objective of the
> reaper is to guarantee a forward progress without relying on any
> externalities. We might kill another OOM victim but that is safer than
> lock up.

current code has a possibility that the OOM reaper is disturbed by
unpredictable dependencies, like I worried that

  I think that there is a possibility that the OOM reaper tries to reclaim
  mlocked pages as soon as exit_mmap() cleared VM_LOCKED flag by calling
  munlock_vma_pages_all().

when current approach was proposed. We currently have the MMF_OOM_SKIP problem.
We need to teach the OOM reaper stop reaping as soon as entering exit_mmap().
Maybe let the OOM reaper poll for progress (e.g. none of get_mm_counter(mm, *)
decreased for last 1 second) ?
