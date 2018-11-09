Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B56C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99DD20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99DD20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbeKIR7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:59:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbeKIR7S (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:59:18 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5597C307D855;
        Fri,  9 Nov 2018 08:19:49 +0000 (UTC)
Received: from krava (unknown [10.40.205.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id C04C5102BCEB;
        Fri,  9 Nov 2018 08:19:46 +0000 (UTC)
Date:   Fri, 9 Nov 2018 09:19:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     acme@kernel.org, jolsa@kernel.org, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf script: share code and output format for uregs and
 iregs output
Message-ID: <20181109081945.GI29732@krava>
References: <20181107223437.9071-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107223437.9071-1-milian.wolff@kdab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 09 Nov 2018 08:19:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 11:34:37PM +0100, Milian Wolff wrote:
> The iregs output was missing the newline at end as well as the leading
> ABI output. This made it hard to compare the iregs and uregs values.
> Instead, use a single function to output the register values and use
> it for both, iregs and uregs, to ensure the output is consistent.
> 
> Before:
> 
> ```
> perf  7049 [-01]  1343.354347:          1 cycles:ppp:
>         ffffffffa7bc21ce perf_event_exec+0x18e (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7c7ead3 setup_new_exec+0xf3 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7cd7be5 load_elf_binary+0x395 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7c7e540 search_binary_handler+0x80 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7c7f1aa __do_execve_file.isra.13+0x58a (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7c7f561 do_execve+0x21 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7c7f596 __x64_sys_execve+0x26 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7a041cb do_syscall_64+0x5b (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa840008c entry_SYSCALL_64+0x7c (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>    AX:0x80000000    BX:0x0    CX:0x0    DX:0x7    SI:0xf    DI:0x286    BP:0xffff95bc8213a460    SP:0xffffacbf0ba97d18    IP:0xffffffffa7bc21cd FLAGS:0x28e    CS:0x10    SS:0x18    R8:0x2    R9:0x21440   R10:0x33816fb3b8c   R11:0x1   R12:0xffff95bc8213a460   R13:0xffff95bc8213a400   R14:0xffff95bc8213a400   R15:0x1  ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7f84ad85798b    DX:0x560209699d50    SI:0x7ffe2c7a6820    DI:0x7ffe2c7a8c9b    BP:0x7ffe2c7a20d0    SP:0x7ffe2c7a2058    IP:0x7f84ad85798b FLAGS:0x206    CS:0x33    SS:0x2b    R8:0x7ffe2c7a2030    R9:0x7f84ae55f010   R10:0x8   R11:0x206   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff
> 
> perf  7049 [-01]  1343.354363:          1 cycles:ppp:
>         ...
> ```
> 
> After:
> 
> ```
> perf  7049 [-01]  1343.354347:          1 cycles:ppp:
>         ffffffffa7bc21ce perf_event_exec+0x18e (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7c7ead3 setup_new_exec+0xf3 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7cd7be5 load_elf_binary+0x395 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7c7e540 search_binary_handler+0x80 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7c7f1aa __do_execve_file.isra.13+0x58a (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7c7f561 do_execve+0x21 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7c7f596 __x64_sys_execve+0x26 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa7a041cb do_syscall_64+0x5b (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>         ffffffffa840008c entry_SYSCALL_64+0x7c (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
>  ABI:2    AX:0x80000000    BX:0x0    CX:0x0    DX:0x7    SI:0xf    DI:0x286    BP:0xffff95bc8213a460    SP:0xffffacbf0ba97d18    IP:0xffffffffa7bc21cd FLAGS:0x28e    CS:0x10    SS:0x18    R8:0x2    R9:0x21440   R10:0x33816fb3b8c   R11:0x1   R12:0xffff95bc8213a460   R13:0xffff95bc8213a400   R14:0xffff95bc8213a400   R15:0x1
>  ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7f84ad85798b    DX:0x560209699d50    SI:0x7ffe2c7a6820    DI:0x7ffe2c7a8c9b    BP:0x7ffe2c7a20d0    SP:0x7ffe2c7a2058    IP:0x7f84ad85798b FLAGS:0x206    CS:0x33    SS:0x2b    R8:0x7ffe2c7a2030    R9:0x7f84ae55f010   R10:0x8   R11:0x206   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
