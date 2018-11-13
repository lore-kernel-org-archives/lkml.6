Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46297C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19850223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19850223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbeKNBU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:20:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732028AbeKNBU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:20:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CACB3DE0E;
        Tue, 13 Nov 2018 15:22:21 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.34.244.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 216F41042557;
        Tue, 13 Nov 2018 15:22:18 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH 0/3] x86/kvm/hyper-v: Implement Direct Mode for synthetic timers
Date:   Tue, 13 Nov 2018 16:22:13 +0100
Message-Id: <20181113152218.22049-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 13 Nov 2018 15:22:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out Hyper-V on KVM (as of 2016) will only use synthetic timers
if direct mode is available. With direct mode we notify the guest by
asserting APIC irq instead of sending a SynIC message.

The series was tested with Hyper-V on KVM as well as kvm-unit-tests.
I'm including Qemu a kvm-unit-tests patches for testing purposes.

Vitaly Kuznetsov (3):
  x86/hyper-v: move synic/stimer control structures definitions to
    hyperv-tlfs.h
  x86/kvm/hyper-v: use stimer config definition from hyperv-tlfs.h
  x86/kvm/hyper-v: direct mode for synthetic timers

 arch/x86/include/asm/hyperv-tlfs.h |  73 +++++++++++++++++++--
 arch/x86/include/asm/kvm_host.h    |   2 +-
 arch/x86/kvm/hyperv.c              | 100 ++++++++++++++++++++++-------
 arch/x86/kvm/trace.h               |  10 +--
 arch/x86/kvm/x86.c                 |   1 +
 drivers/hv/hv.c                    |   2 +-
 drivers/hv/hyperv_vmbus.h          |  68 --------------------
 include/uapi/linux/kvm.h           |   1 +
 8 files changed, 155 insertions(+), 102 deletions(-)

-- 
2.17.2

