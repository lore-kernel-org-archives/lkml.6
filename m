Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE809C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA52207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA52207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeJXQe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:34:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:23573 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbeJXQe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:34:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 01:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="273987295"
Received: from skx-d.bj.intel.com ([10.238.135.53])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2018 01:07:20 -0700
From:   Luwei Kang <luwei.kang@intel.com>
To:     kvm@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, joro@8bytes.org,
        songliubraving@fb.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        konrad.wilk@oracle.com, mattst88@gmail.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        jpoimboe@redhat.com, marcorr@google.com, ubizjak@gmail.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v13 04/12] perf/x86/intel/pt: Add new bit definitions for PT MSRs
Date:   Wed, 24 Oct 2018 16:05:08 +0800
Message-Id: <1540368316-12998-5-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bit definitions for Intel PT MSRs to support trace output
directed to the memeory subsystem and holds a count if packet
bytes that have been sent out.

These are required by the upcoming PT support in KVM guests
for MSRs read/write emulation.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/msr-index.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d3a9eb9..107818e3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -126,6 +126,7 @@
 #define RTIT_CTL_USR			BIT(3)
 #define RTIT_CTL_PWR_EVT_EN		BIT(4)
 #define RTIT_CTL_FUP_ON_PTW		BIT(5)
+#define RTIT_CTL_FABRIC_EN		BIT(6)
 #define RTIT_CTL_CR3EN			BIT(7)
 #define RTIT_CTL_TOPA			BIT(8)
 #define RTIT_CTL_MTC_EN			BIT(9)
@@ -154,6 +155,8 @@
 #define RTIT_STATUS_BUFFOVF		BIT(3)
 #define RTIT_STATUS_ERROR		BIT(4)
 #define RTIT_STATUS_STOPPED		BIT(5)
+#define RTIT_STATUS_BYTECNT_OFFSET	32
+#define RTIT_STATUS_BYTECNT		(0x1ffffull << RTIT_STATUS_BYTECNT_OFFSET)
 #define MSR_IA32_RTIT_ADDR0_A		0x00000580
 #define MSR_IA32_RTIT_ADDR0_B		0x00000581
 #define MSR_IA32_RTIT_ADDR1_A		0x00000582
-- 
1.8.3.1

