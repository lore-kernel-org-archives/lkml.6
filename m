Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26755ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF6020846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF6020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbeGWFuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:50:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:52494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727765AbeGWFuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:50:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 686ACAE9F;
        Mon, 23 Jul 2018 04:50:40 +0000 (UTC)
Date:   Sun, 22 Jul 2018 21:50:35 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2] xen/spinlock: Don't use pvqspinlock if only 1 vCPU
Message-ID: <20180723045035.h6jfsfdmgx55ljot@linux-r8p5>
References: <1532036397-19449-1-git-send-email-longman@redhat.com>
 <20180719215456.5ho3udhfoqlkh75a@linux-r8p5>
 <00e98205-606a-a121-36c2-dedaeae1d0bb@redhat.com>
 <CANRm+CyHfvBKVKNk+pKF+s6+1seZ8c+NyjHuepT2Mf+4Cdd-2w@mail.gmail.com>
 <20180723044257.m7pjrnp7jjqggqij@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180723044257.m7pjrnp7jjqggqij@linux-r8p5>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jul 2018, Davidlohr Bueso wrote:

>On Mon, 23 Jul 2018, Wanpeng Li wrote:
>
>>On Fri, 20 Jul 2018 at 06:03, Waiman Long <longman@redhat.com> wrote:
>>>
>>>On 07/19/2018 05:54 PM, Davidlohr Bueso wrote:
>>>> On Thu, 19 Jul 2018, Waiman Long wrote:
>>>>
>>>>> On a VM with only 1 vCPU, the locking fast paths will always be
>>>>> successful. In this case, there is no need to use the the PV qspinlock
>>>>> code which has higher overhead on the unlock side than the native
>>>>> qspinlock code.
>>>>>
>>>>> The xen_pvspin veriable is also turned off in this 1 vCPU case to
>
>s/veriable
> variable
>
>>>>> eliminate unneeded pvqspinlock initialization in xen_init_lock_cpu()
>>>>> which is run after xen_init_spinlocks().
>>>>
>>>> Wouldn't kvm also want this?
>>>>
>>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>>> index a37bda38d205..95aceb692010 100644
>>>> --- a/arch/x86/kernel/kvm.c
>>>> +++ b/arch/x86/kernel/kvm.c
>>>> @@ -457,7 +457,8 @@ static void __init sev_map_percpu_data(void)
>>>> static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
>>>> {
>>>>     native_smp_prepare_cpus(max_cpus);
>>>> -    if (kvm_para_has_hint(KVM_HINTS_REALTIME))
>>>> +    if (num_possible_cpus() == 1 ||
>>>> +        kvm_para_has_hint(KVM_HINTS_REALTIME))
>>>>         static_branch_disable(&virt_spin_lock_key);
>>>> }
>>>
>>>That doesn't really matter as the slowpath will never get executed in
>>>the 1 vCPU case.
>
>How does this differ then from xen, then? I mean, same principle applies.
>
>>
>>So this is not needed in kvm tree?
>>https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=queue&id=3a792199004ec335346cc607d62600a399a7ee02
>
>Hmm I would think that my patch would be more appropiate as it actually does
>what the comment says.

Both would be needed actually yes, but also disabling the virt_spin_lock_key
would be more robust imo.

Thanks,
Davidlohr
