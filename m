Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877FFC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507A02085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Nz81abuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBGXjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:39:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40313 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:39:05 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so2002277qta.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2XnrAy6YnHFz9HrPjyh/wZzHeOBeBqHUpkLz+64XGAM=;
        b=Nz81abuWvxYZmdsXzP1Biib2wDMxyaVq5Yq8Me6Rhn/JFruGzY47yMPGP06h/Ep0nC
         PNN3MXQNfk6QLgITf9vaDfhBFrBullOvTWk28ok/uDUeHiFPV20a2DL6JCaBaa8dmEpr
         GuyNs6wXA87HuIDZ3X70SNl/IL4YfQaw25YKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2XnrAy6YnHFz9HrPjyh/wZzHeOBeBqHUpkLz+64XGAM=;
        b=sdk6NUJplOrIZnd009AD8VIMvMmC7S53gA2K3p5MdWkLhBlHMq0uUr+E5qSEQffnlh
         unHwxfRl+UcH4J+afo2nU0OeNRRfU2W+FC0+dsLWEMh6ytYsIVZHb6oeNcPifn77byoe
         m2w3QJm1TEs5zgAhGgVjGtzVAKYr4VYc0jnN1j1lgUXN3aMbrE3UlfrpBlx4SpmlWU4C
         xqZfmvrbAHlRO8qZUlAVo0cRV2ZQivaTWzK+GiGR/ovJLOIIF09hPZsRJBbf72xlZrzu
         kVF9VMXLgfJynCMcucSBRMq9/QDEl6fpsoy4wDhknKAJbB1qJIAKf9GAQr7vHbZqA6FB
         qTXQ==
X-Gm-Message-State: AHQUAuYQ3w1Num0SunTN8StvpUnQwbyrWWIn9da7rC+7Khy8zugRQEyP
        svuDv65WcB8PEDyaj//quZ9oXg==
X-Google-Smtp-Source: AHgI3Ibve4ApL0O7bTS9O10kFgM9lMKCDuM/GSoR8G51GLFRhVq1wL/++MX96FZKECSh44sK+zarFg==
X-Received: by 2002:ac8:4882:: with SMTP id i2mr14116293qtq.225.1549582744391;
        Thu, 07 Feb 2019 15:39:04 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id q195sm370955qke.58.2019.02.07.15.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 15:39:03 -0800 (PST)
Date:   Thu, 7 Feb 2019 18:39:02 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, dancol@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        gregkh@linuxfoundation.org, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [PATCH 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190207233902.GA193818@google.com>
References: <20190207211102.154634-1-joel@joelfernandes.org>
 <20190207175239.0607f5eb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207175239.0607f5eb@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, Feb 07, 2019 at 05:52:39PM -0500, Steven Rostedt wrote:
> On Thu,  7 Feb 2019 16:11:01 -0500
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > +
> > +# Build a list of in-kernel headers for building kernel modules
> > +# Any other files will be stored in IKH_EXTRA variable.
> > +ikh_file_list := include/
> > +ikh_file_list += arch/$(ARCH)/Makefile
> > +ikh_file_list += arch/$(ARCH)/include/
> > +ikh_file_list += $(IKH_EXTRA)
> > +ikh_file_list += scripts/
> > +ikh_file_list += Makefile
> > +ikh_file_list += Module.symvers
> > +ifeq ($(CONFIG_STACK_VALIDATION), y)
> > +ikh_file_list += $(objtree)/tools/objtool/objtool
> > +endif
> > +
> > +$(obj)/kheaders.o: $(obj)/kheaders_data.h
> > +
> > +targets += kheaders_data.txz
> > +
> > +quiet_cmd_genikh = GEN     $(obj)/kheaders_data.txz
> > +cmd_genikh = $(srctree)/scripts/gen_ikh_data.sh $@ $^ >/dev/null 2>&1
> > +$(obj)/kheaders_data.txz: $(ikh_file_list) FORCE
> > +	$(call cmd,genikh)
> > +
> > +filechk_ikheadersxz = (echo "static const char kernel_headers_data[] __used = KH_MAGIC_START"; cat $< | scripts/bin2c; echo "KH_MAGIC_END;")
> > +
> > +targets += kheaders_data.h
> > +$(obj)/kheaders_data.h: $(obj)/kheaders_data.txz FORCE
> > +	$(call filechk,ikheadersxz)
> > diff --git a/scripts/gen_ikh_data.sh b/scripts/gen_ikh_data.sh
> > new file mode 100755
> > index 000000000000..609196b5cea2
> > --- /dev/null
> > +++ b/scripts/gen_ikh_data.sh
> > @@ -0,0 +1,19 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +spath="$(dirname "$(readlink -f "$0")")"
> > +
> > +rm -rf $1.tmp
> > +mkdir $1.tmp
> > +
> > +for f in "${@:2}";
> > +	do find "$f" ! -name "*.c" ! -name "*.o" ! -name "*.cmd" ! -name ".*";
> 
> I wonder if it is a good idea to pick all files in the directories
> defined in ikh_file_list, and not just explicitly list what we want,
> with a '*.h' and such?

I also need few files in the archive that are not .h, these don't take up
much space but are needed to make an out-of-tree kernel module build succeed.

One of my goals with this was to make a self-contained module that could be
loaded to build other modules. Majority of the files are kernel headers, but
some are not, such as Module.symvers and other scripts. Then one can run
systemtap on Android which can be made to build modules using the embedded
headers.

> > +done | cpio -pd $1.tmp
> > +
> > +for f in $(find $1.tmp); do
> > +	$spath/strip-comments.pl $f
> > +done
> > +
> > +tar -Jcf $1 -C $1.tmp/ . > /dev/null
> > +
> > +rm -rf $1.tmp
> > diff --git a/scripts/strip-comments.pl b/scripts/strip-comments.pl
> > new file mode 100755
> > index 000000000000..f8ada87c5802
> > --- /dev/null
> > +++ b/scripts/strip-comments.pl
> > @@ -0,0 +1,8 @@
> > +#!/usr/bin/perl -pi
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# This script removes /**/ comments from a file, unless such comments
> > +# contain "SPDX". It is used when building compressed in-kernel headers.
> > +
> > +BEGIN {undef $/;}
> > +s/\/\*((?!SPDX).)*?\*\///smg;
> 
> Hmm, I'm also wondering if we could us the C pre-processor for the
> stripping of everything from the header file. We would then even get
> the header files only having what is necessary for the running kernel.

I thought about this too. An issue with that is it is going to be really slow
due to the large number of headers. The other is, I think it will actually
make the headers bigger and take up more space - because all the include
directives will also be expanded and have more duplication. Let me know if I
missed something though.

thanks,

 - Joel

