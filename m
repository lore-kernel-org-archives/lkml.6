Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43C9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EB6208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n7KbvW8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EB6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeK0UJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:09:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41459 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbeK0UJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:09:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so15309589plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=0tqJrbtN19P35yJFcST9bAZz+wMbkUkltlil3F3x3Z4=;
        b=n7KbvW8fjHY76trGD8IeH090rIVwqDN1lLnxCVmnHUUd0yeXtam66Xa0Tn2fUNojnT
         kSrkrnzdcNkkFff6etBw7Sjlybqg6oKQKHfJllxuuCV6r+6rT2ja1o+RSXXq+XflJa2x
         FbGC7rNnXZ18jQmR+kJXjYXuSsqk1e6qgFh0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=0tqJrbtN19P35yJFcST9bAZz+wMbkUkltlil3F3x3Z4=;
        b=k0KbMi4PiPrnM/br/Ai3iF5kE7LLkXnu2OR8nQF7itJUSQ9e8ir6d7SXwZF+md8f+y
         9PLuF0psVRAaPKgXcg+x5DsGqr/ihn10pdhQdG8iibWEBNVrpAh6z5tEH/2MCpgoq2X/
         ugE5pMffA+qnac6+x1UBEvreepKUXnGnQbkxsFUIOtjKIApFwprTuZYL7cu0xJb2JUZW
         gQ7l7L51zcKz7Hx1l9JZJteS1TTQH5USkLnLRQxgKSrHl4HyMCVIJRMtf4bjXQ6HYGEC
         yyfM3NeKG8NBMsm8Zf4tBsu0YfbFRLPOToM5XhvdJ4kKrWIfPHeoAkqFfwJCzb1tJZge
         WMpA==
X-Gm-Message-State: AA+aEWY68wJz284t6shIKyDs/lJGFYj7i2CDDUseCJR2dk3jdKoUwC7I
        ljjrWY2ONFKJP/GiMMZm0MMKew==
X-Google-Smtp-Source: AFSGD/Vht3KFFr1HFVNEjI6M5H0PROnT/wz69jzxyxL76HM9YmCUsBKh/m3tqfIrwOO2zR3ckf3tSg==
X-Received: by 2002:a17:902:a83:: with SMTP id 3mr26064762plp.276.1543309944554;
        Tue, 27 Nov 2018 01:12:24 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id b10sm4930987pfj.183.2018.11.27.01.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 01:12:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181126161455.GA28236@codeaurora.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com
References: <20181121000648.29262-1-ilina@codeaurora.org>
 <20181121000648.29262-3-ilina@codeaurora.org>
 <154283618199.88331.10217252750356423959@swboyd.mtv.corp.google.com>
 <20181126161455.GA28236@codeaurora.org>
Message-ID: <154330994255.88331.11409511159882116164@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC v3 2/3] dt-bindings: sdm845-pinctrl: add wakeup interrupt parent
 for GPIO
Date:   Tue, 27 Nov 2018 01:12:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-11-26 08:14:55)
> On Wed, Nov 21 2018 at 14:36 -0700, Stephen Boyd wrote:
> >Quoting Lina Iyer (2018-11-20 16:06:47)
> >> SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
> >> routed to the PDC as interrupts that can be used to wake the system up
> >> from deep low power modes and suspend.
> >>
> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >> ---
> >>  .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 31 ++++++++++++++++++-
> >>  1 file changed, 30 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pin=
ctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> >> index 665aadb5ea28..bedfa0b57fa6 100644
> >> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> >> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> >> @@ -29,6 +29,17 @@ SDM845 platform.
> >>         Definition: must be 2. Specifying the pin number and flags, as=
 defined
> >>                     in <dt-bindings/interrupt-controller/irq.h>
> >>
> >> +- wakeup-parent:
> >> +       Usage: optional
> >> +       Value type: <phandle>
> >> +       Definition: A phandle to the wakeup interrupt controller for t=
he SoC.
> >> +
> >> +- wakeup-irq:
> >
> >This shouldn't be needed. TLMM driver can probe for the possibility of
> >wakeup capable irqs from irq allocation step. The only place we should
> >need to know what TLMM pins map to what PDC lines is in the PDC driver.
> >
> Why? Every driver seems to translate the hardware IRQ and pass it to
> it's parent. Why should this be any different ? The PDC is an interrupt
> controller that just knows an interrupt port and maps it to the GIC. Not
> sure, I understand the reasoning for this. It seems to add more
> confusing relationship with the PDC interrupt controller, that way.
> =


Two reasons. First, simplicity. The TLMM driver just needs to pass the
gpio number up to the PDC gpio domain and then that domain can figure
out what hwirq it maps to within the PDC hw irq space. I don't see any
reason why we have to know the hwirq of PDC within the TLMM driver
besides "let's not be different".

And second, it makes it easier for us to implement the MPM case in the
TLMM driver by letting the TLMM code just ask "should I mask the irq
here or not?" by passing that with a wrapper struct around the fwspec
and a dedicated domain in the PDC/MPM driver. Keeping less things in the
TLMM driver and not driving the decision from DT but from tables in the
PDC driver also keeps things simple and reduces DT parsing code/time.

I'm not sure why Marc wanted the pdc to GIC SPI line mapping to come
from DT. I guess there were some contiguous ranges in there so making
the mapping in DT works OK enough because there are only a few ranges to
handle, but the GPIO map seems quite scattered so I don't see much of a
benefit to trying to compress it.

I'm hacking on this code to make it all nice and clean, but here's my
current WIP patch that at least works well enough for me to get gpio
irqs at runtime. I haven't tested the suspend path yet, but presumably
if irqs are working at runtime and the device isn't suspended then any
wakeup irqs will be kept unmasked at the PDC and things would "just
work". This is on top of these patches and the gpio hierarchical
irqdomain patch.

A couple suggestions for starting points:

 1) We could have PDC get a phandle to TLMM so that we can match up
    the irq domain in PDC to the irq domain inside TLMM with a
    irq domain ops::match/select function instead of using a token
    to match this up.
 =

 2) The PDC driver could be a little more friendly about globals
    and actually pass around pointers to things via the irq domain
    void pointer member.

 3) We could have the GPIO PDC domain be a child domain of the main
    PDC domain and just map between GPIO number space and PDC
    number space. Otherwise we duplicate some code between the two
    alloc implementations for trigger type remapping.

---8<----
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index faa7d61b9d6c..39abc06b3a3a 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -13,12 +13,13 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 =

 #define PDC_MAX_IRQS		126
+#define PDC_MAX_GPIO_IRQS	256
 =

 #define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
 #define ENABLE_INTR(reg, intr)	(reg | (1 << intr))
@@ -32,6 +33,11 @@ struct pdc_pin_region {
 	u32 cnt;
 };
 =

+struct pdc_gpio_pin_map {
+	unsigned int gpio;
+	u32 pdc_pin;
+};
+
 static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
 static struct pdc_pin_region *pdc_region;
@@ -47,9 +53,8 @@ static u32 pdc_reg_read(int reg, u32 i)
 	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
 }
 =

-static void pdc_enable_intr(struct irq_data *d, bool on)
+static void pdc_enable_intr(irq_hw_number_t pin_out, bool on)
 {
-	int pin_out =3D d->hwirq;
 	u32 index, mask;
 	u32 enable;
 =

@@ -65,13 +70,23 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
 =

 static void qcom_pdc_gic_mask(struct irq_data *d)
 {
-	pdc_enable_intr(d, false);
+	irq_hw_number_t hwirq =3D d->hwirq;
+
+	if (hwirq =3D=3D ULONG_MAX)
+		return;
+
+	pdc_enable_intr(hwirq, false);
 	irq_chip_mask_parent(d);
 }
 =

 static void qcom_pdc_gic_unmask(struct irq_data *d)
 {
-	pdc_enable_intr(d, true);
+	irq_hw_number_t hwirq =3D d->hwirq;
+
+	if (hwirq =3D=3D ULONG_MAX)
+		return;
+
+	pdc_enable_intr(hwirq, true);
 	irq_chip_unmask_parent(d);
 }
 =

@@ -111,9 +126,12 @@ enum pdc_irq_config_bits {
  */
 static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 {
-	int pin_out =3D d->hwirq;
+	irq_hw_number_t pin_out =3D d->hwirq;
 	enum pdc_irq_config_bits pdc_type;
 =

+	if (pin_out =3D=3D ULONG_MAX)
+		return 0;
+
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		pdc_type =3D PDC_EDGE_RISING;
@@ -157,7 +175,7 @@ static struct irq_chip qcom_pdc_gic_chip =3D {
 	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
 };
 =

-static irq_hw_number_t get_parent_hwirq(int pin)
+static irq_hw_number_t get_parent_hwirq(irq_hw_number_t pin)
 {
 	int i;
 	struct pdc_pin_region *region;
@@ -169,7 +187,6 @@ static irq_hw_number_t get_parent_hwirq(int pin)
 			return (region->parent_base + pin - region->pin_base);
 	}
 =

-	WARN_ON(1);
 	return ~0UL;
 }
 =

@@ -232,6 +249,141 @@ static const struct irq_domain_ops qcom_pdc_ops =3D {
 	.free		=3D irq_domain_free_irqs_common,
 };
 =

+static const struct pdc_gpio_pin_map sdm845_gpio_map[] =3D {
+	{ 1, 30 },
+	{ 3, 31 },
+	{ 5, 32 },
+	{ 10, 33 },
+	{ 11, 34 },
+	{ 20, 35 },
+	{ 22, 36 },
+	{ 24, 37 },
+	{ 26, 38 },
+	{ 30, 39 },
+	{ 31, 117 },
+	{ 32, 41 },
+	{ 34, 42 },
+	{ 36, 43 },
+	{ 37, 44 },
+	{ 38, 45 },
+	{ 39, 46 },
+	{ 40, 47 },
+	{ 41, 115 },
+	{ 43, 49 },
+	{ 44, 50 },
+	{ 46, 51 },
+	{ 48, 52 },
+	{ 49, 118 },
+	{ 52, 54 },
+	{ 53, 55 },
+	{ 54, 56 },
+	{ 56, 57 },
+	{ 57, 58 },
+	{ 58, 59 },
+	{ 59, 60 },
+	{ 60, 61 },
+	{ 61, 62 },
+	{ 62, 63 },
+	{ 63, 64 },
+	{ 64, 65 },
+	{ 66, 66 },
+	{ 68, 67 },
+	{ 71, 68 },
+	{ 73, 69 },
+	{ 77, 70 },
+	{ 78, 71 },
+	{ 79, 72 },
+	{ 80, 73 },
+	{ 84, 74 },
+	{ 85, 75 },
+	{ 86, 76 },
+	{ 88, 77 },
+	{ 89, 116 },
+	{ 91, 79 },
+	{ 92, 80 },
+	{ 95, 81 },
+	{ 96, 82 },
+	{ 97, 83 },
+	{ 101, 84 },
+	{ 103, 85 },
+	{ 104, 86 },
+	{ 115, 90 },
+	{ 116, 91 },
+	{ 117, 92 },
+	{ 118, 93 },
+	{ 119, 94 },
+	{ 120, 95 },
+	{ 121, 96 },
+	{ 122, 97 },
+	{ 123, 98 },
+	{ 124, 99 },
+	{ 125, 100 },
+	{ 127, 102 },
+	{ 128, 103 },
+	{ 129, 104 },
+	{ 130, 105 },
+	{ 132, 106 },
+	{ 133, 107 },
+	{ 145, 108 },
+};
+
+static irq_hw_number_t qcom_gpio_to_pdc_pin(unsigned int gpio)
+{
+	const struct pdc_gpio_pin_map *map =3D sdm845_gpio_map;
+	unsigned int i;
+
+
+	for (i =3D 0; i < ARRAY_SIZE(sdm845_gpio_map); i++, map++)
+		if (gpio =3D=3D map->gpio)
+			return map->pdc_pin;
+
+	return ULONG_MAX;
+}
+
+static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int vir=
q,
+			  unsigned int nr_irqs, void *data)
+{
+	struct qcom_irq_fwspec *qcom_fwspec =3D data;
+	struct irq_fwspec *fwspec =3D &qcom_fwspec->fwspec;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq, parent_hwirq;
+	unsigned int type;
+	int ret;
+
+	hwirq =3D qcom_gpio_to_pdc_pin(fwspec->param[0]);
+	parent_hwirq =3D get_parent_hwirq(hwirq);
+
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					    &qcom_pdc_gic_chip, NULL);
+	if (ret)
+		return ret;
+
+	if (hwirq =3D=3D ULONG_MAX)
+		return 0;
+
+	qcom_fwspec->mask =3D true;
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		type =3D IRQ_TYPE_EDGE_RISING;
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		type =3D IRQ_TYPE_LEVEL_HIGH;
+
+	parent_fwspec.fwnode      =3D domain->parent->fwnode;
+	parent_fwspec.param_count =3D 3;
+	parent_fwspec.param[0]    =3D 0;
+	parent_fwspec.param[1]    =3D parent_hwirq;
+	parent_fwspec.param[2]    =3D type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static const struct irq_domain_ops qcom_pdc_gpio_ops =3D {
+	.alloc		=3D qcom_pdc_gpio_alloc,
+	.free		=3D irq_domain_free_irqs_common,
+};
+
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
 	int ret, n;
@@ -270,7 +422,7 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 =

 static int qcom_pdc_init(struct device_node *node, struct device_node *par=
ent)
 {
-	struct irq_domain *parent_domain, *pdc_domain;
+	struct irq_domain *parent_domain, *pdc_domain, *pdc_gpio_domain;
 	int ret;
 =

 	pdc_base =3D of_iomap(node, 0);
@@ -301,6 +453,12 @@ static int qcom_pdc_init(struct device_node *node, str=
uct device_node *parent)
 		goto fail;
 	}
 =

+	pdc_gpio_domain =3D irq_domain_create_hierarchy(parent_domain, 0, PDC_MAX=
_GPIO_IRQS,
+						 of_fwnode_handle(node),
+						 &qcom_pdc_gpio_ops, NULL);
+	/* TODO: Replace DOMAIN_BUS_NEXUS with DOMAIN_GPIO_WAKEUP or something */
+	irq_domain_update_bus_token(pdc_gpio_domain, DOMAIN_BUS_NEXUS);
+
 	return 0;
 =

 fail:
@@ -308,5 +466,4 @@ static int qcom_pdc_init(struct device_node *node, stru=
ct device_node *parent)
 	iounmap(pdc_base);
 	return ret;
 }
-
 IRQCHIP_DECLARE(pdc_sdm845, "qcom,sdm845-pdc", qcom_pdc_init);
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinc=
trl-msm.c
index 4852f38f48ec..42c2f8fc4c28 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -28,6 +28,7 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/soc/qcom/irq.h>
 #include <linux/reboot.h>
 #include <linux/pm.h>
 #include <linux/log2.h>
@@ -69,6 +70,7 @@ struct msm_pinctrl {
 =

 	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
 	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
+	DECLARE_BITMAP(wakeup_masked_irqs, MAX_NR_GPIO);
 =

 	const struct msm_pinctrl_soc_data *soc;
 	void __iomem *regs;
@@ -695,6 +697,13 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 =

 	g =3D &pctrl->soc->groups[d->hwirq];
 =

+	if (d->parent_data)
+		irq_chip_unmask_parent(d);
+
+	/* Monitored by parent wakeup controller? Keep masked */
+	if (test_bit(d->hwirq, pctrl->wakeup_masked_irqs))
+		return;
+
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 =

 	val =3D readl(pctrl->regs + g->intr_cfg_reg);
@@ -705,9 +714,6 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 	set_bit(d->hwirq, pctrl->enabled_irqs);
 =

 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-
-	if (d->parent_data)
-		irq_chip_unmask_parent(d);
 }
 =

 static void msm_gpio_irq_ack(struct irq_data *d)
@@ -718,6 +724,10 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	unsigned long flags;
 	u32 val;
 =

+	/* Handled by parent wakeup controller? Do nothing */
+	if (test_bit(d->hwirq, pctrl->wakeup_masked_irqs))
+		return;
+
 	g =3D &pctrl->soc->groups[d->hwirq];
 =

 	raw_spin_lock_irqsave(&pctrl->lock, flags);
@@ -745,6 +755,13 @@ static int msm_gpio_irq_set_type(struct irq_data *d, u=
nsigned int type)
 =

 	g =3D &pctrl->soc->groups[d->hwirq];
 =

+	if (d->parent_data)
+		irq_chip_set_type_parent(d, type);
+
+	/* Monitored by parent wakeup controller? Keep masked */
+	if (test_bit(d->hwirq, pctrl->wakeup_masked_irqs))
+		return 0;
+
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 =

 	/*
@@ -826,9 +843,6 @@ static int msm_gpio_irq_set_type(struct irq_data *d, un=
signed int type)
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		irq_set_handler_locked(d, handle_edge_irq);
 =

-	if (d->parent_data)
-		irq_chip_set_type_parent(d, type);
-
 	return 0;
 }
 =

@@ -959,31 +973,6 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinct=
rl *pctrl)
 	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
 }
 =

-static int get_parent_hwirq(struct msm_pinctrl *pctrl, unsigned int hwirq)
-{
-	int i, n, ret;
-	int gpio, pdc =3D -EINVAL;
-	struct device_node *np =3D pctrl->dev->of_node;
-
-	n =3D of_property_count_elems_of_size(np, "wake-irq", sizeof(u32));
-	if (n <=3D 0 || n % 2)
-		return -EINVAL;
-
-	for (i =3D 0; i < n / 2; i++) {
-		ret =3D of_property_read_u32_index(np, "wake-irq", 2 * i, &gpio);
-		if (ret)
-			return ret;
-		if (gpio !=3D hwirq)
-			continue;
-		ret =3D of_property_read_u32_index(np, "wake-irq", 2 * i + 1,
-						 &pdc);
-		if (ret)
-			return ret;
-	}
-
-	return pdc;
-}
-
 static int msm_gpio_domain_translate(struct irq_domain *d,
 				     struct irq_fwspec *fwspec,
 				     unsigned long *hwirq, unsigned int *type)
@@ -1002,36 +991,44 @@ static int msm_gpio_domain_translate(struct irq_doma=
in *d,
 static int msm_gpio_domain_alloc(struct irq_domain *domain, unsigned int v=
irq,
 				 unsigned int nr_irqs, void *arg)
 {
-	int ret =3D 0;
+	int ret;
 	irq_hw_number_t hwirq;
-	int parent_hwirq;
 	struct gpio_chip *gc =3D domain->host_data;
 	struct msm_pinctrl *pctrl =3D gpiochip_get_data(gc);
-	struct irq_fwspec parent_fwspec, *fwspec =3D arg;
+	struct irq_fwspec *fwspec =3D arg;
+	struct qcom_irq_fwspec parent =3D { };
 	unsigned int type;
 =

 	ret =3D msm_gpio_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 =

-	parent_hwirq =3D get_parent_hwirq(pctrl, hwirq);
-	if (parent_hwirq < 0)
-		return 0;
-
 	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
 					    &pctrl->irq_chip, gc);
 	if (ret < 0)
 		return ret;
 =

-	parent_fwspec.fwnode      =3D domain->parent->fwnode;
-	parent_fwspec.param_count =3D 2;
-	parent_fwspec.param[0]    =3D parent_hwirq;
-	parent_fwspec.param[1]    =3D type;
+	if (!domain->parent)
+		return 0;
+
+	parent.fwspec.fwnode      =3D domain->parent->fwnode;
+	parent.fwspec.param_count =3D 2;
+	parent.fwspec.param[0]    =3D hwirq;
+	parent.fwspec.param[1]    =3D type;
+
+	ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent);
+	if (ret)
+		return ret;
+
+	if (parent.mask)
+		set_bit(hwirq, pctrl->wakeup_masked_irqs);
 =

-	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
-					    &parent_fwspec);
+	return 0;
 }
 =

+/*
+ * TODO: Get rid of this and push it into gpiochip_to_irq()
+ */
 static int msm_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
 	struct irq_fwspec fwspec;
@@ -1044,7 +1041,7 @@ static int msm_gpio_to_irq(struct gpio_chip *chip, un=
signed int offset)
 	return irq_create_fwspec_mapping(&fwspec);
 }
 =

-static const struct irq_domain_ops msm_gpiod_ops =3D {
+static const struct irq_domain_ops msm_gpio_domain_ops =3D {
 	.translate =3D msm_gpio_domain_translate,
 	.alloc     =3D msm_gpio_domain_alloc,
 	.free      =3D irq_domain_free_irqs_top,
@@ -1070,6 +1067,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	chip->need_valid_mask =3D msm_gpio_needs_valid_mask(pctrl);
 =

 	pctrl->irq_chip.name =3D "msmgpio";
+	pctrl->irq_chip.irq_eoi	=3D irq_chip_eoi_parent;
 	pctrl->irq_chip.irq_mask =3D msm_gpio_irq_mask;
 	pctrl->irq_chip.irq_unmask =3D msm_gpio_irq_unmask;
 	pctrl->irq_chip.irq_ack =3D msm_gpio_irq_ack;
@@ -1078,6 +1076,21 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	pctrl->irq_chip.irq_request_resources =3D msm_gpio_irq_reqres;
 	pctrl->irq_chip.irq_release_resources =3D msm_gpio_irq_relres;
 =

+	chip->irq.chip =3D &pctrl->irq_chip;
+	chip->irq.domain_ops =3D &msm_gpio_domain_ops;
+	chip->irq.handler =3D handle_edge_irq;
+	chip->irq.default_type =3D IRQ_TYPE_NONE;
+
+	dn =3D of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
+	if (dn) {
+		chip->irq.parent_domain =3D irq_find_matching_host(dn, DOMAIN_BUS_NEXUS);
+		of_node_put(dn);
+		if (!chip->irq.parent_domain)
+			return -EPROBE_DEFER;
+
+		chip->to_irq =3D msm_gpio_to_irq;
+	}
+
 	ret =3D gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
 		dev_err(pctrl->dev, "Failed register gpiochip\n");
@@ -1110,27 +1123,6 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 		}
 	}
 =

-	dn =3D of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
-	if (dn) {
-		chip->irq.parent_domain =3D irq_find_host(dn);
-		of_node_put(dn);
-		if (!chip->irq.parent_domain) {
-			ret =3D -EPROBE_DEFER;
-			goto fail;
-		}
-		chip->to_irq =3D msm_gpio_to_irq;
-	}
-
-	ret =3D gpiochip_irqchip_add(chip,
-				   &pctrl->irq_chip,
-				   0,
-				   handle_edge_irq,
-				   IRQ_TYPE_NONE);
-	if (ret) {
-		dev_err(pctrl->dev, "Failed to add irqchip to gpiochip\n");
-		goto fail;
-	}
-
 	gpiochip_set_chained_irqchip(chip, &pctrl->irq_chip, pctrl->irq,
 				     msm_gpio_irq_handler);
 =

diff --git a/include/linux/soc/qcom/irq.h b/include/linux/soc/qcom/irq.h
new file mode 100644
index 000000000000..bacc9edbce0d
--- /dev/null
+++ b/include/linux/soc/qcom/irq.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __QCOM_IRQ_H
+#define __QCOM_IRQ_H
+
+#include <linux/irqdomain.h>
+
+/**
+ * struct qcom_irq_fwspec - qcom specific irq fwspec wrapper
+ * @fwspec: irq fwspec
+ * @mask: if true, keep the irq masked in the gpio controller
+ *
+ * Use this structure to communicate between the parent irq chip, MPM or P=
DC,
+ * to the gpio chip, TLMM, about the gpio being allocated in the parent
+ * and if the gpio chip should keep the line masked because the parent irq
+ * chip is handling everything about the irq line.
+ */
+struct qcom_irq_fwspec {
+	struct irq_fwspec fwspec;
+	bool mask;
+};
+
+#endif
