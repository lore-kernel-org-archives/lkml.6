Return-Path: <jmoreira@suse.de>
X-Google-Smtp-Source: AIpwx4/FEFZ4lBwPIjSYczCYlnUB21KDQfNYF0OC+Ji5svz6mBBWRQeZy0ztiZmuuXBevY4IOxFl
ARC-Seal: i=1; a=rsa-sha256; t=1523889369; cv=none;
        d=google.com; s=arc-20160816;
        b=JV8idz6E+CH3kKNCwubbseZSeJU7CJ4ToCS46Bvw3ypXBMY1PL9UeqCpQXOc2jLZDR
         kmcZ+VpnCtwBvDd9s09PzK+GnTzNuFqe4vaMvUe1NtnZb3M/J2tYj+XSv2qfptUmitLb
         Kla9TEt55PKr2dm+35UaueChSFmaxuh2D25KpwCQB9w0btbfu6MOfCkqvbI6NNSx/cou
         65Hh4hcrOPMlqUVZVzE2Ig76Oibx15S7d0duGj0uOQmnQLDDKsLI3Zhi7HkrzP/CgxJB
         tOOyqGS98k8VlGSfl/DBx0nA2Q3sInprYGcILNX/wLslM406Oe+h9AhZ3TDdafv1Gt3L
         QsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=maSq/7FoCVcAWFxKbwBj5y4yEuRd2WJLi1Hr8fpeBl0=;
        b=l5Xu9G8a+eufJATvCZAQYBf2PZm6ALBZkbQx7gcjFwZd0zBLkr5+qeq4PYF5JDyzMX
         yKv5flQhRQWMeVatY+Fu0iWzgdMscewo5643baOOVucJPjTNBUqA3fN5fEg8IiZaS59j
         DxXyjMETBZbh1MaelXE09AcpIR7edNHJnSdoH8tRSjv+VizyS22aFAXtO+NORuiACxMC
         58uy8qeeYu2TtxlhQPCDViso2SoRvt4VVtkmhxUAhtQPmdLsTQyR+AfVhSnRi+2aXrJp
         hNiMQ0NBMCNo83S1PIBbZAMRL/vQJZttsZ6Z0Hyb6lITzDoOKD4SdCFFSSdLtFQ6T+q0
         EEjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jmoreira@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jmoreira@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jmoreira@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jmoreira@suse.de
Subject: Re: [PATCH 1/4] x86/crypto: camellia: Fix function prototypes
To: Ingo Molnar <mingo@kernel.org>
Cc: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 gregkh@linuxfoundation.org, keescook@chromium.org
References: <20180415041542.5364-1-jmoreira@suse.de>
 <20180415041542.5364-2-jmoreira@suse.de>
 <20180416061044.z6eb4psw2sbszemb@gmail.com>
From: =?UTF-8?Q?Jo=c3=a3o_Moreira?= <jmoreira@suse.de>
Message-ID: <15bd0d05-e046-1b35-9f14-91e507e6b162@suse.de>
Date: Mon, 16 Apr 2018 11:35:58 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180416061044.z6eb4psw2sbszemb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597784202629370804?=
X-GMAIL-MSGID: =?utf-8?q?1597913819399588169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> 
>> +static inline void camellia_enc_blk(void *ctx, u8 *dst, const u8 *src)
>>   {
>> -	__camellia_enc_blk(ctx, dst, src, false);
>> +	__camellia_enc_blk((struct camellia_ctx *) ctx, dst, src, false);
>>   }
> 
> I don't see how this is an improvement: instead of having a proper type there's
> now an opaque type and an ugly (and dangerous) type cast.
> 
> What does "compatible with CFI requirements" mean?

For "compatible with CFI requirements", I meant: given a set of 
functions that are invoked through a given set of pointers, all 
functions and pointers in these sets have the same prototype. I added a 
note about this CFI heuristic in the cover letter, but I guess I should 
have been clearer there and added something more substantial to the 
commit message.

Regarding the changes, this was the most straight-forward way I found to 
make the sources compliant with the above, not requiring deeper semantic 
changes to the underneath invoking code. On the other hand, I agree that 
there is a collateral damage and that an ideal fix would be the other 
way around -- removing the opaque type from the pointer instead of 
adding it to the functions.

I'll try to think of another way and send if I come to something.

Tks,
João.
