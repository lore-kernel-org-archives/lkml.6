Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeEQIyJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:54:09 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45330 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeEQIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:54:06 -0400
X-Google-Smtp-Source: AB8JxZoSO2D21s+c44L/oSqJ2v9VhxCk6IArDksFODujMRUypGfTL3ArPadHbyWAZIi8hub9yFB44ztgZNOYLJamDZc=
MIME-Version: 1.0
References: <20180516153434.24479-1-glider@google.com> <f8a737c1-8cb9-15e1-2d98-454a4cafc1ed@virtuozzo.com>
In-Reply-To: <f8a737c1-8cb9-15e1-2d98-454a4cafc1ed@virtuozzo.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 17 May 2018 10:53:53 +0200
Message-ID: <CAG_fn=WfY6izR9OhCxm1JndgAeGxHgE2VNUAqDkG36O1-aTSrw@mail.gmail.com>
Subject: Re: [PATCH] lib/stackdepot.c: use a non-instrumented version of memcpy()
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4H8sJYl028051

On Wed, May 16, 2018 at 6:45 PM Andrey Ryabinin <aryabinin@virtuozzo.com>
wrote:

> On 05/16/2018 06:34 PM, Alexander Potapenko wrote:
> > stackdepot used to call memcpy(), which compiler tools normally
> > instrument, therefore every lookup used to unnecessarily call
instrumented
> > code.  This is somewhat ok in the case of KASAN, but under KMSAN a lot
of
> > time was spent in the instrumentation.
> >
> > (A similar change has been previously committed for memcmp())
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > ---
> >  lib/stackdepot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > index e513459a5601..d48c744fa750 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -140,7 +140,7 @@ static struct stack_record
*depot_alloc_stack(unsigned long *entries, int size,
> >       stack->handle.slabindex = depot_index;
> >       stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
> >       stack->handle.valid = 1;
> > -     memcpy(stack->entries, entries, size * sizeof(unsigned long));
> > +     __memcpy(stack->entries, entries, size * sizeof(unsigned long));

> This has no effect. Since the whole file is not instrumented memcpy
automagically replaced with __memcpy.
You're right, we just didn't have the code defining memcpy() to __memcpy()
in KMSAN. I'll fix that instead.


-- 
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Straße, 33
80636 München

Geschäftsführer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
