Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC7C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251FD20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251FD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbeGZOxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:53:06 -0400
Received: from foss.arm.com ([217.140.101.70]:55966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbeGZOxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:53:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 734B515A2;
        Thu, 26 Jul 2018 06:36:11 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD9843F6A8;
        Thu, 26 Jul 2018 06:36:08 -0700 (PDT)
Subject: Re: [PATCH v12 13/16] arm64: kexec_file: invoke the kernel without
 purgatory
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-14-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <b9257c90-a538-fb82-b9de-574d68d06fbd@arm.com>
Date:   Thu, 26 Jul 2018 14:36:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724065759.19186-14-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 24/07/18 07:57, AKASHI Takahiro wrote:
> On arm64, purgatory would do almost nothing. So just invoke secondary
> kernel directly by jumping into its entry code.
> 
> While, in this case, cpu_soft_restart() must be called with dtb address
> in the fifth argument, the behavior still stays compatible with kexec_load
> case as long as the argument is null.

This patch conflicts with commit 76f4e2da45b4 ("arm64: kexec: always reset to
EL2 if present") in the arm64 tree.

Thanks,

James

> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index f76ea92dff91..830a5063e09d 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -205,10 +205,18 @@ void machine_kexec(struct kimage *kimage)
>  	 * uses physical addressing to relocate the new image to its final
>  	 * position and transfers control to the image entry point when the
>  	 * relocation is complete.
> +	 * In kexec case, kimage->start points to purgatory assuming that
> +	 * kernel entry and dtb address are embedded in purgatory by
> +	 * userspace (kexec-tools).
> +	 * In kexec_file case, the kernel starts directly without purgatory.
>  	 */
> -
>  	cpu_soft_restart(kimage != kexec_crash_image,
> -		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
> +		reboot_code_buffer_phys, kimage->head, kimage->start,
> +#ifdef CONFIG_KEXEC_FILE
> +						kimage->arch.dtb_mem);
> +#else
> +						0);
> +#endif
>  
>  	BUG(); /* Should never get here. */
>  }
