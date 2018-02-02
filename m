Return-Path: <jmattson@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517592922; cv=none;
        d=google.com; s=arc-20160816;
        b=jITd1IMdotVNmFDCeXCR3CqNj13VxpjPKXKwCOaCBmdr8e9VSTmfe1iXhdHVCjSg9j
         L4ax9mLXEL2Kteb9FPw6VRB3WCE7R1sXCgCV5Bb3dd4FBQpM4jFJeWDBK9tPbDhFZ1ev
         T/XXdOhQtduOP4VNssWcRyf4pFE1zPQV2CTuyGRLa9/kr4+ORYMfyy/Ec/+q0fWDzlYa
         jU6ISAo7uIqQGzeBCwtC55QsSsDJxsvihQ/YPsdlVRWi49qWxcHsPG6tePHzjoSucTcG
         mPT/xuUymRXJpZh44+CeBfunfJNapdImqzFBz3kONAdRdJfvZpKksrhUaKBVLWoSqoZj
         d5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=NPTuXtqcCeuZnAHH5+ZN8QFaSGwL1V4uhAMQF3YtdCM=;
        b=YQJrFpdxTJIp/w5/+BUqBZKbM9NbosNd3f2A0CSjBBq0h1DPgmwKp6C22nQdOsPd9d
         ViytIsSCWomfPWnhdqAQ4oO3nzhptuKYC7IyhCbltBuxaYXtkGK6wBgrM1KadvLapMET
         OavHcK8lyQMQ+cm9L5FgKQwDZ7II/1w0pehAk/MTf83N2ZUubRKtCJ/8lfer7hT3Cq8I
         7PDYTk/ygk0bIcGVuYnnNrEMi7Q01ph+r5ycHIziRWeTMhA64xWyjW8mLiOr+zVi92ZI
         RRSB9w3l99IvmcVRO8x7/udK+F2XS6w1nvpcwPDfoSA4NfOK4ghivP4RlU5eQcA8A52v
         lcYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=neEadrsX;
       spf=pass (google.com: domain of jmattson@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jmattson@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=neEadrsX;
       spf=pass (google.com: domain of jmattson@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jmattson@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x225F37BX85wiwFDtZpUcxorG1eAhI1paMzt3Iv41NqNy4LuqgKyLXM3EIS5lA1EjwsP4edpz2h7U/t+AUgxyp3g=
MIME-Version: 1.0
In-Reply-To: <20180202105326.v53jv7ry4yd6icm4@starbug-vm.ie.oracle.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-4-git-send-email-karahmed@amazon.de> <20180202105326.v53jv7ry4yd6icm4@starbug-vm.ie.oracle.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 2 Feb 2018 09:35:20 -0800
Message-ID: <CALMp9eQyU+XBdtMiRQjv5UjWNbQED36hRJcYSmZL=f3D2=y54Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] KVM: VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
To: KarimAllah Ahmed <karahmed@amazon.de>, kvm list <kvm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>,
	Asit Mallick <asit.k.mallick@intel.com>, Dave Hansen <dave.hansen@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>, Jun Nakajima <jun.nakajima@intel.com>,
	Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Ashok Raj <ashok.raj@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582262223506?=
X-GMAIL-MSGID: =?utf-8?q?1591311516619359221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 2, 2018 at 2:53 AM, Darren Kenny <darren.kenny@oracle.com> wrote:
> On Thu, Feb 01, 2018 at 10:59:44PM +0100, KarimAllah Ahmed wrote:
>>
>> Intel processors use MSR_IA32_ARCH_CAPABILITIES MSR to indicate RDCL_NO
>> (bit 0) and IBRS_ALL (bit 1). This is a read-only MSR. By default the
>> contents will come directly from the hardware, but user-space can still
>> override it.
>>
>> [dwmw2: The bit in kvm_cpuid_7_0_edx_x86_features can be unconditional]
>>
>> Cc: Asit Mallick <asit.k.mallick@intel.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Jun Nakajima <jun.nakajima@intel.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Greg KH <gregkh@linuxfoundation.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>
>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Reviewed-by: Jim Mattson <jmattson@google.com>
