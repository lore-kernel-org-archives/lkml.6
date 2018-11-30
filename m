Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EAFC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAC62082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAC62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeLAAaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:30:12 -0500
Received: from foss.arm.com ([217.140.101.70]:56262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeLAAaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:30:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 771351596;
        Fri, 30 Nov 2018 05:20:55 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4755E3F5A0;
        Fri, 30 Nov 2018 05:20:55 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 175601AE12D3; Fri, 30 Nov 2018 13:21:14 +0000 (GMT)
Date:   Fri, 30 Nov 2018 13:21:14 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 15/16] arm64: kexec_file: add kernel signature
 verification support
Message-ID: <20181130132113.GE9000@arm.com>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-16-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115055254.2812-16-takahiro.akashi@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 02:52:54PM +0900, AKASHI Takahiro wrote:
> With this patch, kernel verification can be done without IMA security
> subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.
> 
> On x86, a signature is embedded into a PE file (Microsoft's format) header
> of binary. Since arm64's "Image" can also be seen as a PE file as far as
> CONFIG_EFI is enabled, we adopt this format for kernel signing.
> 
> You can create a signed kernel image with:
>     $ sbsign --key ${KEY} --cert ${CERT} Image
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/Kconfig              | 24 ++++++++++++++++++++++++
>  arch/arm64/kernel/kexec_image.c | 17 +++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 93dc4d36d6db..11f3e1a00588 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -867,6 +867,30 @@ config KEXEC_FILE
>  	  for kernel and initramfs as opposed to list of segments as
>  	  accepted by previous system call.
>  
> +config KEXEC_VERIFY_SIG
> +	bool "Verify kernel signature during kexec_file_load() syscall"
> +	depends on KEXEC_FILE
> +	help
> +	  Select this option to verify a signature with loaded kernel
> +	  image. If configured, any attempt of loading a image without
> +	  valid signature will fail.
> +
> +	  In addition to that option, you need to enable signature
> +	  verification for the corresponding kernel image type being
> +	  loaded in order for this to work.
> +
> +config KEXEC_IMAGE_VERIFY_SIG
> +	bool "Enable Image signature verification support"
> +	default y
> +	depends on KEXEC_VERIFY_SIG
> +	depends on EFI && SIGNED_PE_FILE_VERIFICATION
> +	help
> +	  Enable Image signature verification support.
> +
> +comment "Support for PE file signature verification disabled"
> +	depends on KEXEC_VERIFY_SIG
> +	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
> +
>  config CRASH_DUMP
>  	bool "Build kdump crash kernel"
>  	help
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 9f0d8b5d62d3..d1c6c54c22e3 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -12,7 +12,9 @@
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/kexec.h>
> +#include <linux/pe.h>
>  #include <linux/string.h>
> +#include <linux/verification.h>
>  #include <asm/byteorder.h>
>  #include <asm/cpufeature.h>
>  #include <asm/image.h>
> @@ -29,6 +31,10 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>  				sizeof(h->magic)))
>  		return -EINVAL;
>  
> +	pr_debug("PE format: %s\n",
> +			memcmp(&((struct mz_hdr *)h)->magic, "MZ", 2) ?
> +							"no" : "yes");
> 

Is this hunk really necessary? I'd prefer not to commit pr_debug()
invocations.

Will
