Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D814C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5145420821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfBEJ6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:58:14 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:49754 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfBEJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:58:14 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-69-76-nat.elisa-mobile.fi [85.76.69.76])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id C4FE82001B;
        Tue,  5 Feb 2019 11:58:09 +0200 (EET)
Date:   Tue, 5 Feb 2019 11:58:09 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tom Li <tomli@tomli.me>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>, ak@linux.intel.com,
        bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, ville.syrjala@linux.intel.com,
        viresh.kumar@linaro.org, linux-mips@vger.kernel.org
Subject: Re: [REGRESSION 4.20-rc1] 45975c7d21a1 ("rcu: Define RCU-sched API
 in terms of RCU for Tree RCU PREEMPT builds")
Message-ID: <20190205095809.GA16356@darkstar.musicnaut.iki.fi>
References: <20181113135453.GW9144@intel.com>
 <20181113151037.GG4170@linux.ibm.com>
 <20181114202013.GA27603@linux.ibm.com>
 <20181126220122.GA6345@linux.ibm.com>
 <20190205050700.GA31571@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190205050700.GA31571@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 05, 2019 at 01:07:00PM +0800, Tom Li wrote:
> On Tue, Nov 13, 2018 at 03:54:53PM +0200, Ville Syrjälä wrote:
> > Hi Paul,
> > After 4.20-rc1 some of my 32bit UP machines no longer reboot/shutdown.
> > I bisected this down to commit 45975c7d21a1 ("rcu: Define RCU-sched
> > API in terms of RCU for Tree RCU PREEMPT builds").
> > 
> > I traced the hang into
> > -> cpufreq_suspend()
> >  -> cpufreq_stop_governor()
> >   -> cpufreq_dbs_governor_stop()
> >    -> gov_clear_update_util()
> >     -> synchronize_sched()
> >      -> synchronize_rcu()
> >
> > Only PREEMPT=y is affected for obvious reasons, but that couldn't
> > explain why the same UP kernel booted on an SMP machine worked fine.
> > Eventually I realized that the difference between working and
> > non-working machine was IOAPIC vs. PIC. With initcall_debug I saw
> > that we mask everything in the PIC before cpufreq is shut down,
> 
> Hello Paul & Ville.
> 
> I'm not a kernel hacker, just a n00b playing with various non-x86
> systems, but I've been forced getting into kernel hacking due to
> the same issue.
> 
> Since February, I'm working on porting some trivial out-of-tree
> drivers to the upstream, and noticed my Yeeloong 8089D, a machine running
> the Loongson 2F 64-bit MIPS-III processor, will completely hang during
> reboot or shutdown. I tried bisecting it for 24 hours without sleep, but
> the attempt had failed.
> 
> I managed to narrow it in-between 4.19 and 4.20, most unusual thing I've
> observed was its probabilistic nature. The chance of triggering it seems
> getting progressively higher since 4.20, making pinpointing the specific
> commit difficult, finally with a 100% chance since Linux 4.19.
> 
> I initially suspected a bug in the platform driver, later I also tried
> to disable various kernel hardening options, all without success. At this
> point I've realized, because it has shown to be probabilistic, it must be
> a race condition, and since it's an uniprocessor system, it must be the
> CPU scheduler getting preempted somehow. Disabling CONFIG_PREEMPT makes
> the issue go away. I tried to add various preempt_disable() in the platform
> driver but didn't work.
> 
> Finally I've hooked up a netconsole and started adding printk()s.
> 
> [   23.652000] loongson2_cpufreq loongson2_cpufreq: shutdown
> [   23.656000] loongson-gpio loongson-gpio: shutdown
> [   23.660000] migrate_to_reboot_cpu()
> [   23.664000] syscore_shutdown()
> [   23.668000] PM: Calling i8259A_shutdown+0x0/0xa8
> [   23.672000] PM: Calling irq_gc_shutdown+0x0/0x88
> [   23.672000] PM: Calling cpufreq_suspend+0x0/0x1a0
> [   23.672000] cpufreq_suspend()
> [   23.672000] cpufreq_suspend: Suspending Governors
> [   23.672000] cpufreq_stop_governor()
> [   23.672000] cpufreq_stop_governor: for CPU 0
> 
> Looks like something in the core cpufreq code? So I tried searching
> "cpufreq_stop_governor()" at LKML... Oops!

Can you try below fix? It works on my Loongson.

A.

---

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Wed, 2 Jan 2019 22:58:52 +0200
Subject: [PATCH] irqchip/i8259: fix shutdown order by moving syscore_ops
 registration

When using cpufreq on Loongson 2F MIPS platform, "poweroff"
command gets frequently stuck in syscore_shutdown(). The reason is
that i8259A_shutdown() gets called before cpufreq_suspend(), and if we
have pending work then irq_work_sync() in cpufreq_dbs_governor_stop()
gets stuck forever as we have all interrupts masked already.

irq-i8259 is registering syscore_ops using device_initcall(),
while cpufreq uses core_initcall(). Fix the shutdown order simply
by registering the irq syscore_ops during the early IRQ init instead
of using a separate initcall at later stage.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/irqchip/irq-i8259.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index b0d4aab1a58c..d000870d9b6b 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -225,14 +225,6 @@ static struct syscore_ops i8259_syscore_ops = {
 	.shutdown = i8259A_shutdown,
 };
 
-static int __init i8259A_init_sysfs(void)
-{
-	register_syscore_ops(&i8259_syscore_ops);
-	return 0;
-}
-
-device_initcall(i8259A_init_sysfs);
-
 static void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
@@ -332,6 +324,7 @@ struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
 		panic("Failed to add i8259 IRQ domain");
 
 	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
+	register_syscore_ops(&i8259_syscore_ops);
 	return domain;
 }
 
-- 
2.17.0

