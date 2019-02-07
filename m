Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D735C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D6921907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBGWwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:52:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBGWwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:52:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726AC21721;
        Thu,  7 Feb 2019 22:52:41 +0000 (UTC)
Date:   Thu, 7 Feb 2019 17:52:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        yhs@fb.com
Subject: Re: [PATCH 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190207175239.0607f5eb@gandalf.local.home>
In-Reply-To: <20190207211102.154634-1-joel@joelfernandes.org>
References: <20190207211102.154634-1-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Feb 2019 16:11:01 -0500
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> +
> +# Build a list of in-kernel headers for building kernel modules
> +# Any other files will be stored in IKH_EXTRA variable.
> +ikh_file_list := include/
> +ikh_file_list += arch/$(ARCH)/Makefile
> +ikh_file_list += arch/$(ARCH)/include/
> +ikh_file_list += $(IKH_EXTRA)
> +ikh_file_list += scripts/
> +ikh_file_list += Makefile
> +ikh_file_list += Module.symvers
> +ifeq ($(CONFIG_STACK_VALIDATION), y)
> +ikh_file_list += $(objtree)/tools/objtool/objtool
> +endif
> +
> +$(obj)/kheaders.o: $(obj)/kheaders_data.h
> +
> +targets += kheaders_data.txz
> +
> +quiet_cmd_genikh = GEN     $(obj)/kheaders_data.txz
> +cmd_genikh = $(srctree)/scripts/gen_ikh_data.sh $@ $^ >/dev/null 2>&1
> +$(obj)/kheaders_data.txz: $(ikh_file_list) FORCE
> +	$(call cmd,genikh)
> +
> +filechk_ikheadersxz = (echo "static const char kernel_headers_data[] __used = KH_MAGIC_START"; cat $< | scripts/bin2c; echo "KH_MAGIC_END;")
> +
> +targets += kheaders_data.h
> +$(obj)/kheaders_data.h: $(obj)/kheaders_data.txz FORCE
> +	$(call filechk,ikheadersxz)
> diff --git a/scripts/gen_ikh_data.sh b/scripts/gen_ikh_data.sh
> new file mode 100755
> index 000000000000..609196b5cea2
> --- /dev/null
> +++ b/scripts/gen_ikh_data.sh
> @@ -0,0 +1,19 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +spath="$(dirname "$(readlink -f "$0")")"
> +
> +rm -rf $1.tmp
> +mkdir $1.tmp
> +
> +for f in "${@:2}";
> +	do find "$f" ! -name "*.c" ! -name "*.o" ! -name "*.cmd" ! -name ".*";

I wonder if it is a good idea to pick all files in the directories
defined in ikh_file_list, and not just explicitly list what we want,
with a '*.h' and such?


> +done | cpio -pd $1.tmp
> +
> +for f in $(find $1.tmp); do
> +	$spath/strip-comments.pl $f
> +done
> +
> +tar -Jcf $1 -C $1.tmp/ . > /dev/null
> +
> +rm -rf $1.tmp
> diff --git a/scripts/strip-comments.pl b/scripts/strip-comments.pl
> new file mode 100755
> index 000000000000..f8ada87c5802
> --- /dev/null
> +++ b/scripts/strip-comments.pl
> @@ -0,0 +1,8 @@
> +#!/usr/bin/perl -pi
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This script removes /**/ comments from a file, unless such comments
> +# contain "SPDX". It is used when building compressed in-kernel headers.
> +
> +BEGIN {undef $/;}
> +s/\/\*((?!SPDX).)*?\*\///smg;

Hmm, I'm also wondering if we could us the C pre-processor for the
stripping of everything from the header file. We would then even get
the header files only having what is necessary for the running kernel.

-- Steve
