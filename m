Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD48C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B918214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762014;
	bh=Gkkr3lIfbRiGzEY0XXR6thmqvPdwKeZVkZ8Yz6IhHuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kaFM7I6GpozgqLoWPkM7tJ7D8C3wnnBRVP63DnLxzmUPhSla/Ffb2B9ry/IYC5WFV
	 ngcZmUJ+gIOR9s9srYjFv62WSacJtGlzfThyQY74vvXt4b7se6IbvP85WPPGx6meYF
	 vtd0lvJ03Z53nXapSRtZYj3xTkE34s4G5LLcf348=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfA2LkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbfA2LkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D7C20882;
        Tue, 29 Jan 2019 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762009;
        bh=Gkkr3lIfbRiGzEY0XXR6thmqvPdwKeZVkZ8Yz6IhHuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcIACgv/viXPHQN1wtXiKpX80IimAMtkwgOAvW7aax/vHCvDXAff0JWXRJvJ7WJB8
         CZNbfY0Y8RudJIkawj0QJqVy3yPOA9g74nnSLMkktyvt1y4LgC67BbNnjAc/roFH+7
         hkQhIZLdIybJMqIUyhHnPPyjQsi60rVgWIoSNZFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.20 078/117] KVM: x86: WARN_ONCE if sending a PV IPI returns a fatal error
Date:   Tue, 29 Jan 2019 12:35:29 +0100
Message-Id: <20190129113211.380506565@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit de81c2f912ef57917bdc6d63b410c534c3e07982 upstream.

KVM hypercalls return a negative value error code in case of a fatal
error, e.g. when the hypercall isn't supported or was made with invalid
parameters.  WARN_ONCE on fatal errors when sending PV IPIs as any such
error all but guarantees an SMP system will hang due to a missing IPI.

Fixes: aaffcfd1e82d ("KVM: X86: Implement PV IPIs in linux guest")
Cc: stable@vger.kernel.org
Cc: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kvm.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -457,6 +457,7 @@ static void __send_ipi_mask(const struct
 #else
 	u64 ipi_bitmap = 0;
 #endif
+	long ret;
 
 	if (cpumask_empty(mask))
 		return;
@@ -482,8 +483,9 @@ static void __send_ipi_mask(const struct
 		} else if (apic_id < min + KVM_IPI_CLUSTER_SIZE) {
 			max = apic_id < max ? max : apic_id;
 		} else {
-			kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
+			ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
 				(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, icr);
+			WARN_ONCE(ret < 0, "KVM: failed to send PV IPI: %ld", ret);
 			min = max = apic_id;
 			ipi_bitmap = 0;
 		}
@@ -491,8 +493,9 @@ static void __send_ipi_mask(const struct
 	}
 
 	if (ipi_bitmap) {
-		kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
+		ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
 			(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, icr);
+		WARN_ONCE(ret < 0, "KVM: failed to send PV IPI: %ld", ret);
 	}
 
 	local_irq_restore(flags);


