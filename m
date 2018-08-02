Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA244C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBC9214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBC9214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbeHBPVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:21:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387426AbeHBPVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:21:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CE74402242D;
        Thu,  2 Aug 2018 13:30:17 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 860C9213ED6A;
        Thu,  2 Aug 2018 13:30:16 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>, kvm list <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/kvm/lapic: always disable MMIO interface in x2APIC mode
References: <20180727144448.9606-1-vkuznets@redhat.com>
        <CALMp9eSaiw7wMMhzKZQpM141h6zEz=shu5P++BerbQBTVyFdYA@mail.gmail.com>
        <e3b7080f-b788-048b-6f3a-e1a90e4206b7@redhat.com>
        <87sh41nkz5.fsf@vitty.brq.redhat.com>
        <ee1f404c-75d5-eee2-d2fc-014df3a7d01d@redhat.com>
Date:   Thu, 02 Aug 2018 15:30:15 +0200
In-Reply-To: <ee1f404c-75d5-eee2-d2fc-014df3a7d01d@redhat.com> (Paolo
        Bonzini's message of "Thu, 2 Aug 2018 13:54:51 +0200")
Message-ID: <87wot899qw.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 02 Aug 2018 13:30:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 02 Aug 2018 13:30:17 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/07/2018 11:14, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 27/07/2018 18:48, Jim Mattson wrote:
>>>> On a physical machine, I would expect the default local APIC page to
>>>> fall in the PCI hole, so it would be correct to sink writes and to
>>>> return all ones for reads. Does qemu implement a PCI hole, and does
>>>> this address fall into it?
>>>
>>> It does implement a PCI hole, but when using the kernel LAPIC it expects
>>> that only devices write to that range; therefore that address doesn't
>>> fall into the PCI hole, and instead it generates an MSIs.
>> 
>> Yes, and that's why I believe it's correct to never forward lapic
>> reads/writes from KVM to userspace when lapic is in kernel.
>> 
>> "RFC" was mostly about the inconsistency with the case when APIC access
>> page is in use. To be 100% correct I would suggest to somehow make it
>> behave like MMIO hole in case we're in x2APIC/disabled mode too.
>> 
>
> FWIW it is possible to move the MSI memory region from system memory to
> the PCI address space in QEMU, however I'm worried about backwards
> compatibility.
>

You know better :-)

> Vitaly, perhaps you could resubmit this patch, and provide a
> KVM_CAP_DISABLE_QUIRKS switch that would make apic_mmio_{read,write}
> return -EOPNOTSUPP in this case?

Just to make sure I understand,

we introduce a KVM_QUIRK_LAPIC_DISABLED_MMIO bit and will be emulating
MMIO hole in KVM till Qemu is able to deal with reads/writes passed to
it correctly?

-- 
  Vitaly
