Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C61C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87DF2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545998030;
	bh=8bUjnpgTLAKQAsYW9pHIKnqdDPUse3rBj51YH2XJphc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kr+QKli+mS1UXs3kngtOnJ3REwW6+1lTfMaoXvv1u7MoXUhdFtzQZ0HP/fzmlSE62
	 X9Cfx0bVpN+SN7Mun9UElDkXg/qqd2ir4sEGtls4m9Y7hJ0EU1AHid6e4ZmT1J/lMd
	 9cNuPWSRLrQQaFcvuwRAweJjk9Vpl60ZNse+0Rh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbeL1Lxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:53:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732336AbeL1Lxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:53:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1B42184B;
        Fri, 28 Dec 2018 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545998024;
        bh=8bUjnpgTLAKQAsYW9pHIKnqdDPUse3rBj51YH2XJphc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KhSZd+BtS1nz4Mzfz0pEO90idTdV/UF/O+p0MrwsUBGdotfobU4yUKXVTraJB1Chu
         9W+MwJIqh8MmzlP/sqVgP1pQ5GO+hVzI3R30eAXuHfOOttwA+nzVq/SjRryx1K+wnk
         sY+ejmTFOkgXMEnFSBXHxoDmqxA4VR3d2GgrVJb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 22/46] kvm: x86: Add AMDs EX_CFG to the list of ignored MSRs
Date:   Fri, 28 Dec 2018 12:52:16 +0100
Message-Id: <20181228113126.062523818@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

From: Eduardo Habkost <ehabkost@redhat.com>

commit 0e1b869fff60c81b510c2d00602d778f8f59dd9a upstream.

Some guests OSes (including Windows 10) write to MSR 0xc001102c
on some cases (possibly while trying to apply a CPU errata).
Make KVM ignore reads and writes to that MSR, so the guest won't
crash.

The MSR is documented as "Execution Unit Configuration (EX_CFG)",
at AMD's "BIOS and Kernel Developer's Guide (BKDG) for AMD Family
15h Models 00h-0Fh Processors".

Cc: stable@vger.kernel.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/msr-index.h |    1 +
 arch/x86/kvm/x86.c               |    2 ++
 2 files changed, 3 insertions(+)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -389,6 +389,7 @@
 #define MSR_F15H_NB_PERF_CTR		0xc0010241
 #define MSR_F15H_PTSC			0xc0010280
 #define MSR_F15H_IC_CFG			0xc0011021
+#define MSR_F15H_EX_CFG			0xc001102c
 
 /* Fam 10h MSRs */
 #define MSR_FAM10H_MMIO_CONF_BASE	0xc0010058
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2343,6 +2343,7 @@ int kvm_set_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
 	case MSR_AMD64_DC_CFG:
+	case MSR_F15H_EX_CFG:
 		break;
 
 	case MSR_IA32_UCODE_REV:
@@ -2638,6 +2639,7 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_BU_CFG2:
 	case MSR_IA32_PERF_CTL:
 	case MSR_AMD64_DC_CFG:
+	case MSR_F15H_EX_CFG:
 		msr_info->data = 0;
 		break;
 	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:


