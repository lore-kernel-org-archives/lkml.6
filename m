Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054A3C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD70C2168D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD70C2168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbeHNU0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:26:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbeHNU0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:26:17 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 658BED7D;
        Tue, 14 Aug 2018 17:38:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 094/104] KVM: VMX: support MSR_IA32_ARCH_CAPABILITIES as a feature MSR
Date:   Tue, 14 Aug 2018 19:17:48 +0200
Message-Id: <20180814171521.255652366@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit cd28325249a1ca0d771557ce823e0308ad629f98 upstream

This lets userspace read the MSR_IA32_ARCH_CAPABILITIES and check that all
requested features are available on the host.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1049,6 +1049,7 @@ static unsigned num_emulated_msrs;
 static u32 msr_based_features[] = {
 	MSR_F10H_DECFG,
 	MSR_IA32_UCODE_REV,
+	MSR_IA32_ARCH_CAPABILITIES,
 };
 
 static unsigned int num_msr_based_features;
@@ -1057,7 +1058,8 @@ static int kvm_get_msr_feature(struct kv
 {
 	switch (msr->index) {
 	case MSR_IA32_UCODE_REV:
-		rdmsrl(msr->index, msr->data);
+	case MSR_IA32_ARCH_CAPABILITIES:
+		rdmsrl_safe(msr->index, &msr->data);
 		break;
 	default:
 		if (kvm_x86_ops->get_msr_feature(msr))


