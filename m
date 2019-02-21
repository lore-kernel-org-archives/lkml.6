Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8635DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB5320842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="l4kaXKN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfBUP3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:29:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37501 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfBUP3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:29:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id a48so31922270qtb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hmcL06PLV3DDeKpddNMRLopXmb6NchEiT8OaIDudw+s=;
        b=l4kaXKN6Ml+bVpI/6CuNUmAtV0a7wQwsO0udHLsADpvfKkKdt/IWuql0VorcdlqoZ7
         MLv5/LLHHg8eyq4YARM2InRXzEok/ZaSv7wgLXakawtWIURdAmUhLYkveU7IFrTdk4Iy
         gu5uYfA3KSTa+CbXoN1jok3NAsw+yhurOVHD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hmcL06PLV3DDeKpddNMRLopXmb6NchEiT8OaIDudw+s=;
        b=jG1G9NUg1ZIvAu0kGwzLb6/TwKwf6WxyclT0WYZbTHfOgBt7LwHmraKaZTifbWWjqt
         WwII//rYDBnXfB6RtmPjBmVC70TpBkEYT7RxS3O0IJjHEq7BhK8RJ/nk5T/+EyAIZ82d
         g8g2IzOrxWeODkyVRr0/fZsAzeEoBdr8XJUOOF+1NXDw7DhYal3RYFypW8pehMF9b9CG
         nuvN0q51AD5cieNX7tENm3u8jAD5lAqqvfak9VFfNFJ/TYwv7iq8cnB2S8Fnq1uCo8gz
         Vg8w3CQKTwrPXGsA3EMVx0M/oaljQ4xUqUOvZtjlQBp5DqYPHZ7x8y6hKOdF4CjPYldn
         UZ4A==
X-Gm-Message-State: AHQUAuZ9sQgLo3MCa1kwVWao/tJ9MSiMvS/xIdtnwWF66WyTfAWxg/EX
        OPk3SDD2TrIuennvq/PhjWG3ig==
X-Google-Smtp-Source: AHgI3Ia101FQb1CkFMTT2NAOxrRxuvv7HSiGv0NAKejWNuyQrRRZbTGDaEtqQ+94DtKkfh29adPnyQ==
X-Received: by 2002:ac8:2246:: with SMTP id p6mr26315353qtp.66.1550762945744;
        Thu, 21 Feb 2019 07:29:05 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id v18sm11191878qkj.13.2019.02.21.07.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:29:04 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:29:04 -0500
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
Message-ID: <20190221152904.GC19213@google.com>
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
 <CAK7LNAThSm1n1B_Ss0gRDZ3H-DWj2bvpZ+6Ui2jEo4Pt9YynEA@mail.gmail.com>
 <CAK7LNATf4adEEqWko2YO46wHHi-Vvc+_LBjQGNnM7rt8GSOgZQ@mail.gmail.com>
 <20190219151652.GA110907@google.com>
 <CAK7LNAQ7GqCNc008ZZ4K0_BdTVMdwwVUgnfqBO-kDBmw4ikr3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQ7GqCNc008ZZ4K0_BdTVMdwwVUgnfqBO-kDBmw4ikr3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:34:41PM +0900, Masahiro Yamada wrote:
> On Wed, Feb 20, 2019 at 12:17 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> >
> > Firstly, I want to apologize for not testing this and other corner cases you
> > brought up. I should have known better. Since my build was working, I assumed
> > that the feature is working. For that, I am very sorry.
> 
> 
> You do not need to apologize. 0day bot usually catches build errors.
> I guess 0day bot performs compile-tests only incrementally
> and that is why we did not get any report.

Oh ok :) thanks.

> > Secondly, it turns out Module.symvers circularly dependency problem also
> > exists with another use case.
> > If one does 'make modules_prepare' in a base kernel tree and then tries to
> > build modules with that tree, a warning like this is printed but the module
> > still gets built:
> >
> >   WARNING: Symbol version dump ./Module.symvers
> >            is missing; modules will have no dependencies and modversions.
> >
> >   CC [M]  /tmp/testmod/test.o
> >   Building modules, stage 2.
> >   MODPOST 1 modules
> >   CC      /tmp/testmod/test.mod.o
> >   LD [M]  /tmp/testmod/test.ko
> >
> > So, I am thinking that at least for first pass I will just drop the inclusion
> > of Module.symvers in the archive and allow any modules built using
> > /proc/kheaders.tar.xz to not use it.
> >
> > Kbuild will print a warning anyway when anyone tries to build using
> > /proc/kheaders.tar.xz, so if the user really wants module symbol versioning
> > then they should probably use a full kernel source tree with Module.symvers
> > available. For our usecase, kernel symbol versioning is a bit useless when
> > using /proc/kheaders.tar.gz because the proc file is generated with the same
> > kernel that the module is being built against, and subsequently loaded into
> > the kernel. So it is not likely that the CRC of a kernel symbol will be
> > different from what the module expects.
> 
> 
> Without Module.symver, modpost cannot check whether references are
> resolvable or not.
> 
> You will see "WARNING ... undefined" for every symbol referenced from
> the module.
> 
> 
> I am not an Android developer.
> So, I will leave this judge to other people.

IMO I don't see a way around this limiation but it would be nice if there was
a way to make it work. Since the kernel modules being built by this mechanism
are for tracing/debugging purposes, it is not a major concern for us.


> One more request if you have a chance to submit the next version.
> Please do not hide error messages.

Actually it was intended to suppress noise, not hide errors as such. I have
fixed all the errors in the next version and will be submitting it soon.

Thanks a lot for the review!

 - Joel


> I wondered why you redirected stdout/stderr from the script.
> 
> I applied the following patch, and I tested.  Then I see why.
> 
> Please fix your code instead of hiding underlying problems.
> 
> 
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 1d13a7a..a76ccbd 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -148,7 +148,7 @@ $(obj)/kheaders.o: $(obj)/kheaders_data.h
>  targets += kheaders_data.txz
> 
>  quiet_cmd_genikh = GEN     $(obj)/kheaders_data.txz
> -cmd_genikh = $(srctree)/scripts/gen_ikh_data.sh $@ $^ >/dev/null 2>&1
> +cmd_genikh = $(srctree)/scripts/gen_ikh_data.sh $@ $^
>  $(obj)/kheaders_data.txz: $(ikh_file_list) FORCE
>         $(call cmd,genikh)
> 
> 
> 
> 
> 
> 
> masahiro@grover:~/workspace/linux-yamada$ make
>   CALL    scripts/checksyscalls.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   GEN     kernel/kheaders_data.txz
> find: ‘FORCE’: No such file or directory
> 70106 blocks
> Can't do inplace edit: kernel/kheaders_data.txz.tmp is not a regular file.
> Can't do inplace edit: kernel/kheaders_data.txz.tmp/arch is not a regular file.
> Can't do inplace edit: kernel/kheaders_data.txz.tmp/arch/x86 is not a
> regular file.
> Can't do inplace edit: kernel/kheaders_data.txz.tmp/arch/x86/include
> is not a regular file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/uapi is not a regular
> file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/uapi/asm is not a
> regular file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/generated is not a
> regular file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/generated/uapi is not a
> regular file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/generated/uapi/asm is
> not a regular file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/generated/asm is not a
> regular file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/asm is not a regular
> file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/asm/xen is not a regular
> file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/asm/uv is not a regular
> file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/asm/numachip is not a
> regular file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/asm/e820 is not a
> regular file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/asm/fpu is not a regular
> file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/asm/crypto is not a
> regular file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/arch/x86/include/asm/trace is not a
> regular file.
> Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts is not a
> regular file.
> Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/genksyms
> is not a regular file.
> Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/ksymoops
> is not a regular file.
> Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/gdb is not
> a regular file.
> Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/gdb/linux
> is not a regular file.
> Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/basic is
> not a regular file.
> Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/dtc is not
> a regular file.
> Can't do inplace edit: kernel/kheaders_data.txz.tmp/scripts/dtc/libfdt
> is not a regular file.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes is not a
> regular file.
> Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/arm64:
> No such file or directory.
> Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/xtensa:
> No such file or directory.
> Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/openrisc:
> No such file or directory.
> Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/nios2:
> No such file or directory.
> Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/mips:
> No such file or directory.
> Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/arm:
> No such file or directory.
> Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/microblaze:
> No such file or directory.
> Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/arc:
> No such file or directory.
> Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/sh:
> No such file or directory.
> Can't open kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/powerpc:
> No such file or directory.
> Can't do inplace edit:
> kernel/kheaders_data.txz.tmp/scripts/dtc/include-prefixes/dt-bindings
> is not a regular file.
> 
>   [ massive amount of error messages continues ]
> 
> 
> 
> 
> 
> 
> > I can't think any other ways at the moment to break the circular dependency
> > so I'm thinking this is good enough for now especially since Kbuild will
> > print a proper warning. Let me know what you think?
> >
> > thanks,
> >
> >  - Joel
> >
> --
> Best Regards
> Masahiro Yamada
