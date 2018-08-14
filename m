Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51ACC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CCE21727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CCE21727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbeHNUZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:25:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbeHNUZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:25:54 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8B46DD65;
        Tue, 14 Aug 2018 17:37:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 088/104] x86/KVM/VMX: Dont set l1tf_flush_l1d from vmx_handle_external_intr()
Date:   Tue, 14 Aug 2018 19:17:42 +0200
Message-Id: <20180814171520.922328064@linuxfoundation.org>
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

From: Nicolai Stange <nstange@suse.de>

commit 18b57ce2eb8c8b9a24174a89250cf5f57c76ecdc upstream

For VMEXITs caused by external interrupts, vmx_handle_external_intr()
indirectly calls into the interrupt handlers through the host's IDT.

It follows that these interrupts get accounted for in the
kvm_cpu_l1tf_flush_l1d per-cpu flag.

The subsequently executed vmx_l1d_flush() will thus be aware that some
interrupts have happened and conduct a L1d flush anyway.

Setting l1tf_flush_l1d from vmx_handle_external_intr() isn't needed
anymore. Drop it.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9460,7 +9460,6 @@ static void vmx_handle_external_intr(str
 			[ss]"i"(__KERNEL_DS),
 			[cs]"i"(__KERNEL_CS)
 			);
-		vcpu->arch.l1tf_flush_l1d = true;
 	}
 }
 STACK_FRAME_NON_STANDARD(vmx_handle_external_intr);


