Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75830C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3617E2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYIHXMgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3617E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeKHSuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:50:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34349 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKHSuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:50:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id y18-v6so6646843pfn.1;
        Thu, 08 Nov 2018 01:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qnZeUnqhcwg+sgRRpHhl3xeCjMEI8GDTWinkp6r9EUA=;
        b=rYIHXMgSSEM4AVSxH4EPlBjMUhrOqYGTn2alQ9uUS+QxHhe0DoHoJUc4JWMc5zJ963
         yuxLFUZhEJxJdKwRuzQr71FxMFb7Ud7IP3zixx7EVMqplnoJPOEyPIcaGrAY+uxPweBQ
         ay+b8TJ3iVZynk2kf2q0sE6lPpl9IivyLx9zolQCVfOXZym4WDB0z7sDRrmGKKnGr/1C
         CAg8oYIwZ30eg62WNsuiMznmAkgqR/iUJHkbM81uwv+NCGOSBgWPckLg+l+0h3hUT+CY
         ReVxJcUdorTCDaS66st4OQrdUfWcQLzf49HlM1Gmrkb3FscFpaCV9S7noL8rWHARQpUu
         vgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qnZeUnqhcwg+sgRRpHhl3xeCjMEI8GDTWinkp6r9EUA=;
        b=SHvLRtHchG8ctyf6mRfWWPcYayzDX5+fjvMp4eVeeIje9cbv9Xxdi/bKdPaOhiQUR5
         VpZdmJTzu5jjOTFaqKheXJY1eNyhlrnTSStrNW3LrGiRy5q7hmLLEwkjbPez1u0oJnUP
         9RIRTA4ufZ7rHu6ER5PfVC9BZRUy+j+DBv33DM/e9I+b2kJJGtidLVolJCVCXe9VVnL3
         2n8Uk7zlDw5xy1a1KTXp2wDcrWjaidjRNvJ5vsm4wKNgcFhJ9ZMg9ZfGHHwXlE8U6NGB
         4OJunB1AFOSe1up+kldiOuq7Wq/MD2/yVC8jl7Bu0kYn/UJ07Yx7Xidsfk1+t6Aq6lg8
         ukCQ==
X-Gm-Message-State: AGRZ1gJaHOshKPFTONOZm4xCmdlbMI1w9VIyGtyBsSvXj6vSsSXE7oB7
        ggQEK9V9lnfEGBf2oMIKniI=
X-Google-Smtp-Source: AJdET5e/YfsxrqewWUNch5xifPripCFpe9eaVa/+bH3/JZoQDnUMFLB9dz3x7nsjPS6Ux8JquGpGAA==
X-Received: by 2002:a62:3c6:: with SMTP id 189-v6mr3783054pfd.19.1541668562678;
        Thu, 08 Nov 2018 01:16:02 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id w66-v6sm3284114pfb.51.2018.11.08.01.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 01:16:02 -0800 (PST)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, linux@armlinux.org.uk
Subject: [PATCH V5 8/10] KVM/MMU: Move tlb flush in kvm_set_pte_rmapp() to kvm_mmu_notifier_change_pte()
Date:   Thu,  8 Nov 2018 17:14:45 +0800
Message-Id: <20181108091447.8275-9-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108091447.8275-1-Tianyu.Lan@microsoft.com>
References: <20181108091447.8275-1-Tianyu.Lan@microsoft.com>
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

