Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeBVVim (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:38:42 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39923 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeBVVil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:38:41 -0500
Date: Thu, 22 Feb 2018 22:38:49 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Tariq Toukan <tariqt@mellanox.com>
cc: linux-kernel@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
In-Reply-To: <1e79eaa9-202d-b48c-4463-ae195a4fc891@mellanox.com>
Message-ID: <alpine.DEB.2.21.1802222227440.1612@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com> <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de> <alpine.DEB.2.21.1802201917200.24268@nanos.tec.linutronix.de> <1e79eaa9-202d-b48c-4463-ae195a4fc891@mellanox.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018, Tariq Toukan wrote:
> On 20/02/2018 8:18 PM, Thomas Gleixner wrote:
> > On Tue, 20 Feb 2018, Thomas Gleixner wrote:
> > > On Tue, 20 Feb 2018, Tariq Toukan wrote:
> > > 
> > > Is there CPU hotplugging in play?
> 
> No.

Ok.

> > > 
> > > I'll come back to you tomorrow with a plan how to debug that after staring
> > > into the code some more.
> > 
> > Do you have a rough idea what the test case is doing?
> > 
> 
> It arbitrary appears in different flows, like sending traffic or interface
> configuration changes.

Hmm. Looks like memory corruption, but I can't pin point it.

Find below a debug patch which should prevent the crash and might give us
some insight into the type of corruption.

Please enable the irq_matrix and vector allocation trace points. 

echo 1 >/sys/kernel/debug/tracing/events/irq_matrix/enable
echo 1 >/sys/kernel/debug/tracing/events/irq_vectors/vector*/enable

When the problem triggers the bogus vector is printed and the trace is
frozen. Please provide dmesg and the tracebuffer output.

Thanks,

	tglx

8<--------------
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -822,6 +822,12 @@ static void free_moved_vector(struct api
 	unsigned int cpu = apicd->prev_cpu;
 	bool managed = apicd->is_managed;
 
+	if (vector < FIRST_EXTERNAL_VECTOR || vector >= FIRST_SYSTEM_VECTOR) {
+		tracing_off();
+		pr_err("Trying to clear prev_vector: %u\n", vector);
+		goto out;
+	}
+
 	/*
 	 * This should never happen. Managed interrupts are not
 	 * migrated except on CPU down, which does not involve the
@@ -833,6 +839,7 @@ static void free_moved_vector(struct api
 	trace_vector_free_moved(apicd->irq, cpu, vector, managed);
 	irq_matrix_free(vector_matrix, cpu, vector, managed);
 	per_cpu(vector_irq, cpu)[vector] = VECTOR_UNUSED;
+out:
 	hlist_del_init(&apicd->clist);
 	apicd->prev_vector = 0;
 	apicd->move_in_progress = 0;
