Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802292-2-17748793996017160283
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802292; b=r1Rt3tYqp0M6Du2nuHC9T6/P59Pwwm9Ce/k/BXLuXcZIsOQ
    4ZIudLy64lNoxfEex0uLbJQHd6yiLWsIKxIljWAnmhzXGRDqWYuKWjDxLCo+rTGl
    TPA7MQT6DXh2B1T3xLc2VdAPm9zSdU7RPWdr7l9fYyZsPy+Kw0DabBadaKdmKYTP
    jaw6R2Q8jruYq0LsfzEKtKge5WXuPE0xqUI2xEFZrPWjhOyWpyGEPvdLLIzRk6tM
    RL3XHUcHne7dSgWP/Td7maR0DmN4RQZmOQ/NL05DS7J/9Zhg0jTazDoAjw862f9y
    5+3IrFuUFQSDZBxM+ug+OoSk1CdkI97kJApxnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802292; bh=0ve5/U4UWzgFo+o5KCd2YFt0RA
    Ix7/e3frPLl+Qo1VI=; b=XsnTCDBB+R+Siz/ooiAknALsaAULOdgq3o0zPiFi/F
    fm11rqECX44yIwrmipHCMudTvTSP1DSyir5qxE6/lkXSf82J5FROcWEvx+rSRrxD
    23OYm3Ecezbpdpre8gS30Csg7toLIywHJkaDWqa9edyEx1sY60oGmu5MltmfVfgQ
    vU4J3ZQl0H8fiEetHQUIhSJ0jnMfCqGKIuTdjuRJ0V84G/K5kv9NEe24kzE24ewa
    XRd6gtjye3xQk42bXZyHoDUJRcMiD/piyFFatsYmTumrWJmw2FjLi/clBa9c+7HZ
    8ANpU2vKMWPK0bDVr5bGJLGJlovcjpnCMH9cCReLpX7Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeCWKvR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:51:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933172AbeCWKO0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 23/97] KVM: PPC: Book3S PR: Exit KVM on failed mapping
Date: Fri, 23 Mar 2018 10:54:10 +0100
Message-Id: <20180323094158.925063329@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kardashevskiy <aik@ozlabs.ru>


[ Upstream commit bd9166ffe624000140fc6b606b256df01fc0d060 ]

At the moment kvmppc_mmu_map_page() returns -1 if
mmu_hash_ops.hpte_insert() fails for any reason so the page fault handler
resumes the guest and it faults on the same address again.

This adds distinction to kvmppc_mmu_map_page() to return -EIO if
mmu_hash_ops.hpte_insert() failed for a reason other than full pteg.
At the moment only pSeries_lpar_hpte_insert() returns -2 if
plpar_pte_enter() failed with a code other than H_PTEG_FULL.
Other mmu_hash_ops.hpte_insert() instances can only fail with
-1 "full pteg".

With this change, if PR KVM fails to update HPT, it can signal
the userspace about this instead of returning to guest and having
the very same page fault over and over again.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/book3s_64_mmu_host.c |    5 ++++-
 arch/powerpc/kvm/book3s_pr.c          |    6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -177,12 +177,15 @@ map_again:
 	ret = ppc_md.hpte_insert(hpteg, vpn, hpaddr, rflags, vflags,
 				 hpsize, hpsize, MMU_SEGSIZE_256M);
 
-	if (ret < 0) {
+	if (ret == -1) {
 		/* If we couldn't map a primary PTE, try a secondary */
 		hash = ~hash;
 		vflags ^= HPTE_V_SECONDARY;
 		attempt++;
 		goto map_again;
+	} else if (ret < 0) {
+		r = -EIO;
+		goto out_unlock;
 	} else {
 		trace_kvm_book3s_64_mmu_map(rflags, hpteg,
 					    vpn, hpaddr, orig_pte);
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -625,7 +625,11 @@ int kvmppc_handle_pagefault(struct kvm_r
 			kvmppc_mmu_unmap_page(vcpu, &pte);
 		}
 		/* The guest's PTE is not mapped yet. Map on the host */
-		kvmppc_mmu_map_page(vcpu, &pte, iswrite);
+		if (kvmppc_mmu_map_page(vcpu, &pte, iswrite) == -EIO) {
+			/* Exit KVM if mapping failed */
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			return RESUME_HOST;
+		}
 		if (data)
 			vcpu->stat.sp_storage++;
 		else if (vcpu->arch.mmu.is_dcbz32(vcpu) &&
