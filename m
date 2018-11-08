Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32532ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F892081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaO3N/5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F892081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeKIAXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:23:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35687 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeKIAXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:23:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so8956525pgu.2;
        Thu, 08 Nov 2018 06:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qnZeUnqhcwg+sgRRpHhl3xeCjMEI8GDTWinkp6r9EUA=;
        b=kaO3N/5PDu8IaVMW5ezRIp1fXFvcxq7jEqnQ6avJGrCw4fdnFTqIRhoU8C+6jbfA2h
         zNxeDd10BQLTw3fcgs939NnOjVG3/kwguxbc21rOItRY7sfCurYGgDNHdOi/2CoaWeUA
         VI+Y3zW1G5hWGWPCh7h81a71nKsDGY5devxGAckD9nknri6gXn+sAnwKPZMvaDY1zqT2
         ADQfnrJ3z9Cz1DNV4fjbMCycuN6NFq0nHGzTg3HN8u0ub5VXid0KIwgOWdm2xHWboXEx
         jB77MB0i5+f0fshBYBe+yR4zDhFzJFFL+tZ9sWDCUvv0SkGiyvPEn5hJWLrWepkDZHTS
         nbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qnZeUnqhcwg+sgRRpHhl3xeCjMEI8GDTWinkp6r9EUA=;
        b=R971nUWzuMk4vAT3NVm/8K1DRe1vceYc8wHCZlGIZUANgph1X8KKEYGE/HzO85yihc
         aNLoaoNTzoxTS0tDynITENluj8L2I4vm3tGlpgdVV9jDuw74XWmygTRHb8Qad348o7y1
         PRhLCbR1n5AAWlm7lf+cKoMfb2//cntGHw81C2kxq0dBZ5ISmm1fpbiv8ceUcbedvUci
         pcU49EdDUAN5LARpZm7SiRYMLhve5jzuJcKrdoF+T+1DhFjFnL5DqmS979n8l3UzcE+W
         tRvl3xUdYATWXHSHX4dmkVakhVAMuUd+R3D4pg9l6PuhbpcoSfQb5hwCTHJe8XnoHBdh
         Jcrw==
X-Gm-Message-State: AGRZ1gKGvEo9zL9omDa+fISzPl7+2OpW0kUR7X0QI55MEB8qtDUEl8Vc
        qyC1RQGHVibIFuANiZGZ4Zw=
X-Google-Smtp-Source: AJdET5fXh1llMoO/kf7QggFmUCaOe5iB1Yb8m8mNYrqP4UTY1mXLSN5LSC8ETvGpvmfrxf4iW12hDg==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr4095695pgj.410.1541688462090;
        Thu, 08 Nov 2018 06:47:42 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id k75-v6sm11526731pfb.119.2018.11.08.06.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:47:41 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, linux@armlinux.org.uk
Subject: [Resend PATCH V5 8/10] KVM/MMU: Move tlb flush in kvm_set_pte_rmapp() to kvm_mmu_notifier_change_pte()
Date:   Thu,  8 Nov 2018 22:46:37 +0800
Message-Id: <20181108144639.11206-8-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
References: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to move tlb flush in kvm_set_pte_rmapp() to
kvm_mmu_notifier_change_pte() in order to avoid redundant tlb flush.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c  | 8 ++------
 virt/kvm/kvm_main.c | 5 ++++-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 06bfcd327ef6..b13b419166c4 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1776,10 +1776,7 @@ static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 		}
 	}
 
-	if (need_flush)
-		kvm_flush_remote_tlbs(kvm);
-
-	return 0;
+	return need_flush;
 }
 
 struct slot_rmap_walk_iterator {
@@ -1915,8 +1912,7 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
-	kvm_handle_hva(kvm, hva, (unsigned long)&pte, kvm_set_pte_rmapp);
-	return 0;
+	return kvm_handle_hva(kvm, hva, (unsigned long)&pte, kvm_set_pte_rmapp);
 }
 
 static int kvm_age_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2679e476b6c3..dac4b0446aed 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -354,7 +354,10 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 	idx = srcu_read_lock(&kvm->srcu);
 	spin_lock(&kvm->mmu_lock);
 	kvm->mmu_notifier_seq++;
-	kvm_set_spte_hva(kvm, address, pte);
+
+	if (kvm_set_spte_hva(kvm, address, pte))
+		kvm_flush_remote_tlbs(kvm);
+
 	spin_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, idx);
 }
-- 
2.14.4

