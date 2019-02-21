Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CBBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348342084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759883;
	bh=kD7zn9V1OnIjigT1RIjipb2iDl/cpsRBWgdmTtiTzns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PgNJemzicDuDnTo/PFMFhhjkYrTM9wFO/7Z66IHMRzZ9d944nVZcTXT3TAegmy8SK
	 iO5i6lgGd5j0B3BaNxl61onUpA1/B20c20+3N6yEEDlwS9Lr16Xj5myZdCk+zNxYAi
	 P/FcOr9YmXiroamCpBq7nvu00Ccklw6yIkCYV47A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfBUOiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:38:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbfBUOh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:37:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E082075C;
        Thu, 21 Feb 2019 14:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759876;
        bh=kD7zn9V1OnIjigT1RIjipb2iDl/cpsRBWgdmTtiTzns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0urddS7CY0DJ0h0D90r7KXVqpUnog+4rjOTzVDMYsIsRoaup5LeBNGvXsFeuqHVA
         gKDAAx2L+mqjV+XvslOKR96RjE8KQy8wRT6HHCA2oPRIapIOtuaCwzuDv4j/QkMATn
         52Z8M2h/qzofYkITQ5CUzeuG+GsSv00BBEH0Y3Vs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.4 20/20] KVM: VMX: Fix x2apic check in vmx_msr_bitmap_mode()
Date:   Thu, 21 Feb 2019 15:35:50 +0100
Message-Id: <20190221141947.351023124@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joerg Roedel <jroedel@suse.de>

The stable backport of upstream commit

	904e14fb7cb96 KVM: VMX: make MSR bitmaps per-VCPU

has a bug in vmx_msr_bitmap_mode(). It enables the x2apic
MSR-bitmap when the kernel emulates x2apic for the guest in
software. The upstream version of the commit checkes whether
the hardware has virtualization enabled for x2apic
emulation.

Since KVM emulates x2apic for guests even when the host does
not support x2apic in hardware, this causes the intercept of
at least the X2APIC_TASKPRI MSR to be disabled on machines
not supporting that MSR. The result is undefined behavior,
on some machines (Intel Westmere based) it causes a crash of
the guest kernel when it tries to access that MSR.

Change the check in vmx_msr_bitmap_mode() to match the upstream
code. This fixes the guest crashes observed with stable
kernels starting with v4.4.168 through v4.4.175.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4628,7 +4628,9 @@ static u8 vmx_msr_bitmap_mode(struct kvm
 {
 	u8 mode = 0;
 
-	if (irqchip_in_kernel(vcpu->kvm) && apic_x2apic_mode(vcpu->arch.apic)) {
+	if (cpu_has_secondary_exec_ctrls() &&
+	    (vmcs_read32(SECONDARY_VM_EXEC_CONTROL) &
+	     SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE)) {
 		mode |= MSR_BITMAP_MODE_X2APIC;
 		if (enable_apicv)
 			mode |= MSR_BITMAP_MODE_X2APIC_APICV;


