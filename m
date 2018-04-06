Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933076AbeDFNse (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:48:34 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35502 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756968AbeDFNpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:45:17 -0400
X-Google-Smtp-Source: AIpwx48miCcXjs9aOadIjSVcsQIEN6R6lFwlUZCBBk2Uo2/e6yfDXCkOLEygQ5VTeckiev8WU+coQA==
Subject: Re: [PATCH?] reiserfs: prevent panic: don't allow %-char in journal
 dev. name
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, reiserfs-devel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Mahoney <jeffm@suse.com>, Jan Kara <jack@suse.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
References: <d9b518a5-287a-72b3-05f1-ea89e25563ba@infradead.org>
 <20180404184517.9f2b91b856a56f71464f5f7f@linux-foundation.org>
 <6b575956-6498-43c8-dc2c-9e2a0d5564a9@rasmusvillemoes.dk>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f1b08095-c4dc-61f4-0c96-d98a510fb36f@rasmusvillemoes.dk>
Date: Fri, 6 Apr 2018 15:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6b575956-6498-43c8-dc2c-9e2a0d5564a9@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-05 11:04, Rasmus Villemoes wrote:
> On 2018-04-05 03:45, Andrew Morton wrote:
>>
>> Isn't the bug in journal_init_dev()?
> 
> Urgh. At first I was about to reply that the real bug was in reiserfs.h
> for failing to annotate __reiserfs_warning with __printf(). But digging
> into it, it turns out that it implements its own printf extensions, so
> that's obviously a non-starter. Now, one thing is that some of those
> extension clash with existing standard modifiers (%z and %h, so if
> someone adds a correct %zu thing to print a size_t in reiserfs things
> will break). But, and I hope I'm wrong about this and just hasn't had
> enough coffee, this seems completely broken:
> 
>         while ((k = is_there_reiserfs_struct(fmt1, &what)) != NULL) {
>                 *k = 0;
> 
>                 p += vsprintf(p, fmt1, args);
> 
>                 switch (what) {
>                 case 'k':
>                         sprintf_le_key(p, va_arg(args, struct
> reiserfs_key *));
>                         break;
> 
> On architectures where va_list is a typedef for a one-element array of
> some struct (x86-64), that works ok, because the vsprintf call can and
> does update the args metadata. But when args is just a pointer into the
> stack (i386), we don't know how much vsprintf consumed, and end up
> consuming the same arguments again - only this time we may interpret
> some random integer as a struct pointer...

OK, so maybe -mregparm=3 would be the thing making i386 behave like
x86-64 wrt. varargs, but no, when calling a variadic function, gcc
pushes all arguments on the stack, and va_list is still just a pointer
(passed by value to vsprintf) into the stack.

It is only a problem when the format string contains ordinary specifiers
before a reiserfs-specific one, and such calls happen to be rare, but
not non-existing. One example would be reiserfs_warning(tb->tb_sb,
"vs-12339", "%s (%b)", which, bh);. Ok, treating which as a buffer_head
would probably just give some garbage numbers. But

  "reiserfs-16100", "STATDATA, index %d, type 0x%x, %h",		 vi->vi_index,
vi->vi_type, vi->vi_ih

ends up treating vi->vi_index as a struct item_head*, no?

Rasmus
