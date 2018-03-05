Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeCEKR5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:17:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCEKR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:17:56 -0500
Date: Mon, 5 Mar 2018 11:17:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sven Joachim <svenjoac@gmx.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: Linux 4.16-rc4
Message-ID: <20180305101748.GL25201@hirez.programming.kicks-ass.net>
References: <CA+55aFxXg8hi+T_DNCG_OrAotqSheyREw-Njf9XgUD1vXqAyHQ@mail.gmail.com>
 <878tb7eyf8.fsf@turtle.gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878tb7eyf8.fsf@turtle.gmx.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 09:09:31AM +0100, Sven Joachim wrote:
> On 2018-03-04 15:15 -0800, Linus Torvalds wrote:
> 
> > Hmm. A reasonably calm week - the biggest change is to the 'kvm-stat'
> > tool, not any actual kernel files.
> >
> > But there's small changes all over, with architecture updates (x86,
> > s390, arm, parisc) and drivers (media, md, gpu, sound) being the bulk
> > of it.  But there's some filesystem fixes (mostly btrfs),
> > documentation updates etc too.
> >
> > Go test,
> 
> Huh, this version does not build for me:
> 
> ,----
> |   CALL    scripts/checksyscalls.sh
> |   DESCEND  objtool
> |   CC       /usr/local/src/linux/tools/objtool/check.o
> | In file included from check.c:26:0:
> | check.c: In function 'read_retpoline_hints':
> | warn.h:57:3: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Werror=format=]
> |    "%s: warning: objtool: " format "\n", \
> |    ^
> | check.c:1135:3: note: in expansion of macro 'WARN'
> |    WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
> |    ^~~~
> | check.c:1135:44: note: format string is defined here
> |    WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
> |                                           ~~^
> |                                           %d
> | cc1: all warnings being treated as errors
> | mv: cannot stat '/usr/local/src/linux/tools/objtool/.check.o.tmp': No such file or directory
> | /usr/local/src/linux/tools/build/Makefile.build:96: recipe for target '/usr/local/src/linux/tools/objtool/check.o' failed
> | make[3]: *** [/usr/local/src/linux/tools/objtool/check.o] Error 1
> `----
> 
> This might be because I still use a 32-bit userland with a 64-bit
> kernel.

Urgh, so sizeof() returns size_t which is confusing. But what is the
actual value of sizeof(unsigned long) for you? I suspect cross building
objtool doesn't work right at all. We build the kernel using LP64, and
its retpoline_safe section is 8 bytes. But if we build objtool as ILP32
then it would interpret things as 4 bytes.

Josh, is that supposed to work? I could of course move the retpoline
annotation over to 4 byte relative addressing which would fix this one
issue. Is that really the only case?
