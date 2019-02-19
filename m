Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E49C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8988821848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YA+kICQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfBSEem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:34:42 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39663 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfBSEel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:34:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so21721182qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 20:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1FCE5iC4BBC2eXOp5i6IQ7gQBc6Hx/LSa8ABhtHuGCU=;
        b=YA+kICQrBmV0PLuxaiOxmorWhb75h4kt+gKZ5Sh6PjIdfKyZjqeHUzx7+oFcLCQIeB
         dkKwjFaucvxeTVT+hl0vrEDD2TwGxPUrhuM8lY0OyiA0Li515i8LU9lldyvdb0JmwRFp
         c6kdd4tRKtX8HWyyzqLC8zuFgLilL+oPODNEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1FCE5iC4BBC2eXOp5i6IQ7gQBc6Hx/LSa8ABhtHuGCU=;
        b=pPa8TaYsIolWLvkCDNS/gc9kbFZRtfRGk1moTahab4k4Xk+eSD71XHMl4w2WwoeoVp
         WcA/vQlVzR+PtHkSofZ7ZRh8v0pT0MLgavm2CEE7nrtV0g2Cxs+vAjAXPQL0RQGX0v6F
         u0GdOdJCzC3triTq7gHC4NtA32+w8lrM6fVnBRsarJygUxR3D5QpQsJy91m5Wj9H3qKM
         0xmoSKtRN+eFuOeBmyIIIThrqRxmyy9LCJimYTiAt34GKbT66pIIMFtM67bMYy15HqZl
         i8+141JQrj7woRiMJJAWW/erQwsykRFH1TJb0jDzmLOZX2RlqBQjn4o4TsVGENLIFUzl
         Isyw==
X-Gm-Message-State: AHQUAub0jZY7SyOpoBlJLxNTCFzbLr/DF//v02Y8OwMN21yRu5QrcAAM
        dYvIEpzTjRlM60s2A6Ubopd9oA==
X-Google-Smtp-Source: AHgI3IbIEXB71RRU4F0E57ZPpEw15kxNZPxOfffBh1cbGliozorDBZzaJ8pPM85NQI2di/ryDPR7CA==
X-Received: by 2002:ac8:2cd1:: with SMTP id 17mr20832074qtx.299.1550550880201;
        Mon, 18 Feb 2019 20:34:40 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id a3sm8047255qkd.86.2019.02.18.20.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 20:34:39 -0800 (PST)
Date:   Mon, 18 Feb 2019 23:34:38 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190219043438.GC201007@google.com>
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
 <CAK7LNAThSm1n1B_Ss0gRDZ3H-DWj2bvpZ+6Ui2jEo4Pt9YynEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAThSm1n1B_Ss0gRDZ3H-DWj2bvpZ+6Ui2jEo4Pt9YynEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:14:11PM +0900, Masahiro Yamada wrote:
> On Fri, Feb 15, 2019 at 11:48 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
> > > Introduce in-kernel headers and other artifacts which are made available
> > > as an archive through proc (/proc/kheaders.txz file).
> 
> 
> The extension '.txz' is not used in kernel code.
> 
> 
> '.tar.xz' is used for 'tarxz-pkg', 'perf-tarxz-src-pkg' etc.
> 
> 
> $ git grep  '\.txz'
> $ git grep  '\.tar\.xz'
> Documentation/admin-guide/README.rst:     xz -cd linux-4.X.tar.xz | tar xvf -
> arch/x86/crypto/camellia-aesni-avx-asm_64.S: *
> http://koti.mbnet.fi/axh/crypto/camellia-BSD-1.2.0-aesni1.tar.xz
> crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> scripts/package/Makefile:       @echo '  perf-tarxz-src-pkg  - Build
> $(perf-tar).tar.xz source tarball'
> tools/testing/selftests/gen_kselftest_tar.sh:
>  ext=".tar.xz"
> 
> 
> 
> I prefer '.tar.xz' for consistency.

Ok, I will change it to that.

> BTW, have you ever looked at scripts/extract-ikconfig?
> 
> You added IKHD_ST and IKHD_ED
> just to mimic kernel/configs.c
> 
> It is currently pointless without the extracting tool,
> but you might think it is useful to extract headers
> from vmlinux or the module without mounting procfs.

I am planing add to extraction support in the future, so I prefer to leave the
markers as it is for now. Hope that's Ok with you.


> > > This archive makes
> > > it possible to build kernel modules, run eBPF programs, and other
> > > tracing programs that need to extend the kernel for tracing purposes
> > > without any dependency on the file system having headers and build
> > > artifacts.
> > >
> > > On Android and embedded systems, it is common to switch kernels but not
> > > have kernel headers available on the file system. Raw kernel headers
> > > also cannot be copied into the filesystem like they can be on other
> > > distros, due to licensing and other issues. There's no linux-headers
> > > package on Android. Further once a different kernel is booted, any
> > > headers stored on the file system will no longer be useful. By storing
> > > the headers as a compressed archive within the kernel, we can avoid these
> > > issues that have been a hindrance for a long time.
> >
> > The set looks good to me and since the main use case is building bpf progs
> > I can route it via bpf-next tree if there are no objections.
> > Masahiro, could you please ack it?
> 
> 
> Honestly, I was not tracking this thread
> since I did not know I was responsible for this.
> 
> 
> I just started to take a closer look, then immediately got scared.
> 
> This version is not mature enough for the merge.
> First of all, this patch cannot be compiled out-of-tree (O= option).

Oh, ok. This is not how I build the kernel. So I am sorry for missing that. I
will try this out-of-tree build option and fix it.


> I do not know why 0-day bot did not catch this apparent breakage.
> 
> 
> $ make -j8 O=hoge
> make[1]: Entering directory '/home/masahiro/workspace/bsp/linux/hoge'
>   GEN     Makefile
>   Using .. as source for kernel
>   DESCEND  objtool
>   CALL    ../scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
> make[2]: *** No rule to make target 'Module.symvers', needed by
> 'kernel/kheaders_data.txz'.  Stop.
> make[2]: *** Waiting for unfinished jobs....
> /home/masahiro/workspace/bsp/linux/Makefile:1043: recipe for target
> 'kernel' failed
> make[1]: *** [kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make[1]: Leaving directory '/home/masahiro/workspace/bsp/linux/hoge'
> Makefile:152: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
> 
> 
> 
> 
> 
> I was able to compile it in-tree
> but it makes the incremental build extremely slow.
> 
> (Here, the incremental build means
> "make" without changing any code after the full build.)
> 
> 
> 
> 
> Before this patch, "make -j8" took 11 sec on my machine.
> 
> real 0m11.777s
> user 0m16.608s
> sys 0m5.164s
> 
> 
> 
> After this patch, x86_64_defconfig + CONFIG_IKHEADERS_PROC=y
> takes 53 sec for me since kernel/kheaders_data.txz is regenerated
> every time even when you did not touch any source file.

Hmm, true. Let me know look into that as well..


> $ time make -j8
>   DESCEND  objtool
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   GEN     kernel/kheaders_data.txz
>   UPD     kernel/kheaders_data.h
>   CC      kernel/kheaders.o
>   AR      kernel/built-in.a
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   AR      built-in.a
>   LD      vmlinux.o
>   MODPOST vmlinux.o
>   KSYM    .tmp_kallsyms1.o
>   KSYM    .tmp_kallsyms2.o
>   LD      vmlinux
>   SORTEX  vmlinux
>   SYSMAP  System.map
>   Building modules, stage 2.
>   CC      arch/x86/boot/version.o
>   MODPOST 17 modules
>   VOFFSET arch/x86/boot/compressed/../voffset.h
>   OBJCOPY arch/x86/boot/compressed/vmlinux.bin
>   RELOCS  arch/x86/boot/compressed/vmlinux.relocs
>   CC      arch/x86/boot/compressed/kaslr.o
>   GZIP    arch/x86/boot/compressed/vmlinux.bin.gz
>   CC      arch/x86/boot/compressed/misc.o
>   MKPIGGY arch/x86/boot/compressed/piggy.S
>   AS      arch/x86/boot/compressed/piggy.o
>   LD      arch/x86/boot/compressed/vmlinux
>   ZOFFSET arch/x86/boot/zoffset.h
>   OBJCOPY arch/x86/boot/vmlinux.bin
>   AS      arch/x86/boot/header.o
>   LD      arch/x86/boot/setup.elf
>   OBJCOPY arch/x86/boot/setup.bin
>   BUILD   arch/x86/boot/bzImage
> Setup is 15612 bytes (padded to 15872 bytes).
> System is 12673 kB
> CRC 697aaf88
> Kernel: arch/x86/boot/bzImage is ready  (#6)
> 
> real 0m53.024s
> user 0m32.076s
> sys 0m9.296s
> 
> 
> 
> 
> Also, I notice $(ARCH) must be fixed to $(SRCARCH),
> but that is one of minor issues.

Ok.

> We should take time for careful review and test.

Yes, I agree.

> Please give me more time for thorough review.

Sure. Thanks a lot for the feedback provided so far. I will send another
revision soon with all the suggestions addressed.

thanks,

 - Joel

