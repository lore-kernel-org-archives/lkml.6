Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1DAECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D45208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D45208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbeGMR02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:26:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729622AbeGMR02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:26:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FA5C7DAC8;
        Fri, 13 Jul 2018 17:10:57 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D6A61C67B;
        Fri, 13 Jul 2018 17:10:55 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Masatake YAMATO <yamato@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kvm/vmx: don't read current->thread.{fs,gs}base of legacy tasks
References: <20180711173718.8850-1-vkuznets@redhat.com>
        <20180713164650.GA14830@linux.intel.com>
Date:   Fri, 13 Jul 2018 19:10:54 +0200
In-Reply-To: <20180713164650.GA14830@linux.intel.com> (Sean Christopherson's
        message of "Fri, 13 Jul 2018 09:46:50 -0700")
Message-ID: <87lgafvz6p.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 17:10:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 17:10:57 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Wed, Jul 11, 2018 at 07:37:18PM +0200, Vitaly Kuznetsov wrote:
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
>> 
>> Reported-by: Dmitry V. Levin <ldv@altlinux.org>
>> Bisected-by: Masatake YAMATO <yamato@redhat.com>
>> Fixes: 42b933b59721 ("x86/kvm/vmx: read MSR_{FS,KERNEL_GS}_BASE from current->thread")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx.c | 25 +++++++++++++++++--------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 559a12b6184d..65968649b365 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -2560,6 +2560,7 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
>>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>>  #ifdef CONFIG_X86_64
>>  	int cpu = raw_smp_processor_id();
>> +	unsigned long fsbase, kernel_gsbase;
>
> Because bikeshedding is fun, what do you think about using fs_base and
> kernel_gs_base for these names?  I have a series that touches this
> code and also adds local variables for {FS,GS}.base and {FS,GS}.sel.
> I used {fs,gs}_base and {fs,gs}_sel to be consistent with the
> vmx->host_state nomenclature (the local variables are used to update
> the associated vmx->host_state variables), but I'll change my patches
> if you have a strong preference for omitting the underscore.
>

I have nothing against underscores :-)

Hope this small change can be done by Paolo/Radim upon commit. Or I'll
send v2 if needed.

-- 
  Vitaly
