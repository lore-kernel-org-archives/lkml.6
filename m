Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeEAWXK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 18:23:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeEAWXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 18:23:09 -0400
Date: Tue, 1 May 2018 15:23:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] proc: restore seekdir("/proc", 256) semantics
Message-Id: <20180501152307.61113cd16c2c1bec38ac1155@linux-foundation.org>
In-Reply-To: <20180423215009.GE9043@avx2>
References: <20180423215009.GE9043@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 00:50:09 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Long time ago "/proc/self" was an honest symlink and all not-PID entries
> were output before /proc/$PID. To not lose /proc/self in readdir output
> after it became permanently positive dentry it was stuck before /proc/1.
> 
> One side effect of the change was that the code
> 
> 	d = opendir("/proc");
> 	seekdir(d, 256);
> 
> stopped pointing to the first PID for applications that want to skip all
> the crap.
> 
> Later "/proc/thread-self" was added in the same way.
> 
> It looks like ps and top aren't seeking over /proc but are simply
> skipping over so nobody noticed.
> 
> Restore old behaviour, make seekdir(254) point to /proc/self and
> seekdir(255) point to /proc/thread-self.
> 

Gee.  Why?  That's a pretty weird artifact in the userspace API and if
we were able to withdraw it without damage then good, let's leave it
withdrawn?

I mean, if we're to make this a permanent part of the userspace API
then it should be documented in the proc(5) manpage and we should have
something in tools/testing/selftests to detect regressions in the
interface.  Good luck with all that!
