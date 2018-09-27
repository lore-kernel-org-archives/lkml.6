Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45743C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033E521564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033E521564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeI0XWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:22:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeI0XWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:22:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RH2gX7099929
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 10:02:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RH2gQl099926;
        Thu, 27 Sep 2018 10:02:42 -0700
Date:   Thu, 27 Sep 2018 10:02:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-0b13bec787dccca96f8c431da732657ae01baf9a@git.kernel.org>
Cc:     bp@suse.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, puwen@hygon.cn, mingo@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, puwen@hygon.cn,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@suse.de
In-Reply-To: <87000fa82e273f5967c908448414228faf61e077.1537533369.git.puwen@hygon.cn>
References: <87000fa82e273f5967c908448414228faf61e077.1537533369.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/smpboot: Do not use BSP INIT delay and MWAIT to
 idle on Dhyana
Git-Commit-ID: 0b13bec787dccca96f8c431da732657ae01baf9a
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

Commit-ID:  0b13bec787dccca96f8c431da732657ae01baf9a
Gitweb:     https://git.kernel.org/tip/0b13bec787dccca96f8c431da732657ae01baf9a
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Sun, 23 Sep 2018 17:34:32 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 18:28:57 +0200

x86/smpboot: Do not use BSP INIT delay and MWAIT to idle on Dhyana

The Hygon Dhyana CPU uses no delay in smp_quirk_init_udelay(), and does
HLT on idle just like AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: bp@alien8.de
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: thomas.lendacky@amd.com
Link: https://lkml.kernel.org/r/87000fa82e273f5967c908448414228faf61e077.1537533369.git.puwen@hygon.cn
---
 arch/x86/kernel/smpboot.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f02ecaf97904..5369d7fac797 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -676,6 +676,7 @@ static void __init smp_quirk_init_udelay(void)
 
 	/* if modern processor, use no delay */
 	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
+	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
 	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
 		init_udelay = 0;
 		return;
@@ -1592,7 +1593,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
