Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1311C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DC820700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VgxvC5EH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfBSPQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:16:57 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46619 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfBSPQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:16:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id z25so1739165qti.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=En1HWWBT1ftzQJAOCwW5PjG0oMP3Zavpzp6UFdsvhfo=;
        b=VgxvC5EHXwTUEA5hc/DiIGE76bUDg7NSH1nq9Ozl1CVRDKizuObL+mPJvF6EhKlBfB
         AdnSY5Oe7G0BuiPugDxYTKDp47WB5iA+lsi77dJpHq4eGfK1Gkc4AxZzuZsfYeEiSKHN
         6Fdr33TLtrvpxMOQ9K0e76lrG1rGMbwWjhcVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=En1HWWBT1ftzQJAOCwW5PjG0oMP3Zavpzp6UFdsvhfo=;
        b=bwZ3G+1yAG0+XpSFAVAU5wWkxxdWrf1xgrBrAPmXb9BSg2eb37EKQItON3MwU/6C94
         GQDkw/nzRXbSFv2NQEOHr5UQTx1+LGtlxhvFjfyXShyvfqWuPvc4RENygrhp4rsaz2hF
         f+BitY19h/Y2MkE7B/ytUcmdGgMH3Sr7UMmaYzggliU3PDQxqika+Py/LLxlD6ySZJyc
         6StiPbx4X3nDZULkNe88MX20n1OYRb5nIQDIxG0Ed9G/zUx+uiaBwtXsaxoy3LDoSPHf
         PenGxCg578tTS2F3uRpU5kgUHIlQS4RugYSfFOOVwQWzoXZeCCmkGlE7qBw0bJ8FwpnD
         kutA==
X-Gm-Message-State: AHQUAuai0qJzUSu3zzYje4U3BcSTelWeZKO5gq3Y2iNwN5afc100DUxX
        Z1i/7rLLMTjFfypyO7Ove4MzMg==
X-Google-Smtp-Source: AHgI3IZotZh3ayaBAfR6+uCgKq/ub+mJAc5ban6NYVGT9SK7yL9pAFRDXeB3iceJf6Tmsq77new9XQ==
X-Received: by 2002:a0c:91bb:: with SMTP id n56mr22388228qvn.77.1550589414777;
        Tue, 19 Feb 2019 07:16:54 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id a68sm2664380qkj.82.2019.02.19.07.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 07:16:53 -0800 (PST)
Date:   Tue, 19 Feb 2019 10:16:52 -0500
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
Message-ID: <20190219151652.GA110907@google.com>
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
 <CAK7LNAThSm1n1B_Ss0gRDZ3H-DWj2bvpZ+6Ui2jEo4Pt9YynEA@mail.gmail.com>
 <CAK7LNATf4adEEqWko2YO46wHHi-Vvc+_LBjQGNnM7rt8GSOgZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATf4adEEqWko2YO46wHHi-Vvc+_LBjQGNnM7rt8GSOgZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:42:13PM +0900, Masahiro Yamada wrote:
> On Tue, Feb 19, 2019 at 1:14 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Fri, Feb 15, 2019 at 11:48 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
> > > > Introduce in-kernel headers and other artifacts which are made available
> > > > as an archive through proc (/proc/kheaders.txz file).
> >
> >
> > The extension '.txz' is not used in kernel code.
> >
> >
> > '.tar.xz' is used for 'tarxz-pkg', 'perf-tarxz-src-pkg' etc.
> >
> >
> > $ git grep  '\.txz'
> > $ git grep  '\.tar\.xz'
> > Documentation/admin-guide/README.rst:     xz -cd linux-4.X.tar.xz | tar xvf -
> > arch/x86/crypto/camellia-aesni-avx-asm_64.S: *
> > http://koti.mbnet.fi/axh/crypto/camellia-BSD-1.2.0-aesni1.tar.xz
> > crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> > crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> > crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> > crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> > crypto/testmgr.h: *   https://bench.cr.yp.to/supercop/supercop-20170228.tar.xz
> > scripts/package/Makefile:       @echo '  perf-tarxz-src-pkg  - Build
> > $(perf-tar).tar.xz source tarball'
> > tools/testing/selftests/gen_kselftest_tar.sh:
> >  ext=".tar.xz"
> >
> >
> >
> > I prefer '.tar.xz' for consistency.
> >
> >
> >
> >
> >
> >
> > BTW, have you ever looked at scripts/extract-ikconfig?
> >
> > You added IKHD_ST and IKHD_ED
> > just to mimic kernel/configs.c
> >
> > It is currently pointless without the extracting tool,
> > but you might think it is useful to extract headers
> > from vmlinux or the module without mounting procfs.
> >
> >
> >
> >
> > > > This archive makes
> > > > it possible to build kernel modules, run eBPF programs, and other
> > > > tracing programs that need to extend the kernel for tracing purposes
> > > > without any dependency on the file system having headers and build
> > > > artifacts.
> > > >
> > > > On Android and embedded systems, it is common to switch kernels but not
> > > > have kernel headers available on the file system. Raw kernel headers
> > > > also cannot be copied into the filesystem like they can be on other
> > > > distros, due to licensing and other issues. There's no linux-headers
> > > > package on Android. Further once a different kernel is booted, any
> > > > headers stored on the file system will no longer be useful. By storing
> > > > the headers as a compressed archive within the kernel, we can avoid these
> > > > issues that have been a hindrance for a long time.
> > >
> > > The set looks good to me and since the main use case is building bpf progs
> > > I can route it via bpf-next tree if there are no objections.
> > > Masahiro, could you please ack it?
> >
> >
> > Honestly, I was not tracking this thread
> > since I did not know I was responsible for this.
> >
> >
> > I just started to take a closer look, then immediately got scared.
> >
> > This version is not mature enough for the merge.
> >
> >
> >
> > First of all, this patch cannot be compiled out-of-tree (O= option).
> >
> >
> > I do not know why 0-day bot did not catch this apparent breakage.
> >
> >
> > $ make -j8 O=hoge
> > make[1]: Entering directory '/home/masahiro/workspace/bsp/linux/hoge'
> >   GEN     Makefile
> >   Using .. as source for kernel
> >   DESCEND  objtool
> >   CALL    ../scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> > make[2]: *** No rule to make target 'Module.symvers', needed by
> > 'kernel/kheaders_data.txz'.  Stop.
> > make[2]: *** Waiting for unfinished jobs....
> > /home/masahiro/workspace/bsp/linux/Makefile:1043: recipe for target
> > 'kernel' failed
> > make[1]: *** [kernel] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make[1]: Leaving directory '/home/masahiro/workspace/bsp/linux/hoge'
> > Makefile:152: recipe for target 'sub-make' failed
> > make: *** [sub-make] Error 2
> 
> 
> 
> 
> I saw this build error for in-tree building as well.
> 
> We cannot build this from a pristine source tree.
> 
> For example, I observed the build error in the following procedure.
> 
> $ make mrproper
> $ make defconfig
>  Set CONFIG_IKHEADERS_PROC=y
> $ make
> 
> 
> 
> 
> Module.symvers is generated in the modpost stage
> (the very last stage of build).
> 
> But, vmlinux depends on kernel/kheaders_data.txz,
> which includes Module.symvers.

Firstly, I want to apologize for not testing this and other corner cases you
brought up. I should have known better. Since my build was working, I assumed
that the feature is working. For that, I am very sorry.

Secondly, it turns out Module.symvers circularly dependency problem also
exists with another use case.
If one does 'make modules_prepare' in a base kernel tree and then tries to
build modules with that tree, a warning like this is printed but the module
still gets built:

  WARNING: Symbol version dump ./Module.symvers
           is missing; modules will have no dependencies and modversions.

  CC [M]  /tmp/testmod/test.o
  Building modules, stage 2.
  MODPOST 1 modules
  CC      /tmp/testmod/test.mod.o
  LD [M]  /tmp/testmod/test.ko

So, I am thinking that at least for first pass I will just drop the inclusion
of Module.symvers in the archive and allow any modules built using
/proc/kheaders.tar.xz to not use it.

Kbuild will print a warning anyway when anyone tries to build using
/proc/kheaders.tar.xz, so if the user really wants module symbol versioning
then they should probably use a full kernel source tree with Module.symvers
available. For our usecase, kernel symbol versioning is a bit useless when
using /proc/kheaders.tar.gz because the proc file is generated with the same
kernel that the module is being built against, and subsequently loaded into
the kernel. So it is not likely that the CRC of a kernel symbol will be
different from what the module expects.

I can't think any other ways at the moment to break the circular dependency
so I'm thinking this is good enough for now especially since Kbuild will
print a proper warning. Let me know what you think?

thanks,

 - Joel

