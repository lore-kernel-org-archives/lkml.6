Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFD8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAD7206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAD7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbeGSWr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:47:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbeGSWr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:47:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 136DB4070497;
        Thu, 19 Jul 2018 22:02:23 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA2092026D6B;
        Thu, 19 Jul 2018 22:02:22 +0000 (UTC)
Subject: Re: [PATCH v2] xen/spinlock: Don't use pvqspinlock if only 1 vCPU
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <1532036397-19449-1-git-send-email-longman@redhat.com>
 <20180719215456.5ho3udhfoqlkh75a@linux-r8p5>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <00e98205-606a-a121-36c2-dedaeae1d0bb@redhat.com>
Date:   Thu, 19 Jul 2018 18:02:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180719215456.5ho3udhfoqlkh75a@linux-r8p5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 19 Jul 2018 22:02:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 19 Jul 2018 22:02:23 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 05:54 PM, Davidlohr Bueso wrote:
> On Thu, 19 Jul 2018, Waiman Long wrote:
>
>> On a VM with only 1 vCPU, the locking fast paths will always be
>> successful. In this case, there is no need to use the the PV qspinlock
>> code which has higher overhead on the unlock side than the native
>> qspinlock code.
>>
>> The xen_pvspin veriable is also turned off in this 1 vCPU case to
>> eliminate unneeded pvqspinlock initialization in xen_init_lock_cpu()
>> which is run after xen_init_spinlocks().
>
> Wouldn't kvm also want this?
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index a37bda38d205..95aceb692010 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -457,7 +457,8 @@ static void __init sev_map_percpu_data(void)
> static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
> {
>     native_smp_prepare_cpus(max_cpus);
> -    if (kvm_para_has_hint(KVM_HINTS_REALTIME))
> +    if (num_possible_cpus() == 1 ||
> +        kvm_para_has_hint(KVM_HINTS_REALTIME))
>         static_branch_disable(&virt_spin_lock_key);
> }

That doesn't really matter as the slowpath will never get executed in
the 1 vCPU case.

-Longman

