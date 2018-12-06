Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7554CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4321120838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4321120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLFQ63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:58:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeLFQ63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:58:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B7EC30012FC;
        Thu,  6 Dec 2018 16:58:29 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D431519C7D;
        Thu,  6 Dec 2018 16:58:26 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 0/6] x86/kvm/hyper-v: Implement KVM_GET_SUPPORTED_HV_CPUID
Date:   Thu,  6 Dec 2018 17:58:19 +0100
Message-Id: <20181206165825.1832-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 06 Dec 2018 16:58:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Paolo, introduce new KVM_GET_SUPPORTED_HV_CPUID returning
all Hyper-V CPUID feature leaves, this way we won't need to add a new
KVM_CAP_HYPERV_* for every new Hyper-V enlightenment we implement in
KVM.

(Using the existing KVM_GET_SUPPORTED_CPUID doesn't seem to be possible:
Hyper-V CPUID feature leaves intersect with KVM's (e.g. 0x40000000,
0x40000001) and we would probably confuse userspace in case we decide to
return these twice).

This patch series also does some housekeeping work in hyperv-tlfs.h, adds a
simple selftest (that's how I actually checked that the newly added ioctl
works) and removes recently added KVM_CAP_HYPERV_STIMER_DIRECT before it's
too late.

Vitaly Kuznetsov (6):
  x86/hyper-v: Do some housekeeping in hyperv-tlfs.h
  x86/hyper-v: Drop HV_X64_CONFIGURE_PROFILER definition
  x86/kvm/hyper-v: Introduce nested_get_evmcs_version() helper
  x86/kvm/hyper-v: Introduce KVM_GET_SUPPORTED_HV_CPUID
  x86/kvm/hyper-v: Drop KVM_CAP_HYPERV_STIMER_DIRECT
  KVM: selftests: Add hyperv_cpuid test

 arch/x86/include/asm/hyperv-tlfs.h            | 185 +++++++++---------
 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/kvm/hyperv.c                         | 131 ++++++++++++-
 arch/x86/kvm/hyperv.h                         |   2 +
 arch/x86/kvm/svm.c                            |   7 +
 arch/x86/kvm/vmx.c                            |  24 ++-
 arch/x86/kvm/x86.c                            |  21 +-
 include/uapi/linux/kvm.h                      |   5 +-
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/hyperv_cpuid.c       | 142 ++++++++++++++
 10 files changed, 413 insertions(+), 106 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c

-- 
2.19.2

