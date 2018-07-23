Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDAFECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0428120856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0428120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbeGWOfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:35:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387831AbeGWOfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:35:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAE9C814F0A3;
        Mon, 23 Jul 2018 13:33:52 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1CB62166BA0;
        Mon, 23 Jul 2018 13:33:51 +0000 (UTC)
Subject: Re: [PATCH v2] xen/spinlock: Don't use pvqspinlock if only 1 vCPU
To:     Wanpeng Li <kernellwp@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <1532036397-19449-1-git-send-email-longman@redhat.com>
 <20180719215456.5ho3udhfoqlkh75a@linux-r8p5>
 <00e98205-606a-a121-36c2-dedaeae1d0bb@redhat.com>
 <CANRm+CyHfvBKVKNk+pKF+s6+1seZ8c+NyjHuepT2Mf+4Cdd-2w@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <29f7dd77-267a-0ba7-f4e8-6ef3b3de167c@redhat.com>
Date:   Mon, 23 Jul 2018 09:33:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CyHfvBKVKNk+pKF+s6+1seZ8c+NyjHuepT2Mf+4Cdd-2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 23 Jul 2018 13:33:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 23 Jul 2018 13:33:53 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22/2018 11:31 PM, Wanpeng Li wrote:
> On Fri, 20 Jul 2018 at 06:03, Waiman Long <longman@redhat.com> wrote:
>> On 07/19/2018 05:54 PM, Davidlohr Bueso wrote:
>>> On Thu, 19 Jul 2018, Waiman Long wrote:
>>>
>>>> On a VM with only 1 vCPU, the locking fast paths will always be
>>>> successful. In this case, there is no need to use the the PV qspinlock
>>>> code which has higher overhead on the unlock side than the native
>>>> qspinlock code.
>>>>
>>>> The xen_pvspin veriable is also turned off in this 1 vCPU case to
>>>> eliminate unneeded pvqspinlock initialization in xen_init_lock_cpu()
>>>> which is run after xen_init_spinlocks().
>>> Wouldn't kvm also want this?
>>>
>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>> index a37bda38d205..95aceb692010 100644
>>> --- a/arch/x86/kernel/kvm.c
>>> +++ b/arch/x86/kernel/kvm.c
>>> @@ -457,7 +457,8 @@ static void __init sev_map_percpu_data(void)
>>> static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
>>> {
>>>     native_smp_prepare_cpus(max_cpus);
>>> -    if (kvm_para_has_hint(KVM_HINTS_REALTIME))
>>> +    if (num_possible_cpus() == 1 ||
>>> +        kvm_para_has_hint(KVM_HINTS_REALTIME))
>>>         static_branch_disable(&virt_spin_lock_key);
>>> }
>> That doesn't really matter as the slowpath will never get executed in
>> the 1 vCPU case.
> So this is not needed in kvm tree?
> https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=queue&id=3a792199004ec335346cc607d62600a399a7ee02
>
> Regards,
> Wanpeng Li

With only 1 vCPU, the slowpath will not be executed. It will be a
deadlock if it happens. So we don't need to explicitly disable the
static key here.

-Longman

