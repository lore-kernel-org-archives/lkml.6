Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A490ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCA320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCA320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbeGTOOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:14:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730825AbeGTOOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:14:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55B6181A4EA6;
        Fri, 20 Jul 2018 13:26:29 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-189.brq.redhat.com [10.40.204.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E77CF2026D69;
        Fri, 20 Jul 2018 13:26:27 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/7] x86/kvm/nVMX: optimize MMU switch between L1 and L2
Date:   Fri, 20 Jul 2018 15:26:19 +0200
Message-Id: <20180720132626.5975-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 13:26:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 13:26:29 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when we switch from L1 to L2 we do the following:
- Re-initialize L1 MMU as shadow EPT MMU (nested_ept_init_mmu_context())
- Re-initialize 'nested' MMU (nested_vmx_load_cr3() -> init_kvm_nested_mmu())
- Reload MMU root upon guest entry.

When we switch back we do:
- Re-initialize L1 MMU (nested_vmx_load_cr3() -> init_kvm_tdp_mmu())
- Reload MMU root upon guest entry.

This seems to be sub-optimal. Initializing MMU is expensive (thanks to
update_permission_bitmask(), update_pkru_bitmask(),..) and reloading MMU
root doesn't come for free.

Try to approach the issue by splitting L1-normal and L1-nested MMUs and
checking if MMU reset is really needed. This spares us about 1000 cpu
cycles on nested vmexit.

RFC part:
- Does this look like a plausible solution?
- SVM nested can probably be optimized in the same way.
- Doesn mmu_update_needed() cover everything?

Vitaly Kuznetsov (7):
  x86/kvm/mmu: make vcpu->mmu a pointer to the current MMU
  x86/kvm/mmu.c: set get_pdptr hook in kvm_init_shadow_ept_mmu()
  x86/kvm/mmu.c: add kvm_mmu parameter to kvm_mmu_free_roots()
  x86/kvm/mmu: introduce guest_mmu
  x86/kvm/mmu: get rid of redundant kvm_mmu_setup()
  x86/kvm/nVMX: introduce scache for kvm_init_shadow_ept_mmu
  x86/kvm/nVMX: optimize MMU switch from nested_vmx_load_cr3()

 arch/x86/include/asm/kvm_host.h |  36 ++++-
 arch/x86/kvm/cpuid.c            |   2 +-
 arch/x86/kvm/mmu.c              | 282 ++++++++++++++++++++++++++--------------
 arch/x86/kvm/mmu.h              |   2 +-
 arch/x86/kvm/mmu_audit.c        |  12 +-
 arch/x86/kvm/paging_tmpl.h      |  17 +--
 arch/x86/kvm/svm.c              |  20 +--
 arch/x86/kvm/vmx.c              |  52 +++++---
 arch/x86/kvm/x86.c              |  34 ++---
 9 files changed, 292 insertions(+), 165 deletions(-)

-- 
2.14.4

