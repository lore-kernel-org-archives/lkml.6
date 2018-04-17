Return-Path: <kernel-hardening-return-13034-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+KsAFP4QRnNeaLvjksS6Gdj494yYPpnSf/QiSdHEPfw3Pmz/uFm01wGCpgBwpyjGyrz9OP
ARC-Seal: i=1; a=rsa-sha256; t=1524008063; cv=none;
        d=google.com; s=arc-20160816;
        b=p24sfgnfjk3NyQnnnUccqN91vc/0NR4PFe9L4EupWAPOvo5teGPHDVLkHHqcZ+C9DA
         oxnxJlSEhdL+X88J5q41kDnhwsVa/2MHU3VS3eezefPW8htNOHMJUDAWKYkqFlaGjB5Y
         uTvaDTeT03hAIwnDDuyYKIAgt/TMwf5tN5a3ae7AJhBoNcG9dvql7egNrdOk2AF+wf1s
         wQwrDJw2UJDv8/e950juXHrLVBw5Cv/IReWivUu0ZF8qWWxXZpB/14TmieRgf05PvaLp
         ry0wRqH7FnfDC/kbD8mEgr+sqYaxokG74pdO+1V5721sDPfL/17rdLXcEZV/4k/UozjA
         0WgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=2qU/UnvG2sElhgauqaVlQO0u0Bf2BaSoFePP/V30NS8=;
        b=HMKH+FNocRDYZYAu7hAApRE+ro2Te/6YWG+MGQyu6ymjah4V2rGU2eno1RbFcKszb5
         2U1QHG1bFvGHPJT0jRSaS1vLZQT4c0ugdtf2tsIF/GeQWT51Ny1ROz2nmwVx+xPoBmSM
         3M2/sQjIdgsOfM33t9DOTWSNVmMIeC478TM4uLXIm6Cm45BS8RM7tMDP96JMN3RO21rp
         ld2TxBv6e1MD93eujsvGq77TqfWACG+cKYW1iD+A5tfTmmGTx2bfrqETmYz85kNYnDEw
         MFtJoEgma1Y2GI9u8ANzWkhUdyv3grJ2jFpNkQxO9nsiTqCyXH7ItCtmPreI45Rfc0HX
         hLSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13034-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13034-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13034-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13034-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] x86/xen: Remove use of VLAs
To: Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180413221146.28476-1-labbott@redhat.com>
 <7cf66c00-74c2-62bb-81f5-4332313a5a6e@oracle.com>
 <e63f261b-9ef3-5750-20df-555291a8a0d8@suse.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <9fe26cf5-01dc-1fb0-25fd-29bf8615047f@redhat.com>
Date: Tue, 17 Apr 2018 16:33:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e63f261b-9ef3-5750-20df-555291a8a0d8@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597670729617678421?=
X-GMAIL-MSGID: =?utf-8?q?1598038278768539046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/17/2018 12:16 AM, Juergen Gross wrote:
> On 16/04/18 15:27, Boris Ostrovsky wrote:
>> On 04/13/2018 06:11 PM, Laura Abbott wrote:
>>> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
>>> turn on -Wvla. The few VLAs in use have an upper bound based on a size
>>> of 64K. This doesn't produce an excessively large stack so just switch
>>> the upper bound.
>>>
>>> [1] https://lkml.org/lkml/2018/3/7/621
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>>   arch/x86/xen/enlighten_pv.c | 6 ++----
>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>>> index c36d23aa6c35..d96a5a535cbb 100644
>>> --- a/arch/x86/xen/enlighten_pv.c
>>> +++ b/arch/x86/xen/enlighten_pv.c
>>> @@ -421,8 +421,7 @@ static void xen_load_gdt(const struct desc_ptr *dtr)
>>>   {
>>>   	unsigned long va = dtr->address;
>>>   	unsigned int size = dtr->size + 1;
>>> -	unsigned pages = DIV_ROUND_UP(size, PAGE_SIZE);
>>
>>
>>
>> Isn't dtr->size always either GDT_SIZE or 0?
> 
> GDT_SIZE - 1 :-)
> 
>>> -	unsigned long frames[pages];
>>> +	unsigned long frames[DIV_ROUND_UP(SZ_64K, PAGE_SIZE)];
> 
> So we could just go with one frame and modify the BUG_ON() further below
> accordingly.
> 

Do you want to just remove the loop as well since we're never going
to do more than one frame? We end up with net code deletion.

Thanks,
Laura

> 
> Juergen
> 
