Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F5DECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6439720652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6439720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbeGRR0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:26:42 -0400
Received: from foss.arm.com ([217.140.101.70]:37616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbeGRR0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:26:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35E697A9;
        Wed, 18 Jul 2018 09:47:57 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ED033F318;
        Wed, 18 Jul 2018 09:47:54 -0700 (PDT)
Subject: Re: [PATCH v11 10/15] arm64: kexec_file: allow for loading
 Image-format kernel
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-11-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <bfbb8d3f-6d7b-3ebb-d805-15b89c55aaeb@arm.com>
Date:   Wed, 18 Jul 2018 17:47:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711074203.3019-11-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 11/07/18 08:41, AKASHI Takahiro wrote:
> This patch provides kexec_file_ops for "Image"-format kernel. In this
> implementation, a binary is always loaded with a fixed offset identified
> in text_offset field of its header.
> 
> Regarding signature verification for trusted boot, this patch doesn't
> contains CONFIG_KEXEC_VERIFY_SIG support, which is to be added later
> in this series, but file-attribute-based verification is still a viable
> option by enabling IMA security subsystem.
> 
> You can sign(label) a to-be-kexec'ed kernel image on target file system
> with:
>     $ evmctl ima_sign --key /path/to/private_key.pem Image
> 
> On live system, you must have IMA enforced with, at least, the following
> security policy:
>     "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig"
> 
> See more details about IMA here:
>     https://sourceforge.net/p/linux-ima/wiki/Home/

This looks useful to set a keys/signature/policy for a kernel that wasn't built
to enforce signatures at compile time, so its a good thing to have from a
single-image perspective.

I haven't managed to get IMA working to test this, but its all done by the kexec
core code, so I don't think we're missing anything.


> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> new file mode 100644
> index 000000000000..a47cf9bc699e
> --- /dev/null
> +++ b/arch/arm64/kernel/kexec_image.c

> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +	const struct arm64_image_header *h;
> +
> +	h = (const struct arm64_image_header *)(kernel_buf);
> +
> +	if (!h || (kernel_len < sizeof(*h)) ||

> +			!memcmp(&h->magic, ARM64_MAGIC, sizeof(ARM64_MAGIC)))

Doesn't memcmp() return 0 if the memory regions are the same?
This would always match the correct magic, rejecting the image.

That's not whats happening, as kexec-file works, so this never matches anything.

sizeof(ARM64_MAGIC) includes the null terminator, but this sequence is output in
head.S using '.ascii' which doesn't include the terminator, (otherwise it
wouldn't fit in the 4byte magic field). The memcmp() here is also consuming the
least significant bytes of the next field.

I think this line should be:
| 			memcmp(&h->magic, ARM64_MAGIC, sizeof(h->magic)))


> +static void *image_load(struct kimage *image,
> +				char *kernel, unsigned long kernel_len,
> +				char *initrd, unsigned long initrd_len,
> +				char *cmdline, unsigned long cmdline_len)

> +	kbuf.buffer = kernel;
> +	kbuf.bufsz = kernel_len;
> +	kbuf.memsz = le64_to_cpu(h->image_size);
> +	text_offset = le64_to_cpu(h->text_offset);
> +	kbuf.buf_align = SZ_2M;

Nit: MIN_KIMG_ALIGN ?


> +	/* Adjust kernel segment with TEXT_OFFSET */
> +	kbuf.memsz += text_offset;
> +
> +	ret = kexec_add_buffer(&kbuf);
> +	if (ret)
> +		goto out;

You just return in the error cases above but here you goto ... the return
statement at the end. Seems a bit odd.


With the memcmp() thing fixed:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
