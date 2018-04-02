Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeDBJ2I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:28:08 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36820 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeDBJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:28:06 -0400
X-Google-Smtp-Source: AIpwx4+uUAjv0Zh5DObLBoU3KGxGLFPYWYYMsGqPWumvvFxiR/4e91pxPgPoGuqiHZrCui7OF7Ls+hqOqLB9+HDWvCA=
MIME-Version: 1.0
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
From: Vegard Nossum <vegard.nossum@gmail.com>
Date: Mon, 2 Apr 2018 11:28:04 +0200
Message-ID: <CAOMGZ=HwTjk9JbGNeWHd+Jr3rwOkFOU0r8hMSdputZ47bhRO+A@mail.gmail.com>
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
To: David Howells <dhowells@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 April 2018 at 22:40, David Howells <dhowells@redhat.com> wrote:
>
> Here are a series of patches to start converting the kernel to C++.  It
> requires g++ v8.

Nice!

I tried something similar a few years ago, but I don't think it was
nearly as neat. I did get RTTI and exceptions to work (using libcxxrt
+ libunwind), though. Having noticed that a lot of really trivial
kernel bugs are due to control flow issues (e.g. when somebody adds a
possibly-failing step to a function but forget to add a new label to
clean it up) I really wanted to see how/whether exceptions and RAII
could help in that space.

Just in case you want to compare notes, I've pushed my branch to:

https://github.com/vegard/linux-2.6/tree/cxx

I also started a little bit of work on converting a driver to use
RAII, and quickly ran into a few problems: C++ destructors don't take
arguments, which means that some objects would have to carry extra
state around because some of the information needed to destroy an
object resides with somebody else. This means that you would have to
do more refactoring work to avoid needing this in the first place,
i.e. mapping creation/destructing of various C-style structs to C++ is
_not_ straightforward.

Take dma_alloc_coherent() for example. It pairs up with
dma_free_coherent() and that one needs to know the device and buffer
size that you passed too:

void *dma_alloc_coherent(struct device *, size_t, dma_addr_t *, gfp_t);
void dma_free_coherent(struct device *, size_t, void *, dma_addr_t);

This means that if you have 1 device using 2 buffers of the same size
and the size is stored only by the device struct, then you must always
do the destruction from the device struct, since the individual
buffers don't know their size (unless you move the member there; but
it feels like a waste of memory if you could do it just fine in C).
Maybe there's a "proper" way to do it that I didn't see, but problems
like this turned me off the whole approach a little.

Another real bummer is the size and complexity of the RTTI and
unwinding support code. First of all, unwinding requires parsing and
executing DWARF code on the fly, and that just makes everything very
slow. Not to mention that it needs to be threading-aware and does a
lot of memory allocations. IIRC handling out-of-memory conditions was
extremely ugly (not that the kernel is perfect in this respect to
start with) and involved the use of "reserve buffers". I didn't like
it at all.

Also, for reference, I found a few other projects doing similar things
in the past:

https://github.com/veltzer/kcpp
http://www.drdobbs.com/cpp/c-exceptions-the-linux-kernel/229100146
https://pograph.wordpress.com/2009/04/05/porting-cpp-code-to-linux-kernel/
https://www.threatstack.com/blog/c-in-the-linux-kernel/

There's probably more, I seem to remember at least 1 commercial
product using C++ for their out-of-tree module (albeit without
RTTI/exceptions), but I can't find it right now.


Vegard
