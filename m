Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F2AC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE549218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfBCNyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:54:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54518 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729091AbfBCNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:46 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEO-0003ts-8a; Sun, 03 Feb 2019 13:54:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIAM-0007Rv-Mt; Sun, 03 Feb 2019 14:50:34 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Eduardo Habkost" <ehabkost@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.827425857@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 294/305] kvm: x86: Add AMD's EX_CFG to the list of
 ignored MSRs
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eduardo Habkost <ehabkost@redhat.com>

commit 0e1b869fff60c81b510c2d00602d778f8f59dd9a upstream.

Some guests OSes (including Windows 10) write to MSR 0xc001102c
on some cases (possibly while trying to apply a CPU errata).
Make KVM ignore reads and writes to that MSR, so the guest won't
crash.

The MSR is documented as "Execution Unit Configuration (EX_CFG)",
at AMD's "BIOS and Kernel Developer's Guide (BKDG) for AMD Family
15h Models 00h-0Fh Processors".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/uapi/asm/msr-index.h | 1 +
 arch/x86/kvm/x86.c                    | 2 ++
 2 files changed, 3 insertions(+)

--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -236,6 +236,7 @@
 #define MSR_F15H_PERF_CTR		0xc0010201
 #define MSR_F15H_NB_PERF_CTL		0xc0010240
 #define MSR_F15H_NB_PERF_CTR		0xc0010241
+#define MSR_F15H_EX_CFG			0xc001102c
 
 /* Fam 10h MSRs */
 #define MSR_FAM10H_MMIO_CONF_BASE	0xc0010058
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2086,6 +2086,7 @@ int kvm_set_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
 	case MSR_AMD64_DC_CFG:
+	case MSR_F15H_EX_CFG:
 		break;
 
 	case MSR_EFER:
@@ -2464,6 +2465,7 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_BU_CFG2:
 	case MSR_IA32_PERF_CTL:
 	case MSR_AMD64_DC_CFG:
+	case MSR_F15H_EX_CFG:
 		msr_info->data = 0;
 		break;
 	case MSR_P6_PERFCTR0:

