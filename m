Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6D9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CC821783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YU3Mcgr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbeLQS2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:28:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeLQS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fA6zxshqesSaC4hFLlY89VNNeE82Lr+aueExS0DAk9s=; b=YU3Mcgr6gs5REfEadIsqPDEKs
        tAJuMf1TmBP68jN7mPV45CucOD+dFVhyQtCor0f/vLuckO1f0XGLHLYFKot2V9rPq3gMTcJjwf0wd
        S53FGyW4QlDPoC5ln157EtxExuIZBF6OpmRV0lQ4i3cfgIs5dbD/HXzPLMNpwduhG7PNFOl+OlyM2
        Wl57alYUOTjEWTEVO6tioBgVc2Y8h9jhkxwaFhQn50Vqttcc9W9RH82R8j6y4xwXZPhYuah3vnH35
        ofdJ592DlBwkDC8a1WOfauwBTBHGbxK/lzKjpIdV0du3NAZzUMBeNzbc9ndCrnClebGBaSVB1zKP+
        Dsy2kf9YA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYxci-00045d-RS; Mon, 17 Dec 2018 18:28:12 +0000
Date:   Mon, 17 Dec 2018 10:28:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] irqchip: sifive-plic: Add warning in plic_init()
 if handler already present
Message-ID: <20181217182812.GD7086@infradead.org>
References: <20181130080207.20505-1-anup@brainfault.org>
 <20181130080207.20505-5-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130080207.20505-5-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:32:05PM +0530, Anup Patel wrote:
> We have two enteries (one for M-mode and another for S-mode) in the
> interrupts-extended DT property of PLIC DT node for each HART. It is
> expected that firmware/bootloader will set M-mode HWIRQ line of each
> HART to 0xffffffff (i.e. -1) in interrupts-extended DT property
> because Linux runs in S-mode only.
> 
> If firmware/bootloader is buggy then it will not correctly update
> interrupts-extended DT property which might result in a plic_handler
> configured twice. This patch adds a warning in plic_init() if a
> plic_handler is already marked present. This warning provides us
> a hint about incorrectly updated interrupts-extended DT property.
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index d4433399eb89..3d4f205f8abe 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -234,6 +234,11 @@ static int __init plic_init(struct device_node *node,
>  
>  		cpu = riscv_hartid_to_cpuid(hartid);
>  		handler = per_cpu_ptr(&plic_handlers, cpu);
> +		if (handler->present) {
> +			pr_warn("handler not available for context %d.\n", i);
> +			continue;
> +		}

Shouldn't this be something like "handler already present.."

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
