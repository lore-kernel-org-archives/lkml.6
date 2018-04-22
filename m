Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeDVDsd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 23:48:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:24682 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeDVDsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 23:48:32 -0400
To: rientjes@google.com, mhocko@kernel.org
Cc: akpm@linux-foundation.org, aarcange@redhat.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaperunmap
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180419063556.GK17484@dhcp22.suse.cz>
        <alpine.DEB.2.21.1804191214130.157851@chino.kir.corp.google.com>
        <20180420082349.GW17484@dhcp22.suse.cz>
        <20180420124044.GA17484@dhcp22.suse.cz>
        <alpine.DEB.2.21.1804212019400.84222@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1804212019400.84222@chino.kir.corp.google.com>
Message-Id: <201804221248.CHE35432.FtOMOLSHOFJFVQ@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Sun, 22 Apr 2018 12:48:13 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> How have you tested this?
> 
> I'm wondering why you do not see oom killing of many processes if the 
> victim is a very large process that takes a long time to free memory in 
> exit_mmap() as I do because the oom reaper gives up trying to acquire 
> mm->mmap_sem and just sets MMF_OOM_SKIP itself.
> 

We can call __oom_reap_task_mm() from exit_mmap() (or __mmput()) before
exit_mmap() holds mmap_sem for write. Then, at least memory which could
have been reclaimed if exit_mmap() did not hold mmap_sem for write will
be guaranteed to be reclaimed before MMF_OOM_SKIP is set.
