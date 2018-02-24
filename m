Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeBXIEB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 03:04:01 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:38401 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeBXIEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 03:04:00 -0500
X-Google-Smtp-Source: AH8x225TLpVngRRpc3DH+J+gAe1NKeJECLEIde800KwAqKSNiLYHJAoX6jh9M/G1nN9QC4xC591bfZ1RdxdHuH1S2zQ=
MIME-Version: 1.0
In-Reply-To: <1519414953-5478-3-git-send-email-tbaicar@codeaurora.org>
References: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org> <1519414953-5478-3-git-send-email-tbaicar@codeaurora.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 24 Feb 2018 08:03:58 +0000
Message-ID: <CAKv+Gu8bYzctzXKdYVDUDte=KoCPS1bzVoA6JYmidbc0ZrcZ+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi/esrt: mark ESRT memory region as nomap
To: Tyler Baicar <tbaicar@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Hugo <jhugo@codeaurora.org>, Sameer Goel <sgoel@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tyler,

On 23 February 2018 at 19:42, Tyler Baicar <tbaicar@codeaurora.org> wrote:
> The ESRT memory region is being exposed as System RAM in /proc/iomem
> which is wrong because it cannot be overwritten. This memory is needed
> for kexec kernels in order to properly initialize ESRT, so if it is
> overwritten it will cause ESRT failures in the kexec kernel. Mark this
> region as nomap so that it is not overwritten.
>

This is not the right fix. We should only mark regions NOMAP if it is
uncertain whether the firmware may have a mapping of the same region
with mismatched attributes. NOMAP regions punch holes in the linear
region, increasing its TLB footprint significantly, so we should avoid
them if we can.

This same issue has come up in relation to mapping ACPI tables after
kexec. This should simply be a matter of ensuring that all
memblock_reserve()d region appear as such in /proc/iomem rather than
as 'System RAM'

> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/firmware/efi/esrt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index 504f3c3..f5f79c7 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -335,6 +335,14 @@ void __init efi_esrt_init(void)
>         pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
>         efi_mem_reserve(esrt_data, esrt_data_size);
>
> +       /*
> +        * Mark the ESRT memory region as nomap to avoid it being exposed as
> +        * System RAM in /proc/iomem. Otherwise this block can be overwritten
> +        * which will then cause failures in kexec'd kernels since the ESRT
> +        * information is no longer there.
> +        */
> +       memblock_mark_nomap(esrt_data, esrt_data_size);
> +
>         pr_debug("esrt-init: loaded.\n");
>  err_memunmap:
>         early_memunmap(va, size);
> --
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>
