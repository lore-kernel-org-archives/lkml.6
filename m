Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E2FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 02:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D82214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 02:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D82214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeIQHel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 03:34:41 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43161 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbeIQHel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 03:34:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07531099|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.Crl3yJ3_1537150169;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Crl3yJ3_1537150169)
          by smtp.aliyun-inc.com(10.147.41.138);
          Mon, 17 Sep 2018 10:09:29 +0800
Date:   Mon, 17 Sep 2018 10:09:29 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 1/3] irqchip: add C-SKY irqchip drivers
Message-ID: <20180917020928.GA22452@guoren-Inspiron-7460>
References: <a70337117db84f6e1091d0b3fc28acb691ac9b35.1537087118.git.ren_guo@c-sky.com>
 <86in35mfas.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86in35mfas.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 08:07:55PM +0100, Marc Zyngier wrote:
> On Sun, 16 Sep 2018 09:50:02 +0100,
> Guo Ren <ren_guo@c-sky.com> wrote:
> > +static void csky_mpintc_handler(struct pt_regs *regs)
> > +{
> > +	void __iomem *reg_base = this_cpu_read(intcl_reg);
> > +
> > +	do {
> > +		handle_domain_irq(NULL,
> 
> It is definitely odd to call into handle_domain_irq without a
> domain. A new architecture (which C-SKY apparently is) shouldn't
> depend on this, and should always provide a domain.
Ok, I'll change it to handle_domain_irq(root_domain and prepare the
root_domain definition.

> > +	ret = of_property_read_u32(node, "csky,num-irqs", &nr_irq);
> > +	if (ret < 0) {
> > +		nr_irq = INTC_IRQS;
> > +	}
> 
> Drop the extra braces.
Ok, and change it to: 
	if (ret < 0)
		nr_irq = INTC_IRQS

> > +
> > +	irq_set_default_host(root_domain);
> 
> Please drop this. There is no reason to use this on any modern, DT
> based architecture.
Please let me keep this and in my arch/csky/kernel/smp.c:

void __init setup_smp_ipi(void)
{
	...
	irq_create_mapping(NULL, IPI_IRQ);

I need irq_set_default_host to pass the domain and this api is used by
a lot of drivers:

$ grep irq_set_default_host drivers/irqchip -r | wc -l
16

In future we could find a better solution.

> > diff --git a/irq-csky-apb-intc.c b/irq-csky-apb-intc.c
> > new file mode 100644
> > index 0000000..d56e6b5
> > --- /dev/null
> > +++ b/irq-csky-apb-intc.c
> 
> This is a separate driver, right? Please make it a separate patch.
Ok, no problem.

> > +static inline int handle_irq_perbit(struct pt_regs *regs, u32 hwirq, u32 irq_base)
> 
> Consider using bool as the return type, and use true/false as return
> values.
Ok, no problem.


> > +	int ret;
> 
> bool.
Ok, no problem.


> > +	int ret;
> 
> bool.
Ok, no problem.
