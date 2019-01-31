Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505C8C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209F42195D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="VcXDtTdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfAaU1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:27:15 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:11886 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfAaU1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966431; x=1580502431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vpQWtJIGuD5wkDbOzUOZfHizrC9+qDCSo/WPfD0I3Bo=;
  b=VcXDtTdot2O2HaGATVEpwETrD8k+cIO6bAfxOTRe9QeaFv+58XJoujAm
   chocos3DxQ0ALG3dCDFfzA4VwuQl+B8THVBqDPIt+gu/pXFCHOM9GqU5V
   yAo4TWtOXBhgxszmB+lPKPHvTaIPuB6brk+TfKWUigfWFJx+PNtcN/kFx
   U=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="784846795"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 31 Jan 2019 20:27:10 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 443AFC512F;
        Thu, 31 Jan 2019 20:27:10 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKR7DN029031;
        Thu, 31 Jan 2019 21:27:08 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKR76X029030;
        Thu, 31 Jan 2019 21:27:07 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 13/14] KVM/nVMX: Use page_address_valid in a few more locations
Date:   Thu, 31 Jan 2019 21:24:43 +0100
Message-Id: <1548966284-28642-14-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use page_address_valid in a few more locations that is already checking for
a page aligned address that does not cross the maximum physical address.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx/nested.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 60ba582..91e42f9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4203,7 +4203,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 	 * Note - IA32_VMX_BASIC[48] will never be 1 for the nested case;
 	 * which replaces physical address width with 32
 	 */
-	if (!PAGE_ALIGNED(vmptr) || (vmptr >> cpuid_maxphyaddr(vcpu)))
+	if (!page_address_valid(vcpu, vmptr))
 		return nested_vmx_failInvalid(vcpu);
 
 	if (kvm_read_guest(vcpu->kvm, vmptr, &revision, sizeof(revision)) ||
@@ -4266,7 +4266,7 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 	if (nested_vmx_get_vmptr(vcpu, &vmptr))
 		return 1;
 
-	if (!PAGE_ALIGNED(vmptr) || (vmptr >> cpuid_maxphyaddr(vcpu)))
+	if (!page_address_valid(vcpu, vmptr))
 		return nested_vmx_failValid(vcpu,
 			VMXERR_VMCLEAR_INVALID_ADDRESS);
 
@@ -4473,7 +4473,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 	if (nested_vmx_get_vmptr(vcpu, &vmptr))
 		return 1;
 
-	if (!PAGE_ALIGNED(vmptr) || (vmptr >> cpuid_maxphyaddr(vcpu)))
+	if (!page_address_valid(vcpu, vmptr))
 		return nested_vmx_failValid(vcpu,
 			VMXERR_VMPTRLD_INVALID_ADDRESS);
 
-- 
2.7.4

