Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03784C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4454218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfAYPoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:44:10 -0500
Received: from foss.arm.com ([217.140.101.70]:49216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfAYPoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:44:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DA5EA78;
        Fri, 25 Jan 2019 07:44:08 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14C8A3F5AF;
        Fri, 25 Jan 2019 07:44:01 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:43:59 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mattst88@gmail.com, linux@armlinux.org.uk, will.deacon@arm.com,
        tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        monstr@monstr.eu, paul.burton@mips.com, deller@gmx.de,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/29] ARM: add kexec_file_load system call number
Message-ID: <20190125154359.GG25901@arrakis.emea.arm.com>
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-8-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118161835.2259170-8-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 05:18:13PM +0100, Arnd Bergmann wrote:
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 86de9eb34296..20ed7e026723 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -415,3 +415,4 @@
>  398	common	rseq			sys_rseq
>  399	common	io_pgetevents		sys_io_pgetevents
>  400	common	migrate_pages		sys_migrate_pages
> +401	common	kexec_file_load		sys_kexec_file_load

I presume on arm32 this would still return -ENOSYS.

> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 261216c3336e..2c30e6f145ff 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -44,7 +44,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>  
> -#define __NR_compat_syscalls		401
> +#define __NR_compat_syscalls		402
>  #endif
>  
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index f15bcbacb8f6..8ca1d4c304f4 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -823,6 +823,8 @@ __SYSCALL(__NR_rseq, sys_rseq)
>  __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
>  #define __NR_migrate_pages 400
>  __SYSCALL(__NR_migrate_pages, compat_sys_migrate_pages)
> +#define __NR_kexec_file_load 401
> +__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
