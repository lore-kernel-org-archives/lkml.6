Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E07C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A8D2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uqU8kyKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A8D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJQDJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:09:33 -0400
Received: from mail.efficios.com ([167.114.142.138]:46848 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeJQDJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:09:33 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 21E251C12ED;
        Tue, 16 Oct 2018 15:17:39 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id UT-JoZxXY-AE; Tue, 16 Oct 2018 15:17:38 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 601B81C12E5;
        Tue, 16 Oct 2018 15:17:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 601B81C12E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539717458;
        bh=zjxmfsGc4CKn/xFgwTqUPhXaJI8Odei5l4VSEwnLrrE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=uqU8kyKFC2mZFFxE/j6bCOF/ZyMUuryt6T6qBNm8o5NWJB/D3mn3+1nU1MJiXI+0v
         XfIjRca8Rgvs79LR55VQbMjN36zQ8vSbU2JFZ2Vwwmb4MYJUdn8AeRJkgatiIdkkfa
         ao1FaHL8tmBac77qdLGt72MmQ/zoR0Ybw5GGvCv+tThvs5P8eTOHhsG8AuaBl6ZvYv
         NEn/IFT58xlyZRlU1RcHtXbw7MOCBUZd8d/S5/fXr7QCfysJZXlkrq58/G9i2SVhLd
         qpFxVRmBEUFfm8YlKetTLgmK/wuYYEQxtM5iSKQIE6qKGucUJZFzElJO6kAnzDyGWW
         x/4KZSiB9P7rQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id B0Brpi0KFSJO; Tue, 16 Oct 2018 15:17:38 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3AA8F1C12DC;
        Tue, 16 Oct 2018 15:17:38 -0400 (EDT)
Date:   Tue, 16 Oct 2018 15:17:37 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
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
Message-ID: <1984292897.263.1539717457933.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181016081029.GA30363@jagdpanzerIV>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com> <20181010191936.7495-7-mathieu.desnoyers@efficios.com> <20181016081029.GA30363@jagdpanzerIV>
Subject: Re: [RFC PATCH for 4.21 06/16] cpu_opv: Provide cpu_opv system call
 (v8)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v8)
Thread-Index: vm8UPrPInsgaIqXZLf/bG4IscOuaSA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 16, 2018, at 4:10 AM, Sergey Senozhatsky sergey.senozhatsky.work@gmail.com wrote:

> Hi Mathieu,
> 
> On (10/10/18 15:19), Mathieu Desnoyers wrote:
> [..]
>> +SYSCALL_DEFINE4(cpu_opv, struct cpu_op __user *, ucpuopv, int, cpuopcnt,
>> +		int, cpu, int, flags)
>> +{
> [..]
>> +again:
>> +	ret = cpu_opv_pin_pages(cpuopv, cpuopcnt, &vaddr_ptrs);
>> +	if (ret)
>> +		goto end;
>> +	ret = do_cpu_opv(cpuopv, cpuopcnt, &vaddr_ptrs, cpu);
>> +	if (ret == -EAGAIN)
>> +		retry = true;
>> +end:
>> +	for (i = 0; i < vaddr_ptrs.nr_vaddr; i++) {
>> +		struct vaddr *vaddr = &vaddr_ptrs.addr[i];
>> +		int j;
>> +
>> +		vm_unmap_user_ram((void *)vaddr->mem, vaddr->nr_pages);
> 
> A dumb question.
> 
> Both vm_unmap_user_ram() and vm_map_user_ram() can BUG_ON().
> So this is
>   userspace -> syscall -> cpu_opv() -> vm_unmap_user_ram() -> BUG_ON()
> 
> Any chance someone can exploit it?

Hi Sergey,

Let's look at vm_unmap_user_ram() and vm_map_user_ram() separately.

If we look at the input from vm_unmap_user_ram, it's called with the
following parameters by the cpu_opv system call:

        for (i = 0; i < vaddr_ptrs.nr_vaddr; i++) {
                struct vaddr *vaddr = &vaddr_ptrs.addr[i];
                int j;

                vm_unmap_user_ram((void *)vaddr->mem, vaddr->nr_pages);
[...]
        }

The vaddr_ptrs array content is filled by the call to cpu_opv_pin_pages above:

        ret = cpu_opv_pin_pages(cpuopv, cpuopcnt, &vaddr_ptrs);
        if (ret)
                goto end;

by passing the array to cpu_op_pin_pages(), which appends a virtual address at
the end of the array (on success) and increments nr_vaddr. Those virtual
addresses are returned by vm_map_user_ram(), so they are not user-controlled.

Therefore, only an internal kernel bug between vm_map_user_ram() and
vm_unmap_user_ram() should trigger the BUG_ON(). No user input is passed
to vm_unmap_user_ram().

Now, let's look at vm_map_user_ram(). It calls alloc_vmap_area(), which returns
a vmap_area. Then if vmap_page_range failed, vm_unmap_user_ram is called on the
memory that has just been returned by vm_map_user_ram. Again, only an internal
bug between map/unmap can trigger the BUG_ON() in vm_unmap_user_ram.

Is there another scenario I missed ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
