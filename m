Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971663AbeEXVmB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:42:01 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36686 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971631AbeEXVly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:41:54 -0400
X-Google-Smtp-Source: AB8JxZruVUyad8eYHjW3OGY0rcDO5MGquOU1EcojFjd0PFJCgqxT9dCQurtqUDwxHeGaZixBvtFml6L0DeZgWW1Motw=
MIME-Version: 1.0
References: <20180524211135.27760-1-dave@stgolabs.net>
In-Reply-To: <20180524211135.27760-1-dave@stgolabs.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 May 2018 14:41:42 -0700
Message-ID: <CA+55aFxnrwFniJq6nCFn4pWRHLH-Wac9bVFKieBC-TixTsFg=Q@mail.gmail.com>
Subject: Re: [PATCH -next 0/6] rhashtable: guarantee first allocation
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Manfred Spraul <manfred@colorfullife.com>,
        guillaume.knispel@supersonicimagine.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 2:28 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>   10 files changed, 79 insertions(+), 86 deletions(-)

I certainly can't complain about this small code removal, but I think if we
did the kvmalloc_node() cleanup, we'd be able to get rid of even more.

For example, bucket_table_alloc() does that

         if (gfp != GFP_KERNEL)
                 tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
         else
                 tbl = kvzalloc(size, gfp);

purely due to the kvalloc_node() oddity. Wouldn't it be nice to just write
it as

         tbl = kvzalloc(size, gfp);

knowing that the whole point of all the kv*alloc*() functions is to "just
do the right thing given size, gpf mask, and ease of allocation".

             Linus
