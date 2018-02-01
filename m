Return-Path: <prvs=5630c6a94=karahmed@amazon.com>
X-Google-Smtp-Source: AH8x22552ojZ0gyNSATiNGUswSaAY8a81krz5JO+q3M9ukwj/J8mmD2gEGgDZ9UPwr3NZeqpUxqE
ARC-Seal: i=1; a=rsa-sha256; t=1517522418; cv=none;
        d=google.com; s=arc-20160816;
        b=zhJW/Rw5FKZKV60ulp9rpBNmVWk8gLYdYUHm2Xm0RhTw4VQAW8UQ2fgmcUori1gzX7
         TL4uHMZnHVbkges3+dCPkp6l9wMMHzUD276CSItwGpDAd4Bjd6Wq0x0ZX0RVoGGZLhg8
         wKP5Euguu4MbgK+csxq81pFrmxj/zB6bLZy/EnbKhdyT94mxuA+/p5H4oUpCswvkZk1n
         c5YmFiBn+bdc2SqDPAWZ8GMSttGn47XYeX2qQp8VCt0FDvaEJACmaPjA54jBqQgbEAVP
         TEFZDNzwgPzw+6y0X3vgnTtYf0MO+vb1Y20Ivtp6mPM9DDz7McO4xG07QvcEXm/gHV8g
         CJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=v0N5CNrn+WkdiBle+tOxzmx4vkF0rt9kXDz9bdj9A2M=;
        b=rNO9fRXXzaru5Mcscpdn38YcyvTCHPmlXK0bueS5kZlqM6tSTscn9cZvTThJ5W22kB
         Gw2SKxuKmHeYEoB6o216LrW4Is/5DScV0OWII4XTugZVa1Gz0QmbXGWYFwSAbo1vbn0W
         kTsgUtTpwVgtwDejn1ZdHSPQM8F7eIOe2gY3u0Vd74ZVqwqodzNzefCPMuIYHRgx3Xs6
         BcXXz08IMsl8i6ytDGZB6mZ8xX+AKAt/PyXXypt24S70iyEZBqZoEfUeF+LLI5SiAPyV
         jlfmvYe3LRjyOh7vmtSJEkxAW5jb07m7vFJ9P+1demt8zHFHvEt2sPHguRJl9R9NaJoA
         JuLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.de header.s=amazon201209 header.b=PxaCqByJ;
       spf=pass (google.com: domain of prvs=5630c6a94=karahmed@amazon.com designates 207.171.184.29 as permitted sender) smtp.mailfrom=prvs=5630c6a94=karahmed@amazon.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.de
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.de header.s=amazon201209 header.b=PxaCqByJ;
       spf=pass (google.com: domain of prvs=5630c6a94=karahmed@amazon.com designates 207.171.184.29 as permitted sender) smtp.mailfrom=prvs=5630c6a94=karahmed@amazon.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.de
X-IronPort-AV: E=Sophos;i="5.46,444,1511827200";
   d="scan'208";a="592233230"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>, Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>, Borislav Petkov <bp@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Jun Nakajima <jun.nakajima@intel.com>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v6 0/5] KVM: Expose speculation control feature to guests
Date: Thu,  1 Feb 2018 22:59:41 +0100
Message-Id: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237587427068697?=
X-GMAIL-MSGID: =?utf-8?q?1591237587427068697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add direct access to speculation control MSRs for KVM guests. This allows the
guest to protect itself against Spectre V2 using IBRS+IBPB instead of a
retpoline+IBPB based approach.

It also exposes the ARCH_CAPABILITIES MSR which is used by Intel processors to
indicate RDCL_NO and IBRS_ALL.

Keep in mind that the SVM part of the patch is unchanged this time. Mostly to
get feedback/confirmation about the nested handling for VMX first, once this is
done I will update SVM as well.

v6:
- Do not penalize (save/restore IBRS) all L2 guests when anyone of them starts
  using the SPEC_CTRL.

v5:
- svm: add PRED_CMD and SPEC_CTRL to direct_access_msrs list.
- vmx: check also for X86_FEATURE_SPEC_CTRL for msr reads and writes.
- vmx: Use MSR_TYPE_W instead of MSR_TYPE_R for the nested IBPB MSR
- rewrite commit message for IBPB patch [2/5] (Ashok)

v4:
- Add IBRS passthrough for SVM (5/5).
- Handle nested guests properly.
- expose F(IBRS) in kvm_cpuid_8000_0008_ebx_x86_features

Ashok Raj (1):
  KVM: x86: Add IBPB support

KarimAllah Ahmed (4):
  KVM: x86: Update the reverse_cpuid list to include CPUID_7_EDX
  KVM: VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
  KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL
  KVM: SVM: Allow direct access to MSR_IA32_SPEC_CTRL

 arch/x86/kvm/cpuid.c |  22 ++++--
 arch/x86/kvm/cpuid.h |   1 +
 arch/x86/kvm/svm.c   |  87 +++++++++++++++++++++++
 arch/x86/kvm/vmx.c   | 196 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c   |   1 +
 5 files changed, 299 insertions(+), 8 deletions(-)

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org

-- 
2.7.4
