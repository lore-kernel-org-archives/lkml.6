Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5744C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F34214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="GSctGjhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfAIJmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:42:23 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:6461 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbfAIJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547026940; x=1578562940;
  h=from:to:cc:subject:date:message-id;
  bh=dcSfptL6+xloYtIin3+WP6oU7QPChUtfZquybxIvKOo=;
  b=GSctGjhw/h9C6ppXvJNoG/CNwNlQ34Ns+EauXOXafBerewNw8hZ5SkY9
   krGzhLJyeZ5xDWTxC3RYTbNjVOlSyWH2MszOPDDLbC5Z8N6Lzc8OkI4mt
   YkZcEXhD0xUnXK9NSgPzguUKuCfEpWrhcHB6cX/dU5dVrH0xrnk/CuEBi
   U=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="712024354"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Jan 2019 09:42:19 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id E2B1DA1F2A;
        Wed,  9 Jan 2019 09:42:17 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x099gFtM031290;
        Wed, 9 Jan 2019 10:42:15 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x099gFYx031287;
        Wed, 9 Jan 2019 10:42:15 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v5 00/13] KVM/X86: Introduce a new guest mapping interface
Date:   Wed,  9 Jan 2019 10:42:00 +0100
Message-Id: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest memory can either be directly managed by the kernel (i.e. have a "struct
page") or they can simply live outside kernel control (i.e. do not have a
"struct page"). KVM mostly support these two modes, except in a few places
where the code seems to assume that guest memory must have a "struct page".

This patchset introduces a new mapping interface to map guest memory into host
kernel memory which also supports PFN-based memory (i.e. memory without 'struct
page'). It also converts all offending code to this interface or simply
read/write directly from guest memory. Patch 2 is additionally fixing an
incorrect page release and marking the page as dirty (i.e. as a side-effect of
using the helper function to write).

As far as I can see all offending code is now fixed except the APIC-access page
which I will handle in a seperate series along with dropping
kvm_vcpu_gfn_to_page and kvm_vcpu_gpa_to_page from the internal KVM API.

The current implementation of the new API uses memremap to map memory that does
not have a "struct page". This proves to be very slow for high frequency
mappings. Since this does not affect the normal use-case where a "struct page"
is available, the performance of this API will be handled by a seperate patch
series.

v4 -> v5:
- Introduce a new parameter 'dirty' into kvm_vcpu_unmap
- A horrible rebase due to nested.c :)
- Dropped a couple of hyperv patches as the code was fixed already as a
  side-effect of another patch.
- Added a new trivial cleanup patch.

v3 -> v4:
- Rebase
- Add a new patch to also fix the newly introduced enlightned VMCS.

v2 -> v3:
- Rebase
- Add a new patch to also fix the newly introduced shadow VMCS.

Filippo Sironi (1):
  X86/KVM: Handle PFNs outside of kernel reach when touching GPTEs

KarimAllah Ahmed (12):
  X86/nVMX: handle_vmon: Read 4 bytes from guest memory
  X86/nVMX: Update the PML table without mapping and unmapping the page
  KVM: Introduce a new guest mapping API
  X86/nVMX: handle_vmptrld: Use kvm_vcpu_map when copying VMCS12 from
    guest memory
  KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
  KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
  KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt
    descriptor table
  KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
  KVM/nSVM: Use the new mapping API for mapping guest memory
  KVM/nVMX: Use kvm_vcpu_map for accessing the shadow VMCS
  KVM/nVMX: Use kvm_vcpu_map for accessing the enlightened VMCS
  KVM/nVMX: Use page_address_valid in a few more locations

 arch/x86/kvm/paging_tmpl.h |  38 ++++++++---
 arch/x86/kvm/svm.c         |  97 +++++++++++++--------------
 arch/x86/kvm/vmx/nested.c  | 160 ++++++++++++++++-----------------------------
 arch/x86/kvm/vmx/vmx.c     |  19 ++----
 arch/x86/kvm/vmx/vmx.h     |   9 ++-
 arch/x86/kvm/x86.c         |  13 ++--
 include/linux/kvm_host.h   |   9 +++
 virt/kvm/kvm_main.c        |  53 +++++++++++++++
 8 files changed, 217 insertions(+), 181 deletions(-)

-- 
2.7.4

