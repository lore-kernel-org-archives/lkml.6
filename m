Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B137C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B0120656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hPh2Z/tI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbfAORbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:31:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46421 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388023AbfAORbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:31:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so1990431qkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 09:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I76C19/Sgr6Cs6Bc22saq775411+lnshmK6Ut/1XHqk=;
        b=hPh2Z/tIP7ZzyIN1SWMrwAwJe+GG41UVMDyeGwOea/xT8selcM/E9zdDJxRU89B1lY
         uxjLmeMZz/MY8LuoY1riSCo2pV63VZEF7qHeCgQCNuXCoL4AzAR7Adfps4eUM8PeokfX
         fhZGg/npH4CgKCUU74Zfi5lr6qAviDkcXfqtA9QM8ja0H6vq3ggU+qbsHq6eEIRz2PzA
         51opqV9Q19MuBB9zFIBb9wmhoSO2lOUs5mjrdsps7U0TDaagYTtM4Z0jl1/+LPgNaadS
         kjam5VRi1IQDduj12oaTERddV5mbyJfai5fdZUFzreOmBZrXfLVENcs/H7lt3wViPhXG
         6RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I76C19/Sgr6Cs6Bc22saq775411+lnshmK6Ut/1XHqk=;
        b=oEOqdG6Z+YeqZD6CaiJoL4uLkcctHy/HWoReZlv/dE26VwsIc/gElFj4av4/CRN8t+
         kiPM6vkCkq8bAwSYOkXCuRjnblg0fGou63OuOewbGC48k84dWx19DdaAVqf+jtnCz3+K
         TTeTw8+wFmPGoa/2nwiXXqLs5PZ8UrI1nfFkK4kbbzjlLniv06OVHQ3Gh6KtBHIICIbc
         9amuHydhyqKHbQnPoGNmSeb3faX/q9kx2WWraeakuoU86hBFsNEykStE2tau82QtPL2t
         WE6JGZfUosk+WayE9HWw1XKoGWatkpYwKm5bNC4CMdtRDQW1kkacrKeyu2zfOI4P+f0t
         nJpQ==
X-Gm-Message-State: AJcUukcCUxMztJIBkC4GHVHKZ2ELD8cLKDpheyIG1dWqGx+kRXnAUdqL
        y1z+bigKvx6laiRcIDTpNk00PMCsGwq5cw==
X-Google-Smtp-Source: ALg8bN54qWRkjZ8OO79p3AU6AwamYGEiGIXTdeU9RmQvj32gAtXB0KqU/xpFopus0xPhA3x3VIgvuQ==
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr3518829qkf.330.1547573497185;
        Tue, 15 Jan 2019 09:31:37 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b8sm53018062qka.79.2019.01.15.09.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 09:31:36 -0800 (PST)
Subject: Re: [PATCH] kvm: add proper frame pointer logic for vmx
From:   Qian Cai <cai@lca.pw>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com
Cc:     sean.j.christopherson@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190115064459.70513-1-cai@lca.pw>
 <a6477022-bbc0-fc00-2c8e-75007b468d3f@lca.pw>
 <5109b3c2-cac0-aa19-9cc7-801340afe198@redhat.com>
 <7d6ae0bc-b7c7-63ea-ae94-4437a29a31b1@lca.pw>
Message-ID: <17c961e9-bc76-9fe0-b759-3b427f422bbc@lca.pw>
Date:   Tue, 15 Jan 2019 12:31:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <7d6ae0bc-b7c7-63ea-ae94-4437a29a31b1@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/19 11:43 AM, Qian Cai wrote:
> 
> 
> On 1/15/19 2:13 AM, Paolo Bonzini wrote:
>> Hmm, maybe like this:
>>
>> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
>> index bcef2c7e9bc4..33122fa9d4bd 100644
>> --- a/arch/x86/kvm/vmx/vmenter.S
>> +++ b/arch/x86/kvm/vmx/vmenter.S
>> @@ -26,19 +26,17 @@ ENTRY(vmx_vmenter)
>>  	ret
>>
>>  2:	vmlaunch
>> +3:
>>  	ret
>>
>> -3:	cmpb $0, kvm_rebooting
>> -	jne 4f
>> -	call kvm_spurious_fault
>> -4:	ret
>> -
>>  	.pushsection .fixup, "ax"
>> -5:	jmp 3b
>> +4:	cmpb $0, kvm_rebooting
>> +	jne 3b
>> +	jmp kvm_spurious_fault
>>  	.popsection
>>
>> -	_ASM_EXTABLE(1b, 5b)
>> -	_ASM_EXTABLE(2b, 5b)
>> +	_ASM_EXTABLE(1b, 4b)
>> +	_ASM_EXTABLE(2b, 4b)
>>
>>  ENDPROC(vmx_vmenter)
> 
> No, that will not work. The problem is in vmx.o where I just sent another patch
> for it.
> 
> I can see there are five options to solve it.
> 
> 1) always inline vmx_vcpu_run()
> 2) always noinline vmx_vcpu_run()
> 3) add -fdiable-ipa-fnsplit option to Makefile for vmx.o
> 4) let STACK_FRAME_NON_STANDARD support part.* syntax.
> 5) trim-down vmx_vcpu_run() even more to not causing splitting by GCC.
> 
> Option 1) and 2) seems give away the decision for user with
> CONFIG_CC_OPTIMIZE_FOR_(PERFORMANCE/SIZE).
> 
> Option 3) prevents other functions there for splitting for optimization.
> 
> Option 4) and 5) seems tricky to implement.
> 
> I am not more leaning to 3) as only other fuction will miss splitting is
> vmx_segment_access_rights().
> 

Option 3) seems a bit tricky to implement too, as it needs to check for the
compiler version before to see if the option is available before put it to the
CFLAGS.
