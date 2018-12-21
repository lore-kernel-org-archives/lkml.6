Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59983C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019AE21919
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbeLUKG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:06:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731648AbeLUKG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:06:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C1688E67A;
        Fri, 21 Dec 2018 10:06:56 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 295D517D4D;
        Fri, 21 Dec 2018 10:06:54 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org
Subject: Re: [PATCH] KVM: x86: svm: report MSR_IA32_MCG_EXT_CTL as unsupported
In-Reply-To: <20181220200630.GC25497@flask>
References: <20181219110613.24459-1-vkuznets@redhat.com> <20181220200630.GC25497@flask>
Date:   Fri, 21 Dec 2018 11:06:52 +0100
Message-ID: <8736qrw5vn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 21 Dec 2018 10:06:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radim Krčmář <rkrcmar@redhat.com> writes:

> 2018-12-19 12:06+0100, Vitaly Kuznetsov:
>> AMD doesn't seem to implement MSR_IA32_MCG_EXT_CTL and svm code in kvm
>> knows nothing about it, however, this MSR is among emulated_msrs and
>> thus returned with KVM_GET_MSR_INDEX_LIST. The consequent KVM_GET_MSRS,
>> of course, fails.
>> 
>> Report the MSR as unsupported to not confuse userspace.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/svm.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>> index 2acb42b74a51..dfdf7d0b7f88 100644
>> --- a/arch/x86/kvm/svm.c
>> +++ b/arch/x86/kvm/svm.c
>> @@ -5845,6 +5845,13 @@ static bool svm_cpu_has_accelerated_tpr(void)
>>  
>>  static bool svm_has_emulated_msr(int index)
>>  {
>> +	switch (index) {
>> +	case MSR_IA32_MCG_EXT_CTL:
>> +		return false;
>> +	default:
>> +		break;
>
> Queued, thanks.
>
> Btw, I would prefer this without the
>
>   default: break;
>
> as I don't think we'll ever add something there.

"640K ought to be enough for anybody" :-)

But in case you commit it as

return index != MSR_IA32_MCG_EXT_CTL; 

I won't object. Thanks,

-- 
Vitaly
