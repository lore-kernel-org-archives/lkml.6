Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D1ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7062150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OyGFHMOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7062150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJQXAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:00:09 -0400
Received: from mail.efficios.com ([167.114.142.138]:51402 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeJQXAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:00:09 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5961B1CA457;
        Wed, 17 Oct 2018 11:04:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id NAY17FcCkkrQ; Wed, 17 Oct 2018 11:04:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id ED3171CA44E;
        Wed, 17 Oct 2018 11:04:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ED3171CA44E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539788642;
        bh=e1OfzSagmyTggYyC443r01uIr2r6Qk2p35af4+oG0I8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=OyGFHMOXQsi927GlUVWIqCE4XccOv5DjGOMFK5RZN/xeRc80ahKM7VYf5gvtsLlQt
         lbK5YkvzbIB6owCKg9BUydaBCz36vtbCC3MVs8y3L8bEHm3yUvtSwCVx3e3SkhLniN
         Xh85sd7vL9h7u4gcqF9y98T2Z/0B3GNPPz7QUpJpBk5d9LTvnOMXKy2gHt6VS+q2SX
         T/uoLYHOzGY/iFodbacb53OrLF1+pcNI2XmQ5XuIDJX8CkTesYXY3+anAIbRX/dcJ7
         CFOgJnOJRq2Yra2tkkq+tCADu0+v23+cjzYvA+pVatJCpcqgkc4UWh0PCrVJfxSIwO
         4Pg1X4NPkyHYg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 9gRzMb9a_c4U; Wed, 17 Oct 2018 11:04:01 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C0F411CA445;
        Wed, 17 Oct 2018 11:04:01 -0400 (EDT)
Date:   Wed, 17 Oct 2018 11:04:01 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <2060193272.771.1539788641739.JavaMail.zimbra@efficios.com>
In-Reply-To: <1051015468.759.1539788401096.JavaMail.zimbra@efficios.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com> <20181010191936.7495-5-mathieu.desnoyers@efficios.com> <20181016143016.10da89bd@gandalf.local.home> <20181017002722.GA1068@jagdpanzerIV> <1051015468.759.1539788401096.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH for 4.21 04/16] mm: Introduce vm_map_user_ram,
 vm_unmap_user_ram
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: Introduce vm_map_user_ram, vm_unmap_user_ram
Thread-Index: gPGMSdyLSfgdOsd0mGALLpA4RUrvCVBT8D6q
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 17, 2018, at 11:00 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Oct 16, 2018, at 8:27 PM, Sergey Senozhatsky
> sergey.senozhatsky.work@gmail.com wrote:
> 
>> On (10/16/18 14:30), Steven Rostedt wrote:
>>> > +void vm_unmap_user_ram(const void *mem, unsigned int count)
>>> > +{
>>> > +	unsigned long size = (unsigned long)count << PAGE_SHIFT;
>>> > +	unsigned long addr = (unsigned long)mem;
>>> > +	struct vmap_area *va;
>>> > +
>>> > +	might_sleep();
>>> > +	BUG_ON(!addr);
>>> > +	BUG_ON(addr < VMALLOC_START);
>>> > +	BUG_ON(addr > VMALLOC_END);
>>> > +	BUG_ON(!PAGE_ALIGNED(addr));
>>> > +
>>> > +	debug_check_no_locks_freed(mem, size);
>>> > +	va = find_vmap_area(addr);
>>> > +	BUG_ON(!va);
>>> > +	free_unmap_vmap_area(va);
>>> > +}
>>> > +EXPORT_SYMBOL(vm_unmap_user_ram);
>>> > +
>>> 
>>> Noticing this from Sergey's question in another patch, why are you
>>> using BUG_ON()? That's rather extreme and something we are trying to
>>> avoid adding more of (I still need to remove the BUG_ON()s I've added
>>> over ten years ago). I don't see why all these BUG_ON's can't be turned
>>> into:
>> 
>> +1
>> 
>>> 	if (WARN_ON(x))
>>> 		return;
>> 
>> Given that this somewhat MM-related, I'd may be say VM_WARN_ON().

I notice that VM_WARN_ON() casts the result of WARN_ON() to (void), so it
cannot be used in a if () statement.

VM_WARN_ON() will only warn if CONFIG_DEBUG_VM is set.

Is it really what we want ?

Thanks,

Mathieu


> 
> Good point, will do!
> 
> So I'll do one cleanup patch for vm_unmap_ram(), and I'll modify the new
> vm_unmap_user_ram().
> 
> Thanks,
> 
> Mathieu
> 
>> 
>> 	-ss
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
