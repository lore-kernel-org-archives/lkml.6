Return-Path: <kernel-hardening-return-13016-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+I8JfW7XEZSe9NLHy9tK95Vlo/+kaogfzKoyExg6AMmlcrSsfGAEhawIza6yx/UtifhTD9
ARC-Seal: i=1; a=rsa-sha256; t=1523950401; cv=none;
        d=google.com; s=arc-20160816;
        b=oRtz/Bmo/3TyZNRZ/ptnLDb+lR7Kq1ntQmSytYohEUldqCKeWTu1CoWyVg5umwWAYK
         hrUfVLFjK1NkP3d0lvJ8J/sWryHvaX+ZGhq1Jqu7u3UlSRiI3JYwaS4MOBRRYpUbkGOs
         TXKRCP0FvubqpBiHBKnD8Ixd5x0r0TZXO4S/T1PX/BZlZrOL987WrjS/TD/AVp0qP+dO
         CboA0CxRLLfWCTSqSmnyRC/73Go5zf2rTQidrwH263M1gvtSbbG7ZPMUlz78e/A1+Xni
         X0bBL3cQJLCWYREw87hkVYFeq3sAqkc7w5dW/WB0wczxh2pAB+O09+SU/q0FmfoHADAi
         KA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=jVpC9ORl8ZmJD+bkKK6nZ3zFrWG3jYNw/TIHmoFkqmc=;
        b=Oj3IhbxLxy6dXnp7Gbo+DnqzitLAtb3aSRCjfHDwgeHuUkMXlmG1JIAIM2m5H2D7HQ
         ajTwgE+THQdBNj1HAhyVx+qvyf38rNlEHd5xoOm/qGk+RPo2W1azCa45vHYY2ZRpy4uk
         tQXqSa7blpsKW8VvoMM1hRhGa0f33ffhO8CKC/qovOPK35kvmDM8ld4qMrNlkjnWGKyv
         AhPjeJqPRPo87VmGUnQO0u7Bopot0BpNO81vY6WIgv19Tl7arBioB8QDtY8A14ftQ572
         TL4A4tdQsBu+daOcNrCk6TvxNndS82Yj2HcwNU9AROSebGFDn0GlOJcrEidqdN1KgKNZ
         iuZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13016-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13016-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13016-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13016-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] x86/xen: Remove use of VLAs
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Laura Abbott <labbott@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180413221146.28476-1-labbott@redhat.com>
 <7cf66c00-74c2-62bb-81f5-4332313a5a6e@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <e63f261b-9ef3-5750-20df-555291a8a0d8@suse.com>
Date: Tue, 17 Apr 2018 09:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7cf66c00-74c2-62bb-81f5-4332313a5a6e@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597670729617678421?=
X-GMAIL-MSGID: =?utf-8?q?1597977816669499333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16/04/18 15:27, Boris Ostrovsky wrote:
> On 04/13/2018 06:11 PM, Laura Abbott wrote:
>> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
>> turn on -Wvla. The few VLAs in use have an upper bound based on a size
>> of 64K. This doesn't produce an excessively large stack so just switch
>> the upper bound.
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>  arch/x86/xen/enlighten_pv.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>> index c36d23aa6c35..d96a5a535cbb 100644
>> --- a/arch/x86/xen/enlighten_pv.c
>> +++ b/arch/x86/xen/enlighten_pv.c
>> @@ -421,8 +421,7 @@ static void xen_load_gdt(const struct desc_ptr *dtr)
>>  {
>>  	unsigned long va = dtr->address;
>>  	unsigned int size = dtr->size + 1;
>> -	unsigned pages = DIV_ROUND_UP(size, PAGE_SIZE);
> 
> 
> 
> Isn't dtr->size always either GDT_SIZE or 0?

GDT_SIZE - 1 :-)

>> -	unsigned long frames[pages];
>> +	unsigned long frames[DIV_ROUND_UP(SZ_64K, PAGE_SIZE)];

So we could just go with one frame and modify the BUG_ON() further below
accordingly.


Juergen
