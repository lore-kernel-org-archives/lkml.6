Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C52AC4167B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1A620882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1A620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeILXn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbeILXn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:43:28 -0400
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D82020880;
        Wed, 12 Sep 2018 18:37:41 +0000 (UTC)
Date:   Wed, 12 Sep 2018 14:37:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Paulo Zanoni <paulo.r.zanoni@intel.com>
Cc:     linux-kbuild@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/Makefile: fix handling redefinition of
 CC_FLAGS_FTRACE
Message-ID: <20180912143738.0d6264ce@vmware.local.home>
In-Reply-To: <20180910175956.22679-1-paulo.r.zanoni@intel.com>
References: <your-ad-here.call-01536239243-ext-9397@work.hours>
        <20180910175956.22679-1-paulo.r.zanoni@intel.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 10:59:56 -0700
Paulo Zanoni <paulo.r.zanoni@intel.com> wrote:

> As a Kernel developer, I make heavy use of "make targz-pkg" in order
> to locally compile and remotely install my development Kernels. The
> nice feature I rely on is that after a normal "make", "make targz-pkg"
> only generates the tarball without having to recompile everything.
> 
> That was true until commit f28bc3c32c05 ("tracing: Handle
> CC_FLAGS_FTRACE more accurately"). After it, running "make targz-pkg"
> after "make" will recompile the whole Kernel tree, making my
> development workflow much slower.
> 
> The Kernel is choosing to recompile everything because it claims the
> command line has changed. A diff of the .cmd files show a repeated
> -mfentry in one of the files. That is because "make targz-pkg" calls
> "make modules_install" and the environment is already populated with
> the exported variables, CC_FLAGS_FTRACE being one of them. Then,
> -mfentry gets duplicated because it is not protected behind an ifndef
> block, like -pg.
> 
> To complicate the problem a little bit more, architectures can define
> their own version CC_FLAGS_FTRACE, so our code not only has to
> consider recursive Makefiles, but also architecture overrides.
> 
> So in this patch we move CC_FLAGFS_FTRACE up and unconditionally
> define it to -pg. Then we let the architecture Makefiles possibly
> override it, and finally append the extra options later. This ensures
> the variable is always fully redefined at each invocation so recursive
> Makefiles don't keep appending, and hopefully it maintains the
> intended behavior on how architectures can override the defaults..
> 
> Thanks Steven Rostedt and Vasily Gorbik for the help on this
> regression.
> 

I'll pull in this patch, but it's always a good idea to also Cc LKML
(which I added to this email).

I also updated the change log and added Vasily's acked-by.

-- Steve

> Fixes: commit f28bc3c32c05 ("tracing: Handle CC_FLAGS_FTRACE more
>  accurately")
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Paulo Zanoni <paulo.r.zanoni@intel.com>
> ---
>  Makefile | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 4d5c883a98e5..a5ef6818157a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -616,6 +616,11 @@ CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage \
>  	$(call cc-disable-warning,maybe-uninitialized,)
>  export CFLAGS_GCOV
>  
> +# The arch Makefiles can override CC_FLAGS_FTRACE. We may also append it later.
> +ifdef CONFIG_FUNCTION_TRACER
> +  CC_FLAGS_FTRACE := -pg
> +endif
> +
>  # The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
>  # values of the respective KBUILD_* variables
>  ARCH_CPPFLAGS :=
> @@ -755,9 +760,6 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
>  endif
>  
>  ifdef CONFIG_FUNCTION_TRACER
> -ifndef CC_FLAGS_FTRACE
> -CC_FLAGS_FTRACE := -pg
> -endif
>  ifdef CONFIG_FTRACE_MCOUNT_RECORD
>    # gcc 5 supports generating the mcount tables directly
>    ifeq ($(call cc-option-yn,-mrecord-mcount),y)

