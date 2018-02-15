Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518719798-2-11657348273641237469
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719797; b=LmMYUEPOSmf8eVKx9BJjZ4+jljBwXM05xy7bqdCnkTdOQm+
    PDeJ8tHmiaSgKUyDx2vQZM5Ev4wXAvZD7NIsvmjPkd0kPZrYPrQKWtao3PxYeWEA
    B8nuAU7VSe2qqGNb3SkfbYpszCM5xrx55BcGeh5znBKlBpt0CPUm3u7hIutAKIAL
    XN+Org/BUbVyeORXsEyk7UDbhILfsc7ig+YBn5QfNEzdkIYxyHBYvlHjvXhyIWRW
    AO7zDeZ8Qs3u/xDD88+0QDrrEzyDDxolWEGOrx0u0N2w02pu641l97A+kEvYRFGc
    E1IuleSQZUp2we3i+BJAhPUjknVCvUqe4L7fSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719797; bh=THbJBr5MWSwUQPvjKU+nPOOU1L
    BrAly1FxbTEAbIfcQ=; b=SJ6uz9HBpSESR0UatHPQVozRu3/8uqjf3L6czHD7bJ
    UyCHpzYgN6T0zi16FZKBBCqUReBCI6/+9q5vPaaYuZH1CwG5rjvQI30ppzw7X4R8
    5IFOEd7SvilRc6RExnzNrTvTaTwDHu4pxtoIKeAGEPVaEvwuwhINFA6b6v35gvTA
    0VA4xTvIePiWNFafeXgOe2M9WvnzAdiwiNrxVBMpcd0P3q2gz0LGmiJlvlheqxRP
    /kbEqGaybmBmwTJhWdqLYWyxHXC6oxyjMYFtgSiC+obgbbUVmRy6k5kCxNNHkPTP
    jt+jBVEPbSmhGQQeeBh+MO8YDXOO3qGSvBp8/Nx2A1Sg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033949AbeBOPYX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:24:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033898AbeBOPYV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:24:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.4 086/108] arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls
Date: Thu, 15 Feb 2018 16:17:23 +0100
Message-Id: <20180215151234.348680449@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 20e8175d246e9f9deb377f2784b3e7dfb2ad3e86 upstream.

KVM doesn't follow the SMCCC when it comes to unimplemented calls,
and inject an UNDEF instead of returning an error. Since firmware
calls are now used for security mitigation, they are becoming more
common, and the undef is counter productive.

Instead, let's follow the SMCCC which states that -1 must be returned
to the caller when getting an unknown function number.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kvm/handle_exit.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -45,7 +45,7 @@ static int handle_hvc(struct kvm_vcpu *v
 
 	ret = kvm_psci_call(vcpu);
 	if (ret < 0) {
-		kvm_inject_undefined(vcpu);
+		vcpu_set_reg(vcpu, 0, ~0UL);
 		return 1;
 	}
 
@@ -54,7 +54,16 @@ static int handle_hvc(struct kvm_vcpu *v
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	kvm_inject_undefined(vcpu);
+	/*
+	 * "If an SMC instruction executed at Non-secure EL1 is
+	 * trapped to EL2 because HCR_EL2.TSC is 1, the exception is a
+	 * Trap exception, not a Secure Monitor Call exception [...]"
+	 *
+	 * We need to advance the PC after the trap, as it would
+	 * otherwise return to the same address...
+	 */
+	vcpu_set_reg(vcpu, 0, ~0UL);
+	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 	return 1;
 }
 
