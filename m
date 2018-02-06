Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753660AbeBFWcQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:32:16 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:41551 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753611AbeBFWcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:32:15 -0500
X-Google-Smtp-Source: AH8x2267Y5VCZtUylj33adTir1Pv2VarSPO8NqsAnv9ZJkAe8BWPRB5gWKLeo4fQEfyj1GTdEGjPyy33UUF0sJZRhA4=
MIME-Version: 1.0
In-Reply-To: <20180206220159.GA9680@eng-minchan1.roam.corp.google.com>
References: <20180206004903.224390-1-joelaf@google.com> <20180206220159.GA9680@eng-minchan1.roam.corp.google.com>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 6 Feb 2018 14:32:13 -0800
Message-ID: <CAJWu+opFVtVbPygHBYX5gv-LeH1uugY1DDPp2q4va4mOsvBeWw@mail.gmail.com>
Subject: Re: [PATCH RFC] ashmem: Fix lockdep RECLAIM_FS false positive
To: Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zilstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

On Tue, Feb 6, 2018 at 2:01 PM, Minchan Kim <minchan@kernel.org> wrote:
[...]
> On Mon, Feb 05, 2018 at 04:49:03PM -0800, Joel Fernandes wrote:
>> During invocation of ashmem shrinker under memory pressure, ashmem
>> calls into VFS code via vfs_fallocate. We however make sure we
>> don't enter it if the allocation was GFP_FS to prevent looping
>> into filesystem code. However lockdep doesn't know this and prints
>> a lockdep splat as below.
>>
>> This patch fixes the issue by releasing the reclaim_fs lock after
>> checking for GFP_FS but before calling into the VFS path, and
>> reacquiring it after so that lockdep can continue reporting any
>> reclaim issues later.
>
> At first glance, it looks reasonable. However, Couldn't we return
> just 0 in ashmem_shrink_count when the context is under FS?
>

We're already checking if GFP_FS in ashmem_shrink_scan and bailing out
though, did I miss something?

The problem is not that there is a deadlock that occurs, the problem
that even when we're not under FS, lockdep reports an issue that can't
happen. The fix is for the lockdep false positive that occurs.

thanks,

- Joel
