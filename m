Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452054-2-8975921977351918141
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452054; b=XDSNWwPmeDjbiaDYP4J5+IRZh9ObFhnYhME9JDtw0DubVIz
    ha4vUCRmwi4261mftffFTgwKY4F3WOfv7Ete4NJymmIMDWGkg1+7YBC1aP202LSK
    Q9vntPCnM5UayUJK/hMLXuXjR055m1IhBSbHNq7leOUkRwWiZkJCPY501nzRwl2A
    IbmRDpISfb5KA56WPllvE2h+J3hm6F5x0q/IGI7tWtcXahcEiJmXDnV4dyZ/jBoE
    hYsYzpRzIQTKjGJSI7p1MjPOK4t3q7ITKIyMjNF/ovt8B5EL/E5dp7nvMOm/UKgV
    3S04EDn0CdgqyVQB2y6DnK9/NLkuE1B62OV5s6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452054; bh=gnZxVFZXt9Qc71/CzhP3IxRsfJ
    i1TNp3aG8ukwl1tMs=; b=RkL6Ngc/ovnBEV4JEmWlEFfHsBKL1EZ60bjH/k78+9
    kzRmbGUC4uie6c+E0uiF0Ca2RXfydHTMJT2nKx8Vy+K4NZD6seNOfyrRjnfQdoWK
    KmqM6nUK05WUPdM1birTR0v0p4v+N05hkTwFAplbz6sQHI0hULRrVzT/hDZ8R//z
    waly2NgrYmq7tRkVOqIrUrRxbeKgbNBZt5CGlRM36a8svtnTuZvozB45J94Xcu54
    aunTgz4gL37daNBtxmjX/uAqMIRgrK7PJEfFfyv/pctH0djVKwup8CSXUFxL2JWB
    a/kDULeqyhzh9/xLN8/49gSdFep1ashuDqdEQuV9XTXQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935064AbeCGTr3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:47:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45008 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935038AbeCGTr2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:47:28 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.14 086/110] KVM: s390: take care of clock-comparator sign control
Date: Wed,  7 Mar 2018 11:39:09 -0800
Message-Id: <20180307191050.859341930@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit 5fe01793dd953ab947fababe8abaf5ed5258c8df upstream.

Missed when enabling the Multiple-epoch facility. If the facility is
installed and the control is set, a sign based comaprison has to be
performed.

Right now we would inject wrong interrupts and ignore interrupt
conditions. Also the sleep time is calculated in a wrong way.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180207114647.6220-2-david@redhat.com>
Fixes: 8fa1696ea781 ("KVM: s390: Multiple Epoch Facility support")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/interrupt.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -173,8 +173,15 @@ static int ckc_interrupts_enabled(struct
 
 static int ckc_irq_pending(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.sie_block->ckc >= kvm_s390_get_tod_clock_fast(vcpu->kvm))
+	const u64 now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
+	const u64 ckc = vcpu->arch.sie_block->ckc;
+
+	if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul) {
+		if ((s64)ckc >= (s64)now)
+			return 0;
+	} else if (ckc >= now) {
 		return 0;
+	}
 	return ckc_interrupts_enabled(vcpu);
 }
 
@@ -1004,13 +1011,19 @@ int kvm_cpu_has_pending_timer(struct kvm
 
 static u64 __calculate_sltime(struct kvm_vcpu *vcpu)
 {
-	u64 now, cputm, sltime = 0;
+	const u64 now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
+	const u64 ckc = vcpu->arch.sie_block->ckc;
+	u64 cputm, sltime = 0;
 
 	if (ckc_interrupts_enabled(vcpu)) {
-		now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
-		sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
-		/* already expired or overflow? */
-		if (!sltime || vcpu->arch.sie_block->ckc <= now)
+		if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul) {
+			if ((s64)now < (s64)ckc)
+				sltime = tod_to_ns((s64)ckc - (s64)now);
+		} else if (now < ckc) {
+			sltime = tod_to_ns(ckc - now);
+		}
+		/* already expired */
+		if (!sltime)
 			return 0;
 		if (cpu_timer_interrupts_enabled(vcpu)) {
 			cputm = kvm_s390_get_cpu_timer(vcpu);
