Return-Path: <pbonzini@redhat.com>
X-Google-Smtp-Source: AG47ELv8k74OKoBbCFQSX2P/N2tZffGR0TCFIjES4gcCr6BBul1foVBFSO1bYOHazJMKI3EvLTfS
ARC-Seal: i=1; a=rsa-sha256; t=1519917469; cv=none;
        d=google.com; s=arc-20160816;
        b=nj/dTpiAnQH33veQvFrBf8Dzdy2wHRpaxzTjEpyo86tUQJKTGix0rX3ZwEDr2zXeef
         pZ8a230rvm2q3sNXikGLapYe8gmxl5Zq4GV0qcjIdzQXfFc8tLN35Mi6SpwbRfldZrYU
         6emt2UPFKX1zpT+hAdt4A+aRsHW6cZtiLClvUax+xckJoX3og9pBjlwa5EmsoKIDGR6t
         +bCCYw4TeBGVDXrm1WmjTCWyvnt6nBSquadetM+KJaSFvQAIs3NZQczo39MiDVhOdSM4
         umHrFvxnMjEnP6xmvP0NNEpGyBqBP5jq9rEGT3yb53dNFmO3U5UCkkfOmus6RjopBRzD
         mjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=3/7h+cQG+VIL4xOvMQ08YAGRZEM4r5paHPHmuovtTSU=;
        b=jmtfUADeKtBZItVdiqI+ygTw63CNOnebOSA4/KUrG56bLIIWcvfzmS0R3kgDH/eLxS
         hsne1qTQRPL9950tPJ5iKHIj8GDmXm8v057+L/0Ggbv4eAZnxg2qZQ9Zb65G/Tul0APS
         8J3h/bQJEvifmUKMO2SBgam/iInEjsD2IuN68gHgDedAhYskdegqQOXMmEy0T0/wwppL
         MDW0q4ashZDMDGe05UuCPfQXrD+AMCqMdmNPIyRwOHBGuwOBOwcmDorv9r0fCD7IC0zm
         okkOKIeJOWLAnvZ1mppBQIxMEip2oCEKVhyKziH5WD8ocpMrj/s+VEa0/jy0Z7XuU5Bj
         ntUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [RFC PATCH v4 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH
 and CONFIG_XEN_PVH
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Maran Wilson <maran.wilson@oracle.com>, jgross@suse.com,
 roger.pau@citrix.com, andrew.cooper3@citrix.com, hch@infradead.org,
 JBeulich@suse.com, x86@kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
 jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
 thomas.lendacky@amd.com, luto@kernel.org, dave.hansen@linux.intel.com,
 davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org,
 linus.walleij@linaro.org, rdunlap@infradead.org
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-2-git-send-email-maran.wilson@oracle.com>
 <5be04d96-aa10-a022-2597-f7f40138f8f8@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8cdb96db-0771-f062-e0ea-54b4171d6a98@redhat.com>
Date: Thu, 1 Mar 2018 16:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5be04d96-aa10-a022-2597-f7f40138f8f8@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670432609567761?=
X-GMAIL-MSGID: =?utf-8?q?1593748980861644874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/03/2018 16:02, Boris Ostrovsky wrote:
> On 02/28/2018 01:27 PM, Maran Wilson wrote:
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index eb7f43f23521..fa7cd0305125 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -791,6 +791,14 @@ config KVM_GUEST
>>  	  underlying device model, the host provides the guest with
>>  	  timing infrastructure such as time of day, and system time
>>  
>> +config PVH
>> +	bool "Support for running PVH guests"
>> +	depends on KVM_GUEST || XEN
> 
> 
> Not sure about XEN part. PVH is selected by XEN_PVH for Xen.
> 
> What about introducing KVM_GUEST_PVH that will select PVH and then drop
> dependency here?

That is, "config KVM_GUEST_PVH" "depends on KVM_GUEST" "select PVH".
Sounds good to me.

Paolo

> 
> -boris
> 
>> +	def_bool n
>> +	---help---
>> +	  This option enables the PVH entry point for guest virtual machines
>> +	  as specified in the x86/HVM direct boot ABI.
>> +
>>  
> 
> 
>> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
>> index f605825a04ab..021c8591c3c0 100644
>> --- a/arch/x86/xen/Kconfig
>> +++ b/arch/x86/xen/Kconfig
>> @@ -77,8 +77,9 @@ config XEN_DEBUG_FS
>>  	  Enabling this option may incur a significant performance overhead.
>>  
>>  config XEN_PVH
>> -	bool "Support for running as a PVH guest"
>> +	bool "Support for running as a Xen PVH guest"
>>  	depends on XEN && XEN_PVHVM && ACPI
>>  	# Pre-built page tables are not ready to handle 5-level paging.
>>  	depends on !X86_5LEVEL
>> +	select PVH
>>  	def_bool n
> 
