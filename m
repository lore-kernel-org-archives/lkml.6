Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeECHoj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:44:39 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:38539 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeECHof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:44:35 -0400
X-Google-Smtp-Source: AB8JxZoLVAm4zst1nOrCtBd6yIX9lZGrWSqrMzMuus/WMQXkbTfm1uq01MSOLJL1rieP9XxCcHSBKmaEC//eEiSrFwA=
MIME-Version: 1.0
X-Originating-IP: [194.176.227.33]
In-Reply-To: <20180502224533.GW30522@ZenIV.linux.org.uk>
References: <20180502222635.1862-1-mszeredi@redhat.com> <20180502224533.GW30522@ZenIV.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 3 May 2018 09:44:34 +0200
Message-ID: <CAJfpegvMYGt-Mo2LmZVXHDd1KhxqS+iWNKfO7xCUhA1ZcG7KyQ@mail.gmail.com>
Subject: Re: [PATCH] dcache: fix quadratic behavior with parallel shrinkers
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 12:45 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, May 03, 2018 at 12:26:35AM +0200, Miklos Szeredi wrote:
>> When multiple shrinkers are operating on a directory containing many
>> dentries, it takes much longer than if only one shrinker is operating on
>> the directory.
>>
>> Call the shrinker instances A and B, which shrink DIR containing NUM
>> dentries.
>>
>> Assume A wins the race for locking DIR's d_lock, then it goes onto moving
>> all unlinked dentries to its dispose list.  When it's done, then B will
>> scan the directory once again, but will find that all dentries are already
>> being shrunk, so it will have an empty dispose list.  Both A and B will
>> have found NUM dentries (data.found == NUM).
>>
>> Now comes the interesting part: A will proceed to shrink the dispose list
>> by killing individual dentries and decrementing the refcount of the parent
>> (which is DIR).  NB: decrementing DIR's refcount will block if DIR's d_lock
>> is held.  B will shrink a zero size list and then immediately restart
>> scanning the directory, where it will lock DIR's d_lock, scan the remaining
>> dentries and find no dentry to dispose.
>>
>> So that results in B doing the directory scan over and over again, holding
>> d_lock of DIR, while A is waiting for a chance to decrement refcount of DIR
>> and making very slow progress because of this.  B is wasting time and
>> holding up progress of A at the same time.
>>
>> Proposed fix is to check this situation in B (found some dentries, but
>> all are being shrunk already) and just sleep for some time, before retrying
>> the scan.  The sleep is proportional to the number of found dentries.
>
> The thing is, the majority of massive shrink_dcache_parent() can be killed.
> Let's do that first and see if anything else is really needed.
>
> As it is, rmdir() and rename() are ridiculously bad - they should only call
> shrink_dcache_parent() after successful ->rmdir() or ->rename().  Sure,
> there are other places where we do large shrink_dcache_parent() runs,
> but those won't trigger in parallel on the same tree.

I think we are cat hit this also with lru pruner (prune_dcache_sb(),
shrink_dcache_sb()) running in parallel with shrink_dcache_parent().
Although shrink_dcache_sb() looks better in this regard, since it will
only hold up to 1024 dentries in the dispose list.

I'm open to a better solution, but keep in mind that it will also need
backporting.

Thanks,
Miklos
