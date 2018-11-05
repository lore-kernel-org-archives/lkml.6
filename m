Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32318C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01272085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01272085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbeKFBrd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:47:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729670AbeKFBrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:47:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C84F31256D7;
        Mon,  5 Nov 2018 16:27:06 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9A7F19748;
        Mon,  5 Nov 2018 16:27:04 +0000 (UTC)
Subject: Re: [RFC PATCH] x86/mm/fault: Allow stack access below %rsp
To:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <1541187610-5322-1-git-send-email-longman@redhat.com>
 <a3584dd1-c030-cebe-3f3d-eadc0744580a@intel.com>
 <fb715262-df9e-3e77-6964-80ec4a1c7a24@redhat.com>
 <47b1c477-46a7-6b04-7537-378e2910611b@intel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f68d35e6-d103-562f-449a-dacedc6e1d04@redhat.com>
Date:   Mon, 5 Nov 2018 11:27:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <47b1c477-46a7-6b04-7537-378e2910611b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 05 Nov 2018 16:27:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2018 06:28 PM, Dave Hansen wrote:
> On 11/2/18 12:50 PM, Waiman Long wrote:
>> On 11/02/2018 03:44 PM, Dave Hansen wrote:
>>> On 11/2/18 12:40 PM, Waiman Long wrote:
>>>> The 64k+ limit check is kind of arbitrary. So the check is now removed
>>>> to just let expand_stack() decide if a segmentation fault should happen.
>>> With the 64k check removed, what's the next limit that we bump into?  Is
>>> it just the stack_guard_gap space above the next-lowest VMA?
>> I think it is both the stack_guard_gap space above the next lowest VMA
>> and the rlimit(RLIMIT_STACK).
> The gap seems to be hundreds of megabytes, typically where RLIMIT_STACK
> is 8MB by default, so RLIMIT_STACK is likely to be the practical limit
> that will be hit.  So, practically, we've taken a ~64k area that we
> would on-demand extend the stack into in one go, and turned that into a
> the full ~8MB area that you could have expanded into anyway, but all at
> once.
>
> That doesn't seem too insane, especially since we don't physically back
> the 8MB or anything.  Logically, it also seems like you *should* be able
> to touch any bit of the stack within the rlimit.
>
> But, on the other hand, as our comments say: "Accessing the stack below
> %sp is always a bug."  Have we been unsuccessful in convincing our gcc
> buddies of this?

With gcc 4.4.7, the object code for the sample program in the commit log
are:

  0x00000000004004c4 <+0>:    push   %rbp
   0x00000000004004c5 <+1>:    mov    %rsp,%rbp
   0x00000000004004c8 <+4>:    push   %rbx
   0x00000000004004c9 <+5>:    sub    $0x18,%rsp
   0x00000000004004cd <+9>:    lea    -0x2ff8(%rsp),%rax
   0x00000000004004d5 <+17>:    movq   $0x0,(%rax)
   0x00000000004004dc <+24>:    mov    %rsp,%rax
   0x00000000004004df <+27>:    mov    %rax,%rbx
   0x00000000004004e2 <+30>:    lea    -0x3ff8(%rsp),%rax
   0x00000000004004ea <+38>:    lea    -0x43008(%rsp),%rdx
   0x00000000004004f2 <+46>:    jmp    0x400501 <main+61>
   0x00000000004004f4 <+48>:    movq   $0x0,(%rax)
   0x00000000004004fb <+55>:    sub    $0x1000,%rax
   0x0000000000400501 <+61>:    cmp    %rdx,%rax
   0x0000000000400504 <+64>:    ja     0x4004f4 <main+48>
   0x0000000000400506 <+66>:    movq   $0x0,(%rdx)
   0x000000000040050d <+73>:    sub    $0x40010,%rsp
   0x0000000000400514 <+80>:    mov    %rsp,%rax
   0x0000000000400517 <+83>:    add    $0xf,%rax
   0x000000000040051b <+87>:    shr    $0x4,%rax
   0x000000000040051f <+91>:    shl    $0x4,%rax
   0x0000000000400523 <+95>:    mov    %rax,-0x18(%rbp)
   0x0000000000400527 <+99>:    mov    $0x400638,%edi
   0x000000000040052c <+104>:    callq  0x4003b8 <puts@plt>
   0x0000000000400531 <+109>:    mov    $0x0,%eax
   0x0000000000400536 <+114>:    mov    %rbx,%rsp
   0x0000000000400539 <+117>:    mov    -0x8(%rbp),%rbx
   0x000000000040053d <+121>:    leaveq
   0x000000000040053e <+122>:    retq  

With a newer gcc 4.8.5, the object code becomes

   0x000000000040052d <+0>:    push   %rbp
   0x000000000040052e <+1>:    mov    %rsp,%rbp
   0x0000000000400531 <+4>:    lea    -0x1020(%rsp),%rsp
   0x0000000000400539 <+12>:    mov    $0xfffffffffffc0000,%r11
   0x0000000000400540 <+19>:    lea    (%rsp,%r11,1),%r11
   0x0000000000400544 <+23>:    cmp    %r11,%rsp
   0x0000000000400547 <+26>:    je     0x400557 <main+42>
   0x0000000000400549 <+28>:    sub    $0x1000,%rsp
   0x0000000000400550 <+35>:    orq    $0x0,(%rsp)
   0x0000000000400555 <+40>:    jmp    0x400544 <main+23>
   0x0000000000400557 <+42>:    lea    0x1020(%rsp),%rsp
   0x000000000040055f <+50>:    mov    $0x400600,%edi
   0x0000000000400564 <+55>:    callq  0x400410 <puts@plt>
   0x0000000000400569 <+60>:    mov    $0x0,%eax
   0x000000000040056e <+65>:    leaveq
   0x000000000040056f <+66>:    retq   

So gcc had changed to avoid doing that, but my main concern are old
binaries that were compiled with old gcc.

Cheers,
Longman



