Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41225C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D5A2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYbTAqxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D5A2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbeITEan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:30:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43554 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeITEam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:30:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so7382025wre.10;
        Wed, 19 Sep 2018 15:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JMaI3bPtucmE0WoJZLzECfUji99F6c7hA0e1M9vZQyg=;
        b=YYbTAqxyuYOu6W3k+skjX1tF7rvgwkvW9/L9W6Hm+aHpLyirE57W5KwbYUczS3lOiT
         cKmkKv//BIs1OtaHdN7AIMGGG+dAOJjhi2CplUOt8tAkmsa7FrrZWoOI1lq1ROGVUWH0
         V0DV9zqQz6sDZIhWKK4odMdDXv1qfV4KUEZmPJnnM5yM3KcyRUSHY8GjPvPuEMu3g3Kl
         LVatmX407tAKb/aFtejli7+bRh9NCRKm9csKaVvoj25QxKOVAEEFvQkeTnaG3XKpcEPZ
         7rGf+JkZiowTeSaCih8ju3Awl9QD/TDP7z2exf0+pEtyZ+LidPdY25Iaid54Ni99AjF8
         rpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JMaI3bPtucmE0WoJZLzECfUji99F6c7hA0e1M9vZQyg=;
        b=Imz5SWIbv6X8FG/8khfLbWcnScNSAdK6Nyab7x1zZeWtYqEw6pYBacT8FMZXQjyaP2
         qXLnkDa36o/FrW0OoYnPJYBgh6R/6kW3q9bo89BCi42Fct0iGH1yZj5IcavlYfA0g5j3
         OW4ztKDEZjw6PjsbdOhFuYFJgXgnkocgMyCnMDLAA63ycRW5VC8Xcc7idQ+gWNLbO1hm
         8l7iCGhpkgAPfNA1Sk+Y1eFjE1uGqK9YzNBZeUYclVR+daPCnlPwsAp+1lR83WithdDD
         S8P38A5GZLIFI0KAk/kjM+HGsROmnnG9+6jsx06SPlOXcNnKsXcayqkMyVR3S1YrrnJT
         92kA==
X-Gm-Message-State: APzg51CfGkkhuG+cVF7YT6O93ZHZiTUigENUeNYOej9XDNVDByUQQiBj
        zYfJ1ARn+N0KO849pQv7cw83mcaF
X-Google-Smtp-Source: ANB0VdbwzmbHUZJJYtsSCXFFm3B9rdsKpeHBHY3dWRcO/8NtExCCeI4Pk4PgB8OoHnQXCYGVywqhnw==
X-Received: by 2002:adf:bacf:: with SMTP id w15-v6mr31630476wrg.203.1537397432613;
        Wed, 19 Sep 2018 15:50:32 -0700 (PDT)
Received: from 640k.lan (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.gmail.com with ESMTPSA id l10-v6sm46721117wre.0.2018.09.19.15.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 15:50:32 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 1/3] KVM: VMX: immediately mark preemption timer expired only for zero value
Date:   Thu, 20 Sep 2018 00:50:27 +0200
Message-Id: <1537397429-38588-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537397429-38588-1-git-send-email-pbonzini@redhat.com>
References: <1537397429-38588-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

A VMX preemption timer value of '0' at the time of VMEnter is
architecturally guaranteed to cause a VMExit prior to the CPU
executing any instructions in the guest.  This architectural
definition is in place to ensure that a previously expired timer
is correctly recognized by the CPU as it is possible for the timer
to reach zero and not trigger a VMexit due to a higher priority
VMExit being signalled instead, e.g. a pending #DB that morphs into
a VMExit.

Whether by design or coincidence, commit f4124500c2c1 ("KVM: nVMX:
Fully emulate preemption timer") special cased timer values of '0'
and '1' to ensure prompt delivery of the VMExit.  Unlike '0', a
timer value of '1' has no has no architectural guarantees regarding
when it is delivered.

Modify the timer emulation to trigger immediate VMExit if and only
if the timer value is '0', and document precisely why '0' is special.
Do this even if calibration of the virtual TSC failed, i.e. VMExit
will occur immediately regardless of the frequency of the timer.
Making only '0' a special case gives KVM leeway to be more aggressive
in ensuring the VMExit is injected prior to executing instructions in
the nested guest, and also eliminates any ambiguity as to why '1' is
a special case, e.g. why wasn't the threshold for a "short timeout"
set to 10, 100, 1000, etc...

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 533a327372c8..4655d6dd6759 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11427,16 +11427,18 @@ static void vmx_start_preemption_timer(struct kvm_vcpu *vcpu)
 	u64 preemption_timeout = get_vmcs12(vcpu)->vmx_preemption_timer_value;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	if (vcpu->arch.virtual_tsc_khz == 0)
-		return;
-
-	/* Make sure short timeouts reliably trigger an immediate vmexit.
-	 * hrtimer_start does not guarantee this. */
-	if (preemption_timeout <= 1) {
+	/*
+	 * A timer value of zero is architecturally guaranteed to cause
+	 * a VMExit prior to executing any instructions in the guest.
+	 */
+	if (preemption_timeout == 0) {
 		vmx_preemption_timer_fn(&vmx->nested.preemption_timer);
 		return;
 	}
 
+	if (vcpu->arch.virtual_tsc_khz == 0)
+		return;
+
 	preemption_timeout <<= VMX_MISC_EMULATED_PREEMPTION_TIMER_RATE;
 	preemption_timeout *= 1000000;
 	do_div(preemption_timeout, vcpu->arch.virtual_tsc_khz);
-- 
1.8.3.1


