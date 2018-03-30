Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeC3JHp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:07:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34572 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeC3JHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:07:37 -0400
X-Google-Smtp-Source: AIpwx48JXrP2jFq49AWsSoltdfHH1P/+aQDaj6/oeq3A//pO+zz51k67StITWpbkH0Hc84Zm2SaU6w==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v4 0/2] KVM: X86: Add Force Emulation Prefix for "emulate the next instruction"
Date: Fri, 30 Mar 2018 02:06:42 -0700
Message-Id: <1522400804-4578-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no easy way to force KVM to run an instruction through the emulator 
(by design as that will expose the x86 emulator as a significant attack-surface).
However, we do wish to expose the x86 emulator in case we are testing it
(e.g. via kvm-unit-tests). Therefore, this patch adds a "force emulation prefix"
that is designed to raise #UD which KVM will trap and it's #UD exit-handler will
match "force emulation prefix" to run instruction after prefix by the x86 emulator.
To not expose the x86 emulator by default, we add a module parameter that should 
be off by default.

A simple testcase here:

#include <stdio.h>
#include <string.h>
   
#define HYPERVISOR_INFO 0x40000000
   
#define CPUID(idx, eax, ebx, ecx, edx) \
    asm volatile ( \
    "ud2a; .ascii \"kvm\"; cpuid" \
    :"=b" (*ebx), "=a" (*eax), "=c" (*ecx), "=d" (*edx) \
        :"0"(idx) );  
   
void main()  
{  
	unsigned int eax, ebx, ecx, edx;  
	char string[13];  
   
	CPUID(HYPERVISOR_INFO, &eax, &ebx, &ecx, &edx);  
	*(unsigned int *)(string + 0) = ebx;  
	*(unsigned int *)(string + 4) = ecx;  
	*(unsigned int *)(string + 8) = edx;  
   
	string[12] = 0;  
	if (strncmp(string, "KVMKVMKVM\0\0\0", 12) == 0)
		printf("kvm guest\n");  
	else  
		printf("bare hardware\n");  
}

v3 -> v4:
 * forwarding emulation failure to userspace
v2 -> v3:
 * fix compile warning
v1 -> v2:
 * update patch descriptions
 * move handle_ud to x86.c, shared by vmx and svm
 * the parameter is in kvm module 
 * rename parameter to force_emulation_prefix

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Liran Alon <liran.alon@oracle.com>

Wanpeng Li (2):
  KVM: X86: Introduce handle_ud()
  KVM: X86: Add Force Emulation Prefix for "emulate the next instruction"

 arch/x86/kvm/svm.c |  9 +--------
 arch/x86/kvm/vmx.c | 10 ++--------
 arch/x86/kvm/x86.c | 28 ++++++++++++++++++++++++++++
 arch/x86/kvm/x86.h |  2 ++
 4 files changed, 33 insertions(+), 16 deletions(-)

-- 
2.7.4
