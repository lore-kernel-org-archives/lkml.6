Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDDRnX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:43:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750915AbeDDRnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:43:22 -0400
Subject: Re: [PATCH v5 1/2] KVM: X86: Introduce handle_ud()
To: Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <kernellwp@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
References: <1522798129-14588-1-git-send-email-wanpengli@tencent.com>
 <1522798129-14588-2-git-send-email-wanpengli@tencent.com>
 <9d68b1b4-04e6-46d6-70b4-6ebcb0a0c4aa@redhat.com>
 <16957e9b-103a-0fd5-9e2b-084e9ebc3773@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e6c4379c-2038-93c2-99d4-51a45cb9b371@redhat.com>
Date: Wed, 4 Apr 2018 19:43:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <16957e9b-103a-0fd5-9e2b-084e9ebc3773@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.04.2018 19:12, Paolo Bonzini wrote:
> On 04/04/2018 13:54, David Hildenbrand wrote:
>>> +{
>>> +	enum emulation_result er;
>>> +
>>> +	er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
>>> +	if (er == EMULATE_USER_EXIT)
>>> +		return 0;
>>> +	if (er != EMULATE_DONE)
>>> +		kvm_queue_exception(vcpu, UD_VECTOR);
>>> +	return 1;
>> I would now actually prefer
>>
>> if (er == EMULATE_DONE)
>> 	return 1 ...
> 
> Why?  The return statement would be duplicated.
> 
> Paolo
> 

I was talking about two equality checks vs. 1 equality and 1 inequality
check.

er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
if (er == EMULATE_USER_EXIT)
	return 0;
else if (er == EMULATE_DONE)
	return 1;
return kvm_queue_exception(vcpu, UD_VECTOR);


-- 

Thanks,

David / dhildenb
