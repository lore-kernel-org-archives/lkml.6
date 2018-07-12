Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ADCC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBAF20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBAF20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeGLLcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:32:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbeGLLcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:32:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07F3981663FF;
        Thu, 12 Jul 2018 11:23:12 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9020116874;
        Thu, 12 Jul 2018 11:23:10 +0000 (UTC)
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
        <877em0ztoi.fsf@vitty.brq.redhat.com>
Date:   Thu, 12 Jul 2018 13:23:09 +0200
In-Reply-To: <877em0ztoi.fsf@vitty.brq.redhat.com> (Vitaly Kuznetsov's message
        of "Thu, 12 Jul 2018 11:31:41 +0200")
Message-ID: <87h8l4y9ya.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 12 Jul 2018 11:23:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 12 Jul 2018 11:23:12 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Wanpeng Li <kernellwp@gmail.com> writes:
>
>> Test suite: MSR switch
>> PASS: VM entry MSR load
>> PASS: VM exit MSR store
>> PASS: VM exit MSR load
>> FAIL: VM entry MSR load: try to load FS_BASE
>> SUMMARY: 4 tests, 1 unexpected failures
>>
>> kvm-unit-tests fails w/ and w/o the patch, maybe it is another issue,
>> i didn't dig further, you can have a look if you are interested in. :)
>
> The patch only changes the behavior for legacy userspaces and I can
> reproduce the failure on native x86_64, it is something different. I'm,
> however, interested so stay tuned :-)

Yes,

the regression was introduced by 

commit e79f245ddec17bbd89d73cd0169dba4be46c9b55
Author: KarimAllah Ahmed <karahmed@amazon.de>
Date:   Sat Apr 14 05:10:52 2018 +0200

    X86/KVM: Properly update 'tsc_offset' to represent the running guest

basically, when nested_vmx_load_msr() fails we don't set
exit_qualification accordingly.

The fix is simple:

@@ -11720,8 +11721,10 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
        msr_entry_idx = nested_vmx_load_msr(vcpu,
                                            vmcs12->vm_entry_msr_load_addr,
                                            vmcs12->vm_entry_msr_load_count);
-       if (msr_entry_idx)
+       if (msr_entry_idx) {
+               exit_qual = msr_entry_idx;
                goto fail;
+       }
 
        /*
         * Note no nested_vmx_succeed or nested_vmx_fail here. At this point

I'll be sending a patch out shortly. But this is completely orthogonal
to the 'legacy' issue ;-)

-- 
  Vitaly
