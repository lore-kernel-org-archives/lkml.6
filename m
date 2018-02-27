Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeB0Brv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 20:47:51 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:46451 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeB0Bru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 20:47:50 -0500
X-Google-Smtp-Source: AG47ELtQUe5w4q9y/svW7rzdgRAGaR0W5xa5B/JUfED8oGZhUnNwBWT8oKRYJ2GUsg4AroOrH1G2MA==
Date: Mon, 26 Feb 2018 17:47:47 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Yang Shi <yang.shi@linux.alibaba.com>
cc: akpm@linux-foundation.org, mingo@kernel.org, adobriyan@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4 v2] Define killable version for access_remote_vm()
 and use it in fs/proc
In-Reply-To: <4ec32e5b-af63-f412-2213-e52bdbcc9585@linux.alibaba.com>
Message-ID: <alpine.DEB.2.20.1802261742400.24072@chino.kir.corp.google.com>
References: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com> <alpine.DEB.2.20.1802261656490.16999@chino.kir.corp.google.com> <4ec32e5b-af63-f412-2213-e52bdbcc9585@linux.alibaba.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Yang Shi wrote:

> > Rather than killable, we have patches that introduce down_read_unfair()
> > variants for the files you've modified (cmdline and environ) as well as
> > others (maps, numa_maps, smaps).
> 
> You mean you have such functionality used by google internally?
> 

Yup, see https://lwn.net/Articles/387720.

> > When another thread is holding down_read() and there are queued
> > down_write()'s, down_read_unfair() allows for grabbing the rwsem without
> > queueing for it.  Additionally, when another thread is holding
> > down_write(), down_read_unfair() allows for queueing in front of other
> > threads trying to grab it for write as well.
> 
> It sounds the __unfair variant make the caller have chance to jump the gun to
> grab the semaphore before other waiters, right? But when a process holds the
> semaphore, i.e. mmap_sem, for a long time, it still has to sleep in
> uninterruptible state, right?
> 

Right, it's solving two separate things which I think may be able to be 
merged together.  Killable is solving an issue where the rwsem is blocking 
for a long period of time in uninterruptible sleep, and unfair is solving 
an issue where reading the procfs files gets stalled for a long period of 
time.  We haven't run into an issue (yet) where killable would have solved 
it; we just have the unfair variants to grab the rwsem asap and then, if 
killable, gracefully return.

> > Ingo would know more about whether a variant like that in upstream Linux
> > would be acceptable.
> > 
> > Would you be interested in unfair variants instead of only addressing
> > killable?
> 
> Yes, I'm although it still looks overkilling to me for reading /proc.
> 

We make certain inferences on the readablility of procfs files for other 
threads to determine how much its mm's mmap_sem is contended.
