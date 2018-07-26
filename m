Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA7BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE8720685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE8720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbeGZO5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:57:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56178 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbeGZO5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:57:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6B5515A2;
        Thu, 26 Jul 2018 06:40:53 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01A313F6A8;
        Thu, 26 Jul 2018 06:40:50 -0700 (PDT)
Subject: Re: [PATCH v12 16/16] arm64: kexec_file: add kaslr support
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-17-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <50b31f17-fc85-aa72-06f5-d3b62060a91f@arm.com>
Date:   Thu, 26 Jul 2018 14:40:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724065759.19186-17-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 24/07/18 07:57, AKASHI Takahiro wrote:
> Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
> address randomization, at secondary kernel boot.

Hmm, there are three things that get moved by CONFIG_RANDOMIZE_BASE. The kernel
physical placement when booted via the EFIstub, the kernel-text VAs and the
location of memory in the linear-map region. Adding the kaslr-seed only does the
last two.

This means the physical placement of the new kernel is predictable from
/proc/iomem ... but this also tells you the physical placement of the current
kernel, so I don't think this is a problem.


> We always do this as it will have no harm on kaslr-incapable kernel.

> We don't have any "switch" to turn off this feature directly, but still
> can suppress it by passing "nokaslr" as a kernel boot argument.


> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 7356da5a53d5..47a4fbd0dc34 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -158,6 +160,12 @@ static int setup_dtb(struct kimage *image,

Don't you need to reserve some space in the area you vmalloc()d for the DT?


> +	/* add kaslr-seed */
> +	get_random_bytes(&value, sizeof(value));

What happens if the crng isn't ready?

It looks like this will print a warning that these random-bytes aren't really up
to standard, but the new kernel doesn't know this happened.

crng_ready() isn't exposed, all we could do now is
wait_for_random_bytes(), but that may wait forever because we do this
unconditionally.

I'd prefer to leave this feature until we can check crng_ready(), and skip
adding a dodgy-seed if its not-ready. This avoids polluting the next-kernel's
entropy pool.


> +	ret = fdt_setprop(buf, nodeoffset, "kaslr-seed", &value, sizeof(value));

Nit: It would be nice if this string were in a header file somewhere, to void
future refactoring typos.


Thanks,

James
