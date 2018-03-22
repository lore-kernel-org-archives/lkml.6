Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbeCVK3M convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:29:12 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14813 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeCVK3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:29:08 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 22 Mar 2018 03:29:03 -0700
From: Aniruddha Banerjee <aniruddhab@nvidia.com>
To: Marc Zyngier <marc.zyngier@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        Thierry Reding <treding@nvidia.com>, Vipin Kumar <vipink@nvidia.com>
Subject: [RFC PATCH] irqchip: arm-gic: take gic_lock when updating irq type
Thread-Topic: [RFC PATCH] irqchip: arm-gic: take gic_lock when updating irq
 type
Thread-Index: AdPBxF2SqE+GlSbOTIC23ydnb4Rn2w==
Date: Thu, 22 Mar 2018 10:28:59 +0000
Message-ID: <c20f41d47ed9444b9050bc1f609d4bbe@bgmail101.nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.24.44.47]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel documentation states that the irq-chip driver should
handle the locking of the irq-chip registers. In the irq-gic,
the accesses to the irqchip are seemingly not protected and multiple
writes to SPIs from different irq descriptors do RMW requests without
taking the irq-chip lock. When multiple irqs call the request_irq at
the same time, there can be a simultaneous write at the gic
distributor, leading to a race. Acquire the irq_controller lock when the
irq_type is updated.

This patch is only for GICv2; however, I have noticed a similar
implementation in GICv3. This patch is sent as an RFC in case I am
missing anything.

Signed-off-by: Aniruddha Banerjee <aniruddhab@nvidia.com>
---
 drivers/irqchip/irq-gic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4c797b43614d..61380f5a2254 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -67,6 +67,8 @@ static void gic_check_cpu_features(void)
 #define gic_check_cpu_features()       do { } while(0)
 #endif

+static DEFINE_RAW_SPINLOCK(irq_controller_lock);
+
 union gic_base {
        void __iomem *common_base;
        void __percpu * __iomem *percpu_base;
@@ -529,6 +531,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 {
        void __iomem *base = gic_dist_base(d);
        unsigned int gicirq = gic_irq(d);
+       int ret;

        /* Interrupt configuration for SGIs can't be changed */
        if (gicirq < 16)
@@ -539,7 +542,11 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
                            type != IRQ_TYPE_EDGE_RISING)
                return -EINVAL;

-       return gic_configure_irq(gicirq, type, base, NULL);
+       raw_spin_lock(&irq_controller_lock);
+       ret = gic_configure_irq(gicirq, type, base, NULL);
+       raw_spin_unlock(&irq_controller_lock);
+
+       return ret;
 }

 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
--
2.15.1
