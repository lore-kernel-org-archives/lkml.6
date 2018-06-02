Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeFBQoJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 12:44:09 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34536 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbeFBQoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 12:44:08 -0400
X-Google-Smtp-Source: ADUXVKI/K0DLQxKgJHPEt4wT52EAchn6/ijQwcWMsHH0b5JHQLxwL9xN1aVhmUnlI0o3sYyOmUxd8zuLpM6IGi2mIj0=
MIME-Version: 1.0
References: <20180601115329.27807-1-mhocko@kernel.org>
In-Reply-To: <20180601115329.27807-1-mhocko@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Jun 2018 09:43:56 -0700
Message-ID: <CA+55aFwaYEn8rA=-8hi1v8wWiLGJJsvkuEvBOxgvnmfUBfg4Vg@mail.gmail.com>
Subject: Re: [PATCH] mm: kvmalloc does not fallback to vmalloc for
 incompatible gfp flags
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, tom@quantonium.net,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 4:53 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> for more context. Linus has pointed out [1] that our (well mine)
> insisting on GFP_KERNEL compatible gfp flags for kvmalloc* can actually
> lead to a worse code because people will work around the restriction.
> So this patch allows kvmalloc to be more permissive and silently skip
> vmalloc path for incompatible gfp flags.

Ack.

> This will not help my original
> plan to enforce people to think about GFP_NOFS usage more deeply but
> I can live with that obviously...

Is it NOFS in particular you care about? The only reason for that
should be the whole "don't recurse", and I think the naming is
historical and slightly odd.

It was historically just about allocations that were in the writeout
path for a block layer or filesystem - and the name made sense in that
context. These days, I think it's just shorthand for "you can do
simple direct reclaim from the mm itself, but you can't  block or call
anything else".

So I think the name and the semantics are a bit unclear, but it's
obviously still useful.

It's entirely possible that direct reclaim should never do any of the
more complicated callback cases anyway, but we'd still need the whole
"don't wait for the complex case" logic to avoid deadlocks.

           Linus
