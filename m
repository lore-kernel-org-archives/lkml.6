Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeC0CNI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 22:13:08 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37031 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeC0CNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 22:13:06 -0400
X-Google-Smtp-Source: AIpwx492Hs9ZVruIr+Y7rgacRn/RR+teScc4u0LrEx938E6FX+MmeNx8t+FFn0tdaogXAuLs1DHTPQ==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH 0/2] KVM: VMX: Add Force Emulation Prefix for "emulate the next instruction"
Date: Mon, 26 Mar 2018 19:12:13 -0700
Message-Id: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a Force Emulation Prefix (ud2a; .ascii "kvm") 
for "emulate the next instruction", the codes will be executed by emulator 
instead of processor, for testing purposes.

A testcase here:

#include <stdio.h>
#include <string.h>
   
#define HYPERVISOR_INFO 0x40000000
   
#define CPUID(idx, eax, ebx, ecx, edx)\
    asm volatile (\
    "ud2a; .ascii \"kvm\"; 1: cpuid" \
    :"=b" (*ebx), "=a" (*eax),"=c" (*ecx), "=d" (*edx)\
        :"0"(idx) );  
   
void main()  
{  
	unsigned int eax,ebx,ecx,edx;  
	char string[13];  
   
	CPUID(HYPERVISOR_INFO, &eax, &ebx, &ecx, &edx);  
	*(unsigned int *)(string+0) = ebx;  
	*(unsigned int *)(string+4) = ecx;  
	*(unsigned int *)(string+8) = edx;  
   
	string[12] = 0;  
	if (strncmp(string, "KVMKVMKVM\0\0\0",12) == 0)
		printf("kvm guest\n");  
	else  
		printf("bare hardware\n");  
}

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>

Wanpeng Li (2):
  KVM: VMX: Introduce handle_ud()
  KVM: VMX: Add Force Emulation Prefix for "emulate the next instruction"

 arch/x86/kvm/vmx.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

-- 
2.7.4
