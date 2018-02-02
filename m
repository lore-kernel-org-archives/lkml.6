Return-Path: <jmattson@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517594255; cv=none;
        d=google.com; s=arc-20160816;
        b=D0aJYDivUjAa5/JkA5PuiNO191umAFwgf73H+qLNTemtYiOVSLkT/QrM32UMrYrEVS
         xOykUB1OPnfDuCNx/KhU9behwtz9c/tuGXyvvRSjLrOn9nUvDsKtQ2HsjYaTS2aCWrHi
         o1tEuVTNGcN4780jpEl2Rc2MHi4NCBkNAj2V+M3RuwnlEGJYJ99IUBnVf+/gHMQlhmnU
         9vn9Y9vfM7x61NlrvgSMotlptb32WIS47TYfbizY36fgcL7xeki1gP9sRW61ny3IXWw0
         7UJlxEpZ10B1T1fCLj3m5GlUwLJ6VDp3/Wp64440ocIcJziAzWGeLWshKCmHOYA4zZ9Z
         LjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=uUX8ChOe5auxpLm1SScFHrEGfIYnayqmOeshWRSAoIA=;
        b=sK7/MyPvfu/vDjOB2BjwIS5k4vVYk2KHl5dfj22eI6O4wjWMddtRZdKXarBQ+H/W1V
         oMfhnqVQBwVPIGXvGIcSCv72TE8qsq8/fjZeiSFTAXd3gDFwRN3Bynd0gtINxOkMXrIL
         DdvcgpFV6+w2sIv3KtNANo9JX4yAPnTIRMxytCR5lFNDs5WJGzFQ51a+/kZBczKAeBKr
         sLB5mfpG9KQ7QzMC7bSVE7CA9/dFehxX0X6swqTX6ucOQNWRP1cIpylWzVds58l6FARA
         CqSRf7XGUBHynAXVMffWjr+lM5fQ8me4YbcWijIMFVrtV9MxILmkiqSCUKwSZSkHDjvK
         GjuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=liOil1K7;
       spf=pass (google.com: domain of jmattson@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jmattson@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=liOil1K7;
       spf=pass (google.com: domain of jmattson@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jmattson@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x2276kEYVnV97n2UpU5/38IaBuIQljanNLyr+/Uw9VBGVxumNi0HUpV5yzucE6cKBBQjX6iOJJknWgJHgmWiI9Ys=
MIME-Version: 1.0
In-Reply-To: <1517522386-18410-5-git-send-email-karahmed@amazon.de>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de> <1517522386-18410-5-git-send-email-karahmed@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 2 Feb 2018 09:57:34 -0800
Message-ID: <CALMp9eR5vaMPKVRftRWaxVyBp8sZpgeGjKPHZjt-WvMpVESgcw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"the arch/x86 maintainers" <x86@kernel.org>, Asit Mallick <asit.k.mallick@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>, Dave Hansen <dave.hansen@intel.com>,
	Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Dan Williams <dan.j.williams@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>, Greg KH <gregkh@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237580461918240?=
X-GMAIL-MSGID: =?utf-8?q?1591312913961169749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 1, 2018 at 1:59 PM, KarimAllah Ahmed <karahmed@amazon.de> wrote:
> [ Based on a patch from Ashok Raj <ashok.raj@intel.com> ]
>
> Add direct access to MSR_IA32_SPEC_CTRL for guests. This is needed for
> guests that will only mitigate Spectre V2 through IBRS+IBPB and will not
> be using a retpoline+IBPB based approach.
>
> To avoid the overhead of saving and restoring the MSR_IA32_SPEC_CTRL for
> guests that do not actually use the MSR, only start saving and restoring
> when a non-zero is written to it.
>
> No attempt is made to handle STIBP here, intentionally. Filtering STIBP
> may be added in a future patch, which may require trapping all writes
> if we don't want to pass it through directly to the guest.
>
> [dwmw2: Clean up CPUID bits, save/restore manually, handle reset]
>
> Cc: Asit Mallick <asit.k.mallick@intel.com>
> Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jun Nakajima <jun.nakajima@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Jim Mattson <jmattson@google.com>
