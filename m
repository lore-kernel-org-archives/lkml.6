Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5934C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DBC20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DBC20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937753AbeFSMAb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:00:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56939 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937609AbeFSMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:00:30 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVFJC-0004Yz-2L; Tue, 19 Jun 2018 14:00:26 +0200
Date:   Tue, 19 Jun 2018 14:00:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 2/6] irqchip/ls-scfg-msi: Fix MSI affinity handling
In-Reply-To: <20180619115546.12196-3-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.21.1806191357350.1684@nanos.tec.linutronix.de>
References: <20180619115546.12196-1-marc.zyngier@arm.com> <20180619115546.12196-3-marc.zyngier@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018, Marc Zyngier wrote:

> The ls-scfs-msi driver is not dealing with the effective affinity
> as it should. Let's fix that, and make it clear that the effective
> affinity is restricted to a single CPU.
> 
> Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-ls-scfg-msi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
> index 1ec3bfe56693..2811cc53e425 100644
> --- a/drivers/irqchip/irq-ls-scfg-msi.c
> +++ b/drivers/irqchip/irq-ls-scfg-msi.c
> @@ -121,7 +121,8 @@ static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
>  		return -EINVAL;
>  	}
>  
> -	cpumask_copy(irq_data->common->affinity, mask);
> +	cpumask_copy(irq_data->common->affinity, cpumask_of(cpu));

That's wrong. The driver should not fiddle with the affinity mask at all
and just store the effective mask.

> +	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
>  
>  	return IRQ_SET_MASK_OK;

If yuo look at the call site, then you'll notice that it will do:

        case IRQ_SET_MASK_OK:
        case IRQ_SET_MASK_OK_DONE:
                cpumask_copy(desc->irq_common_data.affinity, mask);

So the cpumask_copy() can just go away.

Thanks,

	tglx
