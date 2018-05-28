Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164193AbeE1Kxt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:53:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37435 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163924AbeE1Kxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:44 -0400
Date: Mon, 28 May 2018 12:53:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Song Liu <liu.song.a23@gmail.com>
cc: Tariq Toukan <tariqt@mellanox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, kernel-team@fb.com
Subject: Re: WARNING and PANIC in irq_matrix_free
In-Reply-To: <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com> <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de> <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com> <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com> <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de> <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018, Song Liu wrote:
> On Wed, May 23, 2018 at 1:49 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Wed, 23 May 2018, Tariq Toukan wrote:
> >> I have your patch merged into my internal branch, it prints the following:
> >>
> >> [ 4898.226258] Trying to clear prev_vector: 0
> >> [ 4898.226439] Trying to clear prev_vector: 0
> >>
> >> i.e. vector(0) is lower than FIRST_EXTERNAL_VECTOR.
> >
> > Could you please enable the vector and irq matrix trace points and capture
> > the trace when this happens?

Does the patch below fix it?

Thanks,

	tglx

8<-------------------
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bb6f7a2148d7..54af3d4884b1 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -148,6 +148,7 @@ static void apic_update_vector(struct irq_data *irqd, unsigned int newvec,
 	 * prev_vector for this and the offlined target case.
 	 */
 	apicd->prev_vector = 0;
+	apicd->move_in_progress = false;
 	if (!apicd->vector || apicd->vector == MANAGED_IRQ_SHUTDOWN_VECTOR)
 		goto setnew;
 	/*
