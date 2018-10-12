Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20DFC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8D720658
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8D720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJLKvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 06:51:50 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36522 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbeJLKvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 06:51:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07480073|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03291;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.D0thR3Q_1539314483;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D0thR3Q_1539314483)
          by smtp.aliyun-inc.com(10.147.44.118);
          Fri, 12 Oct 2018 11:21:23 +0800
Date:   Fri, 12 Oct 2018 11:21:23 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, daniel.lezcano@linaro.org,
        will.deacon@arm.com, jhogan@kernel.org, paul.burton@mips.com,
        peterz@infradead.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V11 1/8] irqchip: add C-SKY SMP interrupt controller
Message-ID: <20181012032122.GA20643@guoren-Inspiron-7460>
References: <cover.1539095311.git.ren_guo@c-sky.com>
 <83d216b3fed039037ebe8b8513f3c51a36934e74.1539095312.git.ren_guo@c-sky.com>
 <8772c090-a139-04e4-a55f-820afe1bb5bd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8772c090-a139-04e4-a55f-820afe1bb5bd@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, Oct 09, 2018 at 04:11:05PM +0100, Marc Zyngier wrote:
> On 09/10/18 15:41, Guo Ren wrote:
> >  - Irq-csky-mpintc is C-SKY smp system interrupt controller and it
> >    could support 16 soft irqs, 16 private irqs, and 992 max common
> >    irqs.
> >
> >Changelog:
> >  - Convert the cpumask to an interrupt-controller specific representation
> >    in driver's code, and not the SMP code's.
> >  - pass checkpatch.pl
> >  - Move IPI_IRQ into the driver
> >  - Remove irq_set_default_host() and use set_ipi_irq_mapping()
> >  - Change name with upstream feed-back
> >  - Change irq map, reserve soft_irq & private_irq space
> >  - Add License and Copyright
> >  - Support set_affinity for irq balance in SMP
> >
> >Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> >Cc: Marc Zyngier <marc.zyngier@arm.com>
> 
> [...]
> 
> >+/* C-SKY multi processor interrupt controller */
> >+static int __init
> >+csky_mpintc_init(struct device_node *node, struct device_node *parent)
> >+{
> >+	unsigned int cpu, nr_irq;
> >+	int ret;
> >+
> >+	if (parent)
> >+		return 0;
> >+
> >+	ret = of_property_read_u32(node, "csky,num-irqs", &nr_irq);
> >+	if (ret < 0)
> >+		nr_irq = INTC_IRQS;
> >+
> >+	if (INTCG_base == NULL) {
> >+		INTCG_base = ioremap(mfcr("cr<31, 14>"),
> >+				     INTCL_SIZE*nr_cpu_ids + INTCG_SIZE);
> >+		if (INTCG_base == NULL)
> >+			return -EIO;
> >+
> >+		INTCL_base = INTCG_base + INTCG_SIZE;
> >+
> >+		writel_relaxed(BIT(0), INTCG_base + INTCG_ICTLR);
> >+	}
> >+
> >+	root_domain = irq_domain_add_linear(node, nr_irq, &csky_irqdomain_ops,
> >+					    NULL);
> >+	if (!root_domain)
> >+		return -ENXIO;
> >+
> >+	/* for every cpu */
> >+	for_each_present_cpu(cpu) {
> >+		per_cpu(intcl_reg, cpu) = INTCL_base + (INTCL_SIZE * cpu);
> >+		writel_relaxed(BIT(0), per_cpu(intcl_reg, cpu) + INTCL_PICTLR);
> >+	}
> >+
> >+	set_handle_irq(&csky_mpintc_handler);
> >+
> >+#ifdef CONFIG_SMP
> >+	set_send_ipi(&csky_mpintc_send_ipi);
> >+
> >+	set_ipi_irq_mapping(&csky_mpintc_ipi_irq_mapping);
> 
> Same remark as before.
> 
> You do not need this second callback, and you should redefine set_send_ipi
> to take an irq number:
> 
> 	ipi_irq = irq_create_mapping(root_domain, IPI_IRQ);
> 	if (!ipi_irq)
> 		[handle error]
> 
> 	set_send_ipi(csky_mpintc_send_ipi, ipi_irq);
> 
> and you can then delete both set_ipi_irq_mapping and csky_mpintc_handler,
> none of which serve any purpose.
> 
> In your SMP code:
> 
> void __init set_send_ipi(void (*func)(const struct cpumask *), int irq)
> {
> 	if (send_arch_ipi)
> 		return;
> 
> 	send_arch_ipi = func;
> 	ipi_irq = irq;
> }
> 
> and simplify setup_smp_ipi.
Ok, remove the set_ipi_irq_mapping. See my next version patch.

Best Regards
 Guo Ren
