Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 17BB7C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC306208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC306208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935319AbeFMLHP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:07:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45930 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934971AbeFMLHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:07:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0B131529;
        Wed, 13 Jun 2018 04:07:13 -0700 (PDT)
Received: from [10.1.207.70] (e112298-lin.cambridge.arm.com [10.1.207.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B20883F25D;
        Wed, 13 Jun 2018 04:07:11 -0700 (PDT)
Subject: Re: [PATCH v4 26/26] irqchip/gic-v3: Allow interrupts to be set as
 pseudo-NMI
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <1527241772-48007-27-git-send-email-julien.thierry@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <5f1ff644-6416-3bd2-c817-5a86e16e251e@arm.com>
Date:   Wed, 13 Jun 2018 12:07:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527241772-48007-27-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/18 10:49, Julien Thierry wrote:
> Provide a way to set a GICv3 interrupt as pseudo-NMI. The interrupt
> must not be enabled when setting/clearing the NMI status of the interrupt.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/irqchip/irq-gic-v3.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/interrupt.h    |  1 +
>   2 files changed, 55 insertions(+)
> 

[...]

> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 5426627..02c794f 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -419,6 +419,7 @@ enum irqchip_irq_state {
>   	IRQCHIP_STATE_ACTIVE,		/* Is interrupt in progress? */
>   	IRQCHIP_STATE_MASKED,		/* Is interrupt masked? */
>   	IRQCHIP_STATE_LINE_LEVEL,	/* Is IRQ line high? */
> +	IRQCHIP_STATE_NMI,		/* Is IRQ an NMI? */
>   };

After discussing with Thomas, NMI setting should not be exposed/managed 
through the generic irq interface.

-- 
Julien Thierry
