Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AC6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ACE20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545998033;
	bh=CaWrM62sch6+VvXaJPJWTlKApH4KE+8iNIcocfYSH5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foO8wkclN2RGwbhREQ182L7Q+yi0Va23IA6q72AkgmkjLQNfiYYRMr9YNtA73zgua
	 bHgra2WIBhmz5xD/qwVEVmrjoYR5Ktshu8hgWPcN4BOIlpuKInANuhzk6k48SPuxJo
	 fSk2a6kcxxn5FjGMr9Z9KSZ01OOPi06dnOM9FZ90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbeL1Lxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732355AbeL1Lxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:53:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F522184B;
        Fri, 28 Dec 2018 11:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545998027;
        bh=CaWrM62sch6+VvXaJPJWTlKApH4KE+8iNIcocfYSH5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2hhwqGpAGa+UJmDQSd0y61DprC1bnjHcIUuFvKwFxi5c4cvgsKMWk3eMfPgy0H5dZ
         45HOPmdOj/We5jh17/W30n2AhWsMvfvF1ZCXUFB6efs2avrhmwQWJI2qzowejRk2yi
         6x6trpRq5ijJu5lV7Xe1aea9CmSr91WaPfq7YB0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Honig <ahonig@google.com>,
        Cfir Cohen <cfir@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 23/46] KVM: Fix UAF in nested posted interrupt processing
Date:   Fri, 28 Dec 2018 12:52:17 +0100
Message-Id: <20181228113126.119876474@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

From: Cfir Cohen <cfir@google.com>

commit c2dd5146e9fe1f22c77c1b011adf84eea0245806 upstream.

nested_get_vmcs12_pages() processes the posted_intr address in vmcs12. It
caches the kmap()ed page object and pointer, however, it doesn't handle
errors correctly: it's possible to cache a valid pointer, then release
the page and later dereference the dangling pointer.

I was able to reproduce with the following steps:

1. Call vmlaunch with valid posted_intr_desc_addr but an invalid
MSR_EFER. This causes nested_get_vmcs12_pages() to cache the kmap()ed
pi_desc_page and pi_desc. Later the invalid EFER value fails
check_vmentry_postreqs() which fails the first vmlaunch.

2. Call vmlanuch with a valid EFER but an invalid posted_intr_desc_addr
(I set it to 2G - 0x80). The second time we call nested_get_vmcs12_pages
pi_desc_page is unmapped and released and pi_desc_page is set to NULL
(the "shouldn't happen" clause). Due to the invalid
posted_intr_desc_addr, kvm_vcpu_gpa_to_page() fails and
nested_get_vmcs12_pages() returns. It doesn't return an error value so
vmlaunch proceeds. Note that at this time we have a dangling pointer in
vmx->nested.pi_desc and POSTED_INTR_DESC_ADDR in L0's vmcs.

3. Issue an IPI in L2 guest code. This triggers a call to
vmx_complete_nested_posted_interrupt() and pi_test_and_clear_on() which
dereferences the dangling pointer.

Vulnerable code requires nested and enable_apicv variables to be set to
true. The host CPU must also support posted interrupts.

Fixes: 5e2f30b756a37 "KVM: nVMX: get rid of nested_get_page()"
Cc: stable@vger.kernel.org
Reviewed-by: Andy Honig <ahonig@google.com>
Signed-off-by: Cfir Cohen <cfir@google.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11471,6 +11471,8 @@ static void nested_get_vmcs12_pages(stru
 			kunmap(vmx->nested.pi_desc_page);
 			kvm_release_page_dirty(vmx->nested.pi_desc_page);
 			vmx->nested.pi_desc_page = NULL;
+			vmx->nested.pi_desc = NULL;
+			vmcs_write64(POSTED_INTR_DESC_ADDR, -1ull);
 		}
 		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->posted_intr_desc_addr);
 		if (is_error_page(page))


