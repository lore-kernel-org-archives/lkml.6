Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeDRNtJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:49:09 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45532 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbeDRNtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:49:03 -0400
X-Google-Smtp-Source: AIpwx48trVB9SGkaFWzZCvvSNbe6vmhgG/GSiu7Ey71mbrndkfHKz4lruT0ej1ZBa5RBtld4gSJicxcl0H1LTWoaE/8=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180418093845.19ca33f3@gandalf.local.home>
References: <20180412150826.20988-1-mszeredi@redhat.com> <20180412150826.20988-32-mszeredi@redhat.com>
 <CAOQ4uxgdWCWvwWgjUu06H=BeMxh-BVAjxVE5Ckj-poKRGgwvMQ@mail.gmail.com>
 <CAJfpegtLdmnxieDx7+FBUoc-fKsTEwA+oHinhAfa4E9SDFfSNw@mail.gmail.com> <20180418093845.19ca33f3@gandalf.local.home>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Apr 2018 15:49:02 +0200
Message-ID: <CAJfpeguJN0+m9Vhtv0fo79xq-P1UzWki9GqQq9WyJRMEwiJBqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 31/35] Revert "vfs: add d_real_inode() helper"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Howard McLauchlan <hmclauchlan@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 3:38 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 18 Apr 2018 13:42:03 +0200
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>> On Wed, Apr 18, 2018 at 10:19 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>> > On Thu, Apr 12, 2018 at 6:08 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:
>> >> This reverts commit a118084432d642eeccb961c7c8cc61525a941fcb.
>> >>
>> >> No user of d_real_inode() remains, so it can be removed.
>> >>
>> >
>> > FYI, there is a new user in v4.17-rc1 added by commit
>> > f0a2aa5a2a40 tracing/uprobe: Add support for overlayfs
>> >
>> > Seems like this patch got merged without any CC to overlayfs
>> > mailing list nor maintainer?
>
> It appeared to be a small change with lots of reviewers. I didn't think
> it was something to notify the overlayfs folks with. But perhaps I was
> wrong.

The patch is correct.  The code surrounding it isn't, though.

>
>> >
>> > Not sure yet if overlayfs-rorw patches would allow reverting this
>> > change.
>>
>> Not trivial, because uprobe is looking at i_mapping to get a list of
>> current memory maps.   We could set i_mapping at overlay inode
>> initialization time, but we definitely can't *change* i_mapping at
>> copy up.  Which is bound to result in some weird inconsistencies.  So
>> likely we'll need to keep d_real_inode() for the time being.
>
> I just received this patch:
>
>  http://lkml.kernel.org/r/20180418062907.3210386-1-songliubraving@fb.com
>
> Which removes this code. Can you review it and I'll take it.

It shouldn't remove d_real_inode(), because that part is correct and
fixes a real bug in handling overlayfs files.

I'll review, but apparently I wasn't CC-d on that patch.   Weird.

Thanks,
Miklos
