Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A21C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1342A20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1342A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeKJAgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:36:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeKJAgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:36:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61A2930820DF;
        Fri,  9 Nov 2018 14:55:25 +0000 (UTC)
Received: from treble (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5DE1101960A;
        Fri,  9 Nov 2018 14:55:23 +0000 (UTC)
Date:   Fri, 9 Nov 2018 08:55:21 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
Message-ID: <20181109145521.2nfypucjsaq6bvxx@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <CAKv+Gu_K-=rhV3fkE=OzFM=QipP8wbYhOeMZ8Pa6m=ZCnSOLew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_K-=rhV3fkE=OzFM=QipP8wbYhOeMZ8Pa6m=ZCnSOLew@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 09 Nov 2018 14:55:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:51:16AM +0100, Ard Biesheuvel wrote:
> Hi Josh,
> 
> Thanks a lot for looking into this.
> 
> On 8 November 2018 at 22:15, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > Add a static call infrastructure.  Static calls use code patching to
> > hard-code function pointers into direct branch instructions.  They give
> > the flexibility of function pointers, but with improved performance.
> > This is especially important for cases where retpolines would otherwise
> > be used, as retpolines can significantly impact performance.
> >
> > This code is heavily inspired by the jump label code (aka "static
> > jumps"), as some of the concepts are very similar.
> >
> > There are three implementations, depending on arch support:
> >
> > 1) optimized: patched call sites (CONFIG_HAVE_STATIC_CALL_OPTIMIZED)
> > 2) unoptimized: patched trampolines (CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED)
> 
> Could we move to an idiom like inline/out of line? The unoptimized
> variant may be perfectly adequate for many arches, and 'unoptimized'
> sounds like there is something wrong with it.

Yeah, inline/out-of-line would be better.  It's both more descriptive
and less derogatory :-)

> > + * Usage example:
> > + *
> > + *   # Start with the following functions (with identical prototypes):
> > + *   int func_a(int arg1, int arg2);
> > + *   int func_b(int arg1, int arg2);
> > + *
> > + *   # Define a 'my_key' reference, associated with func_a() by default
> > + *   DEFINE_STATIC_CALL(my_key, func_a);
> > + *
> > + *   # Call func_a()
> > + *   static_call(my_key, arg1, arg2);
> > + *
> > + *   # Update 'my_key' to point to func_b()
> > + *   static_call_update(my_key, func_b);
> > + *
> > + *   # Call func_b()
> > + *   static_call(my_key, arg1, arg2);
> > + *
> 
> Any way we can revert to the default implementation? That would be
> useful for, e.g.,  unloading modules that provide an alternative
> implementation.

I saw your original implementation had a "reset to default", but from
what I can tell, most users wouldn't need that.

Assuming the caller knows what the original dest function was, can't
they just call static_call_update(my_key, orig_func) directly?

> > diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
> > new file mode 100644
> > index 000000000000..7dd4b3d7ec2b
> > --- /dev/null
> > +++ b/include/linux/static_call_types.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _STATIC_CALL_TYPES_H
> > +#define _STATIC_CALL_TYPES_H
> > +
> > +#include <linux/stringify.h>
> > +
> > +#define STATIC_CALL_TRAMP_PREFIX ____static_call_tramp_
> > +#define STATIC_CALL_TRAMP_PREFIX_STR __stringify(STATIC_CALL_TRAMP_PREFIX)
> > +
> > +#define STATIC_CALL_TRAMP(key) STATIC_CALL_TRAMP_PREFIX##key
> > +#define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
> > +
> 
> I needed to apply
> 
> diff --git a/include/linux/static_call_types.h
> b/include/linux/static_call_types.h
> index 7dd4b3d7ec2b..6859b208de6e 100644
> --- a/include/linux/static_call_types.h
> +++ b/include/linux/static_call_types.h
> @@ -7,7 +7,7 @@
>  #define STATIC_CALL_TRAMP_PREFIX ____static_call_tramp_
>  #define STATIC_CALL_TRAMP_PREFIX_STR __stringify(STATIC_CALL_TRAMP_PREFIX)
> 
> -#define STATIC_CALL_TRAMP(key) STATIC_CALL_TRAMP_PREFIX##key
> +#define STATIC_CALL_TRAMP(key) __PASTE(STATIC_CALL_TRAMP_PREFIX, key)
>  #define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
> 
>  /* The static call site table is created by objtool. */
> 
> or I end up with
> 
> 0000000000000000 <STATIC_CALL_TRAMP_PREFIXfoo>:
>    0: 14000000 b a8 <foo_a>
>    4: d503201f nop

Ha, oops.  That was part of a last minute cleanup to share the macros
with objtool.


-- 
Josh
