Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E443C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70E520879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70E520879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeLEWAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:00:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56126 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeLEWAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:00:45 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gUfDf-0000Zh-TC; Wed, 05 Dec 2018 22:00:36 +0000
Date:   Wed, 5 Dec 2018 22:00:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com,
        Jann Horn <jannh@google.com>, Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v2] binder: fix use-after-free due to fdget() optimization
Message-ID: <20181205220035.GX2217@ZenIV.linux.org.uk>
References: <20181205211601.75856-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205211601.75856-1-tkjos@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 01:16:01PM -0800, Todd Kjos wrote:
> 44d8047f1d87a ("binder: use standard functions to allocate fds")
> exposed a pre-existing issue in the binder driver.
> 
> fdget() is used in ksys_ioctl() as a performance optimization.
> One of the rules associated with fdget() is that ksys_close() must
> not be called between the fdget() and the fdput(). There is a case
> where this requirement is not met in the binder driver (and possibly
> other drivers) which results in the reference count dropping to 0
> when the device is still in use. This can result in use-after-free
> or other issues.
> 
> This was observed with the following sequence of events:
> 
> Task A and task B are connected via binder; task A has /dev/binder open at
> file descriptor number X. Both tasks are single-threaded.
> 
> 1. task B sends a binder message with a file descriptor array
>    (BINDER_TYPE_FDA) containing one file descriptor to task A
> 2. task A reads the binder message with the translated file
>    descriptor number Y
> 3. task A uses dup2(X, Y) to overwrite file descriptor Y with
>    the /dev/binder file
> 4. task A unmaps the userspace binder memory mapping; the reference
>    count on task A's /dev/binder is now 2
> 5. task A closes file descriptor X; the reference count on task
>    A's /dev/binder is now 1
> 6. task A forks off a child, task C, duplicating the file descriptor
>    table; the reference count on task A's /dev/binder is now 2
> 7. task A invokes the BC_FREE_BUFFER command on file descriptor X
>    to release the incoming binder message
> 8. fdget() in ksys_ioctl() suppresses the reference count increment,
>    since the file descriptor table is not shared
> 9. the BC_FREE_BUFFER handler removes the file descriptor table
>    entry for X and decrements the reference count of task A's
>    /dev/binder file to 1
> 10.task C calls close(X), which drops the reference count of
>    task A's /dev/binder to 0 and frees it
> 11.task A continues processing of the ioctl and accesses some
>    property of e.g. the binder_proc => KASAN-detectable UAF
> 
> Fixed by using get_file() / fput() in binder_ioctl().

Note that this patch does *not* remove the nasty trap caused by the garbage
in question - struct file can be freed before we even return from
->unlocked_ioctl().  Could you describe in details the desired behaviour
of this interface?

How about grabbing the references to all victims (*before* screwing with
ksys_close()), sticking them into a structure with embedded callback_head
and using task_work_add() on it, the callback doing those fput()?

The callback would trigger before the return to userland, so observable
timing of the final close wouldn't be changed.  And it would avoid the
kludges like this.

Of course, the proper fix would require TARDIS and set of instruments for
treating severe case of retrocranial inversion, so that this "ABI" would've
never existed, but...
