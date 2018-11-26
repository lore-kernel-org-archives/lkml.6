Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2075C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CE220672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CE220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeK0EJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:09:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbeK0EJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:09:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DF428E3CB;
        Mon, 26 Nov 2018 17:14:53 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08C3E19C7F;
        Mon, 26 Nov 2018 17:14:50 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH v2 3/4] x86/kvm/hyper-v: direct mode for synthetic timers
In-Reply-To: <e565638e-d6cc-bbd9-f99e-c835ef1be5b7@redhat.com>
References: <20181126154732.23025-1-vkuznets@redhat.com> <20181126154732.23025-4-vkuznets@redhat.com> <e565638e-d6cc-bbd9-f99e-c835ef1be5b7@redhat.com>
Date:   Mon, 26 Nov 2018 18:14:49 +0100
Message-ID: <8736rnlq0m.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 26 Nov 2018 17:14:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 2b7a652c9fa4..b8da14cee8e5 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -975,6 +975,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
>>  #define KVM_CAP_EXCEPTION_PAYLOAD 164
>>  #define KVM_CAP_ARM_VM_IPA_SIZE 165
>> +#define KVM_CAP_HYPERV_STIMER_DIRECT 166
>
> I wonder if all these capabilities shouldn't be replaced by a single
> KVM_GET_HYPERV_SUPPORTED_CPUID ioctl, or something like that.  If you
> can do it for 4.21, before this one cap is crystallized into userspace
> API, that would be great. :)

Oh, so the suggestion is to get all these features in CPUID format
(leafs 0x40000001-0x4000000A at this moment - as Hyper-V encodes them)
and let userspace parse them. Could work. Will take a look.

Alternatively, we can go with 'something like that' and add a
generalized KVM_GET_HYPERV_SUPPORTED_CAPS ioctl (returning somehthing
like u64 feature, u64 parameter pair). Doing that, however, wouldn't
relieve us from adding a new KVM_CAP_HYPERV_* constant for every new
feature.

-- 
Vitaly
