Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D975DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDB62173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aolAv2C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfBSFMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:12:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39002 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBSFMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:12:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so21781940qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cGBUWjaDlcQIPzo4F5E6iO9ob6JqRw4yCLGX5zw2eMM=;
        b=aolAv2C7w86R4gWSViX9cMjwLfUqRX+7evBV8NPmPS9xXrhVl7UEi004UMIiO/aJqf
         Emc315u74IsSpuoTZlk+Q5O81jGYmNz2FVd/GGC5r8fhugu76O4q++CBdYnuogGt9A0l
         iDKTyz2NkvwU15le+h7Hx7RKNcCT+Z4mhc9dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cGBUWjaDlcQIPzo4F5E6iO9ob6JqRw4yCLGX5zw2eMM=;
        b=NGAhYdgQtKoDJjH/DU0/46gGM2LXpMsCx5x0bEDluduklbOkVUWAD++nRYN3LkhxRD
         9BrU1eIxkpjNlO3HIebCmZtBHUQ6srWZHVvYdUWLkbcFdTjxQ+3bCLik54Ift9CUJtn1
         B0sH/5Jn7XbCaqp8JsPeah8oy/L03iWTwnSBfsIaYUcX18jNSgnIQryVrsIrwKGCWkNR
         ateAd2kUbwRhyoK46kL7kunlbNwNIu2BLM6jLP8Zx8nnFjvBRidgRs9uCuklsTXzWaSn
         Yv8iFDtgjp09eDOvQAd7L4HkAt9JTDcOdZQrg238e0h3upw3dBl4D2UwLJ7MFJ7xvNgk
         NCrw==
X-Gm-Message-State: AHQUAuZIPCyfNDi1I+tegHCyvvkkXucX2aCHFvBJpocjHKmW8FU6OyoO
        fRkHg9NLiSS5X7Hn/s/sabEz5A==
X-Google-Smtp-Source: AHgI3IZTg66sdxkyGQN28OFNjYL0Y9nV+aYr+H25/iHD7dn32Qsm9dnRtxFsVHQznYQeueT3ZH8hJg==
X-Received: by 2002:a0c:ab87:: with SMTP id j7mr18026669qvb.137.1550553124467;
        Mon, 18 Feb 2019 21:12:04 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id a133sm2604248qkg.66.2019.02.18.21.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 21:12:03 -0800 (PST)
Date:   Tue, 19 Feb 2019 00:12:03 -0500
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
Message-ID: <20190219051203.GD201007@google.com>
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
[..]
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
> 
> So, this is not so simple since it is a circular dependency...

I guess I was not building a pristine tree either and missed this circular
dependency :-/ . Any ideas on how we can fix the Module.symvers issue? One
idea is to reserve the space in the binaries, but only populate the space
reserved in the binary *after* the modpost stage, once the archive is ready..

thanks,

 - Joel

