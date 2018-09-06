Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73A0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7182A20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7182A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIFMgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:36:39 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:38954 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeIFMgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:36:39 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id B337999253F060502F3D;
        Thu,  6 Sep 2018 16:02:22 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w8682CnL089915;
        Thu, 6 Sep 2018 16:02:13 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018090616022007-7466155 ;
          Thu, 6 Sep 2018 16:02:20 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     pbonzini@redhat.com
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        zhong.weidong@zte.com.cn, xu.xi8@zte.com.cn
Subject: [PATCH] KVM: x86: fix failure of injecting exceptions in x86_emulate_instruction
Date:   Thu, 6 Sep 2018 16:02:44 +0800
Message-Id: <1536220964-8412-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-09-06 16:02:20,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-09-06 16:02:01,
        Serialize complete at 2018-09-06 16:02:01
X-MAIL: mse01.zte.com.cn w8682CnL089915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to fix a page table walk issue, commit 6ea6e84309ca
("KVM: x86: inject exceptions produced by x86_decode_insn") check
if variable ctxt->have_exception true and inject the exception.
Unfortunately, ctxt->have_exception is set to true only in function
x86_emulate_insn(), which won't be called before invoking
inject_emulated_exception() in the 6ea6e84309ca.
This patch fix this issue.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Xi Xu <xu.xi8@zte.com.cn>
---
 arch/x86/kvm/emulate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 106482d..aecf9a72 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5105,8 +5105,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
 		memcpy(ctxt->fetch.data, insn, insn_len);
 	else {
 		rc = __do_insn_fetch_bytes(ctxt, 1);
-		if (rc != X86EMUL_CONTINUE)
+		if (rc != X86EMUL_CONTINUE) {
+			if (rc == X86EMUL_PROPAGATE_FAULT)
+				ctxt->have_exception = true;
 			return rc;
+		}
 	}
 
 	switch (mode) {
-- 
1.8.3.1

