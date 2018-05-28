Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937663AbeE1Kog (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937335AbeE1Ko3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:44:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 069/496] ARM: OMAP3: Fix prm wake interrupt for resume
Date: Mon, 28 May 2018 11:57:34 +0200
Message-Id: <20180528100322.694996251@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit d3be6d2a08bd26580562d9714d3d97ea9ba22c73 ]

For platform_suspend_ops, the finish call is too late to re-enable wake
irqs and we need re-enable wake irqs on wake call instead.

Otherwise noirq resume for devices has already happened. And then
dev_pm_disarm_wake_irq() has already disabled the dedicated wake irqs
when the interrupt triggers and the wake irq is never handled.

For devices that are already in PM runtime suspended state when we
enter suspend this means that a possible wake irq will never trigger.

And this can lead into a situation where a device has a pending padconf
wake irq, and the device will stay unresponsive to any further wake
irqs.

This issue can be easily reproduced by setting serial console log level
to zero, letting the serial console idle, and suspend the system from
an ssh terminal. Then try to wake up the system by typing to the serial
console.

Note that this affects only omap3 PRM interrupt as that's currently
the only omap variant that does anything in omap_pm_wake().

In general, for the wake irqs to work, the interrupt must have either
IRQF_NO_SUSPEND or IRQF_EARLY_RESUME set for it to trigger before
dev_pm_disarm_wake_irq() disables the wake irqs.

Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/pm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -186,7 +186,7 @@ static void omap_pm_end(void)
 	cpu_idle_poll_ctrl(false);
 }
 
-static void omap_pm_finish(void)
+static void omap_pm_wake(void)
 {
 	if (soc_is_omap34xx())
 		omap_prcm_irq_complete();
@@ -196,7 +196,7 @@ static const struct platform_suspend_ops
 	.begin		= omap_pm_begin,
 	.end		= omap_pm_end,
 	.enter		= omap_pm_enter,
-	.finish		= omap_pm_finish,
+	.wake		= omap_pm_wake,
 	.valid		= suspend_valid_only_mem,
 };
 
