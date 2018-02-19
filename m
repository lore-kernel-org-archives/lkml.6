Return-Path: <pbonzini@redhat.com>
X-Google-Smtp-Source: AH8x227aOGMTzTGvsPZTu74EcxCChg4qzCZDPu/L42G41C4RUuVc+7PmBjk2YBP7fZ+1iLmFADBl
ARC-Seal: i=1; a=rsa-sha256; t=1519045817; cv=none;
        d=google.com; s=arc-20160816;
        b=DIbtt1KRAGHUYbgb55TAsmPIYtbBsfDwmOW6cBVPF9GefCD+bk0JaYEknLZWuUjq/a
         6o+VFggE921VBB8tnz+OW0ekWTzzi8Rj3LHKFcB7jWV/aeDxaWxm/FkTxQHnDJxKxmmF
         8blRObaYdriAjXYRCxQACpipmaT9ZgpFwKqNBqN3WWhvkTV/ZCDbbCfFZPuL89AO2SVY
         fL3w6xW8PR7qTvy7rCInAsou7KhZTkq/JIrwiEGHXbPZmTwp+IGtc2+IzT46jiP/eymp
         mE8E3Mm+DnqPd3ZZ4sMvL9ZWtQeOsE7EFq9+JBmuxda6XjUO1oI8UCM7BfI03Ov27GiY
         0O0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=S2RU5MnAVQ5HZtel8uOmV4sIj5P2EKgiqVlxoCJbxHo=;
        b=bHyc0/i1wKo+x3FNUcVXKJ+gQVV+kh8QHlcCQGPy0iQJXH3YYhNjP37B0z7AXOy6j4
         QVAUkDFhMU3XGlm8qSupAR9xBFUW9db6E2J0KbU/+I7NNM0QUyf3zRj3XnLdujuSVp/6
         cZYFtUSAMjB2qDz5r/gx71RYbHr4q0WxkUacH2yQ2Pd2jZ4cT194FFo7hcyxKDzeCsuO
         bETWSCvHLzH/J309yDtR+HuIkTxLeMbzzDMFxIp+Cv5P3G+sBGc/M4gDvXoJX39ah2NN
         o6dwvcTeY9pcLEn0JGXiYee1cAt1ATatUv6AiIYon2ZlwLSqLj/jDc0eTB7wegxQLI+L
         FZJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH 7/9] KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
To: Jim Mattson <jmattson@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 kvm list <kvm@vger.kernel.org>, KarimAllah Ahmed <karahmed@amazon.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
 <1517938181-15317-8-git-send-email-dwmw@amazon.co.uk>
 <4be4e462-61be-53a9-b0e1-3508466d1645@redhat.com>
 <CALMp9eQQ-94g=fNanvwpr6b2pmH87RPGr6s9gOv43dUDABFuhw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4693ca3-face-e1f5-b619-74fc59870ce9@redhat.com>
Date: Mon, 19 Feb 2018 14:10:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQQ-94g=fNanvwpr6b2pmH87RPGr6s9gOv43dUDABFuhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591673636269892848?=
X-GMAIL-MSGID: =?utf-8?q?1592834987045239750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16/02/2018 17:29, Jim Mattson wrote:
> On Fri, Feb 16, 2018 at 6:18 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> Uhm, taking contents from the hardware is wrong (guess why---live
>> migration).  I'll send a revert of those two lines.
> 
> Hardware seems like a reasonable place to get the default value (cf.
> the VMX capability MSRs).

There are some differences:

- a zero value for ARCH_CAPABILITIES should be safe, while a zero value
for VMX capabilities doesn't really make sense.  On the contrary, a
nonzero value for ARCH_CAPABILITIES is not safe across live migration.

- VMX doesn't support live migration; before adding that support we will
probably have Tom's patches to retrieve MSR capabilities.

Thanks,

Paolo

> Should these two lines just be moved to
> vmx_create_cpu?
> 
