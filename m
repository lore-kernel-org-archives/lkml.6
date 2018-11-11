Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BDEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84C821104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qbhp+uE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84C821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeKLDKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729227AbeKLDKX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:10:23 -0500
Received: from jouet.infradead.org (d66-183-243-195.bchsia.telus.net [66.183.243.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC17E21104;
        Sun, 11 Nov 2018 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541956876;
        bh=Rp5t7pYW9Tc8IxN/xVSWjZgY6CKbo2fGW6B+fjQXMvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qbhp+uE5GP2FbSNmC0zoXbhLsBzT5U+NJF2cW7YwIFxPbCQUcl71pt3SmCDhBjq7z
         2HsLaY9KV6GsPpNgVc8J439ik0ZtslBFcbAjkBhdBLjNV52rN95kj+w5/DmJW9jKW4
         ro89M55lpak2UjMAcnOsbOk/KfEozjW7f23XZmz4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id AC3F71443D0; Sun, 11 Nov 2018 09:21:10 -0800 (PST)
Date:   Sun, 11 Nov 2018 09:21:10 -0800
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>, jolsa@kernel.org,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf script: share code and output format for uregs and
 iregs output
Message-ID: <20181111172110.GB1111@kernel.org>
References: <20181107223437.9071-1-milian.wolff@kdab.com>
 <20181109081945.GI29732@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109081945.GI29732@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 09, 2018 at 09:19:45AM +0100, Jiri Olsa escreveu:
> On Wed, Nov 07, 2018 at 11:34:37PM +0100, Milian Wolff wrote:
> > The iregs output was missing the newline at end as well as the leading
> > ABI output. This made it hard to compare the iregs and uregs values.
> > Instead, use a single function to output the register values and use
> > it for both, iregs and uregs, to ensure the output is consistent.
> > 
> > Before:
> > 
> > ```
> > perf  7049 [-01]  1343.354347:          1 cycles:ppp:
> >         ffffffffa7bc21ce perf_event_exec+0x18e (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7c7ead3 setup_new_exec+0xf3 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7cd7be5 load_elf_binary+0x395 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7c7e540 search_binary_handler+0x80 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7c7f1aa __do_execve_file.isra.13+0x58a (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7c7f561 do_execve+0x21 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7c7f596 __x64_sys_execve+0x26 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7a041cb do_syscall_64+0x5b (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa840008c entry_SYSCALL_64+0x7c (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >    AX:0x80000000    BX:0x0    CX:0x0    DX:0x7    SI:0xf    DI:0x286    BP:0xffff95bc8213a460    SP:0xffffacbf0ba97d18    IP:0xffffffffa7bc21cd FLAGS:0x28e    CS:0x10    SS:0x18    R8:0x2    R9:0x21440   R10:0x33816fb3b8c   R11:0x1   R12:0xffff95bc8213a460   R13:0xffff95bc8213a400   R14:0xffff95bc8213a400   R15:0x1  ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7f84ad85798b    DX:0x560209699d50    SI:0x7ffe2c7a6820    DI:0x7ffe2c7a8c9b    BP:0x7ffe2c7a20d0    SP:0x7ffe2c7a2058    IP:0x7f84ad85798b FLAGS:0x206    CS:0x33    SS:0x2b    R8:0x7ffe2c7a2030    R9:0x7f84ae55f010   R10:0x8   R11:0x206   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff
> > 
> > perf  7049 [-01]  1343.354363:          1 cycles:ppp:
> >         ...
> > ```
> > 
> > After:
> > 
> > ```
> > perf  7049 [-01]  1343.354347:          1 cycles:ppp:
> >         ffffffffa7bc21ce perf_event_exec+0x18e (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7c7ead3 setup_new_exec+0xf3 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7cd7be5 load_elf_binary+0x395 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7c7e540 search_binary_handler+0x80 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7c7f1aa __do_execve_file.isra.13+0x58a (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7c7f561 do_execve+0x21 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7c7f596 __x64_sys_execve+0x26 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa7a041cb do_syscall_64+0x5b (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >         ffffffffa840008c entry_SYSCALL_64+0x7c (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
> >  ABI:2    AX:0x80000000    BX:0x0    CX:0x0    DX:0x7    SI:0xf    DI:0x286    BP:0xffff95bc8213a460    SP:0xffffacbf0ba97d18    IP:0xffffffffa7bc21cd FLAGS:0x28e    CS:0x10    SS:0x18    R8:0x2    R9:0x21440   R10:0x33816fb3b8c   R11:0x1   R12:0xffff95bc8213a460   R13:0xffff95bc8213a400   R14:0xffff95bc8213a400   R15:0x1
> >  ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7f84ad85798b    DX:0x560209699d50    SI:0x7ffe2c7a6820    DI:0x7ffe2c7a8c9b    BP:0x7ffe2c7a20d0    SP:0x7ffe2c7a2058    IP:0x7f84ad85798b FLAGS:0x206    CS:0x33    SS:0x2b    R8:0x7ffe2c7a2030    R9:0x7f84ae55f010   R10:0x8   R11:0x206   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
