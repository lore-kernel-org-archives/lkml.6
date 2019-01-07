Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA55DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E2D218F0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfAGTxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbfAGTxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:53:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36376218AF;
        Mon,  7 Jan 2019 19:53:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1ggaxp-0000LC-7x; Mon, 07 Jan 2019 14:53:33 -0500
Message-Id: <20190107195333.112062036@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Jan 2019 14:53:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
Subject: [PATCH RT 08/13] x86/fpu: Disable preemption around local_bh_disable()
References: <20190107195252.599921907@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit f70ac4a5ca5df1d84dae809453464eca16b54f51 ]

__fpu__restore_sig() restores the content of the FPU state in the CPUs
and in order to avoid concurency it disbles BH. On !RT it also disables
preemption but on RT we can get preempted in BH.

Add preempt_disable() while the FPU state is restored.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/fpu/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index d99a8ee9e185..5e0274a94133 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -344,10 +344,12 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
 		}
 
+		preempt_disable();
 		local_bh_disable();
 		fpu->initialized = 1;
 		fpu__restore(fpu);
 		local_bh_enable();
+		preempt_enable();
 
 		return err;
 	} else {
-- 
2.19.2


