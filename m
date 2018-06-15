Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18042C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E09208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E09208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966017AbeFOQ3i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:29:38 -0400
Received: from foss.arm.com ([217.140.101.70]:44112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965947AbeFOQ3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:29:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D7B61529;
        Fri, 15 Jun 2018 09:29:37 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D36693F25D;
        Fri, 15 Jun 2018 09:29:33 -0700 (PDT)
Subject: Re: [PATCH 0/3] arm64: kexec,kdump: fix boot failures on acpi-only
 system
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <81a9a385-3b9f-113d-96f0-379be74c19f0@arm.com>
Date:   Fri, 15 Jun 2018 17:29:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615075623.13454-1-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

Thanks for putting this together,

On 15/06/18 08:56, AKASHI Takahiro wrote:
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

This means user-space can tell the difference between reserved-system-ram and
reserved-address-space.


> * For case (1), user space (kexec-tools) should rule out such regions
>   in searching for free space for loaded data.

... but doesn't today, because it fails to account for second-level entries.
We've always had second-level entries, so this is a user-space bug. We need both
fixed to fix the issue.

Our attempts to fix this just in the kernel reached a dead end, because Kdump
needs to include reserved-system-ram, whereas kexec has to avoid it. User-space
needs to be able to tell reserved-system-ram and reserved-address-space apart.
Hence we need to expose that information, and pick it up in user-space.

Patched-kernel and unpatch-user-space will work the same way it does today, as
the additional reserved regions are ignored by user-space.

Unpatched-kernel and patched-user-space will also work the same way it does
today as the additional reserved regions are missing.

I think this is the only way forwards on this issue...


> * For case (2), the kernel should access ACPI tables by mapping
>   them with appropriate memory attributes described in UEFI memory map.
>   (This means that it doesn't require any changes in /proc/iomem, and
>   hence user space.)

(this one is handled entirely in the kernel)


Thanks,

James
