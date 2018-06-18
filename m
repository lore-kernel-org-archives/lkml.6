Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964C620874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964C620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755148AbeFRHUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:20:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13324 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754944AbeFRHUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:20:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 418MvF5Vp3z9ttC3;
        Mon, 18 Jun 2018 09:20:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RuveakZzuvTZ; Mon, 18 Jun 2018 09:20:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 418MvF4tFMz9ttBX;
        Mon, 18 Jun 2018 09:20:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29B408B8A6;
        Mon, 18 Jun 2018 09:20:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 88cw-vUhYoVd; Mon, 18 Jun 2018 09:20:48 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 752958B74B;
        Mon, 18 Jun 2018 09:20:47 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/cell: fix build failure by disabling
 attribute-alias warning
From:   Christophe LEROY <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, arnd@arndb.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>
References: <dec3cf2521a8e5dfc78953363b1f55aaa261a052.1527609833.git.christophe.leroy@c-s.fr>
Message-ID: <87114f89-0f42-8aa4-f780-dd5832994065@c-s.fr>
Date:   Mon, 18 Jun 2018 09:20:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <dec3cf2521a8e5dfc78953363b1f55aaa261a052.1527609833.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/05/2018 à 18:06, Christophe Leroy a écrit :
> Latest GCC version emit the following warnings
> 
> As arch/powerpc code is built with -Werror, this breaks build with
> GCC 8.1
> 
> This patch inhibits those warnings
> 
>    CC      arch/powerpc/platforms/cell/spu_syscalls.o
> In file included from arch/powerpc/platforms/cell/spu_syscalls.c:26:
> ./include/linux/syscalls.h:233:18: error: 'sys_spu_create' alias between functions of incompatible types 'long int(const char *, unsigned int,  umode_t,  int)' {aka 'long int(const char *, unsigned int,  short unsigned int,  int)'} and 'long int(long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
>    asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                    ^~~
> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/syscalls.h:214:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>   #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
>                                      ^~~~~~~~~~~~~~~
> arch/powerpc/platforms/cell/spu_syscalls.c:70:1: note: in expansion of macro 'SYSCALL_DEFINE4'
>   SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
>   ^~~~~~~~~~~~~~~
> ./include/linux/syscalls.h:238:18: note: aliased declaration here
>    asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                    ^~~~~~~~
> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/syscalls.h:214:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>   #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
>                                      ^~~~~~~~~~~~~~~
> arch/powerpc/platforms/cell/spu_syscalls.c:70:1: note: in expansion of macro 'SYSCALL_DEFINE4'
>   SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
>   ^~~~~~~~~~~~~~~
> ./include/linux/syscalls.h:233:18: error: 'sys_spu_run' alias between functions of incompatible types 'long int(int,  __u32 *, __u32 *)' {aka 'long int(int,  unsigned int *, unsigned int *)'} and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
>    asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                    ^~~
> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>   #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>                                      ^~~~~~~~~~~~~~~
> arch/powerpc/platforms/cell/spu_syscalls.c:94:1: note: in expansion of macro 'SYSCALL_DEFINE3'
>   SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
>   ^~~~~~~~~~~~~~~
> ./include/linux/syscalls.h:238:18: note: aliased declaration here
>    asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                    ^~~~~~~~
> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>    __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>   #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
>                                      ^~~~~~~~~~~~~~~
> arch/powerpc/platforms/cell/spu_syscalls.c:94:1: note: in expansion of macro 'SYSCALL_DEFINE3'
>   SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
>   ^~~~~~~~~~~~~~~
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

If the serie from Paul Burton 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=50442 
goes in, this patch won't be necessary.

Christophe

> ---
> v2: added '#pragma GCC diagnostic ignored "-Wpragmas"' to avoid build failure on old GCC
> 
>   arch/powerpc/platforms/cell/spu_syscalls.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
> index 263413a34823..7862279a82e4 100644
> --- a/arch/powerpc/platforms/cell/spu_syscalls.c
> +++ b/arch/powerpc/platforms/cell/spu_syscalls.c
> @@ -67,6 +67,9 @@ static inline void spufs_calls_put(struct spufs_calls *calls) { }
>   
>   #endif /* CONFIG_SPU_FS_MODULE */
>   
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wpragmas"
> +#pragma GCC diagnostic ignored "-Wattribute-alias"
>   SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
>   	umode_t, mode, int, neighbor_fd)
>   {
> @@ -111,6 +114,7 @@ SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
>   	spufs_calls_put(calls);
>   	return ret;
>   }
> +#pragma GCC diagnostic pop
>   
>   #ifdef CONFIG_COREDUMP
>   int elf_coredump_extra_notes_size(void)
> 
