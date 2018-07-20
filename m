Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7709FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D4720647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="COykS2Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D4720647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeGTPwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731791AbeGTPwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:52:39 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 725DA20647;
        Fri, 20 Jul 2018 15:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532099038;
        bh=9wvRiNdNZD19W7SjUtII95HOZXUdho7zrtpdJcs6Lgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COykS2SsOJMzcQmxpwHPrNjb9P8ZSA0vOgCANdeaHPyKZWh44cjJfudHHBdEVBkRg
         3h/u6l9BmL/jtvntOGJRRV43yVnX5jj7OFzxnvd3j5xoIFG17yo+m6Q7qa8Epz/bVx
         XRXfoMKRvsWn2mj7qq+Iqmc+9Sa1otIi/gzXY+Ek=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 8CA76140260; Fri, 20 Jul 2018 12:03:54 -0300 (-03)
Date:   Fri, 20 Jul 2018 12:03:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 4/4] perf tools: Move syscall_64.tbl check into
 check-headers.sh
Message-ID: <20180720150354.GC4329@kernel.org>
References: <20180720110036.32251-1-jolsa@kernel.org>
 <20180720110036.32251-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720110036.32251-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 20, 2018 at 01:00:36PM +0200, Jiri Olsa escreveu:
> Probably leftover from the time we introducd the check-headers.sh script.

So, with your patch:

[acme@jouet perf]$ git diff
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709a5ffb..cfc1b0949bb1 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,7 @@
 332    common  statx                   __x64_sys_statx
 333    common  io_pgetevents           __x64_sys_io_pgetevents
 334    common  rseq                    __x64_sys_rseq
+335    common  krava                   __x64_sys_krava
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
[acme@jouet perf]$


It doesn't warn about that new cool syscall, without your patch:

Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'

Can you check this?

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-oh56ckqztoc07we7mtdphu7r@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/arch/x86/Makefile | 3 ---
>  tools/perf/check-headers.sh  | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
> index 1a38e78117ce..8cc6642fce7a 100644
> --- a/tools/perf/arch/x86/Makefile
> +++ b/tools/perf/arch/x86/Makefile
> @@ -19,9 +19,6 @@ systbl := $(sys)/syscalltbl.sh
>  _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>  
>  $(header): $(sys)/syscall_64.tbl $(systbl)
> -	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
> -        (diff -B arch/x86/entry/syscalls/syscall_64.tbl ../../arch/x86/entry/syscalls/syscall_64.tbl >/dev/null) \
> -        || echo "Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'" >&2 )) || true
>  	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
>  
>  clean::
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 73e723675c5f..2c10e46d98e9 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -93,3 +93,6 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
>  check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
>  check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common.h>"'
>  check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
> +
> +# diff non-symmetric files
> +check_2 arch/x86/entry/syscalls/syscall_64.tbl ../../arch/x86/entry/syscalls/syscall_64.tbl
> -- 
> 2.17.1
