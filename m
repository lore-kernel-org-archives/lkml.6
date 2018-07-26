Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE185C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC4020685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC4020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbeGZO4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:56:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56122 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbeGZO4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:56:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3DFD15A2;
        Thu, 26 Jul 2018 06:39:29 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D3013F6A8;
        Thu, 26 Jul 2018 06:39:27 -0700 (PDT)
Subject: Re: [PATCH v12 15/16] arm64: kexec_file: add kernel signature
 verification support
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-16-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <d3704585-9404-a56b-883a-30c123084ada@arm.com>
Date:   Thu, 26 Jul 2018 14:39:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724065759.19186-16-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 24/07/18 07:57, AKASHI Takahiro wrote:
> With this patch, kernel verification can be done without IMA security
> subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.
> 
> On x86, a signature is embedded into a PE file (Microsoft's format) header
> of binary. Since arm64's "Image" can also be seen as a PE file as far as
> CONFIG_EFI is enabled, we adopt this format for kernel signing.
> 
> You can create a signed kernel image with:
>     $ sbsign --key ${KEY} --cert ${CERT} Image

Reviewed-by: James Morse <james.morse@arm.com>


> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index d64f5e9f9d22..578d358632d0 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -102,7 +106,18 @@ static void *image_load(struct kimage *image,
>  	return ERR_PTR(ret);
>  }
>  
> +#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> +static int image_verify_sig(const char *kernel, unsigned long kernel_len)
> +{
> +	return verify_pefile_signature(kernel, kernel_len, NULL,
> +				       VERIFYING_KEXEC_PE_SIGNATURE);
> +}
> +#endif

This is identical to x86's PE image verification helper. We can clean this up
later by providing some kexec_image_verify_pe() in the core kexec_file code. Its
not worth doing now.


>  const struct kexec_file_ops kexec_image_ops = {
>  	.probe = image_probe,
>  	.load = image_load,
> +#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> +	.verify_sig = image_verify_sig,
> +#endif
>  };


Thanks,

James
