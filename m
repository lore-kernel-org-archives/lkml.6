Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 03E8DC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9F2208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9F2208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755008AbeFNKeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:34:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754990AbeFNKd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:33:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFB8E818F703;
        Thu, 14 Jun 2018 10:33:57 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (ovpn-204-185.brq.redhat.com [10.40.204.185])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C6061C5B8;
        Thu, 14 Jun 2018 10:33:54 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "hpa\@zytor.com" <hpa@zytor.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [RFC Patch 3/3] KVM/x86: Add tlb_remote_flush callback support for vmcs
References: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
        <20180604090749.489-4-Tianyu.Lan@microsoft.com>
        <87h8m8qbso.fsf@vitty.brq.redhat.com>
        <f868a339-03fc-4ba6-4882-4bb6232f599d@microsoft.com>
Date:   Thu, 14 Jun 2018 12:33:53 +0200
In-Reply-To: <f868a339-03fc-4ba6-4882-4bb6232f599d@microsoft.com> (Tianyu
        Lan's message of "Thu, 14 Jun 2018 10:13:46 +0000")
Message-ID: <87d0wtpsha.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 14 Jun 2018 10:33:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 14 Jun 2018 10:33:57 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <Tianyu.Lan@microsoft.com> writes:

> On 6/12/2018 11:12 PM, Vitaly Kuznetsov wrote:
>> Tianyu Lan <Tianyu.Lan@microsoft.com> writes:
>> 
>>>
>>> +static int vmx_remote_flush_tlb(struct kvm *kvm)
>>> +{
>>> +	struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, 0);
>>> +
>>> +	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
>>> +		return -1;
>> 
>> Why vcpu0? Can arch.mmu.root_hpa-s differ across vCPUs? What happens if
>> they do?
>
> Yes, it may take place that arch.mmu.root_hpa is differ across vCPUs.
> We may check all vcpu root_hpa and use the hypercall when there is only 
> one validated ept table. If not, go back to current way.
>

I'd suggest an optimization: keep track of wether root_hpas are equal
across all vcpus (check this on change).

-- 
  Vitaly
