Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83388C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C60D206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547039746;
	bh=z//edLbGg4F9Mpz5jOfUW8hSMaDIEorXN1kc21Yl+/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n7E8iPRVAN2xS5xZmuWwUXyTyqpkyioQcO3vzL45++IaLDajH2WNGTUGWKB4VCk5l
	 2LVrcq+1qe6KO+X6GkVNoDgA894FwxG8hl/Oj9EHo1tURQPjp1usQeIcQdhzntAVF+
	 f1leW181RCiz5m3vY+RItGhs1/7x8m6/MvtNKJTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbfAINPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:15:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbfAINPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:15:44 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEDEC20675;
        Wed,  9 Jan 2019 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547039743;
        bh=z//edLbGg4F9Mpz5jOfUW8hSMaDIEorXN1kc21Yl+/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4rrE7qPc9F4VssSOcWmXL/kxZfNSCoEpoMK79koOIqfVgoBBeTF9nrewhPdzrSnj
         0Qic2IitTNCs1zku+lS8VqLDU4xcwDI/el6XPODctNLI/WY4j6bPbudPBvjUh7KfAs
         ncN1OVan6lKuYinzToVlVYOaimS2EBRfJBf/1Tdc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AE1C940355; Wed,  9 Jan 2019 10:15:40 -0300 (-03)
Date:   Wed, 9 Jan 2019 10:15:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] tools uapi asm: Update asm-generic/unistd.h
Message-ID: <20190109131540.GC25192@kernel.org>
References: <20190108221758.14546-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108221758.14546-1-labbott@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 08, 2019 at 02:17:58PM -0800, Laura Abbott escreveu:
> Commit 4e21565b7fd4 ("asm-generic: add kexec_file_load system
> call to unistd.h") added the system call to the generic header
> but not to the perf copy resulting a compile failure on aarch64

Humm, that shouldn't happen, i.e. kernel developers don't have to update
anything in tools/ as part of their normal kernel development workflows.

They can if they wish, but are not required, so the build failure was
due to something else or a pre-existing bug where tools/ living stuff
used things outside tools/.

> When running mksyscalltbl

Lemme try this on my Orangi PI zero... 

- Arnaldo

> BUILDSTDERR: <stdin>: In function 'main':
> BUILDSTDERR: <stdin>:273:44: error: '__NR_kexec_file_load' undeclared (first use in this function)
> BUILDSTDERR: <stdin>:273:44: note: each undeclared identifier is reported only once for each function it appears in
> 
> Fix this by syncing up.
> 
> Fixes: 4e21565b7fd4 ("asm-generic: add kexec_file_load system call to unistd.h")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> Found this on Fedora when compiling 5.0-rc1, I hadn't seen a patch
> queued yet.
> ---
>  tools/include/uapi/asm-generic/unistd.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
> index c7f3321fbe43..d90127298f12 100644
> --- a/tools/include/uapi/asm-generic/unistd.h
> +++ b/tools/include/uapi/asm-generic/unistd.h
> @@ -738,9 +738,11 @@ __SYSCALL(__NR_statx,     sys_statx)
>  __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
>  #define __NR_rseq 293
>  __SYSCALL(__NR_rseq, sys_rseq)
> +#define __NR_kexec_file_load 294
> +__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 294
> +#define __NR_syscalls 295
>  
>  /*
>   * 32 bit systems traditionally used different
> -- 
> 2.20.1

-- 

- Arnaldo
