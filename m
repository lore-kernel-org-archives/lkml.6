Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nzK1EX1jHlsqXwAAmS7hNA
	; Mon, 11 Jun 2018 11:57:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4F709607E4; Mon, 11 Jun 2018 11:57:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D5C1160351;
	Mon, 11 Jun 2018 11:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5C1160351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933330AbeFKL5K (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:57:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933194AbeFKL5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:57:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1919406E807;
        Mon, 11 Jun 2018 11:57:04 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4F27111AF0F;
        Mon, 11 Jun 2018 11:57:02 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] KVM: introduce kvm_make_vcpus_request_mask() API
References: <20180516152131.30689-1-vkuznets@redhat.com>
        <20180516152131.30689-6-vkuznets@redhat.com>
        <20180526144946.GF23390@flask>
Date: Mon, 11 Jun 2018 13:57:01 +0200
In-Reply-To: <20180526144946.GF23390@flask> ("Radim \=\?utf-8\?B\?S3LEjW3DocWZ\?\=
 \=\?utf-8\?B\?Iidz\?\= message of "Sat,
        26 May 2018 16:49:47 +0200")
Message-ID: <87bmchtu2a.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 11 Jun 2018 11:57:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 11 Jun 2018 11:57:04 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radim Krčmář <rkrcmar@redhat.com> writes:

> 2018-05-16 17:21+0200, Vitaly Kuznetsov:
>> Hyper-V style PV TLB flush hypercalls inmplementation will use this API.
>> To avoid memory allocation in CONFIG_CPUMASK_OFFSTACK case add
>> cpumask_var_t argument.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> -bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
>> +bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
>> +				 unsigned long *vcpu_bitmap, cpumask_var_t tmp)
>>  {
>>  	int i, cpu, me;
>> -	cpumask_var_t cpus;
>> -	bool called;
>>  	struct kvm_vcpu *vcpu;
>> -
>> -	zalloc_cpumask_var(&cpus, GFP_ATOMIC);
>> +	bool called;
>>  
>>  	me = get_cpu();
>> +
>
> Two optimizations come to mind: First is to use for_each_set_bit instead
> of kvm_for_each_vcpu to improve the sparse case.
>

I think I had such version at some point but then for some reason I
decided I'm re-implementing kvm_for_each_vcpu for no particular
reason.

>>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		if (!test_bit(i, vcpu_bitmap))
>
> And the second is to pass vcpu_bitmap = NULL instead of building the
> bitmap with all VCPUs.  Doesn't looks too good in the end, though:
>
> #define kvm_for_each_vcpu_bitmap(idx, vcpup, kvm, bitmap, len) \
> 	for (idx = (bitmap ? find_first_bit(bitmap, len) : 0); \
> 	     idx < len && (vcpup = kvm_get_vcpu(kvm, idx)) != NULL; \
> 	     bitmap ? find_next_bit(bitmap, len, idx + 1) : idx++)

I'll take a try, thanks!

-- 
  Vitaly
