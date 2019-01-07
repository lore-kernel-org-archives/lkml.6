Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17464C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FB6206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfAGNdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:33:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:45478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726886AbfAGNdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:33:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E219EAD43;
        Mon,  7 Jan 2019 13:33:04 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, anup@brainfault.org,
        jeremy.linton@arm.com, sudeep.holla@arm.com
Subject: Re: [PATCH] RISC-V: Fix of_node_* refcount
References: <1542755270-10433-1-git-send-email-atish.patra@wdc.com>
X-Yow:  Is this "BIKINI BEACH"?
Date:   Mon, 07 Jan 2019 14:33:03 +0100
In-Reply-To: <1542755270-10433-1-git-send-email-atish.patra@wdc.com> (Atish
        Patra's message of "Tue, 20 Nov 2018 15:07:50 -0800")
Message-ID: <mvmd0p8wq28.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20 2018, Atish Patra <atish.patra@wdc.com> wrote:

> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 18cda0e8..fc185eca 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -57,12 +57,15 @@ void __init setup_smp(void)
>  
>  	while ((dn = of_find_node_by_type(dn, "cpu"))) {
>  		hart = riscv_of_processor_hartid(dn);
> -		if (hart < 0)
> +		if (hart < 0) {
> +			of_node_put(dn);
>  			continue;
> +		}
>  
>  		if (hart == cpuid_to_hartid_map(0)) {
>  			BUG_ON(found_boot_cpu);
>  			found_boot_cpu = 1;
> +			of_node_put(dn);
>  			continue;
>  		}
>  

[    0.000000] OF: ERROR: Bad of_node_put() on /cpus/cpu@0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1-00013-ge0b3e41110 #4
[    0.000000] Call Trace:
[    0.000000] [<ffffffe0010c8c74>] walk_stackframe+0x0/0xa4
[    0.000000] [<ffffffe0010c8e74>] show_stack+0x2a/0x34
[    0.000000] [<ffffffe00160989c>] dump_stack+0x62/0x7c
[    0.000000] [<ffffffe0014d9660>] of_node_release+0xbe/0xc0
[    0.000000] [<ffffffe00160e560>] kobject_put+0xa6/0x1e8
[    0.000000] [<ffffffe0014d8bb8>] of_node_put+0x16/0x20
[    0.000000] [<ffffffe0014d4bc2>] of_find_node_by_type+0x66/0xa4
[    0.000000] [<ffffffe0000028bc>] 0xffffffe0000028bc
[    0.000000] [<ffffffe0000026cc>] 0xffffffe0000026cc
[    0.000000] [<ffffffe0000006ec>] 0xffffffe0000006ec
[    0.000000] [<ffffffe000000076>] 0xffffffe000000076
[    0.000000] OF: ERROR: Bad of_node_put() on /cpus/cpu@1
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1-00013-ge0b3e41110 #4
[    0.000000] Call Trace:
[    0.000000] [<ffffffe0010c8c74>] walk_stackframe+0x0/0xa4
[    0.000000] [<ffffffe0010c8e74>] show_stack+0x2a/0x34
[    0.000000] [<ffffffe00160989c>] dump_stack+0x62/0x7c
[    0.000000] [<ffffffe0014d9660>] of_node_release+0xbe/0xc0
[    0.000000] [<ffffffe00160e560>] kobject_put+0xa6/0x1e8
[    0.000000] [<ffffffe0014d8bb8>] of_node_put+0x16/0x20
[    0.000000] [<ffffffe0014d4bc2>] of_find_node_by_type+0x66/0xa4
[    0.000000] [<ffffffe0000028bc>] 0xffffffe0000028bc
[    0.000000] [<ffffffe0000026cc>] 0xffffffe0000026cc
[    0.000000] [<ffffffe0000006ec>] 0xffffffe0000006ec
[    0.000000] [<ffffffe000000076>] 0xffffffe000000076

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
