Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BD0C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D211321480
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yvNcO29h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D211321480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbeJKXQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbeJKXQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:16:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9AF02098A;
        Thu, 11 Oct 2018 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272917;
        bh=06wnrqZYEr+Oh/am7PNiuaUVUiV8hnJNT/A7zOu+gP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yvNcO29hSHyp2Qvz+68ZkUozQV7YQQgHsiG44hKIZ5l1pavp7s8qjXxBZRTs9BnzH
         jwYcRHAznVp0FHHWBpGNXZclOd3nYNJuuss9vr+Vxvt2RX7FL/vj6dWzuvyhVfFnBC
         hkrjLyIYKZUHjxnVuXCd15TCcUaxzW4dJ5j15e90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gerhard Wiesinger <redhat@wiesinger.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.18 06/44] KVM: VMX: check for existence of secondary exec controls before accessing
Date:   Thu, 11 Oct 2018 17:39:44 +0200
Message-Id: <20181011152452.817512776@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit fd6b6d9b82f97a851fb0078201ddc38fe9728cda upstream.

Return early from vmx_set_virtual_apic_mode() if the processor doesn't
support VIRTUALIZE_APIC_ACCESSES or VIRTUALIZE_X2APIC_MODE, both of
which reside in SECONDARY_VM_EXEC_CONTROL.  This eliminates warnings
due to VMWRITEs to SECONDARY_VM_EXEC_CONTROL (VMCS field 401e) failing
on processors without secondary exec controls.

Remove the similar check for TPR shadowing as it is incorporated in the
flexpriority_enabled check and the APIC-related code in
vmx_update_msr_bitmap() is further gated by VIRTUALIZE_X2APIC_MODE.

Reported-by: Gerhard Wiesinger <redhat@wiesinger.com>
Fixes: 8d860bbeedef ("kvm: vmx: Basic APIC virtualization controls have three settings")
Cc: Jim Mattson <jmattson@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9826,15 +9826,16 @@ static void vmx_set_virtual_apic_mode(st
 	if (!lapic_in_kernel(vcpu))
 		return;
 
+	if (!flexpriority_enabled &&
+	    !cpu_has_vmx_virtualize_x2apic_mode())
+		return;
+
 	/* Postpone execution until vmcs01 is the current VMCS. */
 	if (is_guest_mode(vcpu)) {
 		to_vmx(vcpu)->nested.change_vmcs01_virtual_apic_mode = true;
 		return;
 	}
 
-	if (!cpu_need_tpr_shadow(vcpu))
-		return;
-
 	sec_exec_control = vmcs_read32(SECONDARY_VM_EXEC_CONTROL);
 	sec_exec_control &= ~(SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
 			      SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE);


