Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ACEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6333221717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6333221717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbeHCMo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:44:28 -0400
Received: from ozlabs.org ([203.11.71.1]:60353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbeHCMo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:44:28 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41hkL05wJhz9s0n; Fri,  3 Aug 2018 20:48:40 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6e0495c2e8ac39b1aad0a4588fe64413ce9028c0
In-Reply-To: <1533001454-8751-1-git-send-email-linux@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: powerpc/4xx: Fix error return path in ppc4xx_msi_probe()
Message-Id: <41hkL05wJhz9s0n@ozlabs.org>
Date:   Fri,  3 Aug 2018 20:48:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 01:44:14 UTC, Guenter Roeck wrote:
> An arbitrary error in ppc4xx_msi_probe() quite likely results in a
> crash similar to the following, seen after dma_alloc_coherent()
> returned an error.
> 
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc001bff0
> Oops: Kernel access of bad area, sig: 11 [#1]
> BE Canyonlands
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Tainted: G        W
> 4.18.0-rc6-00010-gff33d1030a6c #1
> NIP:  c001bff0 LR: c001c418 CTR: c01faa7c
> REGS: cf82db40 TRAP: 0300   Tainted: G        W
> (4.18.0-rc6-00010-gff33d1030a6c)
> MSR:  00029000 <CE,EE,ME>  CR: 28002024  XER: 00000000
> DEAR: 00000000 ESR: 00000000
> GPR00: c001c418 cf82dbf0 cf828000 cf8de400 00000000 00000000 000000c4 000000c4
> GPR08: c0481ea4 00000000 00000000 000000c4 22002024 00000000 c00025e8 00000000
> GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c0492380 0000004a
> GPR24: 00029000 0000000c 00000000 cf8de410 c0494d60 c0494d60 cf8bebc0 00000001
> NIP [c001bff0] ppc4xx_of_msi_remove+0x48/0xa0
> LR [c001c418] ppc4xx_msi_probe+0x294/0x3b8
> Call Trace:
> [cf82dbf0] [00029000] 0x29000 (unreliable)
> [cf82dc10] [c001c418] ppc4xx_msi_probe+0x294/0x3b8
> [cf82dc70] [c0209fbc] platform_drv_probe+0x40/0x9c
> [cf82dc90] [c0208240] driver_probe_device+0x2a8/0x350
> [cf82dcc0] [c0206204] bus_for_each_drv+0x60/0xac
> [cf82dcf0] [c0207e88] __device_attach+0xe8/0x160
> [cf82dd20] [c02071e0] bus_probe_device+0xa0/0xbc
> [cf82dd40] [c02050c8] device_add+0x404/0x5c4
> [cf82dd90] [c0288978] of_platform_device_create_pdata+0x88/0xd8
> [cf82ddb0] [c0288b70] of_platform_bus_create+0x134/0x220
> [cf82de10] [c0288bcc] of_platform_bus_create+0x190/0x220
> [cf82de70] [c0288cf4] of_platform_bus_probe+0x98/0xec
> [cf82de90] [c0449650] __machine_initcall_canyonlands_ppc460ex_device_probe+0x38/0x54
> [cf82dea0] [c0002404] do_one_initcall+0x40/0x188
> [cf82df00] [c043daec] kernel_init_freeable+0x130/0x1d0
> [cf82df30] [c0002600] kernel_init+0x18/0x104
> [cf82df40] [c000c23c] ret_from_kernel_thread+0x14/0x1c
> Instruction dump:
> 90010024 813d0024 2f890000 83c30058 41bd0014 48000038 813d0024 7f89f800
> 409d002c 813e000c 57ea103a 3bff0001 <7c69502e> 2f830000 419effe0 4803b26d
> ---[ end trace 8cf551077ecfc42a ]---
> 
> Fix it up. Specifically,
> 
> - Return valid error codes from ppc4xx_setup_pcieh_hw(), have it clean
>   up after itself, and only access hardware after all possible error
>   conditions have been handled.
> - Use devm_kzalloc() instead of kzalloc() in ppc4xx_msi_probe()
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6e0495c2e8ac39b1aad0a4588fe644

cheers
