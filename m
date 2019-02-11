Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8C8C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73154218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfBKNXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:23:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:43170 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727490AbfBKNXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:23:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD3C2AED6;
        Mon, 11 Feb 2019 13:23:17 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Patrick =?utf-8?Q?St=C3=A4hlin?= <me@packi.ch>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [v3 PATCH 8/8] RISC-V: Assign hwcap only according to boot cpu.
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
        <1549590681-24125-9-git-send-email-atish.patra@wdc.com>
X-Yow:  I just heard the SEVENTIES were over!!  And I was just getting in touch
 with my LEISURE SUIT!!
Date:   Mon, 11 Feb 2019 14:23:15 +0100
In-Reply-To: <1549590681-24125-9-git-send-email-atish.patra@wdc.com> (Atish
        Patra's message of "Thu, 7 Feb 2019 17:51:21 -0800")
Message-ID: <mvmo97iv4qk.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 07 2019, Atish Patra <atish.patra@wdc.com> wrote:

> +	while ((node = of_find_node_by_type(node, "cpu"))) {
> +		if (!node) {

That can never be true.

> +			pr_warn("Unable to find \"cpu\" devicetree entry");
> +			return;
> +		}
> +
> +		hartid = riscv_of_processor_hartid(node);
> +		if (hartid < 0)
> +			continue;
>  
> -	if (of_property_read_string(node, "riscv,isa", &isa)) {
> -		pr_warning("Unable to find \"riscv,isa\" devicetree entry");
> +		if (of_property_read_string(node, "riscv,isa", &isa)) {
> +			pr_warn("Unable to find \"riscv,isa\" devicetree entry");
> +			of_node_put(node);
> +			return;
> +		}
>  		of_node_put(node);

[    0.000000] OF: ERROR: Bad of_node_put() on /cpus/cpu@1
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc6-00020-g5903f30f1310 #12
[    0.000000] Call Trace:
[    0.000000] [<ffffffe001076812>] walk_stackframe+0x0/0xa4
[    0.000000] [<ffffffe001076a12>] show_stack+0x2a/0x34
[    0.000000] [<ffffffe0015cf9ea>] dump_stack+0x62/0x7c
[    0.000000] [<ffffffe00149fed4>] of_node_release+0xbe/0xc0
[    0.000000] [<ffffffe0015d465a>] kobject_put+0xa6/0x1e8
[    0.000000] [<ffffffe00149f44e>] of_node_put+0x16/0x20
[    0.000000] [<ffffffe00149b45e>] of_find_node_by_type+0x66/0xa4
[    0.000000] [<ffffffe0010755ca>] riscv_fill_hwcap+0x14c/0x1ce
[    0.000000] [<ffffffe0000026d4>] 0xffffffe0000026d4
[    0.000000] [<ffffffe0000006ec>] 0xffffffe0000006ec
[    0.000000] [<ffffffe000000076>] 0xffffffe000000076

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
