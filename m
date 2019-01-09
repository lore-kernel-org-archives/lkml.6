Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F10214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="HIHb/0Cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfAIJmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:42:43 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:53731 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbfAIJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547026951; x=1578562951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+11XopSD3NZi17fwFjmUAyip5g6Y8L0FisE7NG2U+iQ=;
  b=HIHb/0ClZtu02uFjDftnvMtkheGlDSFaFZxuV8CS64JpZnDsAiUeRWm5
   M2AXBgQp8Rg9hLKxY68DZcsx2agfmgMtVXPi/NWkmrT45FraH1RDTpO5V
   Hrh8tR0eA/GYIf95DLxcgssBR4+7p4A4yd3FGVVpvP5OtMjAzm9WOhUz6
   w=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="380876341"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Jan 2019 09:42:28 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x099gNjO069861
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 9 Jan 2019 09:42:24 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x099gMHQ031351;
        Wed, 9 Jan 2019 10:42:23 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x099gMEo031350;
        Wed, 9 Jan 2019 10:42:22 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v5 13/13] KVM/nVMX: Use page_address_valid in a few more locations
Date:   Wed,  9 Jan 2019 10:42:13 +0100
Message-Id: <1547026933-31226-14-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
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
index ccb3b63..77aad46 100644
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

