Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeB1GDj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:03:39 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:38506 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeB1GDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:03:37 -0500
X-Google-Smtp-Source: AG47ELvibT9MjTSWVoMywxUcgpwZoMg34ihQ+Xo1OTCkQIDTpUX37BVHDqC8Z1gcXrYqDLG5TkN0tQ==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>, Nadav Amit <nadav.amit@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH RESEND v5 1/2] KVM: X86: Introduce kvm_get_msr_feature()
Date: Wed, 28 Feb 2018 14:03:30 +0800
Message-Id: <1519797811-4560-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Introduce kvm_get_msr_feature() to handle the msrs which are supported 
by different vendors and sharing the same emulation logic.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/x86.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d4985a9..efc8554 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1062,13 +1062,25 @@ static u32 msr_based_features[] = {
 
 static unsigned int num_msr_based_features;
 
+static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
+{
+	switch (msr->index) {
+	default:
+		if (kvm_x86_ops->get_msr_feature(msr))
+			return 1;
+	}
+	return 0;
+}
+
 static int do_get_msr_feature(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 {
 	struct kvm_msr_entry msr;
+	int r;
 
 	msr.index = index;
-	if (kvm_x86_ops->get_msr_feature(&msr))
-		return 1;
+	r = kvm_get_msr_feature(&msr);
+	if (r)
+		return r;
 
 	*data = msr.data;
 
@@ -4538,7 +4550,7 @@ static void kvm_init_msr_list(void)
 		struct kvm_msr_entry msr;
 
 		msr.index = msr_based_features[i];
-		if (kvm_x86_ops->get_msr_feature(&msr))
+		if (kvm_get_msr_feature(&msr))
 			continue;
 
 		if (j < i)
-- 
2.7.4
