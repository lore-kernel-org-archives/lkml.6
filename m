Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2348BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9DB21473
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9DB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeHHSQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:16:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbeHHSQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:16:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7D0640216E7;
        Wed,  8 Aug 2018 15:55:56 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F4EC2166BA0;
        Wed,  8 Aug 2018 15:55:54 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v4 00/12] KVM: nVMX: Enlightened VMCS for Hyper-V on KVM
Date:   Wed,  8 Aug 2018 17:55:40 +0200
Message-Id: <20180808155552.4836-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 15:55:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 15:55:56 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
- Rebase to the current kvm/queue.
- Add nested state migration support [Paolo Bonzini]
- Add a selftest [Paolo Bonzini]

Patches 7-12 are new in v4.

Description:

This is an initial implementation of Enlightened VMCS for nested Hyper-V on
KVM. Using it helps to spare 1500 cpu cycles for nested vmexit (tight cpuid
loop in WS2016 with Hyper-V role on KVM: 15200 cycles -> 13700 cycles).

Ladi Prosek (1):
  KVM: hyperv: define VP assist page helpers

Vitaly Kuznetsov (11):
  KVM: VMX: refactor evmcs_sanitize_exec_ctrls()
  KVM: nVMX: add KVM_CAP_HYPERV_ENLIGHTENED_VMCS capability
  KVM: nVMX: add enlightened VMCS state
  KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
  KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case
  x86/kvm/hyperv: don't clear VP assist pages on init
  x86/kvm/lapic: preserve gfn_to_hva_cache len on cache reinit
  x86/kvm/nVMX: allow bare VMXON state migration
  x86/kvm/nVMX: nested state migration for Enlightened VMCS
  KVM: selftests: compile against local uapi headers
  KVM: selftests: add Enlightened VMCS test

 arch/x86/include/asm/kvm_host.h             |    3 +
 arch/x86/include/uapi/asm/kvm.h             |    1 +
 arch/x86/kvm/hyperv.c                       |   31 +-
 arch/x86/kvm/hyperv.h                       |    4 +
 arch/x86/kvm/lapic.c                        |   14 +-
 arch/x86/kvm/lapic.h                        |    2 +-
 arch/x86/kvm/svm.c                          |    9 +
 arch/x86/kvm/vmx.c                          |  886 +++++++++++++++++----
 arch/x86/kvm/x86.c                          |   23 +-
 include/uapi/linux/kvm.h                    |    1 +
 tools/testing/selftests/kvm/Makefile        |    3 +-
 tools/testing/selftests/kvm/evmcs_test.c    |  181 +++++
 tools/testing/selftests/kvm/include/evmcs.h | 1099 +++++++++++++++++++++++++++
 tools/testing/selftests/kvm/include/vmx.h   |   28 +
 tools/testing/selftests/kvm/lib/vmx.c       |   48 +-
 15 files changed, 2151 insertions(+), 182 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/evmcs_test.c
 create mode 100644 tools/testing/selftests/kvm/include/evmcs.h

-- 
2.14.4

