Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbeBFXQw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 18:16:52 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:40833 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753618AbeBFXQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 18:16:51 -0500
X-Google-Smtp-Source: AH8x227dOR0RAMYKEDLcSsB5IJ2miVzQkFor30XnM688Kfloz5aE2pXDZQGnv8uHEHxbtiQIcbxMMnMwkoQrnGT3DRo=
MIME-Version: 1.0
In-Reply-To: <20180206225548.GB9680@eng-minchan1.roam.corp.google.com>
References: <20180206004903.224390-1-joelaf@google.com> <20180206220159.GA9680@eng-minchan1.roam.corp.google.com>
 <CAJWu+opFVtVbPygHBYX5gv-LeH1uugY1DDPp2q4va4mOsvBeWw@mail.gmail.com> <20180206225548.GB9680@eng-minchan1.roam.corp.google.com>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 6 Feb 2018 15:16:49 -0800
Message-ID: <CAJWu+op4SpBG1r+V7MOgwsP_tx8MnGxj=udopxw4irXN44z75w@mail.gmail.com>
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

On Tue, Feb 6, 2018 at 2:55 PM, Minchan Kim <minchan@kernel.org> wrote:
> On Tue, Feb 06, 2018 at 02:32:13PM -0800, Joel Fernandes wrote:
[...]
>> On Tue, Feb 6, 2018 at 2:01 PM, Minchan Kim <minchan@kernel.org> wrote:
>> [...]
>> > On Mon, Feb 05, 2018 at 04:49:03PM -0800, Joel Fernandes wrote:
>> >> During invocation of ashmem shrinker under memory pressure, ashmem
>> >> calls into VFS code via vfs_fallocate. We however make sure we
>> >> don't enter it if the allocation was GFP_FS to prevent looping
>> >> into filesystem code. However lockdep doesn't know this and prints
>> >> a lockdep splat as below.
>> >>
>> >> This patch fixes the issue by releasing the reclaim_fs lock after
>> >> checking for GFP_FS but before calling into the VFS path, and
>> >> reacquiring it after so that lockdep can continue reporting any
>> >> reclaim issues later.
>> >
>> > At first glance, it looks reasonable. However, Couldn't we return
>> > just 0 in ashmem_shrink_count when the context is under FS?
>> >
>>
>> We're already checking if GFP_FS in ashmem_shrink_scan and bailing out
>> though, did I miss something?
>
> I understand your concern now. Apart from that, if ashmem_shrink_count
> is called under GFP_FS, you can just return 0 for removing pointless
> ashmem_shrink_scan calling. But it might be trivial so up to you. :)

Yes, I think we can do that in a subsequent patch since that's a
different optimization. Thanks for the suggestion.

>>
>> The problem is not that there is a deadlock that occurs, the problem
>> that even when we're not under FS, lockdep reports an issue that can't
>> happen. The fix is for the lockdep false positive that occurs.
>
> Yub, you are right. I am happy to add
>
> Reviewed-by: Minchan Kim <minchan@kernel.org?

Great, thanks!

>
> Other than that, I thought a while we could make it in generic so we
> can add SHRINKER_FS_AWARE like that so VM code itself can do for
> preventing such false positive instead of doing it in each driver
> itself.
>
> However, if driver can do by itself, it could be more flexible.

Yes, off the top it feels like something that driver you should do at
more finer grained level, since probably only driver knows that/if we
will be looping into FS.

Thanks for the review,

- Joel
