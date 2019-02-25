Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE40C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B774213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129995;
	bh=SPJTYv1fiYnKR0k1jZP0u6SftH0dtd+Ob4q0otKErQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jdn647tIvwDJ2YKLzvwSP8NnPGigoHhwc/rE+CQmeOjtxjYAbfK76xh8srhwi/TRd
	 p4VAgiJl0iNdUgWiy9bMVFw9xwU5wDaPj0IIPvu852zA91m06phUJX/sJJdPguxK0p
	 Mw+0J7mP93VLwoWJFd7C3je2ybE/DSZZKIQkG4oA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfBYV0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:26:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729280AbfBYV0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 229BE20C01;
        Mon, 25 Feb 2019 21:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129991;
        bh=SPJTYv1fiYnKR0k1jZP0u6SftH0dtd+Ob4q0otKErQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVh4QemDDnhGvFSV6QslWe2qD5zSHXXvq9vvOD4cbrthKI6IE/rDHfwShCqFyXAmH
         cxNcwSloUGy4NekHvO8jGQwMwFNmH8TFc7wh8zoXWByHn2Cy/VERNTjvY26Xyi1cnJ
         c4cNdXZie2lyXSxfTyrJYaUuOzn9/JwVojIfMAYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Zhang <yu.c.zhang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 131/152] kvm: x86: Return LA57 feature based on hardware capability
Date:   Mon, 25 Feb 2019 22:12:03 +0100
Message-Id: <20190225195052.522173520@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Zhang <yu.c.zhang@linux.intel.com>

commit 511da98d207d5c0675a10351b01e37cbe50a79e5 upstream.

Previously, 'commit 372fddf70904 ("x86/mm: Introduce the 'no5lvl' kernel
parameter")' cleared X86_FEATURE_LA57 in boot_cpu_data, if Linux chooses
to not run in 5-level paging mode. Yet boot_cpu_data is queried by
do_cpuid_ent() as the host capability later when creating vcpus, and Qemu
will not be able to detect this feature and create VMs with LA57 feature.

As discussed earlier, VMs can still benefit from extended linear address
width, e.g. to enhance features like ASLR. So we would like to fix this,
by return the true hardware capability when Qemu queries.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/cpuid.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -337,6 +337,7 @@ static inline int __do_cpuid_ent(struct
 	unsigned f_mpx = kvm_mpx_supported() ? F(MPX) : 0;
 	unsigned f_xsaves = kvm_x86_ops->xsaves_supported() ? F(XSAVES) : 0;
 	unsigned f_umip = kvm_x86_ops->umip_emulated() ? F(UMIP) : 0;
+	unsigned f_la57 = 0;
 
 	/* cpuid 1.edx */
 	const u32 kvm_cpuid_1_edx_x86_features =
@@ -491,7 +492,10 @@ static inline int __do_cpuid_ent(struct
 			// TSC_ADJUST is emulated
 			entry->ebx |= F(TSC_ADJUST);
 			entry->ecx &= kvm_cpuid_7_0_ecx_x86_features;
+			f_la57 = entry->ecx & F(LA57);
 			cpuid_mask(&entry->ecx, CPUID_7_ECX);
+			/* Set LA57 based on hardware capability. */
+			entry->ecx |= f_la57;
 			entry->ecx |= f_umip;
 			/* PKU is not yet implemented for shadow paging. */
 			if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))


