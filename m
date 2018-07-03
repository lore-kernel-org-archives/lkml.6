Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44969C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BAC22464
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BAC22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753496AbeGCNmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:42:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753370AbeGCNmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:42:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B5BAC320;
        Tue,  3 Jul 2018 13:42:11 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CB42111AF02;
        Tue,  3 Jul 2018 13:42:07 +0000 (UTC)
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
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] KVM: x86: hyperv: PV IPI support for Windows guests
Date:   Tue,  3 Jul 2018 15:42:01 +0200
Message-Id: <20180703134206.27240-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 03 Jul 2018 13:42:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 03 Jul 2018 13:42:11 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3 [Roman Kagan]:
- Don't use vcpu_id in kvm_make_vcpus_request_mask to avoid dealing with
  sparse CPU masks.
- Create get_vcpu_idx_by_vpidx() and use it in get_vcpu_by_vpidx() and
  kvm_hv_flush_tlb().

Using hypercall for sending IPIs is faster because this allows to specify
any number of vCPUs (even > 64 with sparse CPU set), the whole procedure
will take only one VMEXIT.

Same as PV TLB flush, this allows Windows guests having > 64 vCPUs to boot
on KVM when Hyper-V extensions are enabled.

Vitaly Kuznetsov (5):
  KVM: x86: hyperv: enforce vp_index < KVM_MAX_VCPUS
  KVM: x86: hyperv: optimize 'all cpus' case in kvm_hv_flush_tlb()
  KVM: x86: hyperv: use get_vcpu_by_vpidx() in kvm_hv_flush_tlb()
  x86/hyper-v: rename ipi_arg_{ex,non_ex} structures
  KVM: x86: hyperv: implement PV IPI send hypercalls

 Documentation/virtual/kvm/api.txt  |   8 ++
 arch/x86/hyperv/hv_apic.c          |  12 +--
 arch/x86/include/asm/hyperv-tlfs.h |  16 +--
 arch/x86/kvm/hyperv.c              | 211 +++++++++++++++++++++++++++----------
 arch/x86/kvm/trace.h               |  42 ++++++++
 arch/x86/kvm/x86.c                 |   1 +
 include/uapi/linux/kvm.h           |   1 +
 virt/kvm/kvm_main.c                |   6 +-
 8 files changed, 224 insertions(+), 73 deletions(-)

-- 
2.14.4

