Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B10C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9982084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS6ZU7bR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9982084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbeKLIRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbeKLIRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:02 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD61216FD;
        Sun, 11 Nov 2018 22:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975226;
        bh=9Lv6k26O8hNOwoaA/btY/FNGrcrSoU9S42Ah4/dWm1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JS6ZU7bRVRVHgUOyfDZWa4EDrOfBEqXHFohvMNMpJEigmEDMkmnu1FDjleSRTp3k+
         sXyFHffy6vIl/qDyynQ+G+ZYcW6yZ7t8UOXTAQ4l5Du8c66+9Q7Jc74bOfnQP/2MXP
         8ujX/FBkuNS3/9b1Xjfl86cY+FiY38opscGwFmt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 044/361] x86/kvm/nVMX: allow bare VMXON state migration
Date:   Sun, 11 Nov 2018 14:16:31 -0800
Message-Id: <20181111221626.079501205@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit a1b0c1c64dfef0cff8555bb708bfc5d7c66c6ca4 upstream.

It is perfectly valid for a guest to do VMXON and not do VMPTRLD. This
state needs to be preserved on migration.

Cc: stable@vger.kernel.org
Fixes: 8fcc4b5923af5de58b80b53a069453b135693304
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -14010,13 +14010,6 @@ static int vmx_set_nested_state(struct k
 	if (!page_address_valid(vcpu, kvm_state->vmx.vmxon_pa))
 		return -EINVAL;
 
-	if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
-		return -EINVAL;
-
-	if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
-	    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
-		return -EINVAL;
-
 	if ((kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE) &&
 	    (kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
 		return -EINVAL;
@@ -14046,6 +14039,14 @@ static int vmx_set_nested_state(struct k
 	if (ret)
 		return ret;
 
+	/* Empty 'VMXON' state is permitted */
+	if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
+		return 0;
+
+	if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
+	    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
+		return -EINVAL;
+
 	set_current_vmptr(vmx, kvm_state->vmx.vmcs_pa);
 
 	if (kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON) {


