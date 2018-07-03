Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2469AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A3624871
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A3624871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeGCL71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:59:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752185AbeGCL7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:59:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8472402346D;
        Tue,  3 Jul 2018 11:59:24 +0000 (UTC)
Received: from [10.43.17.120] (unknown [10.43.17.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0C7A2156880;
        Tue,  3 Jul 2018 11:59:21 +0000 (UTC)
Subject: Re: [tip:x86/asm] x86/entry/64: Add two more instruction suffixes
To:     David Laight <David.Laight@ACULAB.COM>,
        "jbeulich@suse.com" <jbeulich@suse.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
References: <5B3A02DD02000078001CFB78@prv1-mh.provo.novell.com>
 <tip-6709812f094d96543b443645c68daaa32d3d3e77@git.kernel.org>
 <dd366701851f48e4897ebe0f62f0fd94@AcuMS.aculab.com>
From:   Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <68107758-8018-d8d5-dcfd-270bb64113eb@redhat.com>
Date:   Tue, 3 Jul 2018 13:59:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <dd366701851f48e4897ebe0f62f0fd94@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 03 Jul 2018 11:59:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 03 Jul 2018 11:59:24 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dvlasenk@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 10:46 AM, David Laight wrote:
> From: Jan Beulich
>> Sent: 03 July 2018 09:36
> ...
>> As said there, omitting suffixes from instructions in AT&T mode is bad
>> practice when operand size cannot be determined by the assembler from
>> register operands, and is likely going to be warned about by upstream
>> gas in the future (mine does already).
> ...
>> -	bt	$9, EFLAGS(%rsp)		/* interrupts off? */
>> +	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
> 
> Hmmm....
> Does the operand size make any difference at all for the bit instructions?
> I'm pretty sure that the cpus (386 onwards) have always done aligned 32bit
> transfers (the docs never actually said aligned).
> I can't remember whether 64bit mode allows immediates above 31.

Immediates up to 63 are allowed in 64 bit mode (IOW: for REX-prefixed form)
(run-tested).

Keep in mind that this instruction is "special" with register bit offset:

Register/memory form (BT REG,[MEM]) does not limit or mask the value of bit offset
in REG, the instruction uses bit REG%8 in byte at address [MEM+REG/8].

This works correctly even for negative values: REG = -1 will access
the most significant bit in the byte immediately before MEM.

Thus, for accesses of standard RAM locations (not memory-mapped IO and such),
the "operand size" concept for this instruction (and BTC, BTR, BTS)
does not make much sense: it accesses one bit. The width of actual memory
access is irrelevant.

I'd say assembler should just use the "natural" width for current mode
(16 or 32-bit), and warn when code tries to use immediate operand which
will be truncated and thus needs a wider operand size.

Intel documentation says that immediate operand in BT IMM,[MEM]
is truncated to operand size. My experiment seems to confirm it:

254:1  <- BT 254,[MEM] actually accesses bit #30, not #254
255:0
254:0
255:0

#include <string.h>
#include <stdio.h>
int main(int argc, char **argv, char **envp)
{
         char buf[256];
         int result;

         memset(buf, 0x55, sizeof(buf)); /* bit pattern: 01010101 */

         buf[255/8] = 0;
         asm("\n"
         "       bt      %1, %2\n"
         "       sbb     %0, %0\n"
         : "=r" (result)
         : "i" (254), "m" (buf)
         );
         printf("254:%x\n", !!result);
         asm("\n"
         "       bt      %1, %2\n"
         "       sbb     %0, %0\n"
         : "=r" (result)
         : "i" (255), "m" (buf)
         );
         printf("255:%x\n", !!result);
         buf[255/8] = 0x55;

         buf[31/8] = 0;
         asm("\n"
         "       bt      %1, %2\n"
         "       sbb     %0, %0\n"
         : "=r" (result)
         : "i" (254), "m" (buf)
         );
         printf("254:%x\n", !!result);
         asm("\n"
         "       bt      %1, %2\n"
         "       sbb     %0, %0\n"
         : "=r" (result)
         : "i" (255), "m" (buf)
         );
         printf("255:%x\n", !!result);

         return 0;
}

When I use "r" instead of "i" to generate REG,[MEM] form,
the instruction does access bit #254:

254:0
255:0
254:1
255:0

