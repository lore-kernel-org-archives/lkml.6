Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeFDLRy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:17:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39200 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeFDLRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:17:53 -0400
Date: Mon, 4 Jun 2018 13:17:48 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
cc: Song Liu <songliubraving@fb.com>, Song Liu <liu.song.a23@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
In-Reply-To: <e4237c07-f00a-1820-d36a-7dbee4ea0297@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1806041316020.2646@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com> <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de> <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com> <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com> <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de> <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com> <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
 <09A22A95-6BBD-48EB-A2FE-42BF6244F751@fb.com> <alpine.DEB.2.21.1805282206440.1584@nanos.tec.linutronix.de> <e4237c07-f00a-1820-d36a-7dbee4ea0297@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2018, Dou Liyang wrote:
> Here, why didn't we avoid this cleanup by
> 
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index a75de0792942..0cc59646755f 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -821,6 +821,9 @@ static void free_moved_vector(struct apic_chip_data
> *apicd)
>          */
>         WARN_ON_ONCE(managed);
> 
> +       if (!vector)
> +               return;
> +
>         trace_vector_free_moved(apicd->irq, cpu, vector, managed);
>         irq_matrix_free(vector_matrix, cpu, vector, managed);
>         per_cpu(vector_irq, cpu)[vector] = VECTOR_UNUSED;
> 
> Is there something I didn't consider with? ;-)

Well, that just prevents the warning, but the hlist is already
corrupted. So you'd just cure the symptom ...

I'm about to send a patch series which addresses that. Just need to finish
writing changelogs.

Thanks,

	tglx
