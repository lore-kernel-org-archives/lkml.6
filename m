Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939638AbeE1PAY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:00:24 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36012 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937092AbeE1O4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:56:24 -0400
Subject: Re: [PATCH] powerpc/Makefile: fix build failure by disabling
 attribute-alias warning
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
 <20180528143719.GB17342@gate.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <63367b72-85a9-fc1f-763f-eaa5e6027ae4@c-s.fr>
Date: Mon, 28 May 2018 16:56:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180528143719.GB17342@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 28/05/2018 à 16:37, Segher Boessenkool a écrit :
> On Mon, May 28, 2018 at 02:17:49PM +0000, Christophe Leroy wrote:
>> Latest GCC version emit many warnings similar to the following one.
> 
> You didn't actually show an example?

Yes I forgot:

In file included from arch/powerpc/kernel/syscalls.c:24:
./include/linux/syscalls.h:233:18: warning: 'sys_mmap2' alias between 
functions of incompatible types 'long int(long unsigned int,  size_t, 
long unsigned int,  long unsigned int,  long unsigned int,  long 
unsigned int)' {aka 'long int(long unsigned int,  unsigned int,  long 
unsigned int,  long unsigned int,  long unsigned int,  long unsigned 
int)'} and 'long int(long int,  long int,  long int,  long int,  long 
int,  long int)' [-Wattribute-alias]
   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                   ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro 
'__SYSCALL_DEFINEx'
   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
   ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:216:36: note: in expansion of macro 
'SYSCALL_DEFINEx'
  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, 
__VA_ARGS__)
                                     ^~~~~~~~~~~~~~~
arch/powerpc/kernel/syscalls.c:65:1: note: in expansion of macro 
'SYSCALL_DEFINE6'
  SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
  ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:238:18: note: aliased declaration here
   asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                   ^~~~~~~~
./include/linux/syscalls.h:222:2: note: in expansion of macro 
'__SYSCALL_DEFINEx'
   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
   ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:216:36: note: in expansion of macro 
'SYSCALL_DEFINEx'
  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, 
__VA_ARGS__)
                                     ^~~~~~~~~~~~~~~
arch/powerpc/kernel/syscalls.c:65:1: note: in expansion of macro 
'SYSCALL_DEFINE6'
  SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
  ^~~~~~~~~~~~~~~

> 
> This warning should detect serious problems, so don't disable it without
> first investigating please.

It's been a discussion on this topic, ref 
https://lkml.org/lkml/2017/12/5/581

It says "The new warning seems reasonable in principle, but it doesn't
help us here, since we rely on the type mismatch to sanitize the
system call arguments. After I reported this as GCC PR82435, a new
-Wno-attribute-alias option was added that could be used to turn the
warning off globally on the command line, but I'd prefer to do it a
little more fine-grained"


> 
> What do you call "latest version", btw?  Trunk, aka 9.0?  Or the most
> advanced release, 8.1?  Or the latest release (which also is 8.1 :-) )

I encounter it with 8.1
According the refered discusion, it linked to GCC 8

Christophe

> 
> 
> Segher
> 
