Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE00C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A8C21531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A8C21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeIZXQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:16:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbeIZXQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:16:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4A2B3083391;
        Wed, 26 Sep 2018 17:03:03 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47D4F60BE7;
        Wed, 26 Sep 2018 17:03:01 +0000 (UTC)
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
Subject: [PATCH v6 0/7] KVM: x86: hyperv: PV IPI support for Windows guests
Date:   Wed, 26 Sep 2018 19:02:52 +0200
Message-Id: <20180926170259.29796-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 26 Sep 2018 17:03:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v5:
- New 'hybrid' approach to VP indexes: introduce 'num_mismatched_vp_indexes'
  and use it for optimization in both PV IPI and TLB flush [Paolo Bonzini,
  Roman Kagan].
- Rebase, KVM_CAP_HYPERV_SEND_IPI is now '160'.
- Patches 3-5 are new in this version.
- Drop "x86/hyper-v: rename ipi_arg_{ex,non_ex} structures" patch as it is
  already merged in kvm/queue.

Original description:
Using hypercall for sending IPIs is faster because this allows to specify
any number of vCPUs (even > 64 with sparse CPU set), the whole procedure
will take only one VMEXIT.

Same as PV TLB flush, this allows Windows guests having > 64 vCPUs to boot
on KVM when Hyper-V extensions are enabled.

Vitaly Kuznetsov (7):
  KVM: x86: hyperv: enforce vp_index < KVM_MAX_VCPUS
  KVM: x86: hyperv: optimize 'all cpus' case in kvm_hv_flush_tlb()
  KVM: x86: hyperv: consistently use 'hv_vcpu' for 'struct kvm_vcpu_hv'
    variables
  KVM: x86: hyperv: keep track of mismatched VP indexes
  KVM: x86: hyperv: valid_bank_mask should be 'u64'
  KVM: x86: hyperv: optimize kvm_hv_flush_tlb() for vp_index == vcpu_idx
    case
  KVM: x86: hyperv: implement PV IPI send hypercalls

 Documentation/virtual/kvm/api.txt |   7 +
 arch/x86/include/asm/kvm_host.h   |   3 +
 arch/x86/kvm/hyperv.c             | 268 +++++++++++++++++++++++-------
 arch/x86/kvm/trace.h              |  42 +++++
 arch/x86/kvm/x86.c                |   1 +
 include/uapi/linux/kvm.h          |   1 +
 virt/kvm/kvm_main.c               |   6 +-
 7 files changed, 265 insertions(+), 63 deletions(-)

-- 
2.17.1

