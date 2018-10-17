Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EED6ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AE52150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LvVlR9dU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AE52150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJRAGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:06:18 -0400
Received: from mail.efficios.com ([167.114.142.138]:40054 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJRAGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:06:17 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 99DFE1CA347;
        Wed, 17 Oct 2018 12:09:52 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ZtcUV8Ta0-2R; Wed, 17 Oct 2018 12:09:51 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A73571CA342;
        Wed, 17 Oct 2018 12:09:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A73571CA342
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539792591;
        bh=+hSbHJElIoBvQsPheS1n2fcIab9kSXagJgoTv1cg+YM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LvVlR9dUx2z7xDVC5ABFz+AKJYTu7rRPtsLXGUaxhrmzQV8vrKYwqpwHwx+4q29Bf
         9a2ISAtwDx4K0mRZxD923NM4FeVBaSVfB3zfsuUDg66u2PSL4kF7kwkFh6iOeM49K9
         vvtoospkPmtT1LwHw7vXaZgjmGbn3kIYtdUdPNrpkJIYmWvpNTtkjsYtgsYWVwfYiP
         2poJILi/xpWcCMCV4cepq3kQh77jy6VDrG+WIDuIoxkiySjZ8icJhgYwdRBVl/2hJS
         Zuqi60L7y9t7Ix6+818iSOlku+A7WnujW1a69mlENYcrUBlHo0ayUwjBI7uodR505X
         qF4RgIBoX8WSw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id a1E9s6x8ny8B; Wed, 17 Oct 2018 12:09:51 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 82BC71CA338;
        Wed, 17 Oct 2018 12:09:51 -0400 (EDT)
Date:   Wed, 17 Oct 2018 12:09:51 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <1102241735.877.1539792591430.JavaMail.zimbra@efficios.com>
In-Reply-To: <1006597066.825.1539789100381.JavaMail.zimbra@efficios.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com> <20181010191936.7495-7-mathieu.desnoyers@efficios.com> <20181017071931.GA18379@linux.vnet.ibm.com> <1006597066.825.1539789100381.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH for 4.21 06/16] cpu_opv: Provide cpu_opv system call
 (v8)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v8)
Thread-Index: 7qW2lzGCTO+IxFmqU0Kf5LalV47JZf1Yo2DH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 17, 2018, at 11:11 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Oct 17, 2018, at 3:19 AM, Srikar Dronamraju srikar@linux.vnet.ibm.com
> wrote:
> 
>> Hi Mathieu,
>> 
>>> +static int do_cpu_opv(struct cpu_op *cpuop, int cpuopcnt,
>>> +		      struct cpu_opv_vaddr *vaddr_ptrs, int cpu)
>>> +{
>>> +	struct mm_struct *mm = current->mm;
>>> +	int ret;
>>> +
>>> +retry:
>>> +	if (cpu != raw_smp_processor_id()) {
>>> +		ret = push_task_to_cpu(current, cpu);
>>> +		if (ret)
>>> +			goto check_online;
>>> +	}
>>> +	down_read(&mm->mmap_sem);
>>> +	ret = vaddr_ptrs_check(vaddr_ptrs);
>>> +	if (ret)
>>> +		goto end;
>>> +	preempt_disable();
>>> +	if (cpu != smp_processor_id()) {
>>> +		preempt_enable();
>>> +		up_read(&mm->mmap_sem);
>>> +		goto retry;
>>> +	}
>> 
>> If we have a higher priority task/s either pinned to the cpu, dont we end up
>> in busy-looping till the task exits/sleeps?
> 
> You're right!
> 
> How about we ditch the thread migration altogether, and simply perform
> the cpu_opv operations in a IPI handler ?
> 
> This is possible now that cpu_opv uses a temporary vmap() rather than
> try to touch the user-space page through the current thread's page table.
> 
> Thoughts ?

Here is the associated implementation on top of this patchset:

commit 759c5a8860d867091e168900329f0955e5101989
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Oct 17 11:32:02 2018 -0400

    cpu opv: use ipi

diff --git a/kernel/cpu_opv.c b/kernel/cpu_opv.c
index db144b71d51a..30405e0cc049 100644
--- a/kernel/cpu_opv.c
+++ b/kernel/cpu_opv.c
@@ -31,6 +31,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/atomic.h>
+#include <linux/smp.h>
 #include <asm/ptrace.h>
 #include <asm/byteorder.h>
 #include <asm/cacheflush.h>
@@ -1039,41 +1040,48 @@ static int vaddr_ptrs_check(struct cpu_opv_vaddr *vaddr_ptrs)
        return 0;
 }

+struct opv_ipi_args {
+       struct cpu_op *cpuop;
+       int cpuopcnt;
+       int ret;
+};
+
+static void cpu_opv_ipi(void *info)
+{
+       struct opv_ipi_args *args = info;
+
+       rseq_preempt(current);
+       args->ret = __do_cpu_opv(args->cpuop, args->cpuopcnt);
+}
+
 static int do_cpu_opv(struct cpu_op *cpuop, int cpuopcnt,
                      struct cpu_opv_vaddr *vaddr_ptrs, int cpu)
 {
        struct mm_struct *mm = current->mm;
+       struct opv_ipi_args args = {
+               .cpuop = cpuop,
+               .cpuopcnt = cpuopcnt,
+       };
        int ret;

 retry:
-       if (cpu != raw_smp_processor_id()) {
-               ret = push_task_to_cpu(current, cpu);
-               if (ret)
-                       goto check_online;
-       }
+       if (!cpumask_test_cpu(cpu, &current->cpus_allowed))
+               return -EINVAL;
        down_read(&mm->mmap_sem);
        ret = vaddr_ptrs_check(vaddr_ptrs);
        if (ret)
                goto end;
-       preempt_disable();
-       if (cpu != smp_processor_id()) {
-               preempt_enable();
+       ret = smp_call_function_single(cpu, cpu_opv_ipi, &args, 1);
+       if (ret) {
                up_read(&mm->mmap_sem);
-               goto retry;
+               goto check_online;
        }
-       ret = __do_cpu_opv(cpuop, cpuopcnt);
-       preempt_enable();
+       ret = args.ret;
 end:
        up_read(&mm->mmap_sem);
        return ret;

 check_online:
-       /*
-        * push_task_to_cpu() returns -EINVAL if the requested cpu is not part
-        * of the current thread's cpus_allowed mask.
-        */
-       if (ret == -EINVAL)
-               return ret;
        get_online_cpus();
        if (cpu_online(cpu)) {
                put_online_cpus();




-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
