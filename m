Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A535C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC63824728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC63824728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933912AbeGCQcU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:32:20 -0400
Received: from foss.arm.com ([217.140.101.70]:52310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeGCQcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:32:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F2E97A9;
        Tue,  3 Jul 2018 09:32:16 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6CD3F5BA;
        Tue,  3 Jul 2018 09:32:11 -0700 (PDT)
Subject: Re: [PATCH v10 08/14] arm64: kexec_file: load initrd and device-tree
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-9-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <1e401f4e-6176-990d-476c-31ae3f28f26c@arm.com>
Date:   Tue, 3 Jul 2018 17:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180623022058.10935-9-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 23/06/18 03:20, AKASHI Takahiro wrote:
> load_other_segments() is expected to allocate and place all the necessary
> memory segments other than kernel, including initrd and device-tree
> blob (and elf core header for crash).
> While most of the code was borrowed from kexec-tools' counterpart,
> users may not be allowed to specify dtb explicitly, instead, the dtb
> presented by the original boot loader is reused.
> 
> arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
> specific data allocated in load_other_segments().


> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index c38a8048ed00..7115c4f915dc 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c

> +static int setup_dtb(struct kimage *image,
> +		unsigned long initrd_load_addr, unsigned long initrd_len,
> +		char *cmdline, unsigned long cmdline_len,
> +		char **dtb_buf, size_t *dtb_buf_len)
> +{
> +	char *buf = NULL;
> +	size_t buf_size;
> +	int nodeoffset;
> +	u64 value;
> +	int ret;
> +
> +	/* duplicate dt blob */
> +	buf_size = fdt_totalsize(initial_boot_params);
> +
> +	if (initrd_load_addr) {
> +		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64));
> +		buf_size += fdt_prop_len("linux,initrd-end", sizeof(u64));
> +	}
> +
> +	if (cmdline)
> +		buf_size += fdt_prop_len("bootargs", cmdline_len + 1);

(a comment here about the possibility of an embedded NULL may avoid surprises later)


> +	buf = vmalloc(buf_size);
> +	if (!buf) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	ret = fdt_open_into(initial_boot_params, buf, buf_size);
> +	if (ret)
> +		goto out_err;
> +
> +	nodeoffset = fdt_path_offset(buf, "/chosen");
> +	if (nodeoffset < 0)
> +		goto out_err;

This doesn't update 'ret', so we return the 0/success from above...


> +
> +	/* add bootargs */
> +	if (cmdline) {
> +		ret = fdt_setprop(buf, nodeoffset, "bootargs",
> +						cmdline, cmdline_len + 1);
> +		if (ret)
> +			goto out_err;
> +	}

So (cmdline_len == 0) from user-space means keep the old cmdline. Sounds
sensible. Is this documented anywhere?

powerpc does the opposite, it deletes the bootargs in this case. Are we happy
making his a per-arch thing?


> +	/* add initrd-* */
> +	if (initrd_load_addr) {
> +		value = cpu_to_fdt64(initrd_load_addr);
> +		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-start",
> +							value);
> +		if (ret)
> +			goto out_err;
> +
> +		value = cpu_to_fdt64(initrd_load_addr + initrd_len);
> +		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-end",
> +							value);
> +		if (ret)
> +			goto out_err;
> +	}

Won't this do the same with the initrd? Re-use the old values if no new one was
provided? I can't find anything that deletes the property by the time we come to
kexec, and the old physical addresses may have been re-used by who-knows-what.

(powerpc has some code to: /* If there's no new initrd, delete the old initrd's
info. */)



Thanks,

James
