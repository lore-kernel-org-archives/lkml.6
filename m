Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7HpCM/RrGltIbwAAmS7hNA
	; Fri, 08 Jun 2018 11:43:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BF623607DC; Fri,  8 Jun 2018 11:43:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 56C30601D2;
	Fri,  8 Jun 2018 11:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56C30601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeFHLnq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:43:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751485AbeFHLnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:43:41 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E3AFB46B124F;
        Fri,  8 Jun 2018 19:43:25 +0800 (CST)
Received: from localhost.localdomain (10.143.28.90) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.382.0; Fri, 8 Jun 2018 19:43:17 +0800
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <rkrcmar@redhat.com>, <corbet@lwn.net>, <christoffer.dall@arm.com>,
        <marc.zyngier@arm.com>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <james.morse@arm.com>, <gengdongjiu@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH RESEND v4 0/2] support exception state migration and set VSESR_EL2 by user space
Date: Sat, 9 Jun 2018 03:48:38 +0800
Message-ID: <1528487320-2873-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patch is separated from https://www.spinics.net/lists/kvm/msg168917.html

1. Detect whether KVM can set set guest SError syndrome
2. Support to Set VSESR_EL2 and inject SError by user space.
3. Support live migration to keep SError pending state and VSESR_EL2 value

The user space patch is here: https://www.mail-archive.com/qemu-devel@nongnu.org/msg539534.html

Dongjiu Geng (2):
  arm64: KVM: export the capability to set guest SError syndrome
  arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS

 Documentation/virtual/kvm/api.txt    | 42 +++++++++++++++++++++++++++++++++---
 arch/arm/include/asm/kvm_host.h      |  6 ++++++
 arch/arm/include/uapi/asm/kvm.h      | 12 +++++++++++
 arch/arm/kvm/guest.c                 | 12 +++++++++++
 arch/arm64/include/asm/kvm_emulate.h |  5 +++++
 arch/arm64/include/asm/kvm_host.h    |  7 ++++++
 arch/arm64/include/uapi/asm/kvm.h    | 13 +++++++++++
 arch/arm64/kvm/guest.c               | 36 +++++++++++++++++++++++++++++++
 arch/arm64/kvm/inject_fault.c        |  6 +++---
 arch/arm64/kvm/reset.c               |  4 ++++
 include/uapi/linux/kvm.h             |  1 +
 virt/kvm/arm/arm.c                   | 19 ++++++++++++++++
 12 files changed, 157 insertions(+), 6 deletions(-)

-- 
2.7.4
