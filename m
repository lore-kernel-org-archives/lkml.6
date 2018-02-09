Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184915-2-11704026913094223873
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184915; b=XZe15RyspUMhGFG1AMKwecQgHBPUrWlm6UH2ZiJscyTJZAu
    OhdzQuwq+hKnpCAU8uiuwSP2BiEaIl7DDTFHabFBg0rRU2h4oZvywX1VquTpoUxI
    xBQcaPlycmPURcGgUB0zk9+T9bXj1v4Fogg5rHBeZ/dyaduao43vvc9kB+A8Rma+
    ca+G8jcj1vxj18DAaa7v6D1OrGas+ZSKP4fZyw/bLi78FSC+J4SjnT411k4BET/U
    ciGZBB92KH1PrjcLvxeWiIGdLtWIaB4bxi/GJnl1L/jMBpqaDTAWtynZC3f8vPtZ
    CRBrLALB3ty+rqk3SniFvjnheMaY0DdvsanJTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184915; bh=ttWVbdMXa9DZ0T/nHgcR4eE4dh
    9ers3fux5iACXkVYk=; b=iZzUAXgBTLA7eZ5MzQ6w0TOw2M1QUKPHcLBufYO13I
    5pdJLqZONRUEgLqMPT2Jqwf7BeF/Aj7KoEiwuTKD6WVV9Y5ocGF6abQqTR9D1zUS
    XNJd40O2Jhyhk535TzfmiAHXtBez7JaZvSBbT0xBOTMNnEySb75rs7I0cEJvpDqY
    BS+qPdW51S98MF7PlNawUIFyuc9BIyY97QZl3fYqX9eEKmIExNvp401mY8K8+6PT
    nJlW7tXOvzY2gb8gSSNCYzwcDTCCroaqEXT2GIRmWNVRcW/4W6Yy2ToENljJbqj3
    AB//PsWfy139cKqRaL9xd9nKVEHW1QuhcXZOXlf2nB3A==
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
        id S1752813AbeBINoC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:44:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51184 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeBINoB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 80/92] KVM: VMX: introduce alloc_loaded_vmcs
Date: Fri,  9 Feb 2018 14:39:49 +0100
Message-Id: <20180209133936.956060769@linuxfoundation.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>


(cherry picked from commit f21f165ef922c2146cc5bdc620f542953c41714b)

Group together the calls to alloc_vmcs and loaded_vmcs_init.  Soon we'll also
allocate an MSR bitmap there.

Cc: stable@vger.kernel.org       # prereq for Spectre mitigation
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3522,11 +3522,6 @@ static struct vmcs *alloc_vmcs_cpu(int c
 	return vmcs;
 }
 
-static struct vmcs *alloc_vmcs(void)
-{
-	return alloc_vmcs_cpu(raw_smp_processor_id());
-}
-
 static void free_vmcs(struct vmcs *vmcs)
 {
 	free_pages((unsigned long)vmcs, vmcs_config.order);
@@ -3545,6 +3540,22 @@ static void free_loaded_vmcs(struct load
 	WARN_ON(loaded_vmcs->shadow_vmcs != NULL);
 }
 
+static struct vmcs *alloc_vmcs(void)
+{
+	return alloc_vmcs_cpu(raw_smp_processor_id());
+}
+
+static int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
+{
+	loaded_vmcs->vmcs = alloc_vmcs();
+	if (!loaded_vmcs->vmcs)
+		return -ENOMEM;
+
+	loaded_vmcs->shadow_vmcs = NULL;
+	loaded_vmcs_init(loaded_vmcs);
+	return 0;
+}
+
 static void free_kvm_area(void)
 {
 	int cpu;
@@ -6943,6 +6954,7 @@ static int handle_vmon(struct kvm_vcpu *
 	struct vmcs *shadow_vmcs;
 	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
 		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+	int r;
 
 	/* The Intel VMX Instruction Reference lists a bunch of bits that
 	 * are prerequisite to running VMXON, most notably cr4.VMXE must be
@@ -6982,11 +6994,9 @@ static int handle_vmon(struct kvm_vcpu *
 		return 1;
 	}
 
-	vmx->nested.vmcs02.vmcs = alloc_vmcs();
-	vmx->nested.vmcs02.shadow_vmcs = NULL;
-	if (!vmx->nested.vmcs02.vmcs)
+	r = alloc_loaded_vmcs(&vmx->nested.vmcs02);
+	if (r < 0)
 		goto out_vmcs02;
-	loaded_vmcs_init(&vmx->nested.vmcs02);
 
 	if (cpu_has_vmx_msr_bitmap()) {
 		vmx->nested.msr_bitmap =
@@ -9107,17 +9117,15 @@ static struct kvm_vcpu *vmx_create_vcpu(
 	if (!vmx->guest_msrs)
 		goto free_pml;
 
-	vmx->loaded_vmcs = &vmx->vmcs01;
-	vmx->loaded_vmcs->vmcs = alloc_vmcs();
-	vmx->loaded_vmcs->shadow_vmcs = NULL;
-	if (!vmx->loaded_vmcs->vmcs)
-		goto free_msrs;
 	if (!vmm_exclusive)
 		kvm_cpu_vmxon(__pa(per_cpu(vmxarea, raw_smp_processor_id())));
-	loaded_vmcs_init(vmx->loaded_vmcs);
+	err = alloc_loaded_vmcs(&vmx->vmcs01);
 	if (!vmm_exclusive)
 		kvm_cpu_vmxoff();
+	if (err < 0)
+		goto free_msrs;
 
+	vmx->loaded_vmcs = &vmx->vmcs01;
 	cpu = get_cpu();
 	vmx_vcpu_load(&vmx->vcpu, cpu);
 	vmx->vcpu.cpu = cpu;
