Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeBVVw1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:52:27 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34493 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeBVVwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:52:24 -0500
X-Google-Smtp-Source: AG47ELvSaBvhNtu9XvuXEXqrqEVLvJzquiOoP9PxHDTCc7V9Qln2qp/bnOd5T+5BFnIbKQUuIeqWmqOxd2MDgfFY9xM=
MIME-Version: 1.0
In-Reply-To: <20180222203651.B776810C@viggo.jf.intel.com>
References: <20180222203651.B776810C@viggo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2018 13:52:22 -0800
X-Google-Sender-Auth: L_4c6ut9G9LZ2v8rU7YwQORxOO4
Message-ID: <CA+55aFy064KtXdduyM2E4rU6-ZJsOB69x2aJdZxbXgJPh2HUOQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/10] Use global pages with PTI
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, namit@vmware.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Side note - and this may be crazy talk - I wonder if it might make
sense to have a mode where we allow executable read-only kernel pages
to be marked global too (but only in the kernel mapping).

Yes, yes, that potentially means that you can run meltdown on recently
run kernel code that is still in the TLB, but even if so, that may be
something people are ok with.

Because it would leak data that can generally be gotten other ways
(aka "just download the vendor kernel from a website"), and from a
security standpoint the biggest issue is likely that you can break
KASLR. But again, that is something that some people may be perfectly
fine with - it's certainly much less of an issue than leaking actual
*data*.

And it might be an easy option to give people, with something like
"pti=data" or similar.

It's also quite possible that depending on how separate the ITLB and
DTLB is, an ITLB entry might not even really be amenable to Meltdown
leaking at all.

Since the pages wouldn't actually exist in the user page tables, the
only sign of them would be in the TLB entries, and if the ITLB is
separate enough it might be practically impossible to really use those
ITLB entries for meltdown.

Of course, maybe the performance advantage from keeping the ITLB
entries around isn't huge, but this *may* be worth at least asking
some Intel architects about?

Because my gut feel is that a noticeable amount of the TLB cost from
PTI comes from the code side. I suspect a lot of kernel code has a
bigger instruction footprint than data.

(And yes, like this set of global bit patches, it probably matters a
whole lot more on CPU's that don't have PCID. With PCID it's probably
not all that noticeable at all).

             Linus
