Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeDVNIl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 09:08:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeDVNIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 09:08:40 -0400
Date: Sun, 22 Apr 2018 07:08:36 -0600
From: Michal Hocko <mhocko@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: rientjes@google.com, akpm@linux-foundation.org, aarcange@redhat.com,
        guro@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaperunmap
Message-ID: <20180422130836.GH17484@dhcp22.suse.cz>
References: <20180419063556.GK17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804191214130.157851@chino.kir.corp.google.com>
 <20180420082349.GW17484@dhcp22.suse.cz>
 <20180420124044.GA17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804212019400.84222@chino.kir.corp.google.com>
 <201804221248.CHE35432.FtOMOLSHOFJFVQ@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804221248.CHE35432.FtOMOLSHOFJFVQ@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 22-04-18 12:48:13, Tetsuo Handa wrote:
> David Rientjes wrote:
> > How have you tested this?
> > 
> > I'm wondering why you do not see oom killing of many processes if the 
> > victim is a very large process that takes a long time to free memory in 
> > exit_mmap() as I do because the oom reaper gives up trying to acquire 
> > mm->mmap_sem and just sets MMF_OOM_SKIP itself.
> > 
> 
> We can call __oom_reap_task_mm() from exit_mmap() (or __mmput()) before
> exit_mmap() holds mmap_sem for write. Then, at least memory which could
> have been reclaimed if exit_mmap() did not hold mmap_sem for write will
> be guaranteed to be reclaimed before MMF_OOM_SKIP is set.

That might be an alternative way but I am really wondering whether this
is the simplest way forward.

-- 
Michal Hocko
SUSE Labs
