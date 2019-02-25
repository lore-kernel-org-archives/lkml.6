Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D52C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777FF217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfBYWo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:44:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfBYWo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 17:44:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1PMi5Xd1880602
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 25 Feb 2019 14:44:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1PMi4FK1880592;
        Mon, 25 Feb 2019 14:44:04 -0800
Date:   Mon, 25 Feb 2019 14:44:04 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-41f035a86b5b72a4f947c38e94239d20d595352a@git.kernel.org>
Cc:     x86@kernel.org, puwen@hygon.cn, bp@suse.de, tony.luck@intel.com,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Reply-To: mingo@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de, bp@suse.de,
          tony.luck@intel.com, x86@kernel.org, puwen@hygon.cn
In-Reply-To: <20190225205940.15226-1-tony.luck@intel.com>
References: <20190225205940.15226-1-tony.luck@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Improve error message when kernel cannot
 recover, p2
Git-Commit-ID: 41f035a86b5b72a4f947c38e94239d20d595352a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  41f035a86b5b72a4f947c38e94239d20d595352a
Gitweb:     https://git.kernel.org/tip/41f035a86b5b72a4f947c38e94239d20d595352a
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Mon, 25 Feb 2019 12:59:40 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 25 Feb 2019 23:21:35 +0100

x86/mce: Improve error message when kernel cannot recover, p2

In

  c7d606f560e4 ("x86/mce: Improve error message when kernel cannot recover")

a case was added for a machine check caused by a DATA access to poison
memory from the kernel. A case should have been added also for an
uncorrectable error during an instruction fetch in the kernel.

Add that extra case so the error message now reads:

  mce: [Hardware Error]: Machine check: Instruction fetch error in kernel

Fixes: c7d606f560e4 ("x86/mce: Improve error message when kernel cannot recover")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190225205940.15226-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/severity.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dc3e26e905a3..65201e180fe0 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -165,6 +165,11 @@ static struct severity {
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
 		KERNEL
 		),
+	MCESEV(
+		PANIC, "Instruction fetch error in kernel",
+		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
+		KERNEL
+		),
 #endif
 	MCESEV(
 		PANIC, "Action required: unknown MCACOD",
