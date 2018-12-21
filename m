Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C6EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B25421920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404603AbeLUWUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:20:30 -0500
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:40566 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730887AbeLUWU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:20:29 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B98213A91;
        Fri, 21 Dec 2018 22:20:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: frame06_78561ece8b74c
X-Filterd-Recvd-Size: 5031
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Dec 2018 22:20:26 +0000 (UTC)
Message-ID: <84199633fd49db573c9ba71f1992936422e907d4.camel@perches.com>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper
 macro
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri, 21 Dec 2018 14:20:25 -0800
In-Reply-To: <20181221160826.34c544e6@gandalf.local.home>
References: <20181221175618.968519903@goodmis.org>
         <20181221175659.208858193@goodmis.org>
         <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
         <20181221144054.20bdeb33@gandalf.local.home>
         <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
         <20181221153526.5e6055ca@gandalf.local.home>
         <077eeb8b09baebe78822819b5f15d671b738a2b2.camel@perches.com>
         <20181221155435.38a9a221@gandalf.local.home> <871s6ad2br.fsf@igel.home>
         <20181221160826.34c544e6@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-21 at 16:08 -0500, Steven Rostedt wrote:
> On Fri, 21 Dec 2018 21:58:32 +0100
> Andreas Schwab <schwab@linux-m68k.org> wrote:
> 
> 
> > > Well, perhaps I can just remove the ending ones. I get paranoid with
> > > macro variables, and tend to over do it so that there's no question.  
> > 
> > Why not make it an inline function?
> 
> Matters if that removes the strlen(const) optimization. I could try it
> and see what happens.

Using

static inline bool str_has_prefix(const char *str, const char prefix[])
{
	return !strncmp(str, prefix, strlen(prefix));
}

eliminates the strlen with gcc 4.8 (oldest I still have)

$ cat lib/test_module.c
 * This module emits "Hello, world" on printk when loaded.
 *
 * It is designed to be used for basic evaluation of the module loading
 * subsystem (for example when validating module signing/verification). It
 * lacks any extra dependencies, and will not normally be loaded by the
 * system unless explicitly requested by name.
 */

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

#include <linux/init.h>
#include <linux/module.h>
#include <linux/printk.h>

static inline bool str_has_prefix(const char *str, const char prefix[])
{
	return !strncmp(str, prefix, strlen(prefix));
}

bool test_str_has_prefix(const char *foo)
{
	return str_has_prefix("TomJonesPrefix", foo);
}

bool test_str_has_prefix_TomJones(void)
{
	return str_has_prefix("TomJonesPrefix", "TomJones");
}

$ make CC=/usr/bin/gcc-4.8 lib/test_module.o
$ objdump -d -s lib/test_module.o

lib/test_module.o:     file format elf64-x86-64

Contents of section .text:
 0000 534889fb e8000000 00b90f00 00004883  SH............H.
 0010 f80f4889 df480f4e c848c7c6 00000000  ..H..H.N.H......
 0020 4839c9f3 a65b0f94 c0c3660f 1f440000  H9...[....f..D..
 0030 b8010000 00c3                        ......          
Contents of section .rodata.str1.1:
 0000 546f6d4a 6f6e6573 50726566 697800    TomJonesPrefix. 
Contents of section .comment:
 0000 00474343 3a202855 62756e74 7520342e  .GCC: (Ubuntu 4.
 0010 382e352d 34756275 6e747539 2920342e  8.5-4ubuntu9) 4.
 0020 382e3500                             8.5.            
Contents of section .orc_unwind_ip:
 0000 00000000 00000000 00000000 00000000  ................
 0010 00000000 00000000                    ........        
Contents of section .orc_unwind:
 0000 08000000 05001000 00000500 08000000  ................
 0010 05000000 00000000 08000000 05000000  ................
 0020 00000000                             ....            

Disassembly of section .text:

0000000000000000 <test_str_has_prefix>:
   0:	53                   	push   %rbx
   1:	48 89 fb             	mov    %rdi,%rbx
   4:	e8 00 00 00 00       	callq  9 <test_str_has_prefix+0x9>
   9:	b9 0f 00 00 00       	mov    $0xf,%ecx
   e:	48 83 f8 0f          	cmp    $0xf,%rax
  12:	48 89 df             	mov    %rbx,%rdi
  15:	48 0f 4e c8          	cmovle %rax,%rcx
  19:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
  20:	48 39 c9             	cmp    %rcx,%rcx
  23:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
  25:	5b                   	pop    %rbx
  26:	0f 94 c0             	sete   %al
  29:	c3                   	retq   
  2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000030 <test_str_has_prefix_TomJones>:
  30:	b8 01 00 00 00       	mov    $0x1,%eax
  35:	c3                   	retq   


