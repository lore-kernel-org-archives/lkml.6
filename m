Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C2DC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE632133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789902;
	bh=JMn3SSFj0g8NHb+MFh7WUwRpo0MvSNUGV1q8RiDG0zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vmO3ohn9HyNKRNp52nPOmMMMAmYDmj0bqb+yWcODhmmrvVo+SXHP8gSN9Aw3vPkCs
	 z1hzVjEaUJJ+QB71j7EFgpbAAfyvkgN2zt4tHOXuEjmxsRsMsIs60Wa0jB9gZk7sH9
	 8u0FJ3iHJdQDLtpM+kPn7vMv5Rg4BXixvDKk//nU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE632133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbeLNMQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:16:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732264AbeLNMQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E185214AE;
        Fri, 14 Dec 2018 12:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789793;
        bh=JMn3SSFj0g8NHb+MFh7WUwRpo0MvSNUGV1q8RiDG0zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wQ6hwG0wgqMKpB0XNpslLnJGNgov8+AlBuS9FJGqmE3xYIW+0NS7itERAIvDt/mmB
         McovjY6qVrXsplwC1Pn6QE68BR6ET9A2B3hrtYdqCTL/qYesSJwPJSDHBbIs4A0CKk
         JHdLmsWiEN2phUpIauwruZdAUynlCb6NOuAiLT8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 58/88] KVM: SVM: Move spec control call after restore of GS
Date:   Fri, 14 Dec 2018 13:00:32 +0100
Message-Id: <20181214115707.259654951@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 15e6c22fd8e5a42c5ed6d487b7c9fe44c2517765 upstream.

svm_vcpu_run() invokes x86_spec_ctrl_restore_host() after VMEXIT, but
before the host GS is restored. x86_spec_ctrl_restore_host() uses 'current'
to determine the host SSBD state of the thread. 'current' is GS based, but
host GS is not yet restored and the access causes a triple fault.

Move the call after the host GS restore.

Fixes: 885f82bfbc6f x86/process: Allow runtime control of Speculative Store Bypass
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3998,6 +3998,18 @@ static void svm_vcpu_run(struct kvm_vcpu
 #endif
 		);
 
+	/* Eliminate branch target predictions from guest mode */
+	vmexit_fill_RSB();
+
+#ifdef CONFIG_X86_64
+	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
+#else
+	loadsegment(fs, svm->host.fs);
+#ifndef CONFIG_X86_32_LAZY_GS
+	loadsegment(gs, svm->host.gs);
+#endif
+#endif
+
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the
 	 * SPEC_CTRL MSR it may have left it on; save the value and
@@ -4018,18 +4030,6 @@ static void svm_vcpu_run(struct kvm_vcpu
 
 	x86_spec_ctrl_restore_host(svm->spec_ctrl);
 
-	/* Eliminate branch target predictions from guest mode */
-	vmexit_fill_RSB();
-
-#ifdef CONFIG_X86_64
-	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
-#else
-	loadsegment(fs, svm->host.fs);
-#ifndef CONFIG_X86_32_LAZY_GS
-	loadsegment(gs, svm->host.gs);
-#endif
-#endif
-
 	reload_tss(vcpu);
 
 	local_irq_disable();


