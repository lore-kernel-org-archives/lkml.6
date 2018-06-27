Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D91FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA666264CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pA8bFMJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA666264CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933858AbeF0JHW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:07:22 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46185 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932187AbeF0JHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:07:20 -0400
Received: by mail-wr0-f194.google.com with SMTP id t6-v6so1201025wrq.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cti9EyZxMPe/cBqks6kT+x3yVAmi2Jo77HfQEywZF3o=;
        b=pA8bFMJ00GiC23B/P6C0GvPkBOTbLOzZyFzWv1aqit95zgNh/sZucPJFtlTzWr4Qed
         1jnxaS5G7+O6l7sNLBwdrOJblp61mTbdfZm/3UXCJVNvoHTPqPV1ybfhhq27ftydZJSv
         GxEoo9JPOQdJkDS/tsQvHEsul3yBtBwYfiyuqTUoLVajrUNA8PgujmyIbE7o9aEEJTlg
         DCEvoXaJf/rr6u6mxnl1qkNrXPRQjwfd1j3vK/zVJvgd/Hg7JA3iOil8ADFC5S2grfPQ
         d2okIJhvsAGxs7M+U1fqlee015z1CKgbvr83mMM4Aq0cKLGOa4psIi57NrB65lY8RsLc
         TPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cti9EyZxMPe/cBqks6kT+x3yVAmi2Jo77HfQEywZF3o=;
        b=PtEyDzs88nwcKZ710yeuHeBO7CsARKNYYKJOKnIy9uHNo4bBu3BWMFMneHMl7rDLGb
         s5uL9bg9KPsUHxuXIRpDKRg5Qn5kQUMQ8aOB46qQr9mPJLxMcSSupuB9Mc/GraY6yPWF
         egl/u5WJqBB15u7R0Po2SNEzJpH4iZWGXKX02xgO1rFlJI4G5CqnoMNneOvs7lz4h9Bv
         gLPMaIMD1CLJKJj7Wp2E4PWcbdwg3bxKQen4j/IxE/SDyNXJqITlwveU0Wt0qcvMX16X
         WTWxtXnD5p+hIJui2Gfpp1WLYSUjOCDTawVrjQezHX9mWk3tD1Bg2nTcX+gwwp+0Qgg3
         NSFQ==
X-Gm-Message-State: APt69E0Xp7fSlT8W9VAQ5du1lPiMVM+OFXNG8cAZ+mdR6a0yxs0qPI9j
        vHAQabD/mit4NSPe7/hgcMs=
X-Google-Smtp-Source: AAOMgpc0+Ijl/TiTvGn8ulx8cNUDQ9mhVWFQIoJFWQsDUS6ZzF/Qod/rVci3Qgcpy8mgnv6mnX04Jg==
X-Received: by 2002:a5d:4306:: with SMTP id h6-v6mr4475948wrq.58.1530090439402;
        Wed, 27 Jun 2018 02:07:19 -0700 (PDT)
Received: from dvyukov-z840.muc.corp.google.com ([2a00:79e0:15:10:8971:4ae9:dd1c:10e])
        by smtp.gmail.com with ESMTPSA id u6-v6sm3626175wrm.60.2018.06.27.02.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 02:07:18 -0700 (PDT)
From:   Dmitry Vyukov <dvyukov@gmail.com>
To:     mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] arch/x86: cleanup show_fault_oops()
Date:   Wed, 27 Jun 2018 11:07:15 +0200
Message-Id: <20180627090715.28076-1-dvyukov@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

Remove once used nx_warning and smep_warning.
As asked by reviewers in
"arch/x86: get rid of KERN_CONT in show_fault_oops()"
review.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
---
 arch/x86/mm/fault.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9a84a0d08727..1d3fd8ff2ea6 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -641,11 +641,6 @@ static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
 	return 0;
 }
 
-static const char nx_warning[] = KERN_CRIT
-"kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n";
-static const char smep_warning[] = KERN_CRIT
-"unable to execute userspace code (SMEP?) (uid: %d)\n";
-
 static void
 show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address)
@@ -664,11 +659,13 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		pte = lookup_address_in_pgd(pgd, address, &level);
 
 		if (pte && pte_present(*pte) && !pte_exec(*pte))
-			printk(nx_warning, from_kuid(&init_user_ns, current_uid()));
+			pr_crit("kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n",
+				from_kuid(&init_user_ns, current_uid()));
 		if (pte && pte_present(*pte) && pte_exec(*pte) &&
 				(pgd_flags(*pgd) & _PAGE_USER) &&
 				(__read_cr4() & X86_CR4_SMEP))
-			printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
+			pr_crit("unable to execute userspace code (SMEP?) (uid: %d)\n",
+				from_kuid(&init_user_ns, current_uid()));
 	}
 
 	printk(KERN_ALERT "BUG: unable to handle kernel ");
-- 
2.18.0.rc2.346.g013aa6912e-goog

