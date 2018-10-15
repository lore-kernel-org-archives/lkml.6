Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB83FC7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB6220842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB6220842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJOLoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 07:44:39 -0400
Received: from ozlabs.org ([203.11.71.1]:33917 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeJOLoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 07:44:38 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42YPr96Hhwz9s5c; Mon, 15 Oct 2018 15:01:11 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7241d26e8175e95290a6549a470c330dbfc63442
In-Reply-To: <a2694b8ffeb6c52d1c755d8a7bfaac689c4e1c6d.1539423893.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, abdhalee@linux.vnet.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/64: properly initialise the stackprotector canary on SMP.
Message-Id: <42YPr96Hhwz9s5c@ozlabs.org>
Date:   Mon, 15 Oct 2018 15:01:11 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-13 at 09:45:12 UTC, Christophe Leroy wrote:
> commit 06ec27aea9fc ("powerpc/64: add stack protector support")
> doesn't initialise the stack canary on SMP secondary CPU's paca,
> leading to the following false positive report from the
> stack protector.
> 
> smp: Bringing up secondary CPUs ...
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc7-next-20181010-autotest-autotest #1
> Call Trace:
> [c000001fed5b3bf0] [c000000000a0ef3c] dump_stack+0xb0/0xf4 (unreliable)
> [c000001fed5b3c30] [c0000000000f9d68] panic+0x140/0x308
> [c000001fed5b3cc0] [c0000000000f9844] __stack_chk_fail+0x24/0x30
> [c000001fed5b3d20] [c000000000a2c3a8] __schedule+0x978/0xa80
> [c000001fed5b3e00] [c000000000a2c9b4] schedule_idle+0x34/0x60
> [c000001fed5b3e30] [c00000000013d344] do_idle+0x224/0x3d0
> [c000001fed5b3ec0] [c00000000013d6e0] cpu_startup_entry+0x30/0x50
> [c000001fed5b3ef0] [c000000000047f34] start_secondary+0x4d4/0x520
> [c000001fed5b3f90] [c00000000000b370] start_secondary_prolog+0x10/0x14
> 
> This patch properly initialises the stack_canary of the secondary
> idle tasks.
> 
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Fixes: 06ec27aea9fc ("powerpc/64: add stack protector support")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7241d26e8175e95290a6549a470c33

cheers
