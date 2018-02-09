Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184917-2-18057218943145435602
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184915; b=ior2/BN1lzOEbvVlPrzCi/GleEt98U7vhPHX8JLD4KhBt/K
    50fxEhbCzh0uji8yr+aN0aQ19PCaGFTzhLx/tqTZJA/Y1rngKxWroiHGWfgUzOVW
    fZJPK1/O8DGpWFIR+GSeuPEyEoUuz519lwRu5CS0PXep+dU/aP00n1ELYvS2tsAF
    zo3fhGlYKinyClFhPf3/nZdjClRJeOrtldH2klsyC7TKMjqigkM1PIuBquwCncOZ
    7wQ0RA/vqnBrRgMuRkePIVEkfJ6Qh5v3wMA92BCVoLQPypnX/bqT3LDJBjTdnGVd
    6oLmiE0/388Ro+vc44LkFnzSAKi1S88rn3fyanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184915; bh=+UgfLrIM6wN8Cze0JJYrWwftb6
    25NWUhP39JdLuJjns=; b=kGdxGYhmdwd6SPHW5tH9pyKoXhufGqbCFPyXUzsb6Z
    pM6w2cw7TxcUkdaL1yY3EkQlMvUncAfE9io5EBQAptuXwqdyGnG7ZQJ57jernH//
    ZLgC64Zwf8CZ8vJj9SB14D9Xml9G0jFqkxEWZy+25l/6lFsOtrR+wiLLeiPGFELp
    ROxO6yPgYkbvIAq8eP+cjNbfM38UN+kkMBgZo+jBOzyuEMhSCHg4i9d9e0kXyJAS
    GtwkibgVELzYJZShu7ILxCYaWKJwBvrw3Wx+rHkNKEACbqaRTLoE7LeMWS7qS33P
    FNiEGoG/Y40Z+p06ghpTp573SLMy6tyPUYlsjrPHWhRg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeBINny (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:43:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51130 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeBINnx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:43:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 77/92] KVM: nVMX: vmx_complete_nested_posted_interrupt() cant fail
Date: Fri,  9 Feb 2018 14:39:46 +0100
Message-Id: <20180209133936.784785649@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>


(cherry picked from commit 6342c50ad12e8ce0736e722184a7dbdea4a3477f)

vmx_complete_nested_posted_interrupt() can't fail, let's turn it into
a void function.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4736,7 +4736,7 @@ static bool vmx_get_enable_apicv(void)
 	return enable_apicv;
 }
 
-static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
+static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int max_irr;
@@ -4747,13 +4747,13 @@ static int vmx_complete_nested_posted_in
 	    vmx->nested.pi_pending) {
 		vmx->nested.pi_pending = false;
 		if (!pi_test_and_clear_on(vmx->nested.pi_desc))
-			return 0;
+			return;
 
 		max_irr = find_last_bit(
 			(unsigned long *)vmx->nested.pi_desc->pir, 256);
 
 		if (max_irr == 256)
-			return 0;
+			return;
 
 		vapic_page = kmap(vmx->nested.virtual_apic_page);
 		__kvm_apic_update_irr(vmx->nested.pi_desc->pir, vapic_page);
@@ -4766,7 +4766,6 @@ static int vmx_complete_nested_posted_in
 			vmcs_write16(GUEST_INTR_STATUS, status);
 		}
 	}
-	return 0;
 }
 
 static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu)
@@ -10482,7 +10481,8 @@ static int vmx_check_nested_events(struc
 		return 0;
 	}
 
-	return vmx_complete_nested_posted_interrupt(vcpu);
+	vmx_complete_nested_posted_interrupt(vcpu);
+	return 0;
 }
 
 static u32 vmx_get_preemption_timer_value(struct kvm_vcpu *vcpu)
