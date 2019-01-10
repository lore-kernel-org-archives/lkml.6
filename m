Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92079C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D75620874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfAJQca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:32:30 -0500
Received: from foss.arm.com ([217.140.101.70]:39320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbfAJQca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:32:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62EA8A78;
        Thu, 10 Jan 2019 08:32:29 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C03B3F7B4;
        Thu, 10 Jan 2019 08:32:22 -0800 (PST)
Date:   Thu, 10 Jan 2019 16:32:20 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        monstr@monstr.eu, paul.burton@mips.com, deller@gmx.de,
        mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com,
        firoz.khan@linaro.org, ebiederm@xmission.com,
        deepa.kernel@gmail.com, linux@dominikbrodowski.net,
        akpm@linux-foundation.org, dave@stgolabs.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 06/15] ARM: add migrate_pages() system call
Message-ID: <20190110163220.GB31683@fuggles.cambridge.arm.com>
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-7-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110162435.309262-7-arnd@arndb.de>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:24:26PM +0100, Arnd Bergmann wrote:
> The migrate_pages system call has an assigned number on all architectures
> except ARM. When it got added initially in commit d80ade7b3231 ("ARM:
> Fix warning: #warning syscall migrate_pages not implemented"), it was
> intentionally left out based on the observation that there are no 32-bit
> ARM NUMA systems.
> 
> However, there are now arm64 NUMA machines that can in theory run 32-bit
> kernels (actually enabling NUMA there would require additional work)
> as well as 32-bit user space on 64-bit kernels, so that argument is no
> longer very strong.
> 
> Assigning the number lets us use the system call on 64-bit kernels as well
> as providing a more consistent set of syscalls across architectures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/unistd.h     | 1 -
>  arch/arm/tools/syscall.tbl        | 1 +
>  arch/arm64/include/asm/unistd.h   | 2 +-
>  arch/arm64/include/asm/unistd32.h | 2 ++
>  4 files changed, 4 insertions(+), 2 deletions(-)

[...]

> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 04ee190b90fe..355fe2bc035b 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -821,6 +821,8 @@ __SYSCALL(__NR_statx, sys_statx)
>  __SYSCALL(__NR_rseq, sys_rseq)
>  #define __NR_io_pgetevents 399
>  __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
> +#define __NR_migrate_pages 400
> +__SYSCALL(__NR_migrate_pages, sys_migrate_pages)

Should be compat_sys_migrate_pages instead?

Will
