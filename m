Return-Path: <jmattson@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518752666; cv=none;
        d=google.com; s=arc-20160816;
        b=BVV0E/kNVME/z70L3+g67dqhIT5it0tS2EDIsO1qcLBvBhFEOI+SzG2G042tza6pqu
         nNKamB9W6p8tmbkJixdCDK1OdGXpA6RKNrJZ/kArbwGBmlKbzqyuN0Z1G5/X33CQNgAm
         xdjlhiBXUcfEoanR3e3Jd2M9nAGBZ8ZpZKE+2SUt8Ohc2awitoP5WiOdzbTn5KBf4NKz
         w9X/40nI2kCaXVxPydWUqp2J0oetn6yl6BeuOoENB9knjV50qvq+GodJz+vTqRGUXvZZ
         q9mNQf0JJjB86JQu5RGu8U13TVKfsxr+nzih3UGUfsuBlEbMOs0b4UdIJ6+gbrpDyaJw
         FhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=cdjXba4UFcFe11E08OGZ7ic9p58PMQNAcUu7XClCMwg=;
        b=ICExN18qIBBEWaJx/ny2M05sf2Lm2TWgbFpzXsOoRNws7/roL8EkO4n5RcLbyp8JR6
         F5l8o6EcZ0OCbEtuiB0QaukyivGaeafhXaJCFrRe92IVlXbfihakpJT6Ll2fo4gZvdcf
         BkAgwTAh4airk7S2Wq/Y4SzeX24XKIj7Gx9LKpPMDDAUnF+X7+Z/n+704/J74ITf9l/a
         zi3d85vFHbTpulScLOGzQTbWxGRxWLex7fgjmRnOYrjiWsjE4iXeI+EQc9C1ES+3Jshq
         hJYqZRZqin3PDncFDBl32ZAD0v0AO4V4KUX/vuO9ZeamCDhQenfYxtkQP+ArOXO3U36m
         Lkww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=r76kCtOi;
       spf=pass (google.com: domain of jmattson@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jmattson@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=r76kCtOi;
       spf=pass (google.com: domain of jmattson@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jmattson@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x224XKiTtYILXlGzkgr46F8JEiALi9ddr9B6jiUKpvEHEZXm9YD+CbAZIY+RAh+oVhn+JTdZZU9jT/Bi1YzalYWI=
MIME-Version: 1.0
In-Reply-To: <1517522386-18410-3-git-send-email-karahmed@amazon.de>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de> <1517522386-18410-3-git-send-email-karahmed@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Feb 2018 19:44:25 -0800
Message-ID: <CALMp9eQEjaaK=RDZ3OFL5+fq78nWRrpVO-KJ8ruosV9vWjfW6g@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] KVM: x86: Add IBPB support
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"the arch/x86 maintainers" <x86@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
	Asit Mallick <asit.k.mallick@intel.com>, Dave Hansen <dave.hansen@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>, Jun Nakajima <jun.nakajima@intel.com>,
	Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1592527595864021020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 1, 2018 at 1:59 PM, KarimAllah Ahmed <karahmed@amazon.de> wrote:

> @@ -3684,6 +3696,22 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>         case MSR_IA32_TSC:
>                 kvm_write_tsc(vcpu, msr);
>                 break;
> +       case MSR_IA32_PRED_CMD:
> +               if (!msr->host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_IBPB))
> +                       return 1;
> +
> +               if (data & ~PRED_CMD_IBPB)
> +                       return 1;
> +
> +               if (!data)
> +                       break;
> +
> +               wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);

Should this be wrmsrl_safe? I don't see where we've verified host
support of this MSR.

> @@ -3342,6 +3369,34 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>         case MSR_IA32_TSC:
>                 kvm_write_tsc(vcpu, msr_info);
>                 break;
> +       case MSR_IA32_PRED_CMD:
> +               if (!msr_info->host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_IBPB) &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
> +                       return 1;
> +
> +               if (data & ~PRED_CMD_IBPB)
> +                       return 1;
> +
> +               if (!data)
> +                       break;
> +
> +               wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);

And here too...wrmsrl_safe?
