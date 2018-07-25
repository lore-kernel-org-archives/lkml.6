Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA469C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C6720852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C6720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbeGYRn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:43:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728637AbeGYRn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:43:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BAE540241C8;
        Wed, 25 Jul 2018 16:31:02 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.205.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 365CF2166BA3;
        Wed, 25 Jul 2018 16:30:59 +0000 (UTC)
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
Subject: [PATCH v3 0/6] KVM: nVMX: Enlightened VMCS for Hyper-V on KVM
Date:   Wed, 25 Jul 2018 18:30:51 +0200
Message-Id: <20180725163057.13948-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 25 Jul 2018 16:31:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 25 Jul 2018 16:31:02 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
- Rebase to the current kvm/queue.
- Simplify clean fields check in prepare_vmcs02{,_full} and
  copy_enlightened_to_vmcs12() by resetting the clean fields mask in
  nested_vmx_handle_enlightened_vmptrld() when we switch from one L2 guest
  to another [Paolo Bonzini]
- Cope with the newly introduced vmx_get_nested_state() by returning
  -ENOTSUPP when eVMCS is in use. We'll do proper nested state save/restore
  later.

Description:

This is an initial implementation of Enlightened VMCS for nested Hyper-V on
KVM. Using it helps to spare 1500 cpu cycles for nested vmexit (tight cpuid
loop in WS2016 with Hyper-V role on KVM: 15200 cycles -> 13700 cycles).

Ladi Prosek (1):
  KVM: hyperv: define VP assist page helpers

Vitaly Kuznetsov (5):
  KVM: VMX: refactor evmcs_sanitize_exec_ctrls()
  KVM: nVMX: add KVM_CAP_HYPERV_ENLIGHTENED_VMCS capability
  KVM: nVMX: add enlightened VMCS state
  KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
  KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case

 arch/x86/include/asm/kvm_host.h |   3 +
 arch/x86/kvm/hyperv.c           |  23 +-
 arch/x86/kvm/hyperv.h           |   4 +
 arch/x86/kvm/lapic.c            |   4 +-
 arch/x86/kvm/lapic.h            |   2 +-
 arch/x86/kvm/svm.c              |   9 +
 arch/x86/kvm/vmx.c              | 824 +++++++++++++++++++++++++++++++++-------
 arch/x86/kvm/x86.c              |  17 +-
 include/uapi/linux/kvm.h        |   1 +
 9 files changed, 737 insertions(+), 150 deletions(-)

-- 
2.14.4

