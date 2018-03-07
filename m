Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520451863-2-7405605654930720051
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
    t=1520451863; b=NvzaJMLcfyk9dylki5PIEaXuzJkRCJyPKYb6x6zwJIqm+Ex
    n84oIaZQLFYrnrMM/uirSwWbpDbmolhaSVWyeDQh7m7DwQT60yZ66FnJ8KadCoip
    YZVNrOnuKhHNFtLapvDqog5ujny41Xg7W+eqFrfQJw0sR5aLVVuSFe26DEkBtGPL
    6VFn8DihmPBxOe9mV6v2Vis0Ovg4tttBBxz9xnKTNr3wdPuvQWpRbHhP1+2QxOkR
    rVhmzk9pFCl/gphYAxLK9eYefyq9Cfjko5liu8itRT4QZyRpJL7rE2Y+0D7gshMv
    H1BkIRb2zi9melBFgkTx4uB6JLd5Gzh6TGNp/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451863; bh=Z+P60IHGjeYeD7F2YwI0xy/w9S
    1F80ryiq0ys+FtzRw=; b=pk4v6IQC6jFXz7JHkF523RtSTUawN329ppqaKU1B6d
    MNz9lkRwJcfarnjrA9KxfjvMP7zD5G4ghzc0JTMd0eMFCFXBQbvP3uFQBCQDKqO+
    lT6SvNIwQ2iriow785X+DEY4mu/8p1y43g/ENryoAT3hHRAReEcQKqafU+apEDyg
    oaE/5tRgr8NwacVvAc9mG8JsAQ97l4ClrlLzeZxUOjTBR7u5HKJLU3Z5LsjPQVuB
    Sf+BwEd98CHGK6QYzu0xpzwOaSgKlfiK/pFTA0jqMtqmpHQmLUS27xZwwIMj+aTv
    Dr+pg1UxP01D2ARvgmVRc7tY0EKhqiMk3DYd/0u6xulg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S965062AbeCGToU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:44:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934593AbeCGToT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:44:19 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.15 114/122] KVM: x86: move LAPIC initialization after VMCS creation
Date: Wed,  7 Mar 2018 11:38:46 -0800
Message-Id: <20180307191746.184967649@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 0b2e9904c15963e715d33e5f3f1387f17d19333a upstream.

The initial reset of the local APIC is performed before the VMCS has been
created, but it tries to do a vmwrite:

 vmwrite error: reg 810 value 4a00 (err 18944)
 CPU: 54 PID: 38652 Comm: qemu-kvm Tainted: G        W I      4.16.0-0.rc2.git0.1.fc28.x86_64 #1
 Hardware name: Intel Corporation S2600CW/S2600CW, BIOS SE5C610.86B.01.01.0003.090520141303 09/05/2014
 Call Trace:
  vmx_set_rvi [kvm_intel]
  vmx_hwapic_irr_update [kvm_intel]
  kvm_lapic_reset [kvm]
  kvm_create_lapic [kvm]
  kvm_arch_vcpu_init [kvm]
  kvm_vcpu_init [kvm]
  vmx_create_vcpu [kvm_intel]
  kvm_vm_ioctl [kvm]

Move it later, after the VMCS has been created.

Fixes: 4191db26b714 ("KVM: x86: Update APICv on APIC reset")
Cc: stable@vger.kernel.org
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/lapic.c |    1 -
 arch/x86/kvm/x86.c   |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2156,7 +2156,6 @@ int kvm_create_lapic(struct kvm_vcpu *vc
 	 */
 	vcpu->arch.apic_base = MSR_IA32_APICBASE_ENABLE;
 	static_key_slow_inc(&apic_sw_disabled.key); /* sw disabled at reset */
-	kvm_lapic_reset(vcpu, false);
 	kvm_iodevice_init(&apic->dev, &apic_mmio_ops);
 
 	return 0;
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7793,6 +7793,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu
 	if (r)
 		return r;
 	kvm_vcpu_reset(vcpu, false);
+	kvm_lapic_reset(vcpu, false);
 	kvm_mmu_setup(vcpu);
 	vcpu_put(vcpu);
 	return r;
