Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52483C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A51C2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789898;
	bh=1X8t8dYrTc2KwG9eMfWFB1VM1dbbljcsmJ1QnUXMPWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BNgjM3/K5ZlMxaJfb2l+XYuYxicdjHD1niLePrfr5Arto4kIaU8jWTuLGtG45r46l
	 xOPKeScOwshY7n+n38ZBO4Du/Lt480i9zDkCyqGoOY3LmShYLDEdMJR9AcGvasySCH
	 jgB9KreOsy7/3Z9zgQ1JE5y7PVV7FMOnHC44dQ1g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A51C2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbeLNMSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732792AbeLNMQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FEA62133F;
        Fri, 14 Dec 2018 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789799;
        bh=1X8t8dYrTc2KwG9eMfWFB1VM1dbbljcsmJ1QnUXMPWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=haTqMLyb6ATddwoX44yxUHrX/re4/ldy55hm0q1SMLmm6LA9P4UHQHeGj3aX3Svrf
         Xwlw0y8aHN4LqvEz4vR4kjk80MgpN6Ps9IwBcpamRuw+gOJBUQ/GV0KtIVQ06bFQCg
         xMnvkKjXYrfojGcFXDkXFIZxntzt/ebVi8S36nHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?J=C3=B6rg=20Otte?= <jrg.otte@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 60/88] x86/speculation: Use synthetic bits for IBRS/IBPB/STIBP
Date:   Fri, 14 Dec 2018 13:00:34 +0100
Message-Id: <20181214115707.366708521@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit e7c587da125291db39ddf1f49b18e5970adbac17 upstream.

Intel and AMD have different CPUID bits hence for those use synthetic bits
which get set on the respective vendor's in init_speculation_control(). So
that debacles like what the commit message of

  c65732e4f721 ("x86/cpu: Restore CPUID_8000_0008_EBX reload")

talks about don't happen anymore.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Tested-by: Jörg Otte <jrg.otte@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Link: https://lkml.kernel.org/r/20180504161815.GG9257@pd.tnic
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 4.4: This was partly applied before; apply just the
 missing bits]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.c |   10 +++++-----
 arch/x86/kvm/cpuid.h |    4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -343,7 +343,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(IBPB) | F(IBRS);
+		F(AMD_IBPB) | F(AMD_IBRS);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_supported_word5_x86_features =
@@ -596,10 +596,10 @@ static inline int __do_cpuid_ent(struct
 		entry->eax = g_phys_as | (virt_as << 8);
 		entry->edx = 0;
 		/* IBRS and IBPB aren't necessarily present in hardware cpuid */
-		if (boot_cpu_has(X86_FEATURE_IBPB))
-			entry->ebx |= F(IBPB);
-		if (boot_cpu_has(X86_FEATURE_IBRS))
-			entry->ebx |= F(IBRS);
+		if (boot_cpu_has(X86_FEATURE_AMD_IBPB))
+			entry->ebx |= F(AMD_IBPB);
+		if (boot_cpu_has(X86_FEATURE_AMD_IBRS))
+			entry->ebx |= F(AMD_IBRS);
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
 		break;
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -164,7 +164,7 @@ static inline bool guest_cpuid_has_ibpb(
 	struct kvm_cpuid_entry2 *best;
 
 	best = kvm_find_cpuid_entry(vcpu, 0x80000008, 0);
-	if (best && (best->ebx & bit(X86_FEATURE_IBPB)))
+	if (best && (best->ebx & bit(X86_FEATURE_AMD_IBPB)))
 		return true;
 	best = kvm_find_cpuid_entry(vcpu, 7, 0);
 	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
@@ -175,7 +175,7 @@ static inline bool guest_cpuid_has_spec_
 	struct kvm_cpuid_entry2 *best;
 
 	best = kvm_find_cpuid_entry(vcpu, 0x80000008, 0);
-	if (best && (best->ebx & bit(X86_FEATURE_IBRS)))
+	if (best && (best->ebx & bit(X86_FEATURE_AMD_IBRS)))
 		return true;
 	best = kvm_find_cpuid_entry(vcpu, 7, 0);
 	return best && (best->edx & (bit(X86_FEATURE_SPEC_CTRL) | bit(X86_FEATURE_SPEC_CTRL_SSBD)));


