Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AD6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0795222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbfBNEMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:12:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:53764 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbfBNEMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:12:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 20:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,367,1544515200"; 
   d="scan'208";a="318870398"
Received: from lxy-dell.sh.intel.com ([10.239.159.147])
  by fmsmga006.fm.intel.com with ESMTP; 13 Feb 2019 20:11:58 -0800
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] kvm: vmx: Fix entry nubmer check for add_atomic_switch_msr()
Date:   Thu, 14 Feb 2019 12:08:58 +0800
Message-Id: <20190214040858.15975-1-xiaoyao.li@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ca83b4a7f2d068da79a0 ("x86/KVM/VMX: Add find_msr() helper function")
introduces the helper function find_msr(), which returns -ENOENT when
not find the msr in vmx->msr_autoload.guest/host. Correct checking contion
of no more available entry in vmx->msr_autoload.

Fixes: ca83b4a7f2d0 ("x86/KVM/VMX: Add find_msr() helper function")
Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 95d618045001..1aaef2d536bd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -863,7 +863,8 @@ static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
 	if (!entry_only)
 		j = find_msr(&m->host, msr);
 
-	if (i == NR_AUTOLOAD_MSRS || j == NR_AUTOLOAD_MSRS) {
+	if ((i < 0 && m->guest.nr == NR_AUTOLOAD_MSRS) ||
+		(j < 0 &&  m->host.nr == NR_AUTOLOAD_MSRS)) {
 		printk_once(KERN_WARNING "Not enough msr switch entries. "
 				"Can't add msr %x\n", msr);
 		return;
-- 
2.19.1

