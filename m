Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C75BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61FB20675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999653;
	bh=K3WWvwiU65vjCkT4POSAvgmoumTzYrOoZVg/gM6fGFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VzTB40ljXGiNSWnPB99MqAs6RIqP/6fMMx3UUxO6MSN8yXpb4O+GmjIwnimxUNE7/
	 7KnnRZdBClH4lpxbdie5m0Gl4wvYAmPGHICfxo6Gc44IvDfR7hqIenM+BN5FxBpuw5
	 C2BJmaqiXCeMihrAbkgBKEbxyeCAtAo8otoxvrV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbeL1MQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:16:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732637AbeL1MQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AABC42184B;
        Fri, 28 Dec 2018 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999373;
        bh=K3WWvwiU65vjCkT4POSAvgmoumTzYrOoZVg/gM6fGFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8pvJEb2YjCOf0zUax/31krZOAKmo26UYU3zh15cp0yHxcFKmez3s0oIFnh6loS4G
         b1wiwFO9pnPsrcPFETlRw2HsuE7CgMPI26bB/EPB9VGBpGlwhIf0KyNL1y2zVGau3Z
         N35J7LI5XtW0PEiRqa4iGM40t2OrEWR7mmppY3JQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 24/36] kvm: x86: Add AMDs EX_CFG to the list of ignored MSRs
Date:   Fri, 28 Dec 2018 12:52:40 +0100
Message-Id: <20181228113128.219016224@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -372,6 +372,7 @@
 #define MSR_F15H_NB_PERF_CTR		0xc0010241
 #define MSR_F15H_PTSC			0xc0010280
 #define MSR_F15H_IC_CFG			0xc0011021
+#define MSR_F15H_EX_CFG			0xc001102c
 
 /* Fam 10h MSRs */
 #define MSR_FAM10H_MMIO_CONF_BASE	0xc0010058
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2227,6 +2227,7 @@ int kvm_set_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
 	case MSR_AMD64_DC_CFG:
+	case MSR_F15H_EX_CFG:
 		break;
 
 	case MSR_IA32_UCODE_REV:
@@ -2508,6 +2509,7 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_BU_CFG2:
 	case MSR_IA32_PERF_CTL:
 	case MSR_AMD64_DC_CFG:
+	case MSR_F15H_EX_CFG:
 		msr_info->data = 0;
 		break;
 	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:


