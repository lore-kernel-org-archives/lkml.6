Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9733DC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEE020647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEE020647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbeGZOvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:51:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55896 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbeGZOvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:51:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A199F15A2;
        Thu, 26 Jul 2018 06:34:59 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBE143F6A8;
        Thu, 26 Jul 2018 06:34:56 -0700 (PDT)
Subject: Re: [PATCH v12 10/16] arm64: kexec_file: load initrd and device-tree
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-11-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <99f87d6c-b5e3-4f98-5f3b-7032ff4780b1@arm.com>
Date:   Thu, 26 Jul 2018 14:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724065759.19186-11-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 24/07/18 07:57, AKASHI Takahiro wrote:
> load_other_segments() is expected to allocate and place all the necessary
> memory segments other than kernel, including initrd and device-tree
> blob (and elf core header for crash).
> While most of the code was borrowed from kexec-tools' counterpart,
> users may not be allowed to specify dtb explicitly, instead, the dtb
> presented by the original boot loader is reused.
> 
> arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
> specific data allocated in load_other_segments().

Since v11 you've renamed struct kimage_arch's dtb_buf as dtb, but not changed
the struct. This series doesn't build until patch 12 where you fix it. This will
cause anyone trying to bisect through here a problem.


Thanks,

James

> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index e17f0529a882..026f7e408f0c 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h

> +struct kimage_arch {
> +	void *dtb_buf;
> +	unsigned long dtb_mem;
> +};

> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index c38a8048ed00..b28fbb0659c9 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c

> +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> +{
> +	vfree(image->arch.dtb);
> +	image->arch.dtb = NULL;
> +
> +	return kexec_image_post_load_cleanup_default(image);
> +}

