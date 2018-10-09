Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E168C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0407C2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0407C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeJIJjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:39:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40749 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbeJIJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:39:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0979709|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01542;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.D.KWfkV_1539051852;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D.KWfkV_1539051852)
          by smtp.aliyun-inc.com(10.147.40.26);
          Tue, 09 Oct 2018 10:24:12 +0800
Date:   Tue, 9 Oct 2018 10:24:12 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, daniel.lezcano@linaro.org,
        anurup.m@huawei.com, Jonathan.Cameron@huawei.com,
        will.deacon@arm.com, zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V10 1/8] irqchip: add C-SKY SMP interrupt controller
Message-ID: <20181009022357.GA826@guoren>
References: <cover.1538672812.git.ren_guo@c-sky.com>
 <e06484474231375248e3e7a6ab47cf8ff8893129.1538672812.git.ren_guo@c-sky.com>
 <404fb433-020e-28f9-2434-a22c6db36a15@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404fb433-020e-28f9-2434-a22c6db36a15@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Oct 08, 2018 at 05:35:19PM +0100, Marc Zyngier wrote:
> Hi Guo,
> 
> On 04/10/18 18:22, Guo Ren wrote:
> >  - Irq-csky-mpintc is C-SKY smp system interrupt controller and it
> >    could support 16 soft irqs, 16 private irqs, and 992 max common
> >    irqs.
> >
> >Changelog:
> >  - pass checkpatch.pl
> >  - Move IPI_IRQ into the driver
> >  - Remove irq_set_default_host() and use set_ipi_irq_mapping()

 [...]

> >+#ifdef CONFIG_SMP
> >+static void csky_mpintc_send_ipi(const unsigned long *mask)
> >+{
> 
> Why isn't this a cpumask? It should be this driver's job to convert the
> cpumask to an interrupt-controller specific representation, and not the SMP
> code's.
Ok, use cpumask. 

 [...]

> >+#ifdef CONFIG_SMP
> >+	set_send_ipi(&csky_mpintc_send_ipi);
> >+
> >+	set_ipi_irq_mapping(&csky_mpintc_ipi_irq_mapping);
> 
> Since you seem to be inventing a new set_send_ipi callback, why don't you
> define it as:
> 
> void set_send_ipi(void (*func)(const struct cpumask *),
> 		  unsigned int ipi_irq);
> after having created the mapping for the IPI interrupt? It would avoid this
> rather pointless mapping callback.

I'll define it to:

void set_send_ipi(void (*func)(const struct cpumask *));

IPI_IRQ only use software-irq-15 in mpintc driver, so arch needn't care
about irq-num.

	/*
	 * INTCL_SIGR[3:0] INTID
	 * INTCL_SIGR[8:15] CPUMASK
	 */
	writel_relaxed((*mask) << 8 | IPI_IRQ, reg_base + INTCL_SIGR);

We direct put IPI_IRQ to the hw-reg for the target core.

Best Regards
 Guo Ren
