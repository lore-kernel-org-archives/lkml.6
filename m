Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvksaLE6HAfhrnWw6582K/veUyh6pY/lICZneT55BBBwwAOMyZ+AtRlbnUQQGC0kdiToz+5
ARC-Seal: i=1; a=rsa-sha256; t=1520641421; cv=none;
        d=google.com; s=arc-20160816;
        b=PLjQNPhng5Krx13tz1Dmeans1R5mm8aYBOJeC5W0uXzYPb7MUnj8j7dcRgDpA6QM+P
         Ix/F8A+NnxnMr7icmpn4pl3PCpoNEB4F3xpdSMIveK9Ruy2GRR5cCJ7Nsv5XWiPPqTDU
         vAAq+p1cW/DQnUK+cdjuOPVQg4oSRZyDxaO1UCB1yoite8n4PG4Owg949GiJFeGYmQcO
         8jmEdbqSOPJoEfbs7uyCGgjKK1LxqNZB8rS4ENo2Gdnb83xFH2rzGyG21oKQ/I5WYmgP
         HzDmpNoXtwWlwEnMh76PNfhIjZsZJdW4+gvEm43jzyUZ2qq6letAH86f/gnovPSzhl5g
         WNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kYlEC0u6yZ4TvqvjP1+AOJWPSPEZ9pQyy/HAJZ50TRk=;
        b=YCDos71f4kB5SvB2LO9BgOM8fUaixwk5GRlGLHoK1OcIxymm3XYDAXTPcG+4SPX5B/
         oSMTn28yMX5CRtwn7a/JRA6WMwkd4eUKqAWOGOvLqtu0Bm6fZSZa9zdXWO1XvmqDfrHs
         1tOYSr55uaaNJ6ehq+IiCO8iCx0pYGjKeNsdEoygyv+4tX4Hh6ssNMHG2GdXWJ0/67CG
         ewLauES6tO86+UbMM6+8EpTWY+wfX2qyJdnrXUpYLoToIYAUiD0f5YE9I6+NiPOYPR0y
         r2F7Hlubfsao3oICG5cl3l+Ys6UN7ZDxr0G/O6Tg6eIb5JejsB3MXcBcD0kC0B2GEd9i
         LaMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wanpeng Li <wanpengli@tencent.com>,
	David Hildenbrand <david@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.15 11/11] KVM: x86: fix backward migration with async_PF
Date: Fri,  9 Mar 2018 16:19:25 -0800
Message-Id: <20180310001835.172970815@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001834.560857664@linuxfoundation.org>
References: <20180310001834.560857664@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508090342902873?=
X-GMAIL-MSGID: =?utf-8?q?1594508098846170890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radim Krčmář <rkrcmar@redhat.com>

commit fe2a3027e74e40a3ece3a4c1e4e51403090a907a upstream.

Guests on new hypersiors might set KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT
bit when enabling async_PF, but this bit is reserved on old hypervisors,
which results in a failure upon migration.

To avoid breaking different cases, we are checking for CPUID feature bit
before enabling the feature and nothing else.

Fixes: 52a5c155cf79 ("KVM: async_pf: Let guest support delivery of async_pf from guest mode")
Cc: <stable@vger.kernel.org>
Reviewed-by: Wanpeng Li <wanpengli@tencent.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[jwang: port to 4.14]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/virtual/kvm/cpuid.txt  |    4 ++++
 Documentation/virtual/kvm/msr.txt    |    3 ++-
 arch/x86/include/uapi/asm/kvm_para.h |    1 +
 arch/x86/kernel/kvm.c                |    8 ++++----
 arch/x86/kvm/cpuid.c                 |    3 ++-
 5 files changed, 13 insertions(+), 6 deletions(-)

--- a/Documentation/virtual/kvm/cpuid.txt
+++ b/Documentation/virtual/kvm/cpuid.txt
@@ -54,6 +54,10 @@ KVM_FEATURE_PV_UNHALT              ||
                                    ||       || before enabling paravirtualized
                                    ||       || spinlock support.
 ------------------------------------------------------------------------------
+KVM_FEATURE_ASYNC_PF_VMEXIT        ||    10 || paravirtualized async PF VM exit
+                                   ||       || can be enabled by setting bit 2
+                                   ||       || when writing to msr 0x4b564d02
+------------------------------------------------------------------------------
 KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
                                    ||       || per-cpu warps are expected in
                                    ||       || kvmclock.
--- a/Documentation/virtual/kvm/msr.txt
+++ b/Documentation/virtual/kvm/msr.txt
@@ -170,7 +170,8 @@ MSR_KVM_ASYNC_PF_EN: 0x4b564d02
 	when asynchronous page faults are enabled on the vcpu 0 when
 	disabled. Bit 1 is 1 if asynchronous page faults can be injected
 	when vcpu is in cpl == 0. Bit 2 is 1 if asynchronous page faults
-	are delivered to L1 as #PF vmexits.
+	are delivered to L1 as #PF vmexits.  Bit 2 can be set only if
+	KVM_FEATURE_ASYNC_PF_VMEXIT is present in CPUID.
 
 	First 4 byte of 64 byte memory location will be written to by
 	the hypervisor at the time of asynchronous page fault (APF)
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -25,6 +25,7 @@
 #define KVM_FEATURE_STEAL_TIME		5
 #define KVM_FEATURE_PV_EOI		6
 #define KVM_FEATURE_PV_UNHALT		7
+#define KVM_FEATURE_ASYNC_PF_VMEXIT	10
 
 /* The last 8 bits are used to indicate how to interpret the flags field
  * in pvclock structure. If no bits are set, all flags are ignored.
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -341,10 +341,10 @@ static void kvm_guest_cpu_init(void)
 #endif
 		pa |= KVM_ASYNC_PF_ENABLED;
 
-		/* Async page fault support for L1 hypervisor is optional */
-		if (wrmsr_safe(MSR_KVM_ASYNC_PF_EN,
-			(pa | KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT) & 0xffffffff, pa >> 32) < 0)
-			wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
+		if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_VMEXIT))
+			pa |= KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
+
+		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
 		__this_cpu_write(apf_reason.enabled, 1);
 		printk(KERN_INFO"KVM setup async PF for cpu %d\n",
 		       smp_processor_id());
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -597,7 +597,8 @@ static inline int __do_cpuid_ent(struct
 			     (1 << KVM_FEATURE_ASYNC_PF) |
 			     (1 << KVM_FEATURE_PV_EOI) |
 			     (1 << KVM_FEATURE_CLOCKSOURCE_STABLE_BIT) |
-			     (1 << KVM_FEATURE_PV_UNHALT);
+			     (1 << KVM_FEATURE_PV_UNHALT) |
+			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT);
 
 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
