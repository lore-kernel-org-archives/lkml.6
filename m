Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002D2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF76F21476
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF76F21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeJAXUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:20:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeJAXUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:20:43 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5CF730E684D;
        Mon,  1 Oct 2018 16:42:04 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C1A85E549;
        Mon,  1 Oct 2018 16:42:00 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Cc:     kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/7] KVM: x86: hyperv: implement PV IPI send hypercalls
In-Reply-To: <d92255fb-d876-1c7f-3ac3-123c417aa685@redhat.com>
References: <20180926170259.29796-1-vkuznets@redhat.com> <20180926170259.29796-8-vkuznets@redhat.com> <20180927110711.GE4186@rkaganb.sw.ru> <51ff55e0-9d8d-73be-e0e7-f8580bc0206e@redhat.com> <877ej1fxkb.fsf@vitty.brq.redhat.com> <d92255fb-d876-1c7f-3ac3-123c417aa685@redhat.com>
Date:   Mon, 01 Oct 2018 18:41:58 +0200
Message-ID: <874le5fwkp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 01 Oct 2018 16:42:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 01/10/2018 18:20, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 27/09/2018 13:07, Roman Kagan wrote:
>> ...
>>>>
>>>> I must say that now it looks even more tempting to follow the same
>>>> pattern as your kvm_hv_flush_tlb: define a function that would call
>>>> kvm_apic_set_irq() on all vcpus in a mask (optimizing the all-set case
>>>> with a NULL mask), and make kvm_hv_send_ipi perform the same hv_vp_set
>>>> -> vcpu_mask transformation followed by calling into that function.
>>>
>>>
>>> It would perhaps be cleaner, but really kvm_apic_set_irq is as efficient
>>> as it can be, since it takes the destination vcpu directly.
>>>
>>> The code duplication for walking the sparse set is a bit ugly, perhaps
>>> that could be changed to use an iterator macro.
>> 
>> I actually like Roman's suggestion on how to re-write kvm_hv_flush_tlb()
>> and I also agree that it would be easier for future readers if we write
>> kvm_hv_send_ipi() in a similar way. Actually, I already have v7 in my
>> stash, will be sending it out shortly.
>
> Just send follow ups now, please.  I already have enough long queue. :)

Oh yea, you should :-)

No problem at all, I'll convert v7 into a follow-up series when
kvm/queue is pushed.

Thanks,

-- 
Vitaly
