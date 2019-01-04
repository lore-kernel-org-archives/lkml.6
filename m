Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A29C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E700F21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSNQv0ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfADIzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:55:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40020 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfADIzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:55:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so17152346plq.7;
        Fri, 04 Jan 2019 00:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VAVkaVsyvHGb3944LCTx3RYQpKB8eIkyndjj2Ikvaks=;
        b=JSNQv0hto48d+cy9OmeC8+vpqtt4/8EI9u9HIqEmmUbj6f2TxB9IIfx/sXfdswigSu
         EfVz+80dJ8PkWlx+96miP5z94XhYM+ykxX3Fmq4clNe8KPorrdKxjWxhLblkovBxKOoE
         xNYBVIAgaXQScDW+EAKSKC9Vr5FCyiuV4d9SXDVbYKPiXlyZHItxqT9jBQmvUlY+lIX6
         QQxwdeg3r8Jc/hvz7dkxYLqoh+osKRZY5AyLcBIZ0cLUIsntPEjJnC3IB6sc65dcu4X5
         0h2aJEJSkwZD10HfzE989QUcENXgc2JHiKAXwoElzz9FnMX6UUYrCm3geYrKeF6nQ2K2
         q/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VAVkaVsyvHGb3944LCTx3RYQpKB8eIkyndjj2Ikvaks=;
        b=gouEeRzpn6TEdVDuQbn4PoAaZD95TxS/DO9XR1wvZql3KAqLDJzub0mBQbSbA6/2sb
         YstxyRPW8Cja7Dx97Hyr52eBeeo7d90JM60ZzrRLNET2XLIgPGQitYM874nmOdwO9jp6
         V9XaK6CM64tORSZqUzzEcOo4RKUNLG+5JdnJsYR9b4/qKMSkexjW0aO6uontBoD7Wm9y
         sFgV36Mhszs7RjL4Jj/XwZob802jLyXedd1JMAfv1Ygl99HYZMX+nZxTFo/3Mxd16Z5q
         ncogPwiFh1CJEkqittHyNEaTRKBscHa9qGZYJ57upUsmwXjsnGfscJ9/8HfSkk7nDPlH
         HuTw==
X-Gm-Message-State: AJcUuke/pL6SG5xDE6ts3voX5gaOBgmTwpHOGtjb8MTatj37Li8eCpwe
        quTGaWg4kcFd+Td/GLNmoAc=
X-Google-Smtp-Source: ALg8bN4OjtFEk71VDHPjiuzCk2TCpCOEwCai/Wt7CBSpw62HsAigCPIHdjQRvUBI364td6kTt3nr6A==
X-Received: by 2002:a17:902:7882:: with SMTP id q2mr51489397pll.305.1546592104889;
        Fri, 04 Jan 2019 00:55:04 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:55:04 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH 6/11] KVM/MMU: Flush tlb with range list in sync_page()
Date:   Fri,  4 Jan 2019 16:54:00 +0800
Message-Id: <20190104085405.40356-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb via flush list function.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/paging_tmpl.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 833e8855bbc9..866ccdea762e 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -973,6 +973,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	bool host_writable;
 	gpa_t first_pte_gpa;
 	int set_spte_ret = 0;
+	LIST_HEAD(flush_list);
 
 	/* direct kvm_mmu_page can not be unsync. */
 	BUG_ON(sp->role.direct);
@@ -980,6 +981,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);
 
 	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
+		int tmp_spte_ret = 0;
 		unsigned pte_access;
 		pt_element_t gpte;
 		gpa_t pte_gpa;
@@ -1029,14 +1031,24 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 
 		host_writable = sp->spt[i] & SPTE_HOST_WRITEABLE;
 
-		set_spte_ret |= set_spte(vcpu, &sp->spt[i],
+		tmp_spte_ret = set_spte(vcpu, &sp->spt[i],
 					 pte_access, PT_PAGE_TABLE_LEVEL,
 					 gfn, spte_to_pfn(sp->spt[i]),
 					 true, false, host_writable);
+
+		if (kvm_available_flush_tlb_with_range()
+		    && (tmp_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)) {
+			struct kvm_mmu_page *leaf_sp = page_header(sp->spt[i]
+					& PT64_BASE_ADDR_MASK);
+			list_add(&leaf_sp->flush_link, &flush_list);
+		}
+
+		set_spte_ret |= tmp_spte_ret;
+
 	}
 
 	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+		kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);
 
 	return nr_present;
 }
-- 
2.14.4

