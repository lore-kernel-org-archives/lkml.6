Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754631AbeDBXhU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 19:37:20 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:40431 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeDBXhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 19:37:18 -0400
X-Google-Smtp-Source: AIpwx49tleIzmS/MZBkNVJo9Cg/OQlnYj0sa8O14xj6EyEIaUgB0VXjMnnHL3Kl8xhuKl31TBi8QP/5FlKhrFbajrM0=
MIME-Version: 1.0
In-Reply-To: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
References: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Apr 2018 16:37:17 -0700
X-Google-Sender-Auth: nhfBvjrWRXwesrhue_Hqk9Wxo3g
Message-ID: <CA+55aFxqFMdVoSHVWnoek-6SFgfJLO16L=WAEA6=zcr2HOQnrw@mail.gmail.com>
Subject: Re: [PATCH] bitmap: fix memset optimization on big-endian systems
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "# .39.x" <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 3:58 PM, Omar Sandoval <osandov@osandov.com> wrote:
>
> Commit 2a98dc028f91 introduced an optimization to bitmap_{set,clear}()
> which uses memset() when the start and length are constants aligned to a
> byte. This is wrong on big-endian systems;

Ugh, yes.

In retrospect, I do wish I had just made the bitmap types be
byte-based, but we had strong reasons for those "unsigned long" array
semantics.

The traditional problem - and the reason why it is byte-order
dependent - was that we often mix bitmap operations with "unsigned
long flags" style operations.

We should probably have at least switched it to "unsigned long int"
with the whole 64-bit transition, but never did even that, so the
bitmap format is not just byte order dependent, but dependent on the
size of "long".

I guess the "unsigned long flag" issue still exists in several places,
and we're stuck with it, probably forever. Think page flags, but also
various networking flags etc.

You'd *think* they use bitmap operations consistently, but they
definitely mix it with direct accesses to the flags field, eg the page
flags are usually done using the PG_xyz bit numbers, but occasionally
you have code that checks multiple independent bits at once, doing
things like

  #define PAGE_FLAGS_PRIVATE                              \
          (1UL << PG_private | 1UL << PG_private_2)

  static inline int page_has_private(struct page *page)
  {
          return !!(page->flags & PAGE_FLAGS_PRIVATE);
  }

so the bits really are _exposed_ as being encoded as bits in an unsigned long.

Your patch is obviously correct, and we just need to make sure people
*really* understand that bitmaps are arrays of unsigned long, and byte
(and bit) order is a real thing.

                 Linus
