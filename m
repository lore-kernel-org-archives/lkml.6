Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1F1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7296820818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="deuALv8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7296820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405647AbeKWDgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:36:16 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:10540 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388150AbeKWDgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1542905763; x=1574441763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SjTMBqqbFlJCxb/Fk+mY8As3c/foiQuyX9sw0WYSkV0=;
  b=deuALv8OW4LI2AUD38uH3cEqxZ8kZ/yillCSEVKrD3mO4tBuF6PyX436
   EoqsLrsRoFlivmDCT+T7Yr+Oqd49EyY6K0X6eWxRkFuL4NLBUt4/oJBMQ
   FxiFQ59ka5N5LbT4ykMn3D6x4ao+UI+cP7+Kcl8Xw1NIyDxjhZSRi/fyV
   A=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="746878404"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Nov 2018 16:50:00 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wAMGntUa083738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 22 Nov 2018 16:49:57 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wAMGnrpJ008102;
        Thu, 22 Nov 2018 17:49:54 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id wAMGnqJH008101;
        Thu, 22 Nov 2018 17:49:52 +0100
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kernel-hardening@lists.openwall.com
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Liran Alon <liran.alon@oracle.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Jonathan Adams <jwadams@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC RESEND PATCH 0/6] Process-local memory allocations
Date:   Thu, 22 Nov 2018 17:49:33 +0100
Message-Id: <cover.1542905228.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a world with processor information leak vulnerabilities, having a treasure
trove of information available for leaking in the global kernel address space is
starting to be a liability. The biggest offender is the linear mapping of all
physical memory and there are already efforts (XPFO) to start addressing this.
In this patch series, I'd like to propose breaking up the kernel address space
further and introduce process-local mappings in the kernel.

The rationale is that there are allocations in the kernel containing data that
should only be accessible when the kernel is executing in the context of a
specific process. A prime example is KVM vCPU state. This patch series
introduces process-local memory in the kernel address space by claiming a PGD
entry for this specific purpose. Then it converts KVM on x86 to use these new
primitives to store GPR and FPU registers of vCPUs. KVM is a good testing
ground, because it makes sure userspace can only interact with a VM from a
single process.

Process-local allocations in the kernel can be part of a robust L1TF mitigation
strategy that works even with SMT enabled. The specific goal here is to make it
harder for a random thread using cache load gadget (usually a bounds check of a
system call argument plus array access suffices) to prefetch interesting data
into the L1 cache and use L1TF to leak this data.

The patch set applies to kvm/next [1]. Feedback is very welcome, both about the
general approach and the actual implementation. As far as testing goes, the KVM
unit tests seem happy on Intel. AMD is only compile tested at the moment.

[1] git://git.kernel.org/pub/scm/virt/kvm/kvm.git

Julian Stecklina (6):
  kvm, vmx: move CR2 context switch out of assembly path
  kvm, vmx: move register clearing out of assembly path
  mm, x86: make __kernel_map_pages always available
  x86/speculation, mm: add process local virtual memory region
  x86/speculation, kvm: move guest FPU state into process local memory
  x86/speculation, kvm: move gprs to process local storage

 arch/x86/Kconfig                        |   1 +
 arch/x86/include/asm/kvm_host.h         |  13 +-
 arch/x86/include/asm/pgtable_64_types.h |   6 +
 arch/x86/include/asm/proclocal.h        |  44 ++++
 arch/x86/kvm/kvm_cache_regs.h           |   4 +-
 arch/x86/kvm/svm.c                      | 132 +++++++-----
 arch/x86/kvm/vmx.c                      | 203 ++++++++++--------
 arch/x86/kvm/x86.c                      |  45 ++--
 arch/x86/mm/Makefile                    |   2 +
 arch/x86/mm/dump_pagetables.c           |   3 +
 arch/x86/mm/fault.c                     |  14 ++
 arch/x86/mm/pageattr.c                  |   3 +-
 arch/x86/mm/proclocal.c                 | 269 ++++++++++++++++++++++++
 include/linux/mm.h                      |   3 +-
 include/linux/mm_types.h                |   7 +
 security/Kconfig                        |  16 ++
 16 files changed, 596 insertions(+), 169 deletions(-)
 create mode 100644 arch/x86/include/asm/proclocal.h
 create mode 100644 arch/x86/mm/proclocal.c

-- 
2.17.1

