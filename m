Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeBSR0c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:26:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59845 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753152AbeBSR0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:26:31 -0500
Date: Mon, 19 Feb 2018 18:26:41 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Randy Dunlap <rdunlap@infradead.org>
cc: Yuriy Vostrikov <delamonpansie@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: linux acpi (thunderbolt? bug)
In-Reply-To: <bfee0c69-ce31-f699-7e9b-7c28fc640596@infradead.org>
Message-ID: <alpine.DEB.2.21.1802191823570.1853@nanos.tec.linutronix.de>
References: <CABbc0=RMYWGN0L=z_Y=FuZJUDzD5NVa2XBTVnmpZxX5tnk3-5g@mail.gmail.com> <alpine.DEB.2.21.1802141306360.1292@nanos.tec.linutronix.de> <alpine.DEB.2.21.1802150948530.1673@nanos.tec.linutronix.de> <CABbc0=QZY8d_Kyd5hX5X99S60ANrncPSk785FpZTAJS+C9_tDQ@mail.gmail.com>
 <alpine.DEB.2.21.1802181901520.1549@nanos.tec.linutronix.de> <alpine.DEB.2.21.1802191549270.1853@nanos.tec.linutronix.de> <bfee0c69-ce31-f699-7e9b-7c28fc640596@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2018, Randy Dunlap wrote:

> On 02/19/18 06:51, Thomas Gleixner wrote:
> >  	} else {
> > +		/*
> > +		 * Offline case: The current vector needs to be released in
> > +		 * the matrix allocator.
> > +		 */
> > +		if (apicd->vector &&
> 
> Drop the "apicd->vector &&" ? (redundant)

No. The else path is entered when

    apicd->vector == 0

or

    apicd->cpu is offline

So we need to check here for vector != 0 as otherwise we'd free vector 0
which is invalid. I'll add a comment explaining the mess.

> > +		    apicd->vector != MANAGED_IRQ_SHUTDOWN_VECTOR) {
> > +			irq_matrix_free(vector_matrix, apicd->cpu,
> > +					apicd->vector, managed);
> > +		}
> >  		apicd->prev_vector = 0;
> >  	}

Thanks,

	tglx
