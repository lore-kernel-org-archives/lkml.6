Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21473C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD102081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="myY8cZ0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD102081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeLEK6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbeLEK6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:58:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D938206B7;
        Wed,  5 Dec 2018 10:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544007502;
        bh=cB63kHz/+DPzZewbeX+oYdJrDnnXbAGlb2RbLnSvy2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myY8cZ0Dr9KEOjdPBuDsaQBrXKcpwSwOVweWEXSM9tMbTJypoK5wKnrphmi001YhF
         CPZ+4rHL9tmfQBuL8g9oAd/sVe0L/giptXFPaj8ulCPSCyUc/bYVVMN4TDLy+O7Rk4
         T+KW2GXTmOOQ8iVtyQtmSwfytRVtsYnbRAqJPsFM=
Date:   Wed, 5 Dec 2018 11:58:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, Martijn Coenen <maco@android.com>,
        kernel-team@android.com, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] binder: fix use-after-free due to fdget() optimization
Message-ID: <20181205105820.GB16376@kroah.com>
References: <20181203202457.228972-1-tkjos@google.com>
 <20181203202457.228972-4-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203202457.228972-4-tkjos@google.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:24:57PM -0800, Todd Kjos wrote:
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
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Todd Kjos <tkjos@google.com>
> Acked-by: Martijn Coenen <maco@android.com>

Shouldn't this go to 4.20-final?  And have a stable@ tag?
And a "Fixes:" tag?

thanks,

greg k-h
