Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C33C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B239921A36
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B239921A36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967538AbeF1R2j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:28:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50848 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967499AbeF1R2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:28:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BB2018A;
        Thu, 28 Jun 2018 10:28:38 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A75B63F318;
        Thu, 28 Jun 2018 10:28:34 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] arm64: acpi: fix alignment fault in accessing ACPI
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-5-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <a8d309e0-4918-9e02-670e-4a67245274d7@arm.com>
Date:   Thu, 28 Jun 2018 18:28:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619064424.6642-5-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 19/06/18 07:44, AKASHI Takahiro wrote:
> This is a fix against the issue that crash dump kernel may hang up
> during booting, which can happen on any ACPI-based system with "ACPI
> Reclaim Memory."
> 
> (kernel messages after panic kicked off kdump)
> 	   (snip...)
> 	Bye!
> 	   (snip...)
> 	ACPI: Core revision 20170728
> 	pud=000000002e7d0003, *pmd=000000002e7c0003, *pte=00e8000039710707
> 	Internal error: Oops: 96000021 [#1] SMP
> 	Modules linked in:
> 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-rc6 #1
> 	task: ffff000008d05180 task.stack: ffff000008cc0000
> 	PC is at acpi_ns_lookup+0x25c/0x3c0
> 	LR is at acpi_ds_load1_begin_op+0xa4/0x294
> 	   (snip...)
> 	Process swapper/0 (pid: 0, stack limit = 0xffff000008cc0000)
> 	Call trace:
> 	   (snip...)
> 	[<ffff0000084a6764>] acpi_ns_lookup+0x25c/0x3c0
> 	[<ffff00000849b4f8>] acpi_ds_load1_begin_op+0xa4/0x294
> 	[<ffff0000084ad4ac>] acpi_ps_build_named_op+0xc4/0x198
> 	[<ffff0000084ad6cc>] acpi_ps_create_op+0x14c/0x270
> 	[<ffff0000084acfa8>] acpi_ps_parse_loop+0x188/0x5c8
> 	[<ffff0000084ae048>] acpi_ps_parse_aml+0xb0/0x2b8
> 	[<ffff0000084a8e10>] acpi_ns_one_complete_parse+0x144/0x184
> 	[<ffff0000084a8e98>] acpi_ns_parse_table+0x48/0x68
> 	[<ffff0000084a82cc>] acpi_ns_load_table+0x4c/0xdc
> 	[<ffff0000084b32f8>] acpi_tb_load_namespace+0xe4/0x264
> 	[<ffff000008baf9b4>] acpi_load_tables+0x48/0xc0
> 	[<ffff000008badc20>] acpi_early_init+0x9c/0xd0
> 	[<ffff000008b70d50>] start_kernel+0x3b4/0x43c
> 	Code: b9008fb9 2a000318 36380054 32190318 (b94002c0)
> 	---[ end trace c46ed37f9651c58e ]---
> 	Kernel panic - not syncing: Fatal exception
> 	Rebooting in 10 seconds..
> 
> (diagnosis)
> * This fault is a data abort, alignment fault (ESR=0x96000021)
>   during reading out ACPI table.
> * Initial ACPI tables are normally stored in system ram and marked as
>   "ACPI Reclaim memory" by the firmware.
> * After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
>   memory as MEMBLOCK_NOMAP"), those regions are differently handled
>   as they are "memblock-reserved", without NOMAP bit.
> * So they are now excluded from device tree's "usable-memory-range"
>   which kexec-tools determines based on a current view of /proc/iomem.
> * When crash dump kernel boots up, it tries to accesses ACPI tables by
>   mapping them with ioremap(), not ioremap_cache(), in acpi_os_ioremap()
>   since they are no longer part of mapped system ram.
> * Given that ACPI accessor/helper functions are compiled in without
>   unaligned access support (ACPI_MISALIGNMENT_NOT_SUPPORTED),
>   any unaligned access to ACPI tables can cause a fatal panic.
> 
> With this patch, acpi_os_ioremap() always honors memory attribute
> information provided by the firmware (EFI) and retaining cacheability
> allows the kernel safe access to ACPI tables.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
