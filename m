Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbeBEStO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:49:14 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14366 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbeBESsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:48:55 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="718190591"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 00/12] KVM/X86: Introduce a new guest mapping API
Date: Mon,  5 Feb 2018 19:47:19 +0100
Message-Id: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest memory can either be directly managed by the kernel (i.e. have a "struct
page") or they can simply live outside kernel control (i.e. do not have a
"struct page"). KVM mostly support these two modes, except in a few places
where the code seems to assume that guest memory must have a "struct page".

This patchset introduces a new mapping function to map guest memory into host
kernel memory. Ideally I should also get rid of all guest mapping functions
that end up converting a guest address to a page, but I decided to get feedback
on this first and see if this is an acceptable API.

Most of the offending code paths that has been updated are in the nested code
base. Mostly because I stumbled upon this code while looking at the nested MSR
bitmap handling for the IBRS patches. There are also offending code paths in
SVM code, but I will do that once the interface is accepted.

KarimAllah Ahmed (12):
  KVM: Introduce helper functions to map/unmap guest memory
  KVM/VMX: Use the new host mapping API for apic_access_page
  KVM/VMX: Use the new host mapping API for virtual_apic_page
  KVM/VMX: Use the new host mapping API for pi_desc_page
  KVM/VMX: Use the new host mapping API for mapping nested vmptr
  KVM/VMX: Use the new host mapping API for handle_vmptrld
  KVM/VMX: Use the new host mapping API for mapping L12 MSR bitmap
  KVM/VMX: Use the new host mapping API for mapping nested PML
  KVM/VMX: Use the new host mapping API for cmpxchg_emulated
  KVM/VMX: Use the new host mapping API for synic_clear_sint_msg_pending
  KVM/VMX: Use the new host mapping API for synic_deliver_msg
  KVM/VMX: Remove kvm_vcpu_gpa_to_page as it is now unused

 arch/x86/kvm/hyperv.c    |  24 +++----
 arch/x86/kvm/vmx.c       | 159 ++++++++++++++++++++---------------------------
 arch/x86/kvm/x86.c       |  12 ++--
 include/linux/kvm_host.h |  18 +++++-
 virt/kvm/kvm_main.c      |  62 ++++++++++++++++++
 5 files changed, 161 insertions(+), 114 deletions(-)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

-- 
2.7.4
