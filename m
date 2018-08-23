Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FC8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164BB2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164BB2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbeHWML7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:11:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50210 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWML6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:11:58 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A693E7F6;
        Thu, 23 Aug 2018 08:43:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 082/324] KVM: arm/arm64: Drop resource size check for GICV window
Date:   Thu, 23 Aug 2018 09:52:28 +0200
Message-Id: <20180823074959.991406201@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit ba56bc3a0786992755e6804fbcbdc60ef6cfc24c ]

When booting a 64 KB pages kernel on a ACPI GICv3 system that
implements support for v2 emulation, the following warning is
produced

  GICV size 0x2000 not a multiple of page size 0x10000

and support for v2 emulation is disabled, preventing GICv2 VMs
from being able to run on such hosts.

The reason is that vgic_v3_probe() performs a sanity check on the
size of the window (it should be a multiple of the page size),
while the ACPI MADT parsing code hardcodes the size of the window
to 8 KB. This makes sense, considering that ACPI does not bother
to describe the size in the first place, under the assumption that
platforms implementing ACPI will follow the architecture and not
put anything else in the same 64 KB window.

So let's just drop the sanity check altogether, and assume that
the window is at least 64 KB in size.

Fixes: 909777324588 ("KVM: arm/arm64: vgic-new: vgic_init: implement kvm_vgic_hyp_init")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/arm/vgic/vgic-v3.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -552,11 +552,6 @@ int vgic_v3_probe(const struct gic_kvm_i
 		pr_warn("GICV physical address 0x%llx not page aligned\n",
 			(unsigned long long)info->vcpu.start);
 		kvm_vgic_global_state.vcpu_base = 0;
-	} else if (!PAGE_ALIGNED(resource_size(&info->vcpu))) {
-		pr_warn("GICV size 0x%llx not a multiple of page size 0x%lx\n",
-			(unsigned long long)resource_size(&info->vcpu),
-			PAGE_SIZE);
-		kvm_vgic_global_state.vcpu_base = 0;
 	} else {
 		kvm_vgic_global_state.vcpu_base = info->vcpu.start;
 		kvm_vgic_global_state.can_emulate_gicv2 = true;


