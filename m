Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754590AbeCGSwH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:52:07 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38413 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754173AbeCGSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:52:06 -0500
X-Google-Smtp-Source: AG47ELvQwTk6URbmgicAKKJYj811Qhpx9quqOZD+M7XfCYVpSazkYFirOICXtl363DnZ922uJADuHw==
Date: Wed, 7 Mar 2018 13:52:03 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Matthias Kaehlcke <mka@chromium.org>
cc: Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] ARM: LTO: avoid THUMB2_KERNEL+LTO
In-Reply-To: <20180307183059.GA57047@google.com>
Message-ID: <nycvar.YSQ.7.76.1803071344540.7678@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-3-arnd@arndb.de> <20180307183059.GA57047@google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2018, Matthias Kaehlcke wrote:

> El Tue, Feb 20, 2018 at 10:59:49PM +0100 Arnd Bergmann ha dit:
> 
> > Trying to build an LTO-Enabled kernel with Thumb2 instructions failed
> > horribly for me, with an endless output of things like
> > 
> > ccVnNycO.s:2665: Error: thumb conditional instruction should be in IT block -- `bxne lr'
> > ccVnNycO.s:7128: Error: thumb conditional instruction should be in IT block -- `strexeq r5,r2,[r3]'
> > ccVnNycO.s:7258: Error: thumb conditional instruction should be in IT block -- `strexeq lr,r0,[r3]'
> > ccVnNycO.s:17380: Error: thumb conditional instruction should be in IT block -- `strexeq r1,r2,[r6]'
> > ccVnNycO.s:19163: Error: thumb conditional instruction should be in IT block -- `strexeq r8,r6,[r3]'
> > ccVnNycO.s:22722: Error: thumb conditional instruction should be in IT block -- `strexeq r7,r1,[r0]'
> > ccVnNycO.s:24105: conditional infixes are deprecated in unified syntax
> > ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `sbcccs r1,r1,r3'
> > ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'
> > ccVnNycO.s:24210: conditional infixes are deprecated in unified syntax
> > ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `sbcccs r2,r2,r3'
> > ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'
> 
> For the record:
> 
> The errors about sbcccs and movcc probably stem from here:
> 
> /* We use 33-bit arithmetic here... */
> #define __range_ok(addr, size) ({ \
>         unsigned long flag, roksum; \
>         __chk_user_ptr(addr);   \
>         __asm__("adds %1, %2, %3; sbcccs %1, %1, %0; movcc %0, #0" \
>                 : "=&r" (flag), "=&r" (roksum) \
>                 : "r" (addr), "Ir" (size), "0" (current_thread_info()->addr_limit) \
>                 : "cc"); \
>         flag; })
> 
> arch/arm/include/asm/uaccess.h
> 
> I stumbled across this when trying to build a 32-bit ARM kernel with
> clang.

You have to tell clang to pass -mno-warn-deprecated to gas. That's what 
the gcc build currently does.

In this particular case with LTO, the same trick as done for 
-mimplicit-it=always would do it to work around 
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78353.


Nicolas
