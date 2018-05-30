Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932468AbeE3V4R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:56:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932310AbeE3V4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:56:15 -0400
Date: Wed, 30 May 2018 23:56:09 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Song Liu <songliubraving@fb.com>
cc: Song Liu <liu.song.a23@gmail.com>, Tariq Toukan <tariqt@mellanox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
In-Reply-To: <7954157A-E523-4041-825B-828A3A38E51B@fb.com>
Message-ID: <alpine.DEB.2.21.1805301257480.4350@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com> <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de> <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com> <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com> <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de> <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com> <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
 <09A22A95-6BBD-48EB-A2FE-42BF6244F751@fb.com> <alpine.DEB.2.21.1805282206440.1584@nanos.tec.linutronix.de> <3F47F523-64C5-422B-B9B0-73B8D105CF71@fb.com> <alpine.DEB.2.21.1805291031480.1685@nanos.tec.linutronix.de>
 <7954157A-E523-4041-825B-828A3A38E51B@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song,

On Tue, 29 May 2018, Song Liu wrote:
> > On May 29, 2018, at 1:35 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Maybe we cannot enable all trace points under irq_vectors/ and irq_matrix.
> > 
> > Right. Sorry, I forgot to say that we only need the irq_vectors ones which
> > are related to vector allocation, i.e.: irq_vectors/vector_*
>
> Here is the ftrace dump:

Thanks for providing the data!

>  19d... 1610359248us : vector_deactivate: irq=31 is_managed=0 can_reserve=1 reserve=0
>  19d... 1610359248us : vector_clear: irq=31 vector=33 cpu=20 prev_vector=0 prev_cpu=2
>  19d... 1610359249us : irq_matrix_free: bit=33 cpu=20 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11241, global_rsvd=25, total_alloc=15

Here IRQ 31 is shutdown and the vector freed.

>  19d... 1610359249us : irq_matrix_reserve: online_maps=56 global_avl=11241, global_rsvd=26, total_alloc=15
>  19d... 1610359249us : vector_reserve: irq=31 ret=0
>  19d... 1610359249us : vector_config: irq=31 vector=239 cpu=0 apicdest=0x00000000

And set to the magic reservation vector 239 to catch spurious interrupts.

>  20dN.. 1610366654us : vector_activate: irq=31 is_managed=0 can_reserve=1 reserve=0
>  20dN.. 1610366654us : vector_alloc: irq=31 vector=4294967268 reserved=1 ret=0
>  20dN.. 1610366655us : irq_matrix_alloc: bit=33 cpu=9 online=1 avl=200 alloc=1 managed=0 online_maps=56 global_avl=11240, global_rsvd=28, total_alloc=16
>  20dN.. 1610366655us : vector_update: irq=31 vector=33 cpu=9 prev_vector=0 prev_cpu=20
>  20dN.. 1610366656us : vector_alloc: irq=31 vector=33 reserved=1 ret=0
>  20dN.. 1610366656us : vector_config: irq=31 vector=33 cpu=9 apicdest=0x00000014

So here it gets initialized again and targets CPU9 now.

>  20dN.. 1610366662us : irq_matrix_alloc: bit=33 cpu=20 online=1 avl=200 alloc=1 managed=0 online_maps=56 global_avl=11240, global_rsvd=28, total_alloc=16
>  20dN.. 1610366662us : vector_update: irq=31 vector=33 cpu=20 prev_vector=33 prev_cpu=9
>  20dN.. 1610366662us : vector_alloc: irq=31 vector=33 reserved=1 ret=0
>  20dN.. 1610366662us : vector_config: irq=31 vector=33 cpu=20 apicdest=0x0000002c

Here it is reconfigured to CPU 20. Now that update schedules vector 33 on
CPU9 for cleanup.

>  20dN.. 1610366666us : irq_matrix_alloc: bit=34 cpu=2 online=1 avl=199 alloc=2 managed=0 online_maps=56 global_avl=11239, global_rsvd=28, total_alloc=17
>  20dN.. 1610366666us : vector_update: irq=31 vector=34 cpu=2 prev_vector=33 prev_cpu=20
>  20dN.. 1610366666us : vector_alloc: irq=31 vector=34 reserved=1 ret=0
>  20dN.. 1610366666us : vector_config: irq=31 vector=34 cpu=2 apicdest=0x00000004

So here the shit hits the fan because that update schedules vector 33 on
CPU20 for cleanup while the previous cleanup for CPU9 has not been done
yet. Cute. or not so cute....

>  20dNh. 1610366669us : vector_free_moved: irq=31 cpu=20 vector=33 is_managed=0
>  20dNh. 1610366670us : irq_matrix_free: bit=33 cpu=20 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11240, global_rsvd=28, total_alloc=16

And frees the CPU 20 vector

>   9d.h. 1610366696us : vector_free_moved: irq=31 cpu=20 vector=0 is_managed=0

And then CPU9 claims that it's queued for cleanup. Bah.

I'm still working on a fix as the elegant solution refused to work.

Thanks,

	tglx
