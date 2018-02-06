Return-Path: <prvs=568fb9cde=dwmw@amazon.com>
X-Google-Smtp-Source: AH8x225PjBFuPMokw4oSdpB2NmsW0YS27h8KeaWhs8IoI5ltcr214TgSXx6rK5dX2i6TH24ULDy8
ARC-Seal: i=1; a=rsa-sha256; t=1517938191; cv=none;
        d=google.com; s=arc-20160816;
        b=E9fRvx8UFIskbBUjG0rEbYxNEk2aCmga856EXJqbLN/SX30uB+bm4qGdg0aa2tVTIP
         t9T7T7wfRHv3rnQhzLaunuB2sEnw2JHUwaAyYC8NJG4F18+wFlswAtM8inXCuxRs3I08
         xDzNzAgRUc2hReLdbzk2H75W+Xrje+4cnfwU5jSqbylj0gqmVmERrLNYC/m/pK8Qog9Y
         aEYqJUp67v3LKKh77IXTk4lOGggU7QEMZnHzdJhJLjL5gLsEFbNKTS6C+8fEuw0ev7mE
         DiMejRPZHP1kMyRweWtlR2kHKfrHiVPfDCS+eOglr62sJJIkOjrJIPXD6hAS9VoSOUgN
         REKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:dkim-signature:arc-authentication-results;
        bh=CBxfhD/ajm9qU8EFYMN0IVzZbrA8QyBXe4TWEHVxevY=;
        b=ZA88CZmyhStfRK7QH3e0FJaxZ67XlORmM8KZZwqJsg4Teh/MXftytUTiKvFC5TTrNR
         BMPtw+3EHtfwq6VJn+wKw8v/m6A66qWBQiEo3Q+GLoKgYYZCbqqq8xcQLVwBGS3slaTj
         qzuIzTwTjVtDqqV5GSSOs9RWKrZOw5RgGtLm3615qurrvNwcNcnMW321x6Zt3KkVP2dC
         vB6Usw/MgjF4dCiGCbUiZsPT2qB7YEEUA6N6fWOBAnrey6oLCTkakaEiyt6L4H6wsXFq
         IVykl3OwMZZTkKDSfCcaVW5LkIi2Bvsn1xyREi/x/jqXBuYglroIUs9QH4RsUy/nmq4B
         1asA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.co.uk header.s=amazon201209 header.b=Fn11aCAe;
       spf=pass (google.com: domain of prvs=568fb9cde=dwmw@amazon.com designates 52.95.48.154 as permitted sender) smtp.mailfrom=prvs=568fb9cde=dwmw@amazon.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.co.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.co.uk header.s=amazon201209 header.b=Fn11aCAe;
       spf=pass (google.com: domain of prvs=568fb9cde=dwmw@amazon.com designates 52.95.48.154 as permitted sender) smtp.mailfrom=prvs=568fb9cde=dwmw@amazon.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.co.uk
X-IronPort-AV: E=Sophos;i="5.46,469,1511827200";
   d="scan'208";a="330925114"
From: David Woodhouse <dwmw@amazon.co.uk>
To: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: [STABLE 4.9.y PATCH 0/9] Backport of KVM Speculation Control support
Date: Tue,  6 Feb 2018 17:29:32 +0000
Message-Id: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591673557127781452?=
X-GMAIL-MSGID: =?utf-8?q?1591673557127781452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I've put together a linux-4.9.y branch at 
http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y

Most of it is fairly straightforward, apart from the IBPB on context 
switch for which Tim has already posted a candidate. I wanted some more
review on my backports of the KVM bits though, including some extra
historical patches I pulled in.

Ashok Raj (1):
  KVM/x86: Add IBPB support

David Hildenbrand (1):
  KVM: nVMX: vmx_complete_nested_posted_interrupt() can't fail

David Matlack (1):
  KVM: nVMX: mark vmcs12 pages dirty on L2 exit

Jim Mattson (1):
  KVM: nVMX: Eliminate vmcs02 pool

KarimAllah Ahmed (3):
  KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
  KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL
  KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL

Paolo Bonzini (2):
  KVM: VMX: introduce alloc_loaded_vmcs
  KVM: VMX: make MSR bitmaps per-VCPU

 arch/x86/kvm/cpuid.c |  21 +-
 arch/x86/kvm/cpuid.h |  31 +++
 arch/x86/kvm/svm.c   | 116 ++++++++
 arch/x86/kvm/vmx.c   | 730 +++++++++++++++++++++++++++------------------------
 arch/x86/kvm/x86.c   |   1 +
 5 files changed, 554 insertions(+), 345 deletions(-)

-- 
2.7.4
