Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D35C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F69240C9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWDbPGy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F69240C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbeGEW3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:29:23 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37622 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753503AbeGEW3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:29:21 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so9182753ioh.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+1nadbarlBULviXe2TXd3EYC1P70DPrOTlKAmlSaYrE=;
        b=jWDbPGy9v67z44xMmvUQGVrh38GiS9uTpMJc5nt+DwuN8EEVW37Z0paz5rmyKU6VuA
         QVIybwtzXgHexp46RX7seDlfa/H04JI+ydc6G59uMPXgZo5M+j28GwmE+3j4SsX93heY
         kT0xdDZrd/j2MdQ09ggIWaxzINOHFm3tMAxvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+1nadbarlBULviXe2TXd3EYC1P70DPrOTlKAmlSaYrE=;
        b=VLSkKdylC+lZsWq8LqTr7IxDxiZD2hrGplifxiZHGtGeY42EwQRUz3Sm9v2WeajJDu
         A7tT1M1BLGIP9g3uMYAR12N8pZmyHvkvJRietLMuEnn4yL4xyBIhlo2u35nt14gzzkaa
         uKnGu6JbJXMlcMJYokhy5Ew64IN3DqLsg5AxLIlHTJox8PN3YNhEzThWO1VXM9I4jmX7
         TrgTZ6yjQFbuXmSG3zY+hnXu+9SvtbJC3LjDB+7tQzrPQK+5xPXS6BpbB4zaF6f8h5SI
         Zcg3zZFLW6+FQTUkiJBU7QGKtCXW1jqHhYhENd6UG07B2rPjyjjOhmL3ssDny69fUNoL
         SIXQ==
X-Gm-Message-State: APt69E1yki3/vqyahf+bnj/X0gcsCziY1ewfRyxUPX12f+KimALPjC0U
        bxpk1zH0H51HjTyuKWBqoyyFsUi5n4EzPMQ1W+Gpgw==
X-Google-Smtp-Source: AAOMgpdDxKJkxlum+J2xDUmCDBXwtfeQt59p3xGInan6um6kf9RkTtfX12CWcFXdFMdYlDx9v9MJHZICXCYkn2cy0QI=
X-Received: by 2002:a6b:5d1a:: with SMTP id r26-v6mr6384933iob.170.1530829761186;
 Thu, 05 Jul 2018 15:29:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 15:29:20 -0700 (PDT)
In-Reply-To: <20180619064424.6642-2-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org> <20180619064424.6642-2-takahiro.akashi@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 6 Jul 2018 00:29:20 +0200
Message-ID: <CAKv+Gu9sbrGAMSrTC=qc1FnC0OjD5=mroV84aggAzjfJLPW1AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via /proc/iomem
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 08:44, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> From: James Morse <james.morse@arm.com>
>
> There has been some confusion around what is necessary to prevent kexec
> overwriting important memory regions. memblock: reserve, or nomap?
> Only memblock nomap regions are reported via /proc/iomem, kexec's
> user-space doesn't know about memblock_reserve()d regions.
>
> Until commit f56ab9a5b73ca ("efi/arm: Don't mark ACPI reclaim memory
> as MEMBLOCK_NOMAP") the ACPI tables were nomap, now they are reserved
> and thus possible for kexec to overwrite with the new kernel or initrd.
> But this was always broken, as the UEFI memory map is also reserved
> and not marked as nomap.
>
> Exporting both nomap and reserved memblock types is a nuisance as
> they live in different memblock structures which we can't walk at
> the same time.
>
> Take a second walk over memblock.reserved and add new 'reserved'
> subnodes for the memblock_reserved() regions that aren't already
> described by the existing code. (e.g. Kernel Code)
>
> We use reserve_region_with_split() to find the gaps in existing named
> regions. This handles the gap between 'kernel code' and 'kernel data'
> which is memblock_reserve()d, but already partially described by
> request_standard_resources(). e.g.:
> | 80000000-dfffffff : System RAM
> |   80080000-80ffffff : Kernel code
> |   81000000-8158ffff : reserved
> |   81590000-8237efff : Kernel data
> |   a0000000-dfffffff : Crash kernel
> | e00f0000-f949ffff : System RAM
>
> reserve_region_with_split needs kzalloc() which isn't available when
> request_standard_resources() is called, use an initcall.
>
> Reported-by: Bhupesh Sharma <bhsharma@redhat.com>
> Reported-by: Tyler Baicar <tbaicar@codeaurora.org>
> Suggested-by: Akashi Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> Fixes: d28f6df1305a ("arm64/kexec: Add core kexec support")
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> CC: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/kernel/setup.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 30ad2f085d1f..5b4fac434c84 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -241,6 +241,44 @@ static void __init request_standard_resources(void)
>         }
>  }
>
> +static int __init reserve_memblock_reserved_regions(void)
> +{
> +       phys_addr_t start, end, roundup_end = 0;
> +       struct resource *mem, *res;
> +       u64 i;
> +
> +       for_each_reserved_mem_region(i, &start, &end) {
> +               if (end <= roundup_end)
> +                       continue; /* done already */
> +
> +               start = __pfn_to_phys(PFN_DOWN(start));
> +               end = __pfn_to_phys(PFN_UP(end)) - 1;
> +               roundup_end = end;
> +
> +               res = kzalloc(sizeof(*res), GFP_ATOMIC);
> +               if (WARN_ON(!res))
> +                       return -ENOMEM;
> +               res->start = start;
> +               res->end = end;
> +               res->name  = "reserved";
> +               res->flags = IORESOURCE_MEM;
> +
> +               mem = request_resource_conflict(&iomem_resource, res);
> +               /*
> +                * We expected memblock_reserve() regions to conflict with
> +                * memory created by request_standard_resources().
> +                */
> +               if (WARN_ON_ONCE(!mem))
> +                       continue;
> +               kfree(res);
> +
> +               reserve_region_with_split(mem, start, end, "reserved");
> +       }
> +
> +       return 0;
> +}
> +arch_initcall(reserve_memblock_reserved_regions);
> +
>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>
>  void __init setup_arch(char **cmdline_p)
> --
> 2.17.0
>
