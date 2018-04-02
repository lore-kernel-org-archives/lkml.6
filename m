Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754711AbeDBXtn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 19:49:43 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:53461 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeDBXtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 19:49:42 -0400
X-Google-Smtp-Source: AIpwx48Nd96D91tQ6KC9CWXu9YNqzss35lGpy2Uuirj3rq6ViSVFtOJR7n96jTvfA7T9vOJYrUfAuyYCDgPRIcN9KWI=
MIME-Version: 1.0
In-Reply-To: <CA+55aFxqFMdVoSHVWnoek-6SFgfJLO16L=WAEA6=zcr2HOQnrw@mail.gmail.com>
References: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
 <CA+55aFxqFMdVoSHVWnoek-6SFgfJLO16L=WAEA6=zcr2HOQnrw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Apr 2018 16:49:39 -0700
X-Google-Sender-Auth: hLNEo4k2sePhNxS5F9dqp3ZVuHY
Message-ID: <CA+55aFxQdzZjQ__dX6AVZfoA_=Uqu+rvidVT6YtJO15RS307Ew@mail.gmail.com>
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

On Mon, Apr 2, 2018 at 4:37 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We should probably have at least switched it to "unsigned long int"

I meant just "unsigned int", of course.

Right now we occasionally have a silly 64-bit field just for a couple of flags.

Of course, we do have cases where 64-bit architectures happily end up
using more than 32 bits too, so the "unsigned long" is occasionally
useful. But it's rare enough that it probably wasn't the right thing
to do.

Water under the bridge. Part of it is due to another historical
accident: the alpha port was one of the early ports, and it didn't do
atomic byte accesses at all.

So we had multiple issues that all conspired to "unsigned long arrays
are the natural for atomic bit operations" even though they have this
really annoying byte order issue.

                  Linus
