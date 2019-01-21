Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E97C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3FC214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfAUH10 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:27:26 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:14070 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfAUH1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:27:25 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 9E1A2570E41E11EA08B0;
        Mon, 21 Jan 2019 15:27:22 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0L7RFfL000226;
        Mon, 21 Jan 2019 15:27:15 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012115272147-23317200 ;
          Mon, 21 Jan 2019 15:27:21 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     pbonzini@redhat.com
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn
Subject: [PATCH] [next] kvm: vmx: fix some -Wmissing-prototypes warnings
Date:   Mon, 21 Jan 2019 15:27:05 +0800
Message-Id: <1548055625-14569-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-21 15:27:21,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-21 15:27:15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn x0L7RFfL000226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get some warnings when building kernel with W=1:
arch/x86/kvm/vmx/vmx.c:426:5: warning: no previous prototype for ‘kvm_fill_hv_flush_list_func’ [-Wmissing-prototypes]
arch/x86/kvm/vmx/nested.c:58:6: warning: no previous prototype for ‘init_vmcs_shadow_fields’ [-Wmissing-prototypes]

Make them static to fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 arch/x86/kvm/vmx/vmx.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 2616bd2..f8af511 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -55,7 +55,7 @@ enum {
 static int max_shadow_read_write_fields =
 	ARRAY_SIZE(shadow_read_write_fields);
 
-void init_vmcs_shadow_fields(void)
+static void init_vmcs_shadow_fields(void)
 {
 	int i, j;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f6915f1..38641e6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -423,7 +423,7 @@ static void check_ept_pointer_match(struct kvm *kvm)
 	to_kvm_vmx(kvm)->ept_pointers_match = EPT_POINTERS_MATCH;
 }
 
-int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
+static int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
 		void *data)
 {
 	struct kvm_tlb_range *range = data;
-- 
1.8.3.1

