Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeFDH5R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:57:17 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32617 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751520AbeFDH4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:56:45 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40711444"
Subject: Re: WARNING and PANIC in irq_matrix_free
To: Thomas Gleixner <tglx@linutronix.de>, Song Liu <songliubraving@fb.com>
CC: Song Liu <liu.song.a23@gmail.com>, Tariq Toukan <tariqt@mellanox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, Kernel Team <Kernel-team@fb.com>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
 <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
 <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
 <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com>
 <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de>
 <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com>
 <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
 <09A22A95-6BBD-48EB-A2FE-42BF6244F751@fb.com>
 <alpine.DEB.2.21.1805282206440.1584@nanos.tec.linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <e4237c07-f00a-1820-d36a-7dbee4ea0297@cn.fujitsu.com>
Date: Mon, 4 Jun 2018 15:56:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805282206440.1584@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 1F8494D0EFFC.AC768
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Sorry to ask the questions at this series, my mailbox was kicked out of
the mailing list a few days ago, and didn't receive the e-mail.

please see below

At 05/29/2018 04:09 AM, Thomas Gleixner wrote:
> On Mon, 28 May 2018, Song Liu wrote:
>> This doesn't fix the issue with bnxt. Here is a trace with this patch:

[...]
> 
> Thanks for providing the data!
> 
>  >  19d... 1610359248us : vector_deactivate: irq=31 is_managed=0 
> can_reserve=1 reserve=0
>  >  19d... 1610359248us : vector_clear: irq=31 vector=33 cpu=20 
> prev_vector=0 prev_cpu=2
>  >  19d... 1610359249us : irq_matrix_free: bit=33 cpu=20 online=1 
> avl=201 alloc=0 managed=0 online_maps=56 global_avl=11241, 
> global_rsvd=25, total_alloc=15
> 
> Here IRQ 31 is shutdown and the vector freed.
> 
>  >  19d... 1610359249us : irq_matrix_reserve: online_maps=56 
> global_avl=11241, global_rsvd=26, total_alloc=15
>  >  19d... 1610359249us : vector_reserve: irq=31 ret=0
>  >  19d... 1610359249us : vector_config: irq=31 vector=239 cpu=0 
> apicdest=0x00000000
> 
> And set to the magic reservation vector 239 to catch spurious interrupts.
> 
>  >  20dN.. 1610366654us : vector_activate: irq=31 is_managed=0 
> can_reserve=1 reserve=0
>  >  20dN.. 1610366654us : vector_alloc: irq=31 vector=4294967268 
> reserved=1 ret=0
>  >  20dN.. 1610366655us : irq_matrix_alloc: bit=33 cpu=9 online=1 
> avl=200 alloc=1 managed=0 online_maps=56 global_avl=11240, 
> global_rsvd=28, total_alloc=16
>  >  20dN.. 1610366655us : vector_update: irq=31 vector=33 cpu=9 
> prev_vector=0 prev_cpu=20
   ^^^^^^^^^^^^
    this means there is no associated previous vector.

>  >  20dN.. 1610366656us : vector_alloc: irq=31 vector=33 reserved=1 ret=0
>  >  20dN.. 1610366656us : vector_config: irq=31 vector=33 cpu=9 
> apicdest=0x00000014
> 
> So here it gets initialized again and targets CPU9 now.
> 
>  >  20dN.. 1610366662us : irq_matrix_alloc: bit=33 cpu=20 online=1 
> avl=200 alloc=1 managed=0 online_maps=56 global_avl=11240, 
> global_rsvd=28, total_alloc=16
>  >  20dN.. 1610366662us : vector_update: irq=31 vector=33 cpu=20 
> prev_vector=33 prev_cpu=9
>  >  20dN.. 1610366662us : vector_alloc: irq=31 vector=33 reserved=1 ret=0
>  >  20dN.. 1610366662us : vector_config: irq=31 vector=33 cpu=20 
> apicdest=0x0000002c
> 
> Here it is reconfigured to CPU 20. Now that update schedules vector 33 on
> CPU9 for cleanup.
> 
>  >  20dN.. 1610366666us : irq_matrix_alloc: bit=34 cpu=2 online=1 
> avl=199 alloc=2 managed=0 online_maps=56 global_avl=11239, 
> global_rsvd=28, total_alloc=17
>  >  20dN.. 1610366666us : vector_update: irq=31 vector=34 cpu=2 
> prev_vector=33 prev_cpu=20
>  >  20dN.. 1610366666us : vector_alloc: irq=31 vector=34 reserved=1 ret=0
>  >  20dN.. 1610366666us : vector_config: irq=31 vector=34 cpu=2 
> apicdest=0x00000004
> 
> So here the shit hits the fan because that update schedules vector 33 on
> CPU20 for cleanup while the previous cleanup for CPU9 has not been done
> yet. Cute. or not so cute....
> 
>  >  20dNh. 1610366669us : vector_free_moved: irq=31 cpu=20 vector=33 
> is_managed=0
>  >  20dNh. 1610366670us : irq_matrix_free: bit=33 cpu=20 online=1 
> avl=201 alloc=0 managed=0 online_maps=56 global_avl=11240, 
> global_rsvd=28, total_alloc=16
> 
> And frees the CPU 20 vector
> 
>  >   9d.h. 1610366696us : vector_free_moved: irq=31 cpu=20 vector=0 
> is_managed=0
> 

Here, why didn't we avoid this cleanup by

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index a75de0792942..0cc59646755f 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -821,6 +821,9 @@ static void free_moved_vector(struct apic_chip_data 
*apicd)
          */
         WARN_ON_ONCE(managed);

+       if (!vector)
+               return;
+
         trace_vector_free_moved(apicd->irq, cpu, vector, managed);
         irq_matrix_free(vector_matrix, cpu, vector, managed);
         per_cpu(vector_irq, cpu)[vector] = VECTOR_UNUSED;

Is there something I didn't consider with? ;-)

Thanks,
	dou.

> And then CPU9 claims that it's queued for cleanup. Bah.
> 
> I'm still working on a fix as the elegant solution refused to work.
> 
> Thanks,
> 
>      tglx
