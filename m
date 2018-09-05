Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16FCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555DC2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JplN6/HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555DC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeIEKPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:15:23 -0400
Received: from m12-14.163.com ([220.181.12.14]:55469 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbeIEKPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=+G/6g
        aR2O8MJaBPRYUEBCCyUv0XxIMvwTKgxgdi9abo=; b=JplN6/HVMPyHbYCFcZkxd
        duTTvaOir6u1LZK0CfXJOT51AzkrpDTErRQIFBWCH0SDsPLG/s8FbaLJIvU3hh0q
        pbQVBYehGCv3cfxxsxFdXMTSE9NMRi4eI4YC0slTJvU3Jvnb8RyAHLCkNdZKn51j
        1M15Y8kCNfI6VBskUI9ozw=
Received: from localhost.localdomain (unknown [49.65.59.196])
        by smtp10 (Coremail) with SMTP id DsCowABnptWpbY9bPrdaPw--.56241S2;
        Wed, 05 Sep 2018 13:46:17 +0800 (CST)
Subject: Re: Affinity managed interrupts vs non-managed interrupts
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p>
 <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com>
 <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
 <486f94a563d63c4779498fe8829a546c@mail.gmail.com>
 <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
 <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com>
 <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
 <66256272c020be186becdd7a3f049302@mail.gmail.com>
 <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de>
 <dd1c5df55aa99cf4a37bcc58e77e840a@mail.gmail.com>
From:   Dou Liyang <dou_liyang@163.com>
Message-ID: <f436fa6a-b865-fadb-4f77-44309ff84405@163.com>
Date:   Wed, 5 Sep 2018 13:46:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <dd1c5df55aa99cf4a37bcc58e77e840a@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DsCowABnptWpbY9bPrdaPw--.56241S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF45XF1fZFyUArW7KF43trb_yoWrury8pF
        Z3Jr17uFWDJ3Wqgw17AayDAFZIy3s7Ar13t3s5u3sa9ryftr1IgF1qqFykZFyUArWrCayU
        CrZ0qryrZa4UJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bUgArUUUUU=
X-Originating-IP: [49.65.59.196]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbiLgm4olSIcI41IQAAsL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Kashyap,

At 09/04/2018 06:29 PM, Kashyap Desai wrote:
>>> I am using " for-4.19/block " and this particular patch "a0c9259
>>> irq/matrix: Spread interrupts on allocation" is included.
>>

IMO, this patch is just used for non-managed interrupts.

>> So if all 16 have their effective affinity set to CPU0 then that's
> strange

But, all these 16 are managed interrupts, and will be assigned vectors
by assign_managed_vector():
{
     cpumask_and(vector_searchmask, vector_searchmask, affmsk);
     cpu = cpumask_first(vector_searchmask);

     ...
     vector = irq_matrix_alloc_managed(vector_matrix, cpu);
     ...
}

Where we always used the *first* cpu in the vector_searchmask(0-71), not
the suitable one. So I guess this situation happened.

Shall we also spread the managed interrupts on allocation?

Thanks,
     dou
-----------------8<----------------------------------------

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 9f148e3d45b4..57dc05691f44 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -314,13 +314,12 @@ assign_managed_vector(struct irq_data *irqd, const 
struct cpumask *dest)
         int vector, cpu;

         cpumask_and(vector_searchmask, vector_searchmask, affmsk);
-       cpu = cpumask_first(vector_searchmask);
-       if (cpu >= nr_cpu_ids)
-               return -EINVAL;
+
         /* set_affinity might call here for nothing */
         if (apicd->vector && cpumask_test_cpu(apicd->cpu, 
vector_searchmask))
                 return 0;
-       vector = irq_matrix_alloc_managed(vector_matrix, cpu);
+
+       vector = irq_matrix_alloc_managed(vector_matrix, 
vector_searchmask, &cpu);
         trace_vector_alloc_managed(irqd->irq, vector, vector);
         if (vector < 0)
                 return vector;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 201de12a9957..36fdeff5043a 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1151,7 +1151,8 @@ void irq_matrix_offline(struct irq_matrix *m);
  void irq_matrix_assign_system(struct irq_matrix *m, unsigned int bit, 
bool replace);
  int irq_matrix_reserve_managed(struct irq_matrix *m, const struct 
cpumask *msk);
  void irq_matrix_remove_managed(struct irq_matrix *m, const struct 
cpumask *msk);
-int irq_matrix_alloc_managed(struct irq_matrix *m, unsigned int cpu);
+int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask 
*msk,
+                                       unsigned int *mapped_cpu);
  void irq_matrix_reserve(struct irq_matrix *m);
  void irq_matrix_remove_reserved(struct irq_matrix *m);
  int irq_matrix_alloc(struct irq_matrix *m, const struct cpumask *msk,
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 5092494bf261..d9e4e0a385fa 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -239,21 +239,40 @@ void irq_matrix_remove_managed(struct irq_matrix 
*m, const struct cpumask *msk)
   * @m:         Matrix pointer
   * @cpu:       On which CPU the interrupt should be allocated
   */
-int irq_matrix_alloc_managed(struct irq_matrix *m, unsigned int cpu)
+int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask 
*msk,
+                                       unsigned int *mapped_cpu)
  {
-       struct cpumap *cm = per_cpu_ptr(m->maps, cpu);
-       unsigned int bit, end = m->alloc_end;
-
-       /* Get managed bit which are not allocated */
-       bitmap_andnot(m->scratch_map, cm->managed_map, cm->alloc_map, end);
-       bit = find_first_bit(m->scratch_map, end);
-       if (bit >= end)
-               return -ENOSPC;
-       set_bit(bit, cm->alloc_map);
-       cm->allocated++;
-       m->total_allocated++;
-       trace_irq_matrix_alloc_managed(bit, cpu, m, cm);
-       return bit;
+       unsigned int cpu, best_cpu, maxavl = 0;
+       unsigned int bit, end;
+       struct cpumap *cm;
+
+       best_cpu = UINT_MAX;
+       for_each_cpu(cpu, msk) {
+               cm = per_cpu_ptr(m->maps, cpu);
+
+               if (!cm->online || cm->available <= maxavl)
+                       continue;
+
+               best_cpu = cpu;
+               maxavl = cm->available;
+       }
+
+       if (maxavl) {
+               cm = per_cpu_ptr(m->maps, best_cpu);
+               end = m->alloc_end;
+               /* Get managed bit which are not allocated */
+               bitmap_andnot(m->scratch_map, cm->managed_map, 
cm->alloc_map, end);
+               bit = find_first_bit(m->scratch_map, end);
+               if (bit >= end)
+                       return -ENOSPC;
+               set_bit(bit, cm->alloc_map);
+               cm->allocated++;
+               m->total_allocated++;
+               *mapped_cpu = best_cpu;
+               trace_irq_matrix_alloc_managed(bit, cpu, m, cm);
+               return bit;
+       }
+       return -ENOSPC;
  }

  /**

