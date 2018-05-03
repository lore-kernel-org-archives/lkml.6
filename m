Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeECRN2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:13:28 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:43647 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECRN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:13:27 -0400
X-Google-Smtp-Source: AB8JxZq7hry/AIUYcMZALeaT2X/LiXhvmStoNWa7hSOTIXmL3/ey7sD3W3MEKRsKUbwSlOW1Kq5wwQ==
Date: Thu, 3 May 2018 20:13:23 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] proc: restore seekdir("/proc", 256) semantics
Message-ID: <20180503171323.GA2137@avx2>
References: <20180423215009.GE9043@avx2>
 <20180501152307.61113cd16c2c1bec38ac1155@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180501152307.61113cd16c2c1bec38ac1155@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 03:23:07PM -0700, Andrew Morton wrote:
> On Tue, 24 Apr 2018 00:50:09 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Long time ago "/proc/self" was an honest symlink and all not-PID entries
> > were output before /proc/$PID. To not lose /proc/self in readdir output
> > after it became permanently positive dentry it was stuck before /proc/1.
> > 
> > One side effect of the change was that the code
> > 
> > 	d = opendir("/proc");
> > 	seekdir(d, 256);
> > 
> > stopped pointing to the first PID for applications that want to skip all
> > the crap.
> > 
> > Later "/proc/thread-self" was added in the same way.
> > 
> > It looks like ps and top aren't seeking over /proc but are simply
> > skipping over so nobody noticed.
> > 
> > Restore old behaviour, make seekdir(254) point to /proc/self and
> > seekdir(255) point to /proc/thread-self.
> > 
> 
> Gee.  Why?  That's a pretty weird artifact in the userspace API and if
> we were able to withdraw it without damage then good, let's leave it
> withdrawn?

I checked ps, top and htop, they are not doing seekdir(256).
Apparently userspace devs were unaware of this trick.
I'll remove this before anyone notices.

> I mean, if we're to make this a permanent part of the userspace API
> then it should be documented in the proc(5) manpage and we should have
> something in tools/testing/selftests to detect regressions in the
> interface.  Good luck with all that!
