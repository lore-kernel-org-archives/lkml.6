Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753600AbeCUVTf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:19:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38903 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbeCUVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:19:34 -0400
X-Google-Smtp-Source: AG47ELsl2Ost+OxZDC9AQ77++aIb3ulTghvdNiHuNJx8YGQBIRA45SPqlMGvtQUmHwfnqqR91os67A==
Date: Wed, 21 Mar 2018 14:19:31 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de
Subject: Re: [PATCH 2/2] x86/unwind: Make CONFIG_UNWINDER_ORC=y the default
 in kconfig for 64-bit
Message-ID: <20180321211931.GA111711@google.com>
References: <20171013052544.euk7yawni47lhmdq@gmail.com>
 <9b1237bbe7244ed9cdf8db2dcb1253e37e1c341e.1507924831.git.jpoimboe@redhat.com>
 <20180319185732.GD37438@google.com>
 <20180319192910.wfbi656bxkrlurgf@treble>
 <20180319203130.GE37438@google.com>
 <20180319212053.e77dc3vmemfazt3b@treble>
 <20180319232255.GF37438@google.com>
 <20180321024507.ud4lu4xndr5jfpkd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321024507.ud4lu4xndr5jfpkd@treble>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, Mar 20, 2018 at 09:45:07PM -0500 Josh Poimboeuf ha dit:

> On Mon, Mar 19, 2018 at 04:22:55PM -0700, Matthias Kaehlcke wrote:
> > arch/x86/mm/pti.o: warning: objtool: pti_init() falls through to next
> > function pti_user_pagetable_walk_pmd()
> > s/debugfs/file.o: warning: objtool: full_proxy_llseek() falls through to next function full_proxy_read()
> > fs/debugfs/file.o: warning: objtool: full_proxy_read() falls through to next function full_proxy_write()
> > fs/debugfs/file.o: warning: objtool: full_proxy_write() falls through to next function full_proxy_poll()
> > fs/debugfs/file.o: warning: objtool: full_proxy_poll() falls through to next function full_proxy_unlocked_ioctl()
> > fs/debugfs/file.o: warning: objtool: full_proxy_unlocked_ioctl() falls
> > through to next function fops_u8_open()
> 
> Ok, I did a little more digging.  Surprise, these objtool warnings are
> actually correct.  Somehow the WARN macros are causing Clang to produce
> bad code.  In some cases, Clang is assuming that a WARN is "noreturn",
> i.e. that the UD2 doesn't return from the exception.
> 
> As an example, here's the full_proxy_llseek() function and its compiled
> code:
> 
> #define FULL_PROXY_FUNC(name, ret_type, filp, proto, args)		\
> static ret_type full_proxy_ ## name(proto)				\
> {									\
> 	struct dentry *dentry = F_DENTRY(filp);			\
> 	const struct file_operations *real_fops;			\
> 	ret_type r;							\
> 									\
> 	r = debugfs_file_get(dentry);					\
> 	if (unlikely(r))						\
> 		return r;						\
> 	real_fops = debugfs_real_fops(filp);				\
> 	r = real_fops->name(args);					\
> 	debugfs_file_put(dentry);					\
> 	return r;							\
> }
> 
> FULL_PROXY_FUNC(llseek, loff_t, filp,
> 		PROTO(struct file *filp, loff_t offset, int whence),
> 		ARGS(filp, offset, whence));
> 
> 
> 0000000000000ca0 <full_proxy_llseek>:
>      ca0:       55                      push   %rbp
>      ca1:       41 57                   push   %r15
>      ca3:       41 56                   push   %r14
>      ca5:       53                      push   %rbx
>      ca6:       48 83 ec 10             sub    $0x10,%rsp
>      caa:       41 89 d6                mov    %edx,%r14d
>      cad:       49 89 f7                mov    %rsi,%r15
>      cb0:       48 89 fd                mov    %rdi,%rbp
>      cb3:       65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
>      cba:       00 00
>      cbc:       48 89 44 24 08          mov    %rax,0x8(%rsp)
>      cc1:       48 8b 5d 18             mov    0x18(%rbp),%rbx
>      cc5:       48 89 df                mov    %rbx,%rdi
>      cc8:       e8 00 00 00 00          callq  ccd <full_proxy_llseek+0x2d>
>                         cc9: R_X86_64_PC32      debugfs_file_get-0x4
>      ccd:       85 c0                   test   %eax,%eax
>      ccf:       75 65                   jne    d36 <full_proxy_llseek+0x96>
>      cd1:       48 8b 45 18             mov    0x18(%rbp),%rax
>      cd5:       48 8b 40 78             mov    0x78(%rax),%rax
>      cd9:       a8 01                   test   $0x1,%al
>      cdb:       75 63                   jne    d40 <full_proxy_llseek+0xa0>
>      ...
>      d40:       0f 0b                   ud2
>      d42:       0f 1f 40 00             nopl   0x0(%rax)
>      d46:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
>      d4d:       00 00 00
> 
> 0000000000000d50 <full_proxy_read>:
> 
> 
> After the debugfs_file_get() call, the debugfs_real_fops() call is
> inlined.  Here it is:
> 
> const struct file_operations *debugfs_real_fops(const struct file *filp)
> {
> 	struct debugfs_fsdata *fsd = F_DENTRY(filp)->d_fsdata;
> 
> 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT) {
> 		/*
> 		 * Urgh, we've been called w/o a protecting
> 		 * debugfs_file_get().
> 		 */
> 		WARN_ON(1);
> 		return NULL;
> 	}
> 
> 	return fsd->real_fops;
> }
> 
> The WARN_ON() is the UD2 at offset d40.  Notice that, as objtool found,
> it just falls through to the next function instead of "returning" to
> full_proxy_llseek().
> 
> 
> At first I thought this might be some kind of "optimization", since, if
> you look closely, you'll see that the warning can never happen in this
> situation.  But no, I downloaded the Clang binary, changed the 
> 
>   if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT) /* DEBUGFS_FSDATA_IS_REAL_FOPS_BIT == 1 */
> 
> to
> 
>   if ((unsigned long)fsd & 0x2)
> 
> and still got the same issue.
> 
> 
> Then I figured that Clang must be peeking into the inline asm, and is
> assuming that UD2 is a dead end.  But no, I changed ASM_UD2 to a 2-byte
> NOP, and got the same issue.
> 
> 
> So unless I'm missing some "undefined behavior", this looks like a Clang
> bug to me.  Somehow it doesn't like the WARN macros (but apparently only
> in a small number of cases).

The behavior is indeed mysterious. Thanks for digging!

I'll see if our compiler folks can get to the bottom of this.

Could you send your fix for objtool that restores the original stack
pointer as an official patch?

Thanks

Matthias
