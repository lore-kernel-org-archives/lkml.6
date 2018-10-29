Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29453C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD5E20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD5E20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeJ3CZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:25:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43690 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbeJ3CZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:25:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3392880D;
        Mon, 29 Oct 2018 10:35:56 -0700 (PDT)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 204E33F6A8;
        Mon, 29 Oct 2018 10:35:53 -0700 (PDT)
Subject: Re: [PATCH net-next 11/12] net: mvpp2: handle cases where more CPUs
 are available than s/w threads
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
 <20180919092711.22296-12-antoine.tenart@bootlin.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <a3108c92-37b8-996e-01f6-72b7db532570@arm.com>
Date:   Mon, 29 Oct 2018 17:35:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919092711.22296-12-antoine.tenart@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Antoine,

On 19/09/18 10:27, Antoine Tenart wrote:
> The Marvell PPv2 network controller has 9 internal threads. The driver
> works fine when there are less CPUs available than threads. This isn't
> true if more CPUs are available. As this is a valid use case, handle
> this particular case.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  14 +-
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 152 ++++++++++++------
>  2 files changed, 112 insertions(+), 54 deletions(-)

[...]

> @@ -3270,9 +3299,18 @@ static int mvpp2_irqs_init(struct mvpp2_port *port)
>  		if (err)
>  			goto err;
>  
> -		if (qv->type == MVPP2_QUEUE_VECTOR_PRIVATE)
> -			irq_set_affinity_hint(qv->irq,
> -					      cpumask_of(qv->sw_thread_id));
> +		if (qv->type == MVPP2_QUEUE_VECTOR_PRIVATE) {
> +			unsigned long mask = 0;
> +			unsigned int cpu;
> +
> +			for_each_present_cpu(cpu) {
> +				if (mvpp2_cpu_to_thread(port->priv, cpu) ==
> +				    qv->sw_thread_id)
> +					mask |= BIT(cpu);
> +			}
> +
> +			irq_set_affinity_hint(qv->irq, to_cpumask(&mask));
> +		}

Really??? How on Earth are you testing this code?

I'll paper over the implicit limitation to 64 CPUs and the open-coded
version of cpumask_set_cpu(). But the to_cpumask on a local variable
passed to the core IRQ code?

All it takes is to boot the box with a non-trivial distro, and here she 
goes:

[   11.779309] Unable to handle kernel paging request at virtual address ffff00000e8db278
[   11.779310] Mem abort info:
[   11.779311]   ESR = 0x96000007
[   11.779313]   Exception class = DABT (current EL), IL = 32 bits
[   11.779314]   SET = 0, FnV = 0
[   11.779315]   EA = 0, S1PTW = 0
[   11.779316] Data abort info:
[   11.779317]   ISV = 0, ISS = 0x00000007
[   11.779319]   CM = 0, WnR = 0
[   11.779321] swapper pgtable: 4k pages, 48-bit VAs, pgdp = 0000000092e8dfda
[   11.779322] [ffff00000e8db278] pgd=00000000effff803, pud=00000000efffe803, pmd=00000000e6795003, pte=0000000000000000
[   11.779328] Internal error: Oops: 96000007 [#1] PREEMPT SMP
[   11.779329] Modules linked in:
[   11.779334] CPU: 1 PID: 2952 Comm: irqbalance Not tainted 4.19.0-09418-g9f51ae62c84a-dirty #273
[   11.779336] Hardware name: Marvell 8040 MACCHIATOBin (DT)
[   11.779338] pstate: 40000085 (nZcv daIf -PAN -UAO)
[   11.779346] pc : irq_affinity_hint_proc_show+0x64/0xc0
[   11.779349] lr : irq_affinity_hint_proc_show+0x5c/0xc0
[   11.779350] sp : ffff00000e97bc70
[   11.779351] x29: ffff00000e97bc70 x28: 0000aaab12101290 
[   11.779354] x27: ffff8000e6ac6b40 x26: 0000000000000400 
[   11.779356] x25: ffff8000e80dd100 x24: ffff00000e97be60 
[   11.779358] x23: 00000000007000c0 x22: ffff8000e80272a4 
[   11.779360] x21: ffff8000e6ac6b00 x20: ffff8000e8027200 
[   11.779362] x19: ffff0000093596c8 x18: ffff000009371000 
[   11.779364] x17: 0000000000000000 x16: 0000000000000000 
[   11.779366] x15: 00000000fffffff0 x14: ffff0000094c3b62 
[   11.779368] x13: 0000000000000000 x12: ffff0000094c3000 
[   11.779370] x11: ffff000009371000 x10: ffff0000094c31b0 
[   11.779372] x9 : 0000000000000000 x8 : ffff0000094cd77b 
[   11.779374] x7 : 0000000000000000 x6 : 000000001c96d97e 
[   11.779376] x5 : 0000000000000000 x4 : ffff8000eff850b0 
[   11.779378] x3 : ffff8000e80272a4 x2 : ffff00000e8db278 
[   11.779380] x1 : 0000000000000000 x0 : 0000000000000000 
[   11.779383] Process irqbalance (pid: 2952, stack limit = 0x000000002121ca97)
[   11.779385] Call trace:
[   11.779387]  irq_affinity_hint_proc_show+0x64/0xc0
[   11.779391]  seq_read+0x130/0x448
[   11.779394]  proc_reg_read+0x6c/0xa8
[   11.779397]  __vfs_read+0x30/0x148
[   11.779398]  vfs_read+0x8c/0x160
[   11.779400]  ksys_read+0x5c/0xc0
[   11.779401]  __arm64_sys_read+0x18/0x20
[   11.779405]  el0_svc_common+0x84/0xd8
[   11.779407]  el0_svc_handler+0x2c/0x80
[   11.779410]  el0_svc+0x8/0xc
[   11.779412] Code: aa1603e0 942650d4 f9405e82 b4000062 (f9400041) 
[   11.779415] ---[ end trace 8648ea6a05ca014e ]---
[   11.779418] note: irqbalance[2952] exited with preempt_count 1

After that, the box is wedged.

I came up with the following fix, which fixes the issue for me.

Thanks,

	M.

From ca25785bd1a679e72ed77e939b19360bfd0eecea Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Mon, 29 Oct 2018 17:07:25 +0000
Subject: [PATCH] net: mvpp2: Fix affinity hint allocation

The mvpp2 driver has the curious behaviour of passing a stack variable
to irq_set_affinity_hint(), which results in the kernel exploding
the first time anyone accesses this information. News flash: userspace
does, and irqbalance will happily take the machine down. Great stuff.

An easy fix is to track the mask within the queue_vector structure,
and to make sure it has the same lifetime as the interrupt itself.

Fixes: e531f76757eb ("net: mvpp2: handle cases where more CPUs are available than s/w threads")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h     |  1 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c    | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 176c6b56fdcc..398328f10743 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -796,6 +796,7 @@ struct mvpp2_queue_vector {
 	int nrxqs;
 	u32 pending_cause_rx;
 	struct mvpp2_port *port;
+	struct cpumask *mask;
 };
 
 struct mvpp2_port {
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 14f9679c957c..7a37a37e3fb3 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3298,24 +3298,30 @@ static int mvpp2_irqs_init(struct mvpp2_port *port)
 	for (i = 0; i < port->nqvecs; i++) {
 		struct mvpp2_queue_vector *qv = port->qvecs + i;
 
-		if (qv->type == MVPP2_QUEUE_VECTOR_PRIVATE)
+		if (qv->type == MVPP2_QUEUE_VECTOR_PRIVATE) {
+			qv->mask = kzalloc(cpumask_size(), GFP_KERNEL);
+			if (!qv->mask) {
+				err = -ENOMEM;
+				goto err;
+			}
+
 			irq_set_status_flags(qv->irq, IRQ_NO_BALANCING);
+		}
 
 		err = request_irq(qv->irq, mvpp2_isr, 0, port->dev->name, qv);
 		if (err)
 			goto err;
 
 		if (qv->type == MVPP2_QUEUE_VECTOR_PRIVATE) {
-			unsigned long mask = 0;
 			unsigned int cpu;
 
 			for_each_present_cpu(cpu) {
 				if (mvpp2_cpu_to_thread(port->priv, cpu) ==
 				    qv->sw_thread_id)
-					mask |= BIT(cpu);
+					cpumask_set_cpu(cpu, qv->mask);
 			}
 
-			irq_set_affinity_hint(qv->irq, to_cpumask(&mask));
+			irq_set_affinity_hint(qv->irq, qv->mask);
 		}
 	}
 
@@ -3325,6 +3331,8 @@ static int mvpp2_irqs_init(struct mvpp2_port *port)
 		struct mvpp2_queue_vector *qv = port->qvecs + i;
 
 		irq_set_affinity_hint(qv->irq, NULL);
+		kfree(qv->mask);
+		qv->mask = NULL;
 		free_irq(qv->irq, qv);
 	}
 
@@ -3339,6 +3347,8 @@ static void mvpp2_irqs_deinit(struct mvpp2_port *port)
 		struct mvpp2_queue_vector *qv = port->qvecs + i;
 
 		irq_set_affinity_hint(qv->irq, NULL);
+		kfree(qv->mask);
+		qv->mask = NULL;
 		irq_clear_status_flags(qv->irq, IRQ_NO_BALANCING);
 		free_irq(qv->irq, qv);
 	}
-- 
2.19.1


-- 
Jazz is not dead. It just smells funny...
