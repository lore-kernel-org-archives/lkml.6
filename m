Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934363AbeCGWsI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:48:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933533AbeCGWsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:48:07 -0500
Date: Wed, 7 Mar 2018 14:48:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/5] sysctl: Enable easy addition of range showing
 sysctl parameters
Message-Id: <20180307144805.224a39e2ab72172f40c3f3d2@linux-foundation.org>
In-Reply-To: <1520454869-13871-1-git-send-email-longman@redhat.com>
References: <1520454869-13871-1-git-send-email-longman@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Mar 2018 15:34:24 -0500 Waiman Long <longman@redhat.com> wrote:

> This patch series is to be applied on top of the patch
> series "ipc: Clamp *mni to the real IPCMNI limit"
> (https://lkml.org/lkml/2018/3/1/716).
> 
> The purpose of this patch series is to enable easy addition of new
> auxillary sysctl parameters that can be read to display ranges of
> other sysctl parameters they are associated with.
> 
> With this patch series applied, a developer can add a range-showing
> auxillary sysctl entries by just setting the CTL_FLAGS_SHOW_RANGE
> flag in the ctl_table entry that has a range to show and add one more
> to the number of reserved range entries in the CTL_RESERVE_RANGES()
> macro before the terminating null entry. The new auxillary sysctl
> parameters will have the "_range" suffix added.
> 
> The number of ctl_table entries that have the CTL_FLAGS_SHOW_RANGE flag
> should match the number of reserved entries in the CTL_RESERVE_RANGES()
> macro. Otherwise, warning or error like below will be logged in the
> kernel ring buffer.
> 
>   Warning: Too many reserved ctl_table range entries ("shmmax")!
> 
>   Error: Insufficient reserved ctl_table range entries ("shmmax")!
> 
> The IPC sysctl parameters msgmni and shmmni are extended to have
> those auxillary sysctl entries. As a result, one can now find out
> the range of allowable value by looking at the corresponding
> auxillary _range sysctl parameters. For example,
> 
>   % cat msgmni_range
>   [0, 32768]
> 
> That means the msgmni sysctl parameter has to be within the 0 - 32768
> range inclusively.
> 
> ...
> 
>  fs/proc/proc_sysctl.c  | 99 +++++++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/sysctl.h | 52 +++++++++++++++++++++++++-
>  ipc/ipc_sysctl.c       |  5 ++-
>  kernel/sysctl.c        | 91 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 238 insertions(+), 9 deletions(-)

That quite a bunch of new code and it's not clear to me that we get a
lot of value from it all.  Perhaps I'm missing the point.

A worked example would help, along the lines of:


a) Here's how we do X at present and here's the output

b) Here's how we X after these patches and here's the new output

c) b) is better than a) for <reasons>
