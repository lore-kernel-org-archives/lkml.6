Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522EDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1885E20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="E1tt++88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1885E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=eikelenboom.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeKJBKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:10:20 -0500
Received: from server.eikelenboom.it ([91.121.65.215]:57358 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeKJBKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:10:19 -0500
X-Greylist: delayed 1621 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2018 20:10:18 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gdrpT8Blps2lYTcCcnjOd/aLBxI+Er/zE12ocCDhAx0=; b=E1tt++88X4euXltR5gyZKA894m
        oXnrdQTXB4iuQljcwr9rhRYOd8QFyeI+AJdz/w8CbiFITxOCC2GFW6I0JIoy0siS9L+yp7tvn1rBZ
        0d/p5SRR6evR9ZgiDOdWwlqXhcmz079ES8LERDOdreZzC8Jm7iXBXm0hS6KOI1vX1XL0=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:44956 helo=[172.16.1.49])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1gL8iI-0002qL-Nn; Fri, 09 Nov 2018 16:28:50 +0100
Subject: Re: [Xen-devel] [PATCH] xen: fix xen_qlock_wait()
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        stable@vger.kernel.org
References: <20181109120413.9539-1-jgross@suse.com>
 <400409f5-397e-780b-d13b-19a1ee578f44@eikelenboom.it>
 <068f9560-598b-0228-463b-bc7f202cf8e0@suse.com>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <913d7f22-9ec2-54be-3edb-a93a6adf4fda@eikelenboom.it>
Date:   Fri, 9 Nov 2018 16:29:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <068f9560-598b-0228-463b-bc7f202cf8e0@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/18 16:20, Juergen Gross wrote:
> On 09/11/2018 16:02, Sander Eikelenboom wrote:
>> On 09/11/18 13:04, Juergen Gross wrote:
>>> Commit a856531951dc80 ("xen: make xen_qlock_wait() nestable")
>>> introduced a regression for Xen guests running fully virtualized
>>> (HVM or PVH mode). The Xen hypervisor wouldn't return from the poll
>>> hypercall with interrupts disabled in case of an interrupt (for PV
>>> guests it does).
>>>
>>> So instead of disabling interrupts in xen_qlock_wait() use a nesting
>>> counter to avoid calling xen_clear_irq_pending() in case
>>> xen_qlock_wait() is nested.
>>>
>>> Fixes: a856531951dc80 ("xen: make xen_qlock_wait() nestable")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>
>> Although you don't seem too interested, you can stick on a:
>> Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
>> if you like.
> 
> I am interested.
> 
> OTOH I wanted to post the patch officially to give others the chance to
> send remarks.

OK, would be nice to at least be CC'ed on patches going upstream when
you have been reporting stuff.

--
Sander


> 
> Juergen
> 
>>
>> --
>> Sander
>>
>>> ---
>>>  arch/x86/xen/spinlock.c | 14 ++++++++------
>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
>>> index 441c88262169..1c8a8816a402 100644
>>> --- a/arch/x86/xen/spinlock.c
>>> +++ b/arch/x86/xen/spinlock.c
>>> @@ -9,6 +9,7 @@
>>>  #include <linux/log2.h>
>>>  #include <linux/gfp.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/atomic.h>
>>>  
>>>  #include <asm/paravirt.h>
>>>  #include <asm/qspinlock.h>
>>> @@ -21,6 +22,7 @@
>>>  
>>>  static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
>>>  static DEFINE_PER_CPU(char *, irq_name);
>>> +static DEFINE_PER_CPU(atomic_t, xen_qlock_wait_nest);
>>>  static bool xen_pvspin = true;
>>>  
>>>  static void xen_qlock_kick(int cpu)
>>> @@ -39,25 +41,25 @@ static void xen_qlock_kick(int cpu)
>>>   */
>>>  static void xen_qlock_wait(u8 *byte, u8 val)
>>>  {
>>> -	unsigned long flags;
>>>  	int irq = __this_cpu_read(lock_kicker_irq);
>>> +	atomic_t *nest_cnt = this_cpu_ptr(&xen_qlock_wait_nest);
>>>  
>>>  	/* If kicker interrupts not initialized yet, just spin */
>>>  	if (irq == -1 || in_nmi())
>>>  		return;
>>>  
>>> -	/* Guard against reentry. */
>>> -	local_irq_save(flags);
>>> +	/* Detect reentry. */
>>> +	atomic_inc(nest_cnt);
>>>  
>>> -	/* If irq pending already clear it. */
>>> -	if (xen_test_irq_pending(irq)) {
>>> +	/* If irq pending already and no nested call clear it. */
>>> +	if (atomic_read(nest_cnt) == 1 && xen_test_irq_pending(irq)) {
>>>  		xen_clear_irq_pending(irq);
>>>  	} else if (READ_ONCE(*byte) == val) {
>>>  		/* Block until irq becomes pending (or a spurious wakeup) */
>>>  		xen_poll_irq(irq);
>>>  	}
>>>  
>>> -	local_irq_restore(flags);
>>> +	atomic_dec(nest_cnt);
>>>  }
>>>  
>>>  static irqreturn_t dummy_handler(int irq, void *dev_id)
>>>
>>
>>
> 

