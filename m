Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22436C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74CD20895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74CD20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbeG0LID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:08:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbeG0LID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:08:03 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B364AAF8;
        Fri, 27 Jul 2018 09:46:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.17 01/66] KVM: VMX: support MSR_IA32_ARCH_CAPABILITIES as a feature MSR
Date:   Fri, 27 Jul 2018 11:44:54 +0200
Message-Id: <20180727093809.193890627@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit cd28325249a1ca0d771557ce823e0308ad629f98 upstream.

This lets userspace read the MSR_IA32_ARCH_CAPABILITIES and check that all
requested features are available on the host.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1092,6 +1092,7 @@ static u32 msr_based_features[] = {
 
 	MSR_F10H_DECFG,
 	MSR_IA32_UCODE_REV,
+	MSR_IA32_ARCH_CAPABILITIES,
 };
 
 static unsigned int num_msr_based_features;
@@ -1100,7 +1101,8 @@ static int kvm_get_msr_feature(struct kv
 {
 	switch (msr->index) {
 	case MSR_IA32_UCODE_REV:
-		rdmsrl(msr->index, msr->data);
+	case MSR_IA32_ARCH_CAPABILITIES:
+		rdmsrl_safe(msr->index, &msr->data);
 		break;
 	default:
 		if (kvm_x86_ops->get_msr_feature(msr))


