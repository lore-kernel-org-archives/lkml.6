Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeCIRFO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:05:14 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbeCIRFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:05:13 -0500
Subject: Re: [PATCH] arm64: kdump: fix interrupt handling done during
 machine_crash_shutdown
To: Grzegorz Jaszczyk <jaz@semihalf.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Hoeun Ryu <hoeun.ryu@gmail.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
 <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
 <9a709b76-1b45-8250-9d8e-adbad59a43cc@arm.com>
 <CAH76GKPOX6J=mKV89pjp+f_K7=1aS_SaGfy_nCN5jLDNM4r9aA@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <6805008a-b1cd-b8f7-66cc-1e61beef98a5@arm.com>
Date: Fri, 9 Mar 2018 17:05:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAH76GKPOX6J=mKV89pjp+f_K7=1aS_SaGfy_nCN5jLDNM4r9aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/18 10:33, Grzegorz Jaszczyk wrote:
>> Not using EOImode==1 is definitely an oddity (at least on the host), but
>> that doesn't mean it shouldn't work.
>>
>> The reason the thing is hanging is that although we correctly deactivate
>> the interrupt, nothing performs the priority drop. Your write to EOI
>> helps in the sense that it guarantees that both priority drop and
>> deactivate are done with the same operation, but that's not something
>> we'd want to expose.
>>
>> My preferred approach would be to nuke the active priority registers at
>> boot time, as the CPUs come up. I'll try to write something this week.
> 
> I've made a PoC which performs priority drop at boot time as you
> suggested and it works with both GICv2 and GICv3 but I see some
> problem:
> It seems that the only way to drop the priority is to perform write to
> EOI register (the GIC_RPR is RO). According to GIC documentation a
> write to EOI register must correspond to the most recent valid read
> from IAR. The problem is that the interrupt was already acked in the
> 'original' kernel, so reading GICC_IAR in crashdump kernel returns
> spurious interrupt and it seems that there is no way to figure out
> appropriate irqnr for EOI write. Nevertheless I've observed that
> choosing random irqnr for EOI write works fine (maybe because all
> interrupts in Linux uses the same priority?).
> 
> Here is the PoC (not ready for submission only for further
> discussion): https://pastebin.com/gLYNuRiZ
> 
> Looking forward to your feedback.

Well, the feedback is that this patch is really horrible, and choosing a 
random IRQ is at best hilarious. It also doesn't account for multiple 
priorities being active... In short, this is just fundamentally broken.

I gave you a clue about the active priority registers. Why didn't you 
try that?

Anyway, here's something that should fix it.

	M.

>From 6ace9d56c96203c4d11a23cbec6a6c216164bb88 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Fri, 9 Mar 2018 14:53:19 +0000
Subject: [PATCH] irqchip/gic-v2: Reset APRn registers at boot time

Booting a crash kernel while in an interrupt handler is likely
to leave the Active Priority Registers with some state that
is not relevant to the new kernel, and is likely to lead
to erratic behaviours such as interrupts not firing as their
priority is already active.

As a sanity measure, wipe the APRs clean on startup.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 121af5cf688f..79801c24800b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -453,15 +453,26 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
 	return mask;
 }
 
+static bool gic_check_gicv2(void __iomem *base)
+{
+	u32 val = readl_relaxed(base + GIC_CPU_IDENT);
+	return (val & 0xff0fff) == 0x02043B;
+}
+
 static void gic_cpu_if_up(struct gic_chip_data *gic)
 {
 	void __iomem *cpu_base = gic_data_cpu_base(gic);
 	u32 bypass = 0;
 	u32 mode = 0;
+	int i;
 
 	if (gic == &gic_data[0] && static_key_true(&supports_deactivate))
 		mode = GIC_CPU_CTRL_EOImodeNS;
 
+	if (gic_check_gicv2(cpu_base))
+		for (i = 0; i < 4; i++)
+			writel_relaxed(0, cpu_base + GIC_CPU_ACTIVEPRIO + i * 4);
+
 	/*
 	* Preserve bypass disable bits to be written back later
 	*/
@@ -1264,12 +1275,6 @@ static int __init gicv2_force_probe_cfg(char *buf)
 }
 early_param("irqchip.gicv2_force_probe", gicv2_force_probe_cfg);
 
-static bool gic_check_gicv2(void __iomem *base)
-{
-	u32 val = readl_relaxed(base + GIC_CPU_IDENT);
-	return (val & 0xff0fff) == 0x02043B;
-}
-
 static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
 {
 	struct resource cpuif_res;
-- 
2.14.2


-- 
Jazz is not dead. It just smells funny...
