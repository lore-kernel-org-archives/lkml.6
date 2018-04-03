Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeDCSI6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:08:58 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45490 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeDCSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:08:56 -0400
X-Google-Smtp-Source: AIpwx4+Rwc3Kw9e63MZkmaicfy5tQxFtzlIbDZWileiVK6HOBUwJCP/7GzsxLM5hHbfSIXBKHI9HEA==
Date: Tue, 3 Apr 2018 11:08:54 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] bitmap: fix memset optimization on big-endian systems
Message-ID: <20180403180854.GA17679@vader>
References: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
 <CA+55aFxqFMdVoSHVWnoek-6SFgfJLO16L=WAEA6=zcr2HOQnrw@mail.gmail.com>
 <CA+55aFxQdzZjQ__dX6AVZfoA_=Uqu+rvidVT6YtJO15RS307Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxQdzZjQ__dX6AVZfoA_=Uqu+rvidVT6YtJO15RS307Ew@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 04:49:39PM -0700, Linus Torvalds wrote:
> On Mon, Apr 2, 2018 at 4:37 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > We should probably have at least switched it to "unsigned long int"
> 
> I meant just "unsigned int", of course.
> 
> Right now we occasionally have a silly 64-bit field just for a couple of flags.

Not to mention the mix of bit fields, macros, and enums, some of which
are bit masks, some of which are the bit number :)

> Of course, we do have cases where 64-bit architectures happily end up
> using more than 32 bits too, so the "unsigned long" is occasionally
> useful. But it's rare enough that it probably wasn't the right thing
> to do.
> 
> Water under the bridge. Part of it is due to another historical
> accident: the alpha port was one of the early ports, and it didn't do
> atomic byte accesses at all.
> 
> So we had multiple issues that all conspired to "unsigned long arrays
> are the natural for atomic bit operations" even though they have this
> really annoying byte order issue.

Thanks for the historical context, this is exactly what I was wondering
when I spotted this bug and fixed a similar one in Btrfs a couple of
years back.
