Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9A6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D344A2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D344A2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJQAlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:41:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeJQAlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:41:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2195B308429C;
        Tue, 16 Oct 2018 16:50:15 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EBA4608EE;
        Tue, 16 Oct 2018 16:50:12 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v6 00/13] KVM: nVMX: Enlightened VMCS for Hyper-V on KVM
Date:   Tue, 16 Oct 2018 18:49:58 +0200
Message-Id: <20181016165011.6607-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 16 Oct 2018 16:50:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v5:
- Rebase to kvm/queue.
- Add "KVM: selftests: state_test: test bare VMXON migration" patch.

Original description:

This is an initial implementation of Enlightened VMCS for nested Hyper-V on
KVM. Using it helps to spare 1500 cpu cycles for nested vmexit (tight cpuid
loop in WS2016 with Hyper-V role on KVM: 15200 cycles -> 13700 cycles).

Ladi Prosek (1):
  KVM: hyperv: define VP assist page helpers

Vitaly Kuznetsov (12):
  KVM: VMX: refactor evmcs_sanitize_exec_ctrls()
  KVM: nVMX: add KVM_CAP_HYPERV_ENLIGHTENED_VMCS capability
  KVM: nVMX: add enlightened VMCS state
  KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
  KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case
  x86/kvm/hyperv: don't clear VP assist pages on init
  x86/kvm/lapic: preserve gfn_to_hva_cache len on cache reinit
  x86/kvm/nVMX: allow bare VMXON state migration
  KVM: selftests: state_test: test bare VMXON migration
  x86/kvm/nVMX: nested state migration for Enlightened VMCS
  tools/headers: update kvm.h
  KVM: selftests: add Enlightened VMCS test

 arch/x86/include/asm/kvm_host.h               |    3 +
 arch/x86/include/uapi/asm/kvm.h               |    1 +
 arch/x86/kvm/hyperv.c                         |   31 +-
 arch/x86/kvm/hyperv.h                         |    4 +
 arch/x86/kvm/lapic.c                          |   14 +-
 arch/x86/kvm/lapic.h                          |    2 +-
 arch/x86/kvm/svm.c                            |    9 +
 arch/x86/kvm/vmx.c                            |  887 ++++++++++---
 arch/x86/kvm/x86.c                            |   23 +-
 include/uapi/linux/kvm.h                      |    1 +
 tools/include/uapi/linux/kvm.h                |    5 +
 tools/testing/selftests/kvm/Makefile          |    1 +
 tools/testing/selftests/kvm/include/evmcs.h   | 1098 +++++++++++++++++
 .../selftests/kvm/include/x86_64/vmx.h        |   29 +
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  |   51 +-
 .../testing/selftests/kvm/x86_64/evmcs_test.c |  159 +++
 .../testing/selftests/kvm/x86_64/state_test.c |   22 +-
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |    1 +
 18 files changed, 2159 insertions(+), 182 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/evmcs.h
 create mode 100644 tools/testing/selftests/kvm/x86_64/evmcs_test.c

-- 
2.17.1

