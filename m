Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E7AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC476214E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ZaaAFtT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC476214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeLCJbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:31:48 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:18951 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLCJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543829492; x=1575365492;
  h=from:to:cc:subject:date:message-id;
  bh=pEbvu2wGMelkIqGN51jd58vwSxnPNRF8SGOTgQHnSpE=;
  b=ZaaAFtT2IrCp9eOxEtgIS398ZKOe7+WH8VYnTiRwluLmN5id0D32AEDB
   TGkSsTjX2t6EfhFCSchZ/VwVEwXeGhlDJOFfLvVxCwajbZ6bex9Ls6E/v
   unBCMJXKBkjOlMmyWOMIGEjRBDzmut8loBcazZrEeKg4ibt2SMqc3SDzW
   0=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="773724670"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Dec 2018 09:31:29 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wB39VOuf107956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 3 Dec 2018 09:31:26 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wB39VMIS018105;
        Mon, 3 Dec 2018 10:31:22 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id wB39VMZd018101;
        Mon, 3 Dec 2018 10:31:22 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     rkrcmar@redhat.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v4 00/14] KVM/X86: Introduce a new guest mapping interface
Date:   Mon,  3 Dec 2018 10:30:53 +0100
Message-Id: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
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
read/write directly from guest memory.

As far as I can see all offending code is now fixed except the APIC-access page
which I will handle in a seperate series along with dropping
kvm_vcpu_gfn_to_page and kvm_vcpu_gpa_to_page from the internal KVM API.

The current implementation of the new API uses memremap to map memory that does
not have a "struct page". This proves to be very slow for high frequency
mappings. Since this does not affect the normal use-case where a "struct page"
is available, the performance of this API will be handled by a seperate patch
series.

v3 -> v4:
- Rebase
- Add a new patch to also fix the newly introduced enhanced VMCS.

v2 -> v3:
- Rebase
- Add a new patch to also fix the newly introduced shadow VMCS.

Filippo Sironi (1):
  X86/KVM: Handle PFNs outside of kernel reach when touching GPTEs

KarimAllah Ahmed (13):
  X86/nVMX: handle_vmon: Read 4 bytes from guest memory
  X86/nVMX: handle_vmptrld: Copy the VMCS12 directly from guest memory
  X86/nVMX: Update the PML table without mapping and unmapping the page
  KVM: Introduce a new guest mapping API
  KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
  KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
  KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt
    descriptor table
  KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
  KVM/X86: hyperv: Use kvm_vcpu_map in synic_clear_sint_msg_pending
  KVM/X86: hyperv: Use kvm_vcpu_map in synic_deliver_msg
  KVM/nSVM: Use the new mapping API for mapping guest memory
  KVM/nVMX: Use kvm_vcpu_map for accessing the shadow VMCS
  KVM/nVMX: Use kvm_vcpu_map for accessing the enhanced VMCS

 arch/x86/kvm/hyperv.c      |  28 +++----
 arch/x86/kvm/paging_tmpl.h |  38 ++++++---
 arch/x86/kvm/svm.c         |  97 +++++++++++------------
 arch/x86/kvm/vmx.c         | 189 +++++++++++++++++----------------------------
 arch/x86/kvm/x86.c         |  13 ++--
 include/linux/kvm_host.h   |   9 +++
 virt/kvm/kvm_main.c        |  50 ++++++++++++
 7 files changed, 228 insertions(+), 196 deletions(-)

-- 
2.7.4

