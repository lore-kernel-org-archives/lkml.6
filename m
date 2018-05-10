Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeEJVtq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:49:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752374AbeEJVtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:49:45 -0400
Date: Thu, 10 May 2018 14:49:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Larry Chen <lchen@suse.com>
Cc: mfasheh@versity.com, jlbec@evilplan.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH] ocfs2: ocfs2_inode_lock_tracker does not distinguish
 lock level
Message-Id: <20180510144944.d0842b82b99a471dbbc745ad@linux-foundation.org>
In-Reply-To: <20180510053230.17217-1-lchen@suse.com>
References: <20180510053230.17217-1-lchen@suse.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018 13:32:30 +0800 Larry Chen <lchen@suse.com> wrote:

> ocfs2_inode_lock_tracker as a variant of ocfs2_inode_lock,
> is used to prevent deadlock due to recursive lock acquisition.
> 
> But this function does not distinguish
> whether the requested level is EX or PR.
> 
> If a RP lock has been attained, this function
> will immediately return success afterwards even
> an EX lock is requested.
> 
> But actually the return value does not mean that
> the process got a EX lock, because ocfs2_inode_lock
> has not been called.
> 
> When taking lock levels into account, we face some different situations.
> 1. no lock is held
>    In this case, just lock the inode and return 0
> 
> 2. We are holding a lock
>    For this situation, things diverges into several cases
> 
>    wanted     holding	     what to do
>    ex		ex	    see 2.1 below
>    ex		pr	    see 2.2 below
>    pr		ex	    see 2.1 below
>    pr		pr	    see 2.1 below
> 
>    2.1 lock level that is been held is compatible
>    with the wanted level, so no lock action will be tacken.
> 
>    2.2 Otherwise, an upgrade is needed, but it is forbidden.
> 
> Reason why upgrade within a process is forbidden is that
> lock upgrade may cause dead lock. The following illustrate
> how it happens.
> 
>         process 1                             process 2
> ocfs2_inode_lock_tracker(ex=0)
>                                <======   ocfs2_inode_lock_tracker(ex=1)
> 
> ocfs2_inode_lock_tracker(ex=1)
> 

Nice changelog, but it gives no information about the severity of the
bug: how often does it hit and what is the end-user impact.

This info is needed so that I and others can decide which kernel
version(s) need the patch, so please always include it when fixing a
bug, thanks.
