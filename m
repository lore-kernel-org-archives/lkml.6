Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBE1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DE120880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DE120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbeGWNsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbeGWNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:00 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BFB78C96;
        Mon, 23 Jul 2018 12:46:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sherry Hurwitz <sherry.hurwitz@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 086/107] x86/cpu/AMD: Fix erratum 1076 (CPB bit)
Date:   Mon, 23 Jul 2018 14:42:20 +0200
Message-Id: <20180723122417.789791295@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit f7f3dc00f61261cdc9ccd8b886f21bc4dffd6fd9 upstream

CPUID Fn8000_0007_EDX[CPB] is wrongly 0 on models up to B1. But they do
support CPB (AMD's Core Performance Boosting cpufreq CPU feature), so fix that.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170907170821.16021-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/kernel/cpu/amd.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -713,6 +713,16 @@ static void init_amd_bd(struct cpuinfo_x
 	}
 }
 
+static void init_amd_zn(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
+	 * all up to and including B1.
+	 */
+	if (c->x86_model <= 1 && c->x86_mask <= 1)
+		set_cpu_cap(c, X86_FEATURE_CPB);
+}
+
 static void init_amd(struct cpuinfo_x86 *c)
 {
 	u32 dummy;
@@ -743,6 +753,7 @@ static void init_amd(struct cpuinfo_x86
 	case 0x10: init_amd_gh(c); break;
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
+	case 0x17: init_amd_zn(c); break;
 	}
 
 	/* Enable workaround for FXSAVE leak */


