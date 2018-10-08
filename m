Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EE4C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48C52145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48C52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJICli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:41:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbeJICli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:41:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D4C13082E63;
        Mon,  8 Oct 2018 19:28:20 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.205.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A3BE612AB;
        Mon,  8 Oct 2018 19:28:16 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] x86/kvm/nVMX: optimize MMU switch between L1 and L2
Date:   Mon,  8 Oct 2018 21:28:04 +0200
Message-Id: <20181008192813.30624-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 08 Oct 2018 19:28:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v3 [Sean Christopherson]:
- Add Reviewed-by tags (thanks!).
- Drop stale role initializer in kvm_calc_shadow_ept_root_page_role
  (interim change in PATCH4, the end result is the same).
- Use '!!' instead of '!= 0' for kvm_read_cr4_bits() readings.

Also, rebased to the current kvm/queue.

Original description:

Currently, when we switch from L1 to L2 (VMX) we do the following:
- Re-initialize L1 MMU as shadow EPT MMU (nested_ept_init_mmu_context())
- Re-initialize 'nested' MMU (nested_vmx_load_cr3() -> init_kvm_nested_mmu())

When we switch back we do:
- Re-initialize L1 MMU (nested_vmx_load_cr3() -> init_kvm_tdp_mmu())

This seems to be sub-optimal. Initializing MMU is expensive (thanks to
update_permission_bitmask(), update_pkru_bitmask(),..) Try solving the
issue by splitting L1-normal and L1-nested MMUs and checking if MMU reset
is really needed. This spares us about 1000 cpu cycles on nested vmexit.

Brief look at SVM makes me think it can be optimized the exact same way,
I'll do this in a separate series.

Paolo Bonzini (1):
  x86/kvm/mmu: get rid of redundant kvm_mmu_setup()

Vitaly Kuznetsov (8):
  x86/kvm/mmu: make vcpu->mmu a pointer to the current MMU
  x86/kvm/mmu.c: set get_pdptr hook in kvm_init_shadow_ept_mmu()
  x86/kvm/mmu.c: add kvm_mmu parameter to kvm_mmu_free_roots()
  x86/kvm/mmu: introduce guest_mmu
  x86/kvm/mmu: make space for source data caching in struct kvm_mmu
  x86/kvm/nVMX: introduce source data cache for
    kvm_init_shadow_ept_mmu()
  x86/kvm/mmu: check if tdp/shadow MMU reconfiguration is needed
  x86/kvm/mmu: check if MMU reconfiguration is needed in
    init_kvm_nested_mmu()

 arch/x86/include/asm/kvm_host.h |  44 +++-
 arch/x86/kvm/mmu.c              | 357 +++++++++++++++++++-------------
 arch/x86/kvm/mmu.h              |   8 +-
 arch/x86/kvm/mmu_audit.c        |  12 +-
 arch/x86/kvm/paging_tmpl.h      |  15 +-
 arch/x86/kvm/svm.c              |  14 +-
 arch/x86/kvm/vmx.c              |  55 +++--
 arch/x86/kvm/x86.c              |  22 +-
 8 files changed, 322 insertions(+), 205 deletions(-)

-- 
2.17.1

