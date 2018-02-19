Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeBSOu6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:50:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59489 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbeBSOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:50:57 -0500
Date: Mon, 19 Feb 2018 15:51:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yuriy Vostrikov <delamonpansie@gmail.com>
cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: linux acpi (thunderbolt? bug)
In-Reply-To: <alpine.DEB.2.21.1802181901520.1549@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1802191549270.1853@nanos.tec.linutronix.de>
References: <CABbc0=RMYWGN0L=z_Y=FuZJUDzD5NVa2XBTVnmpZxX5tnk3-5g@mail.gmail.com> <alpine.DEB.2.21.1802141306360.1292@nanos.tec.linutronix.de> <alpine.DEB.2.21.1802150948530.1673@nanos.tec.linutronix.de> <CABbc0=QZY8d_Kyd5hX5X99S60ANrncPSk785FpZTAJS+C9_tDQ@mail.gmail.com>
 <alpine.DEB.2.21.1802181901520.1549@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Feb 2018, Thomas Gleixner wrote:
> On Fri, 16 Feb 2018, Yuriy Vostrikov wrote:
> > On 15 February 2018 at 11:52, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > Can you please take snapshots from:
> > >
> > >     /proc/interrupts
> > >     /sys/kernel/debug/irq/*
> > >
> > > right after boot, after the unplug, before suspend and after resume?
> > >
> > 
> > Apparently, timing is important: problem manifests if the laptop goes
> > to sleep shortly after unplug.
> > If there is some delay between unplugging and sleeping, then there is
> > no problem.
> > I'm attaching tar.gz with two runs: run-1 with the problem and run-2
> > without. Dumps include output
> > of dmesg in time of making a snapshot.
> > 
> > Hope this clarifies the situation a bit.
> 
> Yes. I finally wrapped my brain around it and I can reproduce now after
> understanding the root cause. I have no fix yet, but I should have
> something for you to test tomorrow.

The patch below should cure it.

Thanks,

	tglx

8<------------------

Subject: genirq/matrix: Handle CPU offlining proper
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 19 Feb 2018 12:59:34 +0100

Add blurb.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/vector.c |   10 ++++++++++
 kernel/irq/matrix.c           |   23 ++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -134,6 +134,7 @@ static void apic_update_vector(struct ir
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	struct irq_desc *desc = irq_data_to_desc(irqd);
+	bool managed = irqd_affinity_is_managed(irqd);
 
 	lockdep_assert_held(&vector_lock);
 
@@ -146,6 +147,15 @@ static void apic_update_vector(struct ir
 		apicd->prev_vector = apicd->vector;
 		apicd->prev_cpu = apicd->cpu;
 	} else {
+		/*
+		 * Offline case: The current vector needs to be released in
+		 * the matrix allocator.
+		 */
+		if (apicd->vector &&
+		    apicd->vector != MANAGED_IRQ_SHUTDOWN_VECTOR) {
+			irq_matrix_free(vector_matrix, apicd->cpu,
+					apicd->vector, managed);
+		}
 		apicd->prev_vector = 0;
 	}
 
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -16,6 +16,7 @@ struct cpumap {
 	unsigned int		available;
 	unsigned int		allocated;
 	unsigned int		managed;
+	bool			initialized;
 	bool			online;
 	unsigned long		alloc_map[IRQ_MATRIX_SIZE];
 	unsigned long		managed_map[IRQ_MATRIX_SIZE];
@@ -81,9 +82,11 @@ void irq_matrix_online(struct irq_matrix
 
 	BUG_ON(cm->online);
 
-	bitmap_zero(cm->alloc_map, m->matrix_bits);
-	cm->available = m->alloc_size - (cm->managed + m->systembits_inalloc);
-	cm->allocated = 0;
+	if (!cm->initialized) {
+		cm->available = m->alloc_size;
+		cm->available -= cm->managed + m->systembits_inalloc;
+		cm->initialized = true;
+	}
 	m->global_available += cm->available;
 	cm->online = true;
 	m->online_maps++;
@@ -370,14 +373,16 @@ void irq_matrix_free(struct irq_matrix *
 	if (WARN_ON_ONCE(bit < m->alloc_start || bit >= m->alloc_end))
 		return;
 
-	if (cm->online) {
-		clear_bit(bit, cm->alloc_map);
-		cm->allocated--;
+	clear_bit(bit, cm->alloc_map);
+	cm->allocated--;
+
+	if (cm->online)
 		m->total_allocated--;
-		if (!managed) {
-			cm->available++;
+
+	if (!managed) {
+		cm->available++;
+		if (cm->online)
 			m->global_available++;
-		}
 	}
 	trace_irq_matrix_free(bit, cpu, m, cm);
 }
