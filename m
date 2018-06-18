Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93711C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569D720864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569D720864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935975AbeFRIXz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:23:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55898 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbeFRIXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:23:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB3C5C5C;
        Mon, 18 Jun 2018 08:23:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 186/279] sh: fix build failure for J2 cpu with SMP disabled
Date:   Mon, 18 Jun 2018 10:12:51 +0200
Message-Id: <20180618080616.634904671@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rich Felker <dalias@libc.org>

[ Upstream commit 6cb465972c4eb6741b3094a58a65e527fc63c100 ]

The sh asm/smp.h defines a fallback hard_smp_processor_id macro for
the !SMP case, but linux/smp.h never includes asm/smp.h in the !SMP
case.

Signed-off-by: Rich Felker <dalias@libc.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/kernel/cpu/sh2/probe.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -43,7 +43,11 @@ void __ref cpu_probe(void)
 #endif
 
 #if defined(CONFIG_CPU_J2)
+#if defined(CONFIG_SMP)
 	unsigned cpu = hard_smp_processor_id();
+#else
+	unsigned cpu = 0;
+#endif
 	if (cpu == 0) of_scan_flat_dt(scan_cache, NULL);
 	if (j2_ccr_base) __raw_writel(0x80000303, j2_ccr_base + 4*cpu);
 	if (cpu != 0) return;


