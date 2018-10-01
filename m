Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09574C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA576208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA576208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeJAU62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:58:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbeJAU61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:58:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 787EB8764A;
        Mon,  1 Oct 2018 14:20:25 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 002B36E52E;
        Mon,  1 Oct 2018 14:20:13 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] x86/kvm/nVMX: optimize MMU switch between L1 and L2
Date:   Mon,  1 Oct 2018 16:20:01 +0200
Message-Id: <20181001142010.21132-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 01 Oct 2018 14:20:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v2 [Sean Christopherson]:
- Add Reviewed-by tags (thanks!).
- Move get_pdptr setting to nested_ept_init_mmu_context().
- Move kvm_mmu_free_roots() call to nested_release_vmcs12().
- In kvm_calc_shadow_ept_root_page_role() we need to inherit role
  from root_mmu so fields like .smap_andnot_wp, .smep_andnot_wp, ...
  remain correctly initialized.
- Use u32 for base_role instead of unsigned int in kvm_mmu_pte_write
- Split kvm_calc_mmu_role_common() into kvm_calc_mmu_role_common() and
  kvm_calc_mmu_role_ext().
- Rename 'mmu_init' parameter to 'base_only'.

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

