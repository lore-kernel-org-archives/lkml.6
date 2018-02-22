Return-Path: <kernel-hardening-return-11882-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227tw1iCZwtABFuWRu1oLNVhmb5zA0oVnMmYJZMLh7nfKSCHGJxjq0Jy4xFAKVAAbh21P4LS
ARC-Seal: i=1; a=rsa-sha256; t=1519263345; cv=none;
        d=google.com; s=arc-20160816;
        b=ENE9TM/Jm2hNaSq5UOlmoNX54OdlNVCpntHx+rgolpjTKbYcH+HJm9NpB3Adaidcj2
         CIU0o9X7PUTt5gSJ1n+KwPVyxneuiimNj8N7ymMX7F/Odc7waWuSc1i+STbfQYZAzVNX
         z0pK/T/ITsrXjk8EkjwlmXXvBKw16AlZGIKfmQ8SKMtXgxgZ7c792dauKVc7qLWumCGj
         8N5KIOLnT0jxLTyo0+NlBkXh3cmGI8VDfedGOobwbOjOTGPBdn66MpC7ifltNBX33aU3
         tCo3D4ae54d63mwtA1z4+wWJ9/UQfwHXSRd5df49HuM2cFm4SM4UJ6EIXs2dDb8dVXQP
         usNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=RtLQ00sMRRLxLpl5Nx34qkWy28XwafRAvmlOVRbfe2E=;
        b=RSWrmDsypaT+TLBZC0tIZLieZvLWOKLnbzAwDQYAOfSU+eJmlYvwN35G2E7Y9hNsf4
         VbvjaDefbxQy9bnYaZMPB0ucDgkZ1At6x02UOkXNcmTgtWYbj65hfqYWIkuAVVF4E+cG
         IwP3pUe0lCQmegt/TF1QKT2cvBCvR4PTflMVZR8A/fgVNH/vFq7uQUEyV4g7fHLmtDGW
         rM+jQ4W40t6GSeowZXcNQrxN7vcjddhBk5Wyb6PdkM6/EL66X0OIZndF8CW7ZIOTIPSQ
         lDod+kB71hbZHrxiU7LsjzYnoDK/z32/EhvMtCjlzwZdowvkMcCUy15lPcmcGYQTjV0D
         21Gg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11882-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11882-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11882-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11882-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/2] arm64: Clear the stack
From: Laura Abbott <labbott@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>, Kees Cook
 <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 kernel-hardening@lists.openwall.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20180221011303.20392-1-labbott@redhat.com>
 <20180221011303.20392-3-labbott@redhat.com>
 <20180221153850.ywpzsigfnz3etoun@salmiak>
 <3b76d238-e10a-9abf-c9cb-6d3738eb7896@redhat.com>
Message-ID: <572af610-c20f-e826-f124-8df47680795b@redhat.com>
Date: Wed, 21 Feb 2018 17:35:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3b76d238-e10a-9abf-c9cb-6d3738eb7896@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592971106986303834?=
X-GMAIL-MSGID: =?utf-8?q?1593063081549325549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 03:53 PM, Laura Abbott wrote:
>> I *think* this should happen in finish_ret_to_user a few lines down, since we
>> can call C code if we branch to work_pending, dirtying the stack.
>>
> 
> I think you're right but this didn't immediately work when I tried it.
> I'll have to dig into this some more.

Okay I figured this out. Not corrupting registers works wonders.
