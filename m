Return-Path: <mka@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517957327; cv=none;
        d=google.com; s=arc-20160816;
        b=Nku81mN9fTggpffBrRHha0imDTAnQqKDsBGE3XCuXcQzbQ7/bngLABfsQ77z0Qi52/
         dEbPmglVFbKYk4PfkaaUN/5WZYPZtOqbAUHJP9Qy8Psf6HMgE2KymxzxCg4fCjkduJcK
         rCexH9q7j5J9P4grbAohOxTz+cOgKTzzcuPmbseQv2AX2w3QiW7ZqehiaIvjc6aq1As3
         vXe3+jYnTRwlic9qt4SlvbswTofJHzGB1vyUSxGb11VknnwEOINA3+j/MGE1ar4QckEu
         nq6orXkJWlM6xSntvqMWfCviVCwSXEFJWnrDZk1viQiDqqaQCXJd83i2XD3ILgQuPLiN
         T5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=kj4gruxTcwEzQcZ4OkDZjboWslHQyU+jq//Oh3wCf8Y=;
        b=Rxumn4uuYQ3MLTbl+fWlPclyG7SnjSBISmpROLnPZGMav9tlWkDw9LquZlcV7FXc/p
         bAx0mgsjriLk+9l7zP+ga95T4Kn/ShttULnaMZMoSbKjtFSLOwt+i2m2gsFUHcwiuJDR
         LqWcLJybOczW4u4BD343ZNjWNHJ5GTeJiKT3w8LO64N1J5gWOHJGfd2blrWblQbE5ALA
         vCqysc80Ert+qJg8MmMqlDzN4mLCIY/qS+ozs38fPj+DKEGrwtPLb6QWV3CkGIc0wPUS
         jAtMILHUutJBFD0/yE8Vb+x1No4EG9bhw8/AzxFGBYY6qbihaUvnjPnJ1o5kHQ83FU3Y
         L3tA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NrJC1naj;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NrJC1naj;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x225/Hx2WGNpLmMFuJU2mV7gvTYJHISpS2rgvqxGdTqYLKZjVaSv7QtyGbozvzdWQE8O0LZlQDQ==
Date: Tue, 6 Feb 2018 14:48:45 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, David Woodhouse <dwmw@amazon.co.ku>,
	Razvan Ghitulete <rga@amazon.de>,
	Guenter Roeck <groeck@chromium.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Greg Hackmann <ghackmann@google.com>
Subject: Re: [PATCH 4.4 05/53] x86/asm: Use register variable to get stack
 pointer value
Message-ID: <20180206224845.GA116483@google.com>
References: <20180122083910.299610926@linuxfoundation.org>
 <20180122083910.527513802@linuxfoundation.org>
 <20180206215941.GA99249@google.com>
 <20180206223706.GC23990@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180206223706.GC23990@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1590281391571990781?=
X-GMAIL-MSGID: =?utf-8?q?1591693622219146736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

El Tue, Feb 06, 2018 at 02:37:06PM -0800 Greg Kroah-Hartman ha dit:

> On Tue, Feb 06, 2018 at 01:59:41PM -0800, Matthias Kaehlcke wrote:
> > Hi Greg,
> > 
> > El Mon, Jan 22, 2018 at 09:39:57AM +0100 Greg Kroah-Hartman ha dit:
> > 
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > 
> > > commit 196bd485ee4f03ce4c690bfcf38138abfcd0a4bc upstream.
> > > 
> > > Currently we use current_stack_pointer() function to get the value
> > > of the stack pointer register. Since commit:
> > > 
> > >   f5caf621ee35 ("x86/asm: Fix inline asm call constraints for Clang")
> > > 
> > > ... we have a stack register variable declared. It can be used instead of
> > > current_stack_pointer() function which allows to optimize away some
> > > excessive "mov %rsp, %<dst>" instructions:
> > > 
> > >  -mov    %rsp,%rdx
> > >  -sub    %rdx,%rax
> > >  -cmp    $0x3fff,%rax
> > >  -ja     ffffffff810722fd <ist_begin_non_atomic+0x2d>
> > > 
> > >  +sub    %rsp,%rax
> > >  +cmp    $0x3fff,%rax
> > >  +ja     ffffffff810722fa <ist_begin_non_atomic+0x2a>
> > > 
> > > Remove current_stack_pointer(), rename __asm_call_sp to current_stack_pointer
> > > and use it instead of the removed function.
> > > 
> > > Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Link: http://lkml.kernel.org/r/20170929141537.29167-1-aryabinin@virtuozzo.com
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > [dwmw2: We want ASM_CALL_CONSTRAINT for retpoline]
> > > Signed-off-by: David Woodhouse <dwmw@amazon.co.ku>
> > > Signed-off-by: Razvan Ghitulete <rga@amazon.de>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > We recently merged this patch to the Chrome OS kernel tree and it
> > broke our x86 builds with clang:
> > 
> > arch/x86/include/asm/asm.h:116:50: error: register 'rsp' unsuitable for global register variables on this target
> > register unsigned long current_stack_pointer asm(_ASM_SP);
> >                                                  ^
> > arch/x86/include/asm/asm.h:41:18: note: expanded from macro '_ASM_SP'
> > #define _ASM_SP         __ASM_REG(sp)
> >                         ^
> > arch/x86/include/asm/asm.h:24:32: note: expanded from macro '__ASM_REG'
> > #define __ASM_REG(reg)         __ASM_SEL_RAW(e##reg, r##reg)
> >                                ^
> > arch/x86/include/asm/asm.h:19:29: note: expanded from macro '__ASM_SEL_RAW'
> > # define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(b)
> >                             ^
> > arch/x86/include/asm/asm.h:10:32: note: expanded from macro '__ASM_FORM_RAW'
> > # define __ASM_FORM_RAW(x)     #x
> >                                ^
> > <scratch space>:4:1: note: expanded from here
> > "rsp"
> > ^
> > 1 error generated.
> > 
> > 
> > This can be fixed by also integrating the following patch:
> > 
> > commit 520a13c530aeb5f63e011d668c42db1af19ed349
> > Author: Josh Poimboeuf <jpoimboe@redhat.com>
> > Date:   Thu Sep 28 16:58:26 2017 -0500
> > 
> >     x86/asm: Fix inline asm call constraints for GCC 4.4
> > 
> > 
> > Admittedly a v4.4 kernel built with clang + LTS merges is a very
> > special case and we can fix this in Chrome OS by integrating the above
> > patch locally. Still it would be good to get it into stable to avoid
> > others from running into this, especially since the fix is very
> > simple.
> > 
> > Actually I just noticed that the patch also isn't in v4.9, which could
> > extend the number of affected 'users' significantly, so I think we
> > almost certainly want Josh's patch in stable.
> 
> That patch doesn't apply cleanly to the 4.4.y or 4.9.y trees anymore.
> It seems that only one hunk of it is really needed, the #ifndef change,
> right?  If so, I'll be glad to apply that portion.

Indeed, only the #ifndef change is needed.

Thanks!

m.
