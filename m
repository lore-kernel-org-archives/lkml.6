Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABBFECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2742151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2742151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeJQWnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbeJQWnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:43:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12B013002978;
        Wed, 17 Oct 2018 14:47:31 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC1135F7C2;
        Wed, 17 Oct 2018 14:47:28 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v6 06/13] KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case
In-Reply-To: <2064be05-4286-e3d5-cd22-13fd957b7003@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com> <20181016165011.6607-7-vkuznets@redhat.com> <2064be05-4286-e3d5-cd22-13fd957b7003@redhat.com>
Date:   Wed, 17 Oct 2018 16:47:27 +0200
Message-ID: <8736t4sk8w.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 17 Oct 2018 14:47:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 16/10/2018 18:50, Vitaly Kuznetsov wrote:
>> +	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
>> +			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
>> +		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
>> +		vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
>> +		vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
>> +		vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
>> +		vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
>> +	}
>
> For what it's worth, I suspect that these can be moved to
> prepare_vmcs02_full.  The initial implementation of shadow VMCS did not
> expose "unrestricted guest" to the L1 hypervisor, and emulation does a
> lot of accesses to CS (of course).  Not sure how ES base ended up in
> there and not DS base, though...

I tried unshadowing all these fields and at least Hyper-V on KVM
(without using eVMCS of course) experiences a 1200-1300 cpu cycles
regression during tight cpuid loop test. I checked and this happens
because it likes vmreading GUEST_CS_AR_BYTES a lot.

-- 
Vitaly
