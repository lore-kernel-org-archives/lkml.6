Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFB0ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342EE2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+Ieh8f3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342EE2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeKIAWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:22:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40825 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeKIAWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:22:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so7069544pgp.7;
        Thu, 08 Nov 2018 06:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yiyADj8185+lR6YtIPxI/9OlNcR1QogQW5VAb4fNZlE=;
        b=u+Ieh8f3qfjTxqUeTZ2algF1CEGnXeJx1sAg9socsFBe0+RezxQX80e5prVeAOHZmY
         icR0KXzvJL4vGN0ROj0jg1ryZEx+Gi3Fb4hx4weXtMyfy2+eiUizNHGkrTX/olcFiFOY
         WZDOeg/4+xYx2ZTTYnRZtDTF/z8OjLoSW8BJtUozZVa1lLhI07D3GmBImm1/oN+GD7e7
         qA6K3aelJQQxFTmV3yZnIF5dj3IwsYxjYYEkhbLD0J3ibcbJSOoMKgjPuJL6BfT+XihI
         F62rPzVl+6qgi2bTAfx30crPQUsf/q/kFe8Ej9KOG8ocX811swqDCQUfbN03fBEreMOi
         Hnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yiyADj8185+lR6YtIPxI/9OlNcR1QogQW5VAb4fNZlE=;
        b=DZ6T4FF0wHSZuyWu1f3f/LuRnAZ4Bo59qYIJOsCK/WLYcS/DF1XC2YKbIOyxsu3DsQ
         5zAbqkmfQ9w0FzDK9B2VNPBmEs65h5U06UTnc34CdypHbWS3blzdt3IzkJa/3+Ijd2J3
         qIs6ZlGBOKtf2rcCsvcUEhJDW67VOLE2Pk/S+JfqLjXpOxTXWEpwf9voruVzjZk8Jbwg
         F50L9WlMTRCWdw4oKryc9xp34wOS/rjHnhl9cNgeIIQpPII1urJmiqRfj4nnbn7u6bHx
         Kqfvyocm2Yksn7pd2RDqIkp7kEbj2OZHEmRBQsVXgU49UAQW7FqkPzvJCSx6KQhzh0a4
         S34w==
X-Gm-Message-State: AGRZ1gIgZX0IEPi8AbwbmjBFVRStIxrPHUX3llRjML69jUuVPFLRiZ9Y
        eN83qZSQYPOsJYpsKWklmVQ=
X-Google-Smtp-Source: AJdET5feGS/RXRvm4uJ38TQRmWSiiTRsWmdCxatvMEDX3Rva1bkcCH0h71uVKtGhhB9g0GT/xwrfeg==
X-Received: by 2002:a63:5e43:: with SMTP id s64mr4024148pgb.101.1541688411056;
        Thu, 08 Nov 2018 06:46:51 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id k75-v6sm11526731pfb.119.2018.11.08.06.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:46:50 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devel@linuxdriverproject.org, kvm@vger.kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com
Subject: [Resend PATCH V5 1/10] KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
Date:   Thu,  8 Nov 2018 22:46:30 +0800
Message-Id: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Add flush range call back in the kvm_x86_ops and platform can use it
to register its associated function. The parameter "kvm_tlb_range"
accepts a single range and flush list which contains a list of ranges.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Change "end_gfn" to "pages" to aviod confusion as to whether
"end_gfn" is inclusive or exlusive.
---
 arch/x86/include/asm/kvm_host.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55e51ff7e421..c8a65f0a7107 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -439,6 +439,11 @@ struct kvm_mmu {
 	u64 pdptrs[4]; /* pae */
 };
 
+struct kvm_tlb_range {
+	u64 start_gfn;
+	u64 pages;
+};
+
 enum pmc_type {
 	KVM_PMC_GP = 0,
 	KVM_PMC_FIXED,
@@ -1042,6 +1047,8 @@ struct kvm_x86_ops {
 
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 	int  (*tlb_remote_flush)(struct kvm *kvm);
+	int  (*tlb_remote_flush_with_range)(struct kvm *kvm,
+			struct kvm_tlb_range *range);
 
 	/*
 	 * Flush any TLB entries associated with the given GVA.
-- 
2.14.4

