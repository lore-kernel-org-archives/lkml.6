Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98CAC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1F620C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1F620C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeGLJk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:40:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbeGLJk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:40:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF3C1401EF26;
        Thu, 12 Jul 2018 09:31:43 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82DE7111AF0E;
        Thu, 12 Jul 2018 09:31:42 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, ldv@altlinux.org,
        yamato@redhat.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/kvm/vmx: don't read current->thread.{fs,gs}base of legacy tasks
References: <20180711173718.8850-1-vkuznets@redhat.com>
        <CANRm+CxKWuuzyu4Yi-phUR3RpVb0bx_=r3FoJvZMm1ii-8-wKw@mail.gmail.com>
Date:   Thu, 12 Jul 2018 11:31:41 +0200
In-Reply-To: <CANRm+CxKWuuzyu4Yi-phUR3RpVb0bx_=r3FoJvZMm1ii-8-wKw@mail.gmail.com>
        (Wanpeng Li's message of "Thu, 12 Jul 2018 09:39:09 +0800")
Message-ID: <877em0ztoi.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 12 Jul 2018 09:31:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 12 Jul 2018 09:31:44 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> On Thu, 12 Jul 2018 at 08:07, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> When we switched from doing rdmsr() to reading FS/GS base values from
>> current->thread we completely forgot about legacy 32-bit userspaces which
>> we still support in KVM (why?). task->thread.{fsbase,gsbase} are only
>> synced for 64-bit processes, calling save_fsgs_for_kvm() and using
>> its result from current is illegal for legacy processes.
>>
>> There's no ARCH_SET_FS/GS prctls for legacy applications. Base MSRs are,
>> however, not always equal to zero. Intel's manual says (3.4.4 Segment
>> Loading Instructions in IA-32e Mode):
>>
>> "In order to set up compatibility mode for an application, segment-load
>> instructions (MOV to Sreg, POP Sreg) work normally in 64-bit mode. An
>> entry is read from the system descriptor table (GDT or LDT) and is loaded
>> in the hidden portion of the segment register.
>> ...
>> The hidden descriptor register fields for FS.base and GS.base are
>> physically mapped to MSRs in order to load all address bits supported by
>> a 64-bit implementation.
>> "
>>
>> The issue was found by strace test suite where 32-bit ioctl_kvm_run test
>> started segfaulting.
>
> Test suite: MSR switch
> PASS: VM entry MSR load
> PASS: VM exit MSR store
> PASS: VM exit MSR load
> FAIL: VM entry MSR load: try to load FS_BASE
> SUMMARY: 4 tests, 1 unexpected failures
>
> kvm-unit-tests fails w/ and w/o the patch, maybe it is another issue,
> i didn't dig further, you can have a look if you are interested in. :)

The patch only changes the behavior for legacy userspaces and I can
reproduce the failure on native x86_64, it is something different. I'm,
however, interested so stay tuned :-)

-- 
  Vitaly
