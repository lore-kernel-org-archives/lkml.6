Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA59C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7FE208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7FE208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeHWMb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:31:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:31:26 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3994CC83;
        Thu, 23 Aug 2018 09:02:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 265/324] kvm: nVMX: Restore exit qual for VM-entry failure due to MSR loading
Date:   Thu, 23 Aug 2018 09:55:31 +0200
Message-Id: <20180823075009.247157354@linuxfoundation.org>
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

From: Jim Mattson <jmattson@google.com>

[ Upstream commit 0b88abdc3f964c28ec03bc69eb17cb6b3b034564 ]

This exit qualification was inadvertently dropped when the two
VM-entry failure blocks were coalesced.

Fixes: e79f245ddec1 ("X86/KVM: Properly update 'tsc_offset' to represent the running guest")
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11791,7 +11791,6 @@ static int enter_vmx_non_root_mode(struc
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
-	u32 msr_entry_idx;
 	u32 exit_qual;
 	int r;
 
@@ -11813,10 +11812,10 @@ static int enter_vmx_non_root_mode(struc
 	nested_get_vmcs12_pages(vcpu, vmcs12);
 
 	r = EXIT_REASON_MSR_LOAD_FAIL;
-	msr_entry_idx = nested_vmx_load_msr(vcpu,
-					    vmcs12->vm_entry_msr_load_addr,
-					    vmcs12->vm_entry_msr_load_count);
-	if (msr_entry_idx)
+	exit_qual = nested_vmx_load_msr(vcpu,
+					vmcs12->vm_entry_msr_load_addr,
+					vmcs12->vm_entry_msr_load_count);
+	if (exit_qual)
 		goto fail;
 
 	/*


