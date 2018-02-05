Return-Path: <pbonzini@redhat.com>
X-Google-Smtp-Source: AH8x2258KAnaDt7Cgw9iaD8x0ROkY/YqJTa9YQ+K7uiQCi0dF4HQolQ92MJyeMPZyb1J943bNxgf
ARC-Seal: i=1; a=rsa-sha256; t=1517858649; cv=none;
        d=google.com; s=arc-20160816;
        b=OHwsILMhBcKQnYKyLtlzVShVNlsiatlIxZoO/MDvc/0oWexJf5MTFAvEHgM+GngNx3
         CMAwW/8H9ZpyoiAnxtytT+bEL7unQ/JStycoirDnuvrLCj4oNBwUvvZFCUJhJ15tnc8i
         Sm/rNjG6QSCcj1nCECE6/paDkqhRns9f8dZ61lviFaj26PLs8+JRuC+Xm7SftRSLnDS+
         njejm/3zRa4ngcOiq/+6zLtK+WW14hPC9dBKh7oaSOfg32zIinPLzYzshWo0r0AXLNkS
         l90et5h39jCf7PondDUSTtjUAHGeC6YUuDxXMk1oH+K2ZVi1oOy4LHz+3bFXo+mZUINj
         MAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Pe67joqCRwya6ffB/y0vZrQbjn/tlxMI6QQYrN6s5N4=;
        b=L7XAowmbNrr5sxZpw3UBQ/WOIXJ5oQFiYbj3qLctj8C81sGCcf9Ks12wqyK/zZO2/d
         jFwSl4bOaZNc3N0TY/crJGcTjK86Yrbli+Mo/B1EOw2UJoaR1AiTA/3rfDBFW/IoSr7y
         TN5jLNfFGEomagg82hnNTsQ2nd4SSO92M6U/rtZccGZ+8MtAhyV36ODZlnqEVT9lEOq2
         5vBv1GAtPJLxBu/fxzXFKV+fGRiHYrwP5Kp81sbNaUycomocb4AKZ1Iab92YfUfAHNa5
         ND9quvXverCpsPRT8vgCmTNahOYAh7Je4nGfxiftryWUp9yDqAN/DyfgZ2ucD8aeFhmg
         WZCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH v6 2/5] KVM: x86: Add IBPB support
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, Ashok Raj
 <ashok.raj@intel.com>, Asit Mallick <asit.k.mallick@intel.com>,
 Dave Hansen <dave.hansen@intel.com>,
 Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dan Williams
 <dan.j.williams@intel.com>, Jun Nakajima <jun.nakajima@intel.com>,
 Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-3-git-send-email-karahmed@amazon.de>
 <20180202174932.GR28192@char.us.oracle.com>
 <1517594544.31953.62.camel@infradead.org>
 <20180202195601.GD28192@char.us.oracle.com>
 <1517602575.31953.74.camel@infradead.org>
 <20180202202857.GI28192@char.us.oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5fae597b-c70e-1610-165e-5afc3ec996a9@redhat.com>
Date: Mon, 5 Feb 2018 20:24:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180202202857.GI28192@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1591590150414702217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/2018 21:28, Konrad Rzeszutek Wilk wrote:
>>>> Nothing would *set* the IBPB bit though, since that's a "virtual" bit
>>>> on Intel hardware. The comment explains why we have that |= F(IBPB),
>>>> and if the comment wasn't true, we wouldn't need that code either.
>>> But this seems wrong. That is on Intel CPUs we will advertise on
>>> AMD leaf that the IBPB feature is available.
>>>
>>> Shouldn't we just check to see if the machine is AMD before advertising
>>> this bit?
>> No. The AMD feature bits give us more fine-grained support for exposing
>> IBPB or IBRS alone, so we expose those bits on Intel too.
> But but.. that runs smack against the idea of exposing a platform that
> is as close to emulating the real hardware as possible.
> 
> As in I would never expect an Intel CPU to expose the IBPB on the 0x8000_0008
> leaf. Hence KVM (nor any hypervisor) should not do it either.

This is KVM_GET_*SUPPORTED*_CPUID.  The actual CPUID bits that are
exposed (and also which CPUID leafs are there, even though this one is
present in both Intel and AMD) are determined by userspace.

Paolo
