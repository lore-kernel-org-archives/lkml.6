Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FFEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFA62176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQrmXhYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfBDSP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:15:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41183 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:15:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so282460pfi.8;
        Mon, 04 Feb 2019 10:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YZe004olxwKUVDNhwEwrZ8AUV4iVt97unB7E5kh6nQ4=;
        b=IQrmXhYJn+hqxmnp2CKgxQtlZ/Plcxr3XKvJAlVd5LVl4ehyQEQyTW3i6g9aDkFdWB
         BlSQvYrHO04cqFRXHDFceoyzCyJjkEUYcdv8SMX3X8kEcAFyGnZZnQy3YTjYAAoKzZzL
         37CyqRl4Xz3IG9WZGdn/ub1I0CoSEBtCocL0KPfAtM/Pq8+/TphetVo8ZCIOKRkSMe/e
         6zdTFFr4eBZmo16fnkCw3kEFRC29XwHCOtqP8uxcfKFLPIb9OtClIu6+Ed1cZ6kCaIqz
         YrpTH1YSNpQoSXSdmT38pszxTEWgFqbZ+qx5I7iUCxMXnWy77QKrrIdOErtX/PYZ/ZRv
         s1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YZe004olxwKUVDNhwEwrZ8AUV4iVt97unB7E5kh6nQ4=;
        b=RZBzVY5Xtgk3uvGrp08r4Mv9ddknGM3TUPCwNMN11AdGNFa79LTOBs0o9xHTmIXbwr
         FpBQJWBerPzWEFFb0wVK1KxWRKY0V/rYbhdk/RRjF2e8TV6DO2BLlefcPu4z2st3BjZ4
         ClYbUN/ex6oH95KUhs69ZZrgBy5dCE7kFms0vKPTKvSZzrn4ArjXl1fGlScP0mWamanl
         dMvOyIRKkpL1xFHhRdadyZ+8atzoNwfh91KGC36Q05qITTI7ywAaFTGFgXPEGljLj9kk
         W5hv09okoDRXrm1iJYrL9xJiCR/IqXJrf9uZKHTlaRhGoDLxIP5tqHA7miFV1Dl+1fxh
         DQEg==
X-Gm-Message-State: AHQUAuZns8SO5zgv41qfomIxZ0zh/aIIkrXO8HOAsoxkeuHLO4BC4WR5
        HTRtWqOtPeN58UVVwPW+/Cs=
X-Google-Smtp-Source: AHgI3IYghO9Gyc5CdVnnZDhQJpFkPxKmWnw3rcVOoUNENx3bnkpWEbZ8P5nJPUmckNTyGdk2ogPr6Q==
X-Received: by 2002:a63:1f64:: with SMTP id q36mr580276pgm.230.1549304153874;
        Mon, 04 Feb 2019 10:15:53 -0800 (PST)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id q5sm2033090pfi.165.2019.02.04.10.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 10:15:53 -0800 (PST)
Subject: [RFC PATCH 3/4] kvm: Add guest side support for free memory hints
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, alexander.h.duyck@linux.intel.com,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org
Date:   Mon, 04 Feb 2019 10:15:52 -0800
Message-ID: <20190204181552.12095.46287.stgit@localhost.localdomain>
In-Reply-To: <20190204181118.12095.38300.stgit@localhost.localdomain>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Add guest support for providing free memory hints to the KVM hypervisor for
freed pages huge TLB size or larger. I am restricting the size to
huge TLB order and larger because the hypercalls are too expensive to be
performing one per 4K page. Using the huge TLB order became the obvious
choice for the order to use as it allows us to avoid fragmentation of higher
order memory on the host.

I have limited the functionality so that it doesn't work when page
poisoning is enabled. I did this because a write to the page after doing an
MADV_DONTNEED would effectively negate the hint, so it would be wasting
cycles to do so.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 arch/x86/include/asm/page.h |   13 +++++++++++++
 arch/x86/kernel/kvm.c       |   23 +++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 7555b48803a8..4487ad7a3385 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -18,6 +18,19 @@
 
 struct page;
 
+#ifdef CONFIG_KVM_GUEST
+#include <linux/jump_label.h>
+extern struct static_key_false pv_free_page_hint_enabled;
+
+#define HAVE_ARCH_FREE_PAGE
+void __arch_free_page(struct page *page, unsigned int order);
+static inline void arch_free_page(struct page *page, unsigned int order)
+{
+	if (static_branch_unlikely(&pv_free_page_hint_enabled))
+		__arch_free_page(page, order);
+}
+#endif
+
 #include <linux/range.h>
 extern struct range pfn_mapped[];
 extern int nr_pfn_mapped;
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5c93a65ee1e5..09c91641c36c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -48,6 +48,7 @@
 #include <asm/tlb.h>
 
 static int kvmapf = 1;
+DEFINE_STATIC_KEY_FALSE(pv_free_page_hint_enabled);
 
 static int __init parse_no_kvmapf(char *arg)
 {
@@ -648,6 +649,15 @@ static void __init kvm_guest_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
 		apic_set_eoi_write(kvm_guest_apic_eoi_write);
 
+	/*
+	 * The free page hinting doesn't add much value if page poisoning
+	 * is enabled. So we only enable the feature if page poisoning is
+	 * no present.
+	 */
+	if (!page_poisoning_enabled() &&
+	    kvm_para_has_feature(KVM_FEATURE_PV_UNUSED_PAGE_HINT))
+		static_branch_enable(&pv_free_page_hint_enabled);
+
 #ifdef CONFIG_SMP
 	smp_ops.smp_prepare_cpus = kvm_smp_prepare_cpus;
 	smp_ops.smp_prepare_boot_cpu = kvm_smp_prepare_boot_cpu;
@@ -762,6 +772,19 @@ static __init int kvm_setup_pv_tlb_flush(void)
 }
 arch_initcall(kvm_setup_pv_tlb_flush);
 
+void __arch_free_page(struct page *page, unsigned int order)
+{
+	/*
+	 * Limit hints to blocks no smaller than pageblock in
+	 * size to limit the cost for the hypercalls.
+	 */
+	if (order < KVM_PV_UNUSED_PAGE_HINT_MIN_ORDER)
+		return;
+
+	kvm_hypercall2(KVM_HC_UNUSED_PAGE_HINT, page_to_phys(page),
+		       PAGE_SIZE << order);
+}
+
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 
 /* Kick a cpu by its apicid. Used to wake up a halted vcpu */

