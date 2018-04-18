Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752998AbeDRELj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 00:11:39 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36508 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDRELi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 00:11:38 -0400
X-Google-Smtp-Source: AIpwx4/uYBZWQVpR2bzMUJ+o87fW5fXuTLyia/0Bzt0eOnafPez6YDQdA/YnYdT0BHF/2QY1nBmZdw==
Date: Tue, 17 Apr 2018 21:11:36 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Andrea Arcangeli <aarcange@redhat.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper
 unmap
In-Reply-To: <201804180355.w3I3tM6T001187@www262.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1804172103050.113086@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com> <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com> <201804180355.w3I3tM6T001187@www262.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018, Tetsuo Handa wrote:

> > Fix this by reusing MMF_UNSTABLE to specify that an mm should not be
> > reaped.  This prevents the concurrent munlock_vma_pages_range() and
> > unmap_page_range().  The oom reaper will simply not operate on an mm that
> > has the bit set and leave the unmapping to exit_mmap().
> 
> This change assumes that munlock_vma_pages_all()/unmap_vmas()/free_pgtables()
> are never blocked for memory allocation. Is that guaranteed? For example,
> i_mmap_lock_write() from unmap_single_vma() from unmap_vmas() is never blocked
> for memory allocation? Commit 97b1255cb27c551d ("mm,oom_reaper: check for
> MMF_OOM_SKIP before complaining") was waiting for i_mmap_lock_write() from
> unlink_file_vma() from free_pgtables(). Is it really guaranteed that somebody
> else who is holding that lock is never waiting for memory allocation?
> 

Commit 97b1255cb27c is referencing MMF_OOM_SKIP already being set by 
exit_mmap().  The only thing this patch changes is where that is done: 
before or after free_pgtables().  We can certainly move it to before 
free_pgtables() at the risk of subsequent (and eventually unnecessary) oom 
kills.  It's not exactly the point of this patch.

I have thousands of real-world examples where additional processes were 
oom killed while the original victim was in free_pgtables().  That's why 
we've moved the MMF_OOM_SKIP to after free_pgtables().  I'm not sure how 
likely your scenario is in the real world, but if it poses a problem then 
I believe it should be fixed by eventually deferring previous victims as a 
change to oom_evaluate_task(), not exit_mmap().  If you'd like me to fix 
that, please send along your test case that triggers it and I will send a 
patch.
