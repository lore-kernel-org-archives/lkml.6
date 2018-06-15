Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 74439C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B5E208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B5E208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756151AbeFOMwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:52:06 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37616 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755850AbeFOMwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:52:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21-v6so14499955lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 05:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0Utll6ofGCXbQpMI0zrypqOdyUpSoC95d9PTXaJ3wf8=;
        b=RFoWwHlQD5jz+Dmuz9Xw0/TKtYt6XFBgU/inaGAgye8Mmod6t2/p2WksDPqnGaLxFJ
         q7Zahh7zyLJhz670yST3uMin4C8k4PYm+E0DtTGHmj7LKYdbhEnrlKA0DWBAPSyE0Am9
         hzzjIQg8mGmBmqXDYG9gjF/OwbCfi0zIhj4yWuGWptj9JPNiHzyBBINDhTeMa0sLXk6B
         vKIICA7SGnzBvS5j1bKroS4utUGog9SLp74b5MGR0rm/MtX86hNDL0c1MzxODH5XTUbR
         JlBiOHOiN7jFN5E4kSqV2LFPMqPyjMXjagWEnf3gdUl+cLLl1sTuWR1Tmk2YOM9InI+O
         CqAg==
X-Gm-Message-State: APt69E2dxm0sKYJgQtIsZDjQGRkAf4oK5IpE9vtVaXy0y1lt50g0yNWj
        6Q5pIEKlKLC2OyrDFzoB6GO4UzPo65SnW59PHrB0Nw==
X-Google-Smtp-Source: ADUXVKJtKJnS7hHCouGZtq/tvuX5M8kV+Ph0GvLIsmifRPxlnyLNODebenDtUnl6DFQ1OTEAJc3OEtCGiKgzZJX0JVc=
X-Received: by 2002:a2e:161d:: with SMTP id w29-v6mr1331571ljd.105.1529067122867;
 Fri, 15 Jun 2018 05:52:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:898a:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 05:52:02
 -0700 (PDT)
In-Reply-To: <20180615075623.13454-1-takahiro.akashi@linaro.org>
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 15 Jun 2018 18:22:02 +0530
Message-ID: <CACi5LpNDSwSJfsZ9gh9skfhAhAsKXRXxGHhiG8+we=OdhB+KsA@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: kexec,kdump: fix boot failures on acpi-only system
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, akpm@linux-foundation.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        tbaicar@codeaurora.org, Dave Young <dyoung@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

Thanks for the patchset - we have been waiting for quite some time for
this fix so that crashkernel can boot on arm64 machines which support
boot'ing via ACPI tables.

I have tested this on my huawei-taishan arm64 board, so:
Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

BTW, if possible I would suggest to use:
Reported-by: Bhupesh Sharma <bhsharma@redhat.com>

rather than:
Reported-by: Bhupesh Sharma <bhupesh.linux@gmail.com>

Thanks,
Bhupesh


On Fri, Jun 15, 2018 at 1:26 PM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> # apologies for a bit late updates
>
> This patch series is a set of bug fixes to address kexec/kdump
> failures which are sometimes observed on ACPI-only system and reported
> in LAK-ML before.
>
> In short, the phenomena are:
> 1. kexec'ed kernel can fail to boot because some ACPI table is corrupted
>    by a new kernel (or other data) being loaded into System RAM. Currently
>    kexec may possibly allocate space ignoring such "reserved" regions.
>    We will see no messages after "Bye!"
>
> 2. crash dump (kdump) kernel can fail to boot and get into panic due to
>    an alignment fault when accessing ACPI tables. This can happen because
>    those tables are not always properly aligned while they are mapped
>    non-cacheable (ioremap'ed) as they are not recognized as part of System
>    RAM under the current implementation.
>
> After discussing several possibilities to address those issues,
> the agreed approach, in my understanding, is
> * to add resource entries for every "reserved", i.e. memblock_reserve(),
>   regions to /proc/iomem.
>   (NOMAP regions, also marked as "reserved," remains at top-level for
>   backward compatibility.)
> * For case (1), user space (kexec-tools) should rule out such regions
>   in searching for free space for loaded data.
> * For case (2), the kernel should access ACPI tables by mapping
>   them with appropriate memory attributes described in UEFI memory map.
>   (This means that it doesn't require any changes in /proc/iomem, and
>   hence user space.)
>
> Please find past discussions about /proc/iomem in [1].
>
> Patch#1 addresses kexec case, for which you are also required to update
> user space. See necessary patches in [2]. If you want to review Patch#1,
> please also take a look at and review [2].
>
> Patch#2 and #3 addresses kdump case. This is a revised version after
> Ard's comments.[3]
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/565980.html
> [2] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/resv_mem
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573655.html
>
> AKASHI Takahiro (2):
>   arm64: acpi,efi: fix alignment fault in accessing ACPI tables at kdump
>   init: map UEFI memory map early if on arm or arm64
>
> James Morse (1):
>   arm64: export memblock_reserve()d regions via /proc/iomem
>
>  arch/arm64/include/asm/acpi.h      | 23 ++++++++++++------
>  arch/arm64/kernel/acpi.c           | 11 +++------
>  arch/arm64/kernel/setup.c          | 38 ++++++++++++++++++++++++++++++
>  drivers/firmware/efi/arm-runtime.c | 27 ++++++++++-----------
>  init/main.c                        |  3 +++
>  5 files changed, 72 insertions(+), 30 deletions(-)
>
> --
> 2.17.0
>
