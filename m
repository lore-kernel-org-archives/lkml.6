Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DCCC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218A620878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218A620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLFR7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:59:53 -0500
Received: from foss.arm.com ([217.140.101.70]:57404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbeLFR7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:59:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0867E80D;
        Thu,  6 Dec 2018 09:59:53 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECD213F5AF;
        Thu,  6 Dec 2018 09:59:51 -0800 (PST)
Date:   Thu, 6 Dec 2018 17:59:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@gmx.us>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] drivers/base: kmemleak ignore a known leak
Message-ID: <20181206175949.GR54495@arrakis.emea.arm.com>
References: <1543504357-4873-1-git-send-email-cai@gmx.us>
 <20181206160751.36211-1-cai@gmx.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206160751.36211-1-cai@gmx.us>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 11:07:51AM -0500, Qian Cai wrote:
> unreferenced object 0xffff808ec6dc5a80 (size 128):
>   comm "swapper/0", pid 1, jiffies 4294938063 (age 2560.530s)
>   hex dump (first 32 bytes):
>     ff ff ff ff 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
>     6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>   backtrace:
>     [<00000000476dcf8c>] kmem_cache_alloc_trace+0x430/0x500
>     [<000000004f708d37>] platform_device_register_full+0xbc/0x1e8
>     [<000000006c2a7ec7>] acpi_create_platform_device+0x370/0x450
>     [<00000000ef135642>] acpi_default_enumeration+0x34/0x78
>     [<000000003bd9a052>] acpi_bus_attach+0x2dc/0x3e0
>     [<000000003cf4f7f2>] acpi_bus_attach+0x108/0x3e0
>     [<000000003cf4f7f2>] acpi_bus_attach+0x108/0x3e0
>     [<000000002968643e>] acpi_bus_scan+0xb0/0x110
>     [<0000000010dd0bd7>] acpi_scan_init+0x1a8/0x410
>     [<00000000965b3c5a>] acpi_init+0x408/0x49c
>     [<00000000ed4b9fe2>] do_one_initcall+0x178/0x7f4
>     [<00000000a5ac5a74>] kernel_init_freeable+0x9d4/0xa9c
>     [<0000000070ea6c15>] kernel_init+0x18/0x138
>     [<00000000fb8fff06>] ret_from_fork+0x10/0x1c
>     [<0000000041273a0d>] 0xffffffffffffffff
> 
> Then, faddr2line pointed out this line,
> 
> /*
>  * This memory isn't freed when the device is put,
>  * I don't have a nice idea for that though.  Conceptually
>  * dma_mask in struct device should not be a pointer.
>  * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
>  */
> pdev->dev.dma_mask =
> 	kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> 
> Since this leak has been existed for more than 8-year now and it does not
> reference other part of the memory, let kmemleak ignore it, so users don't
> need to waste time reporting this in the future.
> 
> Signed-off-by: Qian Cai <cai@gmx.us>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
