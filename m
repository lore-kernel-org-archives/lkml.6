Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F047C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C452086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C452086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeIKURS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:17:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37171 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeIKURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:17:17 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fzkPp-000415-36; Tue, 11 Sep 2018 17:17:21 +0200
Message-ID: <1536679036.3362.58.camel@pengutronix.de>
Subject: Re: [PATCH] dmaengine: zx-dma: replace spin_lock_irqsave with
 spin_lock in ISR
From:   Lucas Stach <l.stach@pengutronix.de>
To:     jun qian <hangdianqj@163.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     dmaengine@vger.kernel.org, Barry song <21cnbao@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Tue, 11 Sep 2018 17:17:16 +0200
In-Reply-To: <20180911143158.52917-1-hangdianqj@163.com>
References: <20180911143158.52917-1-hangdianqj@163.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 11.09.2018, 07:31 -0700 schrieb jun qian:
> As you are already in ISR, it is unnecessary to call
> spin_lock_irqsave.

As the IRQ in this driver isn't marked with IRQF_NO_THREAD, this is
going to blow up if the kernel is booted with the "threadirqs" command
line argument.

Regards,
Lucas

> Signed-off-by: jun qian <hangdianqj@163.com>
> Cc: Barry song <21cnbao@gmail.com>
> ---
>  drivers/dma/zx_dma.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
> index 2571bc7693df..111ab2db83b1 100644
> --- a/drivers/dma/zx_dma.c
> +++ b/drivers/dma/zx_dma.c
> @@ -288,9 +288,8 @@ static irqreturn_t zx_dma_int_handler(int irq,
> void *dev_id)
>  		p = &d->phy[i];
>  		c = p->vchan;
>  		if (c) {
> -			unsigned long flags;
>  
> -			spin_lock_irqsave(&c->vc.lock, flags);
> +			spin_lock(&c->vc.lock);
>  			if (c->cyclic) {
>  				vchan_cyclic_callback(&p->ds_run-
> >vd);
>  			} else {
> @@ -298,7 +297,7 @@ static irqreturn_t zx_dma_int_handler(int irq,
> void *dev_id)
>  				p->ds_done = p->ds_run;
>  				task = 1;
>  			}
> -			spin_unlock_irqrestore(&c->vc.lock, flags);
> +			spin_unlock(&c->vc.lock);
>  			irq_chan |= BIT(i);
>  		}
>  	}
