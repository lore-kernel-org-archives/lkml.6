Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeDJRav (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:30:51 -0400
Received: from foss.arm.com ([217.140.101.70]:41132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751820AbeDJRau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:30:50 -0400
Subject: Re: [PATCH] irqchip/gic-v3: Support v2m frame backwards compatibility
 mode
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hanna Hawa <hannah@marvell.com>,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>
References: <20170320223614.1351-1-sboyd@codeaurora.org>
 <bac1e827-3860-d92c-7bb4-eaf9840c608f@arm.com>
 <20180410170155.6e07113d@windsurf>
 <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
Organization: ARM Ltd
Message-ID: <41edab13-83db-4d57-583a-782144463857@arm.com>
Date: Tue, 10 Apr 2018 18:30:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/18 16:23, Marc Zyngier wrote:

> I have a vague idea how to support this. Given that level-triggered MSIs
> have to be platform MSIs (because it is just madness otherwise), we can
> probably store an extra message in the struct platform_msi_desc for the
> "lower the line" write. On activation, you'd get two callbacks, probably
> with a flag of some sort to indicate whether this is for the rising or
> falling edge.

Actually, we can get away with a single call and no extra storage if we do
something like below, and check the trigger in the backends:

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2a8571f72b17..85408be6d752 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -89,13 +89,13 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
 			    const struct cpumask *mask, bool force)
 {
 	struct irq_data *parent = irq_data->parent_data;
-	struct msi_msg msg;
+	struct msi_msg msg[2];
 	int ret;
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
-		BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
-		irq_chip_write_msi_msg(irq_data, &msg);
+		BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
+		irq_chip_write_msi_msg(irq_data, msg);
 	}
 
 	return ret;
@@ -104,20 +104,20 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
 static int msi_domain_activate(struct irq_domain *domain,
 			       struct irq_data *irq_data, bool early)
 {
-	struct msi_msg msg;
+	struct msi_msg msg[2];
 
-	BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
-	irq_chip_write_msi_msg(irq_data, &msg);
+	BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
+	irq_chip_write_msi_msg(irq_data, msg);
 	return 0;
 }
 
 static void msi_domain_deactivate(struct irq_domain *domain,
 				  struct irq_data *irq_data)
 {
-	struct msi_msg msg;
+	struct msi_msg msg[2];
 
-	memset(&msg, 0, sizeof(msg));
-	irq_chip_write_msi_msg(irq_data, &msg);
+	memset(msg, 0, sizeof(msg));
+	irq_chip_write_msi_msg(irq_data, msg);
 }
 
 static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,

Is it disgusting? You bet. Does it work? Probably.

	M.
-- 
Jazz is not dead. It just smells funny...
