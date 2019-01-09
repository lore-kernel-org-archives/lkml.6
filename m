Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E74C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275A420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfAIHnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:43:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37600 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfAIHnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:43:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51CFC80D;
        Tue,  8 Jan 2019 23:43:31 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC9443F6CF;
        Tue,  8 Jan 2019 23:43:29 -0800 (PST)
Date:   Wed, 9 Jan 2019 07:43:24 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yu.zheng@hxt-semitech.com>, <dongsheng.wang@hxt-semitech.com>
Subject: Re: [RESEND 1/1] gic: its: Make sure a LPI is discarded before
 free.
Message-ID: <20190109074324.6445118d@why.wild-wind.fr.eu.org>
In-Reply-To: <e37e3f5e0146be65c60092a457ca5c82e25581a0.1545292748.git.yuanyuan.zhao@hxt-semitech.com>
References: <e37e3f5e0146be65c60092a457ca5c82e25581a0.1545292748.git.yuanyuan.zhao@hxt-semitech.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 11:53:27 +0800
Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com> wrote:

Hi Zhao,

> Its device will be removed after all events be freed.
> Undisarded events can lead to unpredictable behaviar.
> 
> Signed-off-by: Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index db20e99..4fee008 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2572,6 +2572,10 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>  								virq + i);
>  		u32 event = its_get_event_id(data);
>  
> +		/* Discard irq before free */
> +		if (irqd_is_activated(d))
> +			its_send_discard(its_dev, event);
> +
>  		/* Mark interrupt index as unused */
>  		clear_bit(event, its_dev->event_map.lpi_map);
>  

But we already do send a discard on deactivate, which logically happens
before we free the domain. So what are you fixing here?

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
