Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDE8ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81502150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IoEOgIuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81502150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeJQXHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:07:50 -0400
Received: from mail.efficios.com ([167.114.142.138]:57802 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQXHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:07:49 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1EC0A1CA6B4;
        Wed, 17 Oct 2018 11:11:41 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 3t3An6xl9U90; Wed, 17 Oct 2018 11:11:40 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8E4CF1CA6AD;
        Wed, 17 Oct 2018 11:11:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8E4CF1CA6AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539789100;
        bh=pOsEDiQXaRkGMm76xjqtw5SniO690HLscXPdPt3k9L8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IoEOgIufWUIe0IYeoGBWoWN1oYlKlsfMTxhrs1qXRKLCcu1nbPMrt7kbFw8+pHrlY
         R56HLITNW/l3MJCDRDCs5qngBfkswSvKKJ3pMGp/s2tYKxaaaXj7ITdKxrhsYY97ZB
         q1ToqfinlxHNumfzhBRQDgU4UVnVNxYm5otmgOVTr1Kjc6OMb6t73hH7MFwMAVpWPb
         bTtiSM1nwuojshUz/i3qTNdwUIwVwoZKodZqGQizVHGQiJirUehRaTckMnDcGPX4l3
         P7qCqS7NZf/2ZlEYAzeG72Ral1ATaeyn5f7jWwcsr1oFQNDaD29+TG2VDPF9dZdYww
         a/ymbrLOlJWnQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id m0gjQxnKcsKy; Wed, 17 Oct 2018 11:11:40 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 6E04D1CA6A6;
        Wed, 17 Oct 2018 11:11:40 -0400 (EDT)
Date:   Wed, 17 Oct 2018 11:11:40 -0400 (EDT)
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
Message-ID: <1006597066.825.1539789100381.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181017071931.GA18379@linux.vnet.ibm.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com> <20181010191936.7495-7-mathieu.desnoyers@efficios.com> <20181017071931.GA18379@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH for 4.21 06/16] cpu_opv: Provide cpu_opv system call
 (v8)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v8)
Thread-Index: 7qW2lzGCTO+IxFmqU0Kf5LalV47JZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 17, 2018, at 3:19 AM, Srikar Dronamraju srikar@linux.vnet.ibm.com wrote:

> Hi Mathieu,
> 
>> +static int do_cpu_opv(struct cpu_op *cpuop, int cpuopcnt,
>> +		      struct cpu_opv_vaddr *vaddr_ptrs, int cpu)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	int ret;
>> +
>> +retry:
>> +	if (cpu != raw_smp_processor_id()) {
>> +		ret = push_task_to_cpu(current, cpu);
>> +		if (ret)
>> +			goto check_online;
>> +	}
>> +	down_read(&mm->mmap_sem);
>> +	ret = vaddr_ptrs_check(vaddr_ptrs);
>> +	if (ret)
>> +		goto end;
>> +	preempt_disable();
>> +	if (cpu != smp_processor_id()) {
>> +		preempt_enable();
>> +		up_read(&mm->mmap_sem);
>> +		goto retry;
>> +	}
> 
> If we have a higher priority task/s either pinned to the cpu, dont we end up
> in busy-looping till the task exits/sleeps?

You're right!

How about we ditch the thread migration altogether, and simply perform
the cpu_opv operations in a IPI handler ?

This is possible now that cpu_opv uses a temporary vmap() rather than
try to touch the user-space page through the current thread's page table.

Thoughts ?

Thanks,

Mathieu

> 
>> +	ret = __do_cpu_opv(cpuop, cpuopcnt);
>> +	preempt_enable();
>> +end:
>> +	up_read(&mm->mmap_sem);
>> +	return ret;
>> +
>> +check_online:
>> +	/*
>> +	 * push_task_to_cpu() returns -EINVAL if the requested cpu is not part
>> +	 * of the current thread's cpus_allowed mask.
>> +	 */
>> +	if (ret == -EINVAL)
>> +		return ret;
>> +	get_online_cpus();
>> +	if (cpu_online(cpu)) {
>> +		put_online_cpus();
>> +		goto retry;
> > +	}

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
