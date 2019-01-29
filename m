Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747A1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463C520882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762329;
	bh=jBAvyyvdUS3A9m5WVPOugNXzymzv4yetnLohzc9ZJq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i78NTb+mHQjITlTWXH2rYXSFRGoYF5yZYg8mrVHfW4+p4Mq8oa+zZo6PWUkBtIPX+
	 bGi8fo4OreCFRMaqjA65WosVo7SvH2eiegEoNIeqFMkPWMw0A+M/UdH/plzoYV+2A/
	 +qg2yEwu/Cdsdj8eMwhaS4ZaMUW5viYdIuv+9Ys0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfA2Lp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:45:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbfA2LpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:45:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7937E2083B;
        Tue, 29 Jan 2019 11:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762325;
        bh=jBAvyyvdUS3A9m5WVPOugNXzymzv4yetnLohzc9ZJq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HkkzOcpy1AIayO6brb/ALlG1n0rRLO7D4S12Jx9i7fBGqsNELVkux7BxJ2qrBV2m3
         s2Ijr9HCi526Kq1fP8ic3OHBzQr+McFtzCvMP22QdW2wsVF9jYeaqWY/LVPLCcgazZ
         UEbCPpw8JQfaFIYsdOlv/RR+h78lUY+eS9TrekiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 069/103] KVM: x86: WARN_ONCE if sending a PV IPI returns a fatal error
Date:   Tue, 29 Jan 2019 12:35:46 +0100
Message-Id: <20190129113204.772388391@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


