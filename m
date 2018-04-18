Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753719AbeDRDzk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 23:55:40 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:11634 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752800AbeDRDzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 23:55:39 -0400
Message-Id: <201804180355.w3I3tM6T001187@www262.sakura.ne.jp>
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper unmap
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Andrea Arcangeli <aarcange@redhat.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
MIME-Version: 1.0
Date: Wed, 18 Apr 2018 12:55:22 +0900
References: <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com> <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> Fix this by reusing MMF_UNSTABLE to specify that an mm should not be
> reaped.  This prevents the concurrent munlock_vma_pages_range() and
> unmap_page_range().  The oom reaper will simply not operate on an mm that
> has the bit set and leave the unmapping to exit_mmap().

This change assumes that munlock_vma_pages_all()/unmap_vmas()/free_pgtables()
are never blocked for memory allocation. Is that guaranteed? For example,
i_mmap_lock_write() from unmap_single_vma() from unmap_vmas() is never blocked
for memory allocation? Commit 97b1255cb27c551d ("mm,oom_reaper: check for
MMF_OOM_SKIP before complaining") was waiting for i_mmap_lock_write() from
unlink_file_vma() from free_pgtables(). Is it really guaranteed that somebody
else who is holding that lock is never waiting for memory allocation?
